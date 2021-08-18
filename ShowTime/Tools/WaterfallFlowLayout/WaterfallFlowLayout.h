//
//  WaterfallFlowLayout.h
//  xingxuan
//
//  Created by wesion on 2021/4/8.
//  Copyright © 2021 辛橙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WaterfallFlowLayout;

@protocol WaterfallFlowLayoutDelegate <NSObject>

@required

/// 高度
- (CGFloat)waterflowLayout:(WaterfallFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional

/// 竖排 数
- (CGFloat)columnCountInWaterflowLayout:(WaterfallFlowLayout *)waterflowLayout;

/// 竖向 间距
- (CGFloat)columnMarginInWaterflowLayout:(WaterfallFlowLayout *)waterflowLayout;

/// 横向 间距
- (CGFloat)rowMarginInWaterflowLayout:(WaterfallFlowLayout *)waterflowLayout;

/// 边缘间距
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterfallFlowLayout *)waterflowLayout;

@end

@interface WaterfallFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<WaterfallFlowLayoutDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
