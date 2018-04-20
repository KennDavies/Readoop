//
//  UserPresentationVC.m
//  Readoop
//
//  Created by Marin Chitan on 17/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "UserPresentationVC.h"
#import "Essentials.h"

@interface UserPresentationVC ()

@end

@implementation UserPresentationVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    [self setupUI];
    [self populateData];
}

- (void)setupUI {
    [ViewUtils setUpButton:self.cancelButton withRadius:5.0];
    [ViewUtils setUpButton:self.addToFriendsButton withRadius:5.0];
    [ViewUtils setUpCancelActiveBUtton:self.cancelButton];
    [ViewUtils setUpStandardActiveButton:self.addToFriendsButton];

    self.userNameLabel.textColor = [Color getSubTitleGray];
    self.fullNameLabel.textColor = [Color getSubTitleGray];
    self.locaitonLabel.textColor = [Color getSubTitleGray];
    self.emailLabel.textColor = [Color getSubTitleGray];
    self.ageLabel.textColor = [Color getSubTitleGray];
    self.booksLabel.textColor = [Color getSubTitleGray];
    self.friendsLabel.textColor = [Color getSubTitleGray];
    
    self.userNameLabel.font = [Font getBariolwithSize:22];
    self.fullNameLabel.font = [Font getBariolwithSize:22];
    self.locaitonLabel.font = [Font getBariolwithSize:17];
    self.emailLabel.font = [Font getBariolwithSize:17];
    self.ageLabel.font = [Font getBariolwithSize:17];
    self.booksLabel.font = [Font getBariolwithSize:17];
    self.friendsLabel.font = [Font getBariolwithSize:17];
    
    self.userNameContent.textColor = [Color getPassiveTab];
    self.fullNameContent.textColor = [Color getPassiveTab];
    self.locationContent.textColor = [Color getPassiveTab];
    self.emailContent.textColor = [Color getPassiveTab];
    self.ageContent.textColor = [Color getPassiveTab];
    self.booksContent.textColor = [Color getPassiveTab];
    self.friendsContent.textColor = [Color getPassiveTab];
    
    self.userNameContent.font = [Font getBariolwithSize:22];
    self.fullNameContent.font = [Font getBariolwithSize:22];
    self.locationContent.font = [Font getBariolwithSize:17];
    self.emailContent.font = [Font getBariolwithSize:17];
    self.ageContent.font = [Font getBariolwithSize:17];
    self.booksContent.font = [Font getBariolwithSize:17];
    self.friendsContent.font = [Font getBariolwithSize:17];
    
    self.showBooksLabel.font = [Font getFAFont:14];
    self.showFriendsLabel.font = [Font getFAFont:14];
    self.showBooksLabel.text = [NSString stringWithFormat:@"%@%@",[NSString fontAwesomeIconStringForEnum:FAChevronRight],
                                [NSString fontAwesomeIconStringForEnum:FAChevronRight]];
    self.showFriendsLabel.text = [NSString stringWithFormat:@"%@%@",[NSString fontAwesomeIconStringForEnum:FAChevronRight],
                                  [NSString fontAwesomeIconStringForEnum:FAChevronRight]];
    self.showBooksLabel.textColor = [Color getPassiveTab];
    self.showFriendsLabel.textColor = [Color getPassiveTab];
    
    
    if(self.isOwnProfile) {
        [self.addToFriendsButton setTitle:@"Edit profie" forState:UIControlStateNormal];
        [self.addToFriendsButton setTitle:@"Edit profie" forState:UIControlStateFocused];
    }
    
    self.avatarView.clipsToBounds = YES;
    self.avatarView.layer.cornerRadius = self.avatarView.frame.size.width / 2;
}

- (void)populateData {
    self.avatarView.image = [UIImage imageWithData:self.appSession.currentUser.avatar];
    self.userNameContent.text = self.appSession.currentUser.username;
    self.fullNameContent.text = self.appSession.currentUser.fullName ? self.appSession.currentUser.fullName : @" - ";
    self.emailContent.text = self.appSession.currentUser.email ? self.appSession.currentUser.email : @" - ";
    
    NSString *locationString = [NSString new];
    if(self.appSession.currentUser.city && self.appSession.currentUser.country){
        locationString = [NSString stringWithFormat:@"%@, %@", self.appSession.currentUser.city, self.appSession.currentUser.country];
    } else if(self.appSession.currentUser.city) {
        locationString = self.appSession.currentUser.city;
    } else if(self.appSession.currentUser.country){
        locationString = self.appSession.currentUser.country;
    } else {
        locationString = @" - ";
    }
    
    self.locationContent.text = locationString;
    
    NSString *ageString = [NSString new];
    if(self.appSession.currentUser.dateOfBirth)
    {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger currentYear = [components year];
        
        NSDateComponents *userComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.appSession.currentUser.dateOfBirth];
        NSInteger userYear = [userComponents year];

        ageString = [NSString stringWithFormat:@"%tu",currentYear-userYear];
        self.ageContent.text = ageString;
    } else {
        self.ageContent.text = @" - ";
    }
    
    self.booksContent.text = [NSString stringWithFormat:@"%tu", [self.appSession.currentUser.books count]];
    self.friendsContent.text = [NSString stringWithFormat:@"%tu", [self.appSession.currentUser.friends count]];
}


- (IBAction)addToFriendsAction:(id)sender {
    //Check if is already friends
    if(self.isOwnProfile){
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController pushViewController:[ViewController getEditProfileVC] animated:YES];
    }
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showBooksAction:(id)sender {
}

- (IBAction)showFriendsAction:(id)sender {
}

@end
