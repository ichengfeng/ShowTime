//
//  CBTabBarViewController.h
//  CodeBook
//
//  Created by Podinn on 2019/5/27.
//  Copyright © 2019 Podinn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define TABBAR_TITLE_ARRAY ((NSArray *)[NSArray arrayWithObjects:@"推荐",@"我的",@"收藏", nil])

#define IMAGE_NORMAL ((NSArray *)[NSArray arrayWithObjects:@"video",@"wifi",@"game", nil])

#define IMAGE_SELECTED ((NSArray *)[NSArray arrayWithObjects:@"video_h",@"wifi_h",@"game_h", nil])

@interface TabBarViewController : UITabBarController

@end

NS_ASSUME_NONNULL_END
