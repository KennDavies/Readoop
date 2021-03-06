//
//  ProfileViewController.m
//  Readoop
//
//  Created by Marin Chitan on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ProfileViewController.h"
#import "Color.h"
#import "Navigation.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <EHPlainAlert/EHPlainAlert.h>
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "ViewController.h"
#import "AlertUtils.h"
#import "Session.h"
#import "UserDefaultsManager.h"
#import "User.h"
#import <Realm/Realm.h>
#import "Font.h"
#import "NSString+FontAwesome.h"
#import "RealmUtils.h"

@interface ProfileViewController ()
@property (assign, nonatomic) CGFloat initialCornerRadius;
@property (nonatomic, strong) Session* appSession;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.initialCornerRadius = 5.0;
    [self setUpUI];
    [self setUpProfilePanel];
    [self setUpSignals];
    self.appSession = [Session sharedSession];
}

- (void)viewWillAppear:(BOOL)animated {
    [Navigation hideNavBar:[self navigationController]];
    if(!self.rememberMeEnabled){
        [self clearFields];
    }
}

- (void)clearFields {
    self.usernameField.text = @"";
    self.passwordField.text = @"";
}

- (void)setUpUI {
    [Navigation showStatusBar];
    [Navigation makeStatusBarLightStyle];
    [Navigation hideNavBar:[self navigationController]];
    [Navigation paintStatusBarWithColor:[Color getMainRed]];
    self.view.backgroundColor = [Color getMainRed];
}

- (void)setUpProfilePanel {
    self.profileView.layer.cornerRadius = 30;
    self.profileView.layer.masksToBounds = YES;
    self.profileView.backgroundColor = [[Color getWhite] colorWithAlphaComponent:1];
    self.welcomeLabel.textColor = [Color getMainWhite];
    
    self.usernameField.layer.cornerRadius = self.initialCornerRadius;
    self.signInButton.layer.cornerRadius = self.initialCornerRadius;
    self.passwordField.layer.cornerRadius = self.initialCornerRadius;
    self.signUpButton.layer.cornerRadius = self.initialCornerRadius;
    self.cancelButton.layer.cornerRadius = self.initialCornerRadius;
    
    self.usernameField.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    self.passwordField.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    self.usernameField.layer.masksToBounds = YES;
    self.usernameField.layer.borderWidth = 1.0f;
    self.passwordField.layer.masksToBounds = YES;
    self.passwordField.layer.borderWidth = 1.0f;
    
    self.signInButton.enabled = NO;
    self.signInButton.backgroundColor = [Color getPassiveBariolRed];
    [self.signInButton setTitleColor:[Color getMainPassiveGray] forState:UIControlStateDisabled];
    
    self.signUpButton.backgroundColor = [Color getMainRed];
    self.cancelButton.backgroundColor = [Color getMainPassiveGray];
    
    self.usernameLabel.hidden = NO;
    self.passwordLabel.hidden = NO;
    
    [self setUpRememberMe];
}

- (void)setUpRememberMe {
    self.rememberMeIcon.font = [Font getFAFont:20];
    self.rememberMeIcon.textColor = [Color getPassiveTab];
    self.rememberMeIcon.text = [NSString fontAwesomeIconStringForEnum:FACheckSquareO];
    
    self.rememberMeLabel.font = [Font getBariolwithSize:14];
    self.rememberMeEnabled = YES;
}

- (IBAction)tapRememberMe:(id)sender {
    self.rememberMeIcon.text = self.rememberMeEnabled ? [NSString fontAwesomeIconStringForEnum:FASquareO] : [NSString fontAwesomeIconStringForEnum:FACheckSquareO];
    self.rememberMeEnabled = !self.rememberMeEnabled;
}

- (void)setUpSignals {
    //Handle the focus cases for the fields
    RAC(self.usernameField.layer, borderWidth) = [[[self.usernameField rac_signalForControlEvents:UIControlEventEditingDidBegin] merge:[self.usernameField rac_signalForControlEvents:UIControlEventEditingDidEnd]] map:^id _Nullable(UITextField *value) {
        return value.isFirstResponder ? @2 : @0.8;
    }];
    RAC(self.passwordField.layer, borderWidth) = [[[self.passwordField rac_signalForControlEvents:UIControlEventEditingDidBegin] merge:[self.passwordField rac_signalForControlEvents:UIControlEventEditingDidEnd]] map:^id _Nullable(UITextField *value) {
        return value.isFirstResponder ? @2 : @0.8;
    }];
    RAC(self.usernameField.layer, borderColor) = [[[self.usernameField rac_signalForControlEvents:UIControlEventEditingDidBegin] merge:[self.usernameField rac_signalForControlEvents:UIControlEventEditingDidEnd]] map:^id _Nullable(UITextField *value) {
        return value.isFirstResponder ? [[Color getSilverGray] CGColor] : [[Color getTextFieldBorderGray] CGColor];
    }];
    RAC(self.passwordField.layer, borderColor) = [[[self.passwordField rac_signalForControlEvents:UIControlEventEditingDidBegin] merge:[self.passwordField rac_signalForControlEvents:UIControlEventEditingDidEnd]] map:^id _Nullable(UITextField *value) {
        return value.isFirstResponder ? [[Color getSilverGray] CGColor] : [[Color getTextFieldBorderGray] CGColor];
    }];
    
    RAC(self.usernameLabel, hidden) = [[self.usernameField rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        BOOL containsText = !(value.length > 0);
        return @(containsText);
    }];
    
    RAC(self.passwordLabel, hidden) = [[self.passwordField rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        BOOL containsText = !(value.length > 0);
        return @(containsText);
    }];
    
    RACSignal *usernameSignal = [[self.usernameField rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        BOOL containsText = value.length > 0;
        return @(containsText);
    }];
    
    RACSignal *passwordSignal = [[self.passwordField rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        BOOL containsText = value.length > 0;
        return @(containsText);
    }];
    
    //CombineLatest waits untill both signals emit a signal
    //Reduce returns a value from both signals combined
    RAC(self.signInButton, enabled) = [RACSignal combineLatest:@[usernameSignal, passwordSignal]
                                                        reduce:^id (NSNumber *usernameValid, NSNumber *passwordValid){
                                                            return @([usernameValid boolValue] && [passwordValid boolValue]);
                                                        }];
    
    RAC(self.signInButton, backgroundColor) = [RACSignal combineLatest:@[usernameSignal, passwordSignal]
                                                        reduce:^id (NSNumber *usernameValid, NSNumber *passwordValid){
                                                            return [usernameValid boolValue] && [passwordValid boolValue] ?
                                                            [Color getMainRed] : [Color getPassiveBariolRed];
                                                        }];
}

- (BOOL)userCredentialsCheck {
    User *retrievedUser = [RealmUtils getUserByName:self.usernameField.text byPassword:self.passwordField.text];
    if(retrievedUser){
        //MONGOPUT
        [RealmUtils changeRememberStatusForUser:retrievedUser shouldBeRemembered:self.rememberMeEnabled];
        self.appSession.currentUser = retrievedUser;
        return YES;
    } else {
        return NO;
    }
}

- (IBAction)signIn:(id)sender {
    if([self userCredentialsCheck]){
        //if succesessfully logged save credentials to cache, so next time will be seamless logged
        [UserDefaultsManager saveCredentialsUsername:self.usernameField.text password:self.passwordField.text];
        self.appSession.wayOfArrival = login_path;
        
        [self.navigationController pushViewController:[ViewController getTabbedDashboard] animated:YES];
    } else {
        [AlertUtils getErrorToastPanel:@"Oops!" withMessage:@"Wrong credentials supplied"];
    }
}

- (IBAction)signUp:(id)sender {
    RegisterViewController *registerVC = [ViewController getRegisterVC];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)cancel:(id)sender {
    __weak ProfileViewController *weakSelf = self;
    [AlertUtils showAlertModal:@"Do you want to quit the application?"
                     withTitle:@"Quit"
              withActionButton:@"Yes"
              withCancelButton:@"No"
                    withAction:^{ exit(0);}
                          onVC:weakSelf];
}

@end
