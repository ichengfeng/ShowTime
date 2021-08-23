//
//  Screen.h
//  lib-ui-lib-ui
//
//  Created by 于浦洋 on 2021/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Screen : NSObject

/// 屏幕宽
+ (CGFloat)width;

/// 屏幕高
+ (CGFloat)height;

/// 状态栏高
+ (CGFloat)statusBarHeight;
/// 导航栏高
+ (CGFloat)navBarHeight;
/// 顶部安全距离
+ (CGFloat)safeAreaTop;
/// 底部安全距离
+ (CGFloat)safeAreaBottom;
//tab 高度
+ (CGFloat)tabBarHeight;
//屏幕适配比例
+ (CGFloat)ratio;
//屏高比
+ (CGFloat)ratioHeight;
/// 字体适配比例，根据 ui check 可选
+ (CGFloat)ratioFont;
@end

NS_ASSUME_NONNULL_END
