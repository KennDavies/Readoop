//
//  FeedTVCDataSource.h
//  Readoop
//
//  Created by Marin Chitan on 30/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface FeedTVCDataSource : NSObject

+ (RLMArray*)getAllFeedPosts;
+ (RLMArray*)getFriendsFeedPosts;

@end
