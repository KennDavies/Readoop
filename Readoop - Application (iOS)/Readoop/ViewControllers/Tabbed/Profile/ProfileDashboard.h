//
//  ProfileDashboard.h
//  Readoop
//
//  Created by Marin Chitan on 16/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "Essentials.h"
#import "ContainerViewController.h"
#import "ProfileDashboardDelegateProtocol.h"


@interface ProfileDashboard : ContainerViewController <UITableViewDelegate, UITableViewDataSource, ProfileDashboardDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
