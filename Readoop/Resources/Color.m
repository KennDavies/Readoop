//
//  Color.m
//  Readoop
//
//  Created by Marin Chitan on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "Color.h"

@implementation Color

+ (UIColor *)getMainRed {
    return [Color getBariolRed];
}

+ (UIColor *)getMainWhite {
    return [Color getWhite];
}

+ (UIColor*)getMainPassiveGray {
    return [Color getSilverGray];
}


+ (UIColor *)getBariolRed {
    return [UIColor colorWithRed:(244/255.0) green:(67/255.0) blue:(54/255.0) alpha:1];
}

+ (UIColor *)getSmokeWhite {
    return [UIColor colorWithRed:(239/255.0) green:(239/255.0) blue:(239/255.0) alpha:1];
}

+ (UIColor *)getWhite {
    return [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
}

+ (UIColor *)getSilverGray {
    return [UIColor colorWithRed:(74/255.0) green:(76/255.0) blue:(78/255.0) alpha:1];
}


@end
