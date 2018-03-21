//
//  Session.h
//  Readoop
//
//  Created by Marin Chitan on 18/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum wayOfArrival{
   register_path,
   login_path,
   others_path
}ArrivalWay;

@interface Session : NSObject 

@property  (nonatomic, assign) ArrivalWay wayOfArrival; //Give a welcome message when entering dashboard for first time from Login or Register pages

+ (id)sharedSession;

@end
