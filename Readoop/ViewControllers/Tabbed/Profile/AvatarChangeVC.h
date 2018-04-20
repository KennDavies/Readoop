//
//  AvatarChangeVC.h
//  Readoop
//
//  Created by Marin Chitan on 12/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"
#import "ProfileDashboardDelegateProtocol.h"


@interface AvatarChangeVC : ContainerViewController <UINavigationControllerDelegate ,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet UILabel *dismissLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;

@property (weak, nonatomic) id<ProfileDashboardDelegate> dashboarDelegate;

@end
