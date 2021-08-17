//
//  CBBaseViewController.m
//  CodeBook
//
//  Created by Podinn on 2019/5/27.
//  Copyright © 2019 Podinn. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (XCNavigationBaseBar *)navBar {
    if (!_navBar) {
        _navBar = [[XCNavigationBaseBar alloc] init];
        _navBar.bottomLineView.hidden = NO;
        _navBar.titleLabel.text = @"";
        _navBar.titleLabel.font = [UIFont boldSystemFontOfSize:18*adjustRatio];
        _navBar.titleLabel.textColor = UIColor.whiteColor;
        _navBar.rightButton.hidden = YES;
        [self.view addSubview:_navBar];
        
        [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.height.mas_equalTo(Screen.navBarHeight);
        }];
    }
    return _navBar;
}

/*
 @abstract 设置导航栏上的标题
 @param title 标题
 */
- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    if (navTitle) {
        self.navBar.hidden = NO;
        self.navBar.titleLabel.text = navTitle;
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navBar.hidden = YES;
}

//UIGestureRecognizerDelegate 重写侧滑协议
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    return [self gestureRecognizerShouldBegin];
//}
//- (BOOL)gestureRecognizerShouldBegin {
//    return YES;
//}

#pragma mark - Some Method
- (void)pageJumpTo:(NSString *)nibName {
    const char *className = [nibName cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
    UIViewController *controller = instance;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
