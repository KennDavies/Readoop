//
//  Color.h
//  Readoop
//
//  Created by Marin Chitan on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Color : NSObject

#pragma mark - Main Colors
+ (UIColor *)getMainRed;
+ (UIColor *)getMainWhite;
+ (UIColor *)getMainPassiveGray;
+ (UIColor *)getMainAlertYellow;

#pragma mark - Flat Colors
+ (UIColor *)getSmokeWhite;
+ (UIColor *)getBariolRed;
+ (UIColor *)getPassiveBariolRed;
+ (UIColor *)getWhite;
+ (UIColor *)getBlack;
+ (UIColor *)getSubTitleGray;
+ (UIColor *)getSilverGray;
+ (UIColor *)getAlertYellow;
+ (UIColor *)getLightGray;
+ (UIColor *)getTextFieldBorderGray;
+ (UIColor *)getUltraLightGray;

+ (UIColor *)getValidGreen;
+ (UIColor *)getInvalidRed;
+ (UIColor *)getNeutralYellow;

+ (UIColor *)getPassiveTab;
+ (UIColor *)getActiveTab;
  //Alternative reds

+ (UIColor *)getFeedPostGray;

+ (UIColor *)getBeginnerStatus;
+ (UIColor *)getAmateurStatus;
+ (UIColor *)getExperiencedStatus;
+ (UIColor *)getProffesionalStatus;

@end
