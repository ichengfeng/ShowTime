//
//  CBBaseViewController.h
//  CodeBook
//
//  Created by Podinn on 2019/5/27.
//  Copyright © 2019 Podinn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCNavigationBaseBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property(nonatomic, strong)XCNavigationBaseBar *navBar;

@property(nonatomic, strong)NSString *navTitle;

- (void)pageJumpTo:(NSString *)nibName;

@end

NS_ASSUME_NONNULL_END
