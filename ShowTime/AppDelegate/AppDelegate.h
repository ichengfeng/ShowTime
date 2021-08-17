//
//  AppDelegate.h
//  ShowTime
//
//  Created by chengfeng on 2021/8/13.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong , nonatomic)TabBarViewController *tabBarController;

+ (AppDelegate *)shareAppDelegate;

@end

