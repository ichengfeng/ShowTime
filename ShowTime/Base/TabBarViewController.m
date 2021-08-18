//
//  CBTabBarViewController.m
//  CodeBook
//
//  Created by Podinn on 2019/5/27.
//  Copyright © 2019 Podinn. All rights reserved.
//

#import "TabBarViewController.h"

#import "HomeViewController.h"
#import "CenterViewController.h"
#import "CollectionViewController.h"

@interface TabBarViewController ()
{
    NSMutableArray *itemArray;
}
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //消除白边
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.translucent = NO;
    
    CGRect rect = CGRectMake(0.0f, 0.0f, Screen.width, 0.5);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"#EDEDED"].CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:image];
    [self.tabBar setBackgroundImage:[UIImage new]];
    
    self.tabBar.layer.shadowColor = [UIColor colorWithHexString:@"9B9DA4"].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -3);
    self.tabBar.layer.shadowOpacity = 0.3;
    
    
    //设置MainTabBarView
    [self initTabBarItems];
    [self loadTabbarSubViews];
}

- (void)initTabBarItems {
    
    itemArray = [NSMutableArray new];
    
    for (int i=0; i < IMAGE_SELECTED.count; i++) {
        
        //选中状态图片
        UIImage*selectImage=[[UIImage imageNamed:IMAGE_SELECTED[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //正常状态图片
        UIImage*unSelectImage=[[UIImage imageNamed:IMAGE_NORMAL[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //设置两种状态下的图片
        UITabBarItem*item=[[UITabBarItem alloc]initWithTitle:TABBAR_TITLE_ARRAY[i] image:unSelectImage selectedImage:selectImage];
        
        [item setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithHexString:@"18b7d1"]} forState:UIControlStateSelected];
        
        [itemArray addObject:item];
    }
}

- (void)loadTabbarSubViews {
    
    HomeViewController *firstViewController = [[HomeViewController alloc] init];
    UINavigationController *firstNavigationController = [[UINavigationController alloc] initWithRootViewController:firstViewController];
    firstNavigationController.tabBarItem = itemArray[0];
    
    CenterViewController *secondViewController = [[CenterViewController alloc]init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc]initWithRootViewController:secondViewController];
    secondNavigationController.tabBarItem = itemArray[1];
    
    CollectionViewController *thirdViewController = [[CollectionViewController alloc] init];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc] initWithRootViewController:thirdViewController];
    thirdNavigationController.tabBarItem = itemArray[2];
    
    self.viewControllers = @[firstNavigationController, secondNavigationController, thirdNavigationController];
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
