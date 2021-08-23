//
//  Screen.m
//  lib-ui-lib-ui
//
//  Created by 于浦洋 on 2021/4/9.
//

#import "Screen.h"

@implementation Screen

+ (CGFloat)width {
    return UIScreen.mainScreen.bounds.size.width;
}

+ (CGFloat)height {
    return UIScreen.mainScreen.bounds.size.height;
}

+ (CGFloat)statusBarHeight {
    if (@available(iOS 14.0, *)) {
        UIScene *scene = UIApplication.sharedApplication.connectedScenes.anyObject;
        return [scene isKindOfClass:[UIWindowScene class]] ? [(UIWindowScene *)scene statusBarManager].statusBarFrame.size.height:20;
    } else {
        return UIApplication.sharedApplication.statusBarFrame.size.height;
    }
}

+ (CGFloat)navBarHeight {
    return [self statusBarHeight] + 44;
}
/// 顶部安全距离
+ (CGFloat)safeAreaTop {
    if (@available(iOS 11.0, *)) {
        //用scene的项目需要注意
        return UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.top;
    } else {
        return 0;
    }
}

+ (CGFloat)safeAreaBottom {
    if (@available(iOS 11.0, *)) {
        //用scene的项目需要注意
        return UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.bottom;
    } else {
        return 0;
    }
}

+ (CGFloat)tabBarHeight {
    return 49.f + [self safeAreaBottom];
}

+ (CGFloat)ratio {
    return [[UIScreen mainScreen] bounds].size.width/375.0;
}

+ (CGFloat)ratioHeight {
    return [[UIScreen mainScreen] bounds].size.height/667.0;
}

+ (CGFloat)ratioFont {
    return [[UIScreen mainScreen] bounds].size.width > 414.0 ? 1.0 : [self ratio];
}
@end
