//
//  UIViewController+TopMostViewController.h
//  zmjx
//
//  Created by yupuyang on 2019/5/4.
//  Copyright © 2019 于浦洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TopMostViewController)
+ (UIViewController *)topMost;
+ (UIViewController *)topMostOf:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
