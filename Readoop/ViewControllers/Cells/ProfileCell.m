//
//  ProfileCell.m
//  Readoop
//
//  Created by Marin Chitan on 26/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ProfileCell.h"
#import "Color.h"
#import "NSString+FontAwesome.h"
#import "Font.h"
#import "ChangePasswordVC.h"
#import "AdditionalInfoVC.h"
#import "EditProfileVC.h"
#import "AlertUtils.h"
#import "ViewController.h"

@implementation ProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupUI {
    self.separatorView.backgroundColor = [Color getUltraLightGray];
    self.icon.font = [Font getFAFont:26];
    self.icon.textColor = [Color getPassiveTab];
    self.chevron.font = [Font getFAFont:25];
    self.title.font = [Font getBariolwithSize:23];
    

    self.chevron.text = [NSString fontAwesomeIconStringForEnum:FAChevronRight];
    self.chevron.textColor = [Color getBariolRed];
}

- (void)setUpCellIconIndex:(int)value {
    [self setUpIcons:value];
}

- (void)setUpIcons:(int)value {
    switch(value) { //The order of the titles
        case 0:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FABook];
            break;
        case 1:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FAUsers];
            break;
        case 2:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FAuserPlus];
            break;
        case 3:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FAPencil];
            break;
        case 4:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FAUnlockAlt];
            break;
        case 5:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FAFile];
            break;
        case 6:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FASignOut];
            break;
    }
 
}

- (IBAction)action:(id)sender {
    if([self.action isEqualToString:@"myBooksAction"]){
        NSLog(@"MyBooks Action clicked");
    } else if([self.action isEqualToString:@"myFriendsAction"]){
        NSLog(@"MyFriends Action clicked");
    } else if([self.action isEqualToString:@"requestsAction"]) {
        NSLog(@"Requests Action clicked");
    } else if([self.action isEqualToString:@"editProfileAction"]) {
        EditProfileVC *editProfileVC = [ViewController getEditProfileVC];
        [self.currentNav pushViewController:editProfileVC animated:YES];
    } else if([self.action isEqualToString:@"changePasswordAction"]) {
        ChangePasswordVC *chpsswVC = [ViewController getChangePasswVC];
        [self.currentNav pushViewController:chpsswVC animated:YES];
        
    } else if([self.action isEqualToString:@"additionalInfoAction"]) {
        AdditionalInfoVC *addInfVC = [ViewController getAdditionalInfoVC];
        [self.currentNav pushViewController:addInfVC animated:YES];
    } else if([self.action isEqualToString:@"signoutAction"]) {
        [AlertUtils showInformation:@"Do you want to sign out?"
                          withTitle:@"Sign Out"
                   withActionButton:@"Yes"
                   withCancelButton:@"No"
                         withAction:^{[self.currentTab.navigationController popViewControllerAnimated:self.currentTab];}
                               onVC:self.currentVC];
        
    }
}

@end
