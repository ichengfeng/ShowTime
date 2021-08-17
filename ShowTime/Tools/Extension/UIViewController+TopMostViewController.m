//
//  UIViewController+TopMostViewController.m
//  zmjx
//
//  Created by yupuyang on 2019/5/4.
//  Copyright © 2019 于浦洋. All rights reserved.
//

#import "UIViewController+TopMostViewController.h"

@implementation UIViewController (TopMostViewController)
+ (UIViewController *)topMost {
    UIViewController *rootVC = [[UIApplication sharedApplication].windows.firstObject rootViewController];
    return [self.class topMostOf:rootVC];
}

+ (UIViewController *)topMostOf:(UIViewController *)viewController {
   if (!viewController) {
         return nil;
     }
     
     // UITabBarController
     if ([viewController isKindOfClass:[UITabBarController class]]) {
         return [self topMostOf:[(UITabBarController *)viewController selectedViewController]];
     }
     
     // presented view controller
    if ([viewController presentedViewController] && ![[viewController presentedViewController] isKindOfClass:[UIAlertController class]]) {
            return [self topMostOf:[viewController presentedViewController]];
     }
     
     // UINavigationController
     if ([viewController isKindOfClass:[UINavigationController class]]) {
         return [[(UINavigationController *)viewController viewControllers] lastObject];
     }
     
    
     
     //这里如果是添加了多个childViewController，是不是搜索出来的不一定是topMost？
     for (UIView *subview in viewController.view.subviews) {
         UIResponder *responder = subview.nextResponder;
         if (responder && [responder isKindOfClass:[UIViewController class]]) {
             return [self topMostOf:(id)responder];
         }
     }
     
     return viewController;
}

@end
