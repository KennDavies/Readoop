//
//  User.m
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSString *)primaryKey {
    return @"userId";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"fullName" : @"Name Surname",
             @"email": @"example@mail.com",
             @"status":@0
             };
}

@end
