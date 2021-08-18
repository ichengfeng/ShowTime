//
//  PagerCategoryView.h
//  CodeBook
//
//  Created by mac on 2021/6/18.
//  Copyright © 2021 Podinn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCategoryTitleImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PagerCategoryView : UIView

@property(nonatomic, strong)NSArray *titles;

@property(nonatomic, strong)NSArray *images;

@property(nonatomic, strong)NSArray *selectImages;

@property(nonatomic, strong)HomeCategoryTitleImageView *categoryTitleImageView;

@property(nonatomic, strong)HomeCategoryTitleImageView *categoryOnlyTitleView;

- (void)changeCategory:(BOOL)onlyTitle;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
