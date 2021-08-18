//
//  PagerCategoryView.m
//  CodeBook
//
//  Created by mac on 2021/6/18.
//  Copyright © 2021 Podinn. All rights reserved.
//

#import "PagerCategoryView.h"

@interface PagerCategoryView ()

@property(nonatomic, strong)UIImageView *bgImg;

@property(nonatomic,assign)BOOL isOnlyTitle;

@end

@implementation PagerCategoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bgImg.hidden = NO;
        
        self.categoryTitleImageView.hidden = NO;
        self.categoryOnlyTitleView.hidden = YES;
        
        [self.categoryOnlyTitleView.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
        [self.categoryTitleImageView.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark ----- KVO 检测滑动 -----
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        UICollectionView *collection = object;
        CGPoint offset = collection.contentOffset;
        
        if (self.isOnlyTitle) {
            if (object == self.categoryOnlyTitleView.collectionView) {
                if (self.categoryTitleImageView.hidden == YES) {
                    self.categoryTitleImageView.collectionView.contentOffset = offset;
                }
            }
        }else {
            if (object == self.categoryTitleImageView.collectionView) {
                if (self.categoryOnlyTitleView.hidden == YES) {
                    self.categoryOnlyTitleView.collectionView.contentOffset = offset;
                }
            }
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    if (self.categoryTitleImageView) {
        [self.categoryTitleImageView.collectionView removeObserver:self forKeyPath:@"contentOffset"];
    }
    
    if (self.categoryOnlyTitleView.collectionView) {
        [self.categoryOnlyTitleView.collectionView removeObserver:self forKeyPath:@"contentOffset"];
    }
}


#pragma mark ----- setter -----

- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc]init];
        _bgImg.image = [UIImage imageNamed:@"img_home_top2"];
        [self addSubview:_bgImg];
        [_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _bgImg;
}

- (HomeCategoryTitleImageView *)categoryTitleImageView {
    if (!_categoryTitleImageView) {
        _categoryTitleImageView = [[HomeCategoryTitleImageView alloc] init];
        _categoryTitleImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 95*adjustRatio);
        _categoryTitleImageView.backgroundColor = [UIColor clearColor];
        _categoryTitleImageView.titleSelectedColor = [UIColor whiteColor];
        _categoryTitleImageView.titleColor = [UIColor colorWithHexString:@"#BB1B42"];
        _categoryTitleImageView.titleColorGradientEnabled = YES;
        _categoryTitleImageView.titleFont = [UIFont systemFontOfSize:12*adjustRatio weight:UIFontWeightRegular];
        _categoryTitleImageView.titleSelectedFont = [UIFont systemFontOfSize:14*adjustRatio weight:UIFontWeightMedium];
        _categoryTitleImageView.titleImageSpacing = 5;
        _categoryTitleImageView.imageSize = CGSizeMake(55*adjustRatio, 55*adjustRatio);
        _categoryTitleImageView.imageZoomEnabled = YES;
        _categoryTitleImageView.imageZoomScale = 1.4;
        _categoryTitleImageView.cellWidth = 60*adjustRatio;
        [self addSubview:_categoryTitleImageView];
        
        JXCategoryIndicatorImageView *backgroundView = [[JXCategoryIndicatorImageView alloc] init];
        backgroundView.verticalMargin = -2*adjustRatio;
        backgroundView.indicatorImageView.image = [UIImage imageNamed:@"red_bubble"];
        backgroundView.indicatorImageViewSize = CGSizeMake(77*adjustRatio, 32*adjustRatio);
        backgroundView.indicatorImageView.contentMode = UIViewContentModeScaleAspectFill;
        _categoryTitleImageView.indicators = @[backgroundView];
    }
    return _categoryTitleImageView;
}

- (HomeCategoryTitleImageView *)categoryOnlyTitleView {
    if (!_categoryOnlyTitleView) {
        _categoryOnlyTitleView = [[HomeCategoryTitleImageView alloc] init];
        _categoryOnlyTitleView.frame = CGRectMake(0, 50*adjustRatio, [UIScreen mainScreen].bounds.size.width, 50*adjustRatio);
        _categoryOnlyTitleView.backgroundColor = [UIColor clearColor];
        _categoryOnlyTitleView.titleSelectedColor = [UIColor colorWithHexString:@"#F20000"];
        _categoryOnlyTitleView.titleColor = [UIColor whiteColor];
        _categoryOnlyTitleView.titleFont = [UIFont systemFontOfSize:12*adjustRatio weight:UIFontWeightRegular];
        _categoryOnlyTitleView.titleSelectedFont = [UIFont systemFontOfSize:14*adjustRatio weight:UIFontWeightMedium];
        _categoryOnlyTitleView.titleColorGradientEnabled = YES;
        _categoryOnlyTitleView.cellWidth = 60*adjustRatio;
        [self addSubview:_categoryOnlyTitleView];
        
        JXCategoryIndicatorImageView *backgroundView = [[JXCategoryIndicatorImageView alloc] init];
        backgroundView.verticalMargin = 5*adjustRatio;
        backgroundView.indicatorImageView.image = [UIImage imageNamed:@"white_bubble"];
        backgroundView.indicatorImageViewSize = CGSizeMake(77*adjustRatio, 32*adjustRatio);
        backgroundView.indicatorImageView.contentMode = UIViewContentModeScaleAspectFill;
        _categoryOnlyTitleView.indicators = @[backgroundView];
    }
    return _categoryOnlyTitleView;
}

#pragma mark ----- method -----
- (void)changeCategory:(BOOL)onlyTitle {
    
    if (self.isOnlyTitle == onlyTitle) {
        return;
    }
    
    if (onlyTitle) {
        self.bgImg.image = [UIImage imageNamed:@"img_home_backimage"];
    }else {
        self.bgImg.image = [UIImage imageNamed:@"img_home_top2"];
    }
    
    self.isOnlyTitle = onlyTitle;
    self.categoryTitleImageView.hidden = onlyTitle;
    self.categoryOnlyTitleView.hidden = !onlyTitle;
    
}

- (void)configCategory:(HomeCategoryTitleImageView *)categoryView onlyTitle:(BOOL)onlyTitle {
    
    categoryView.titles = self.titles;
    categoryView.imageURLs = self.images;
    categoryView.selectedImageURLs =  self.selectImages;
    categoryView.imageTypes = [self configImageTypesWithImage:onlyTitle];
    
    if (onlyTitle) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FF045C"];
    }else {
        self.backgroundColor = [UIColor clearColor];
    }
    
    [categoryView reloadData];
    
}

- (NSArray *)configImageTypesWithImage:(BOOL)onlyTitle {
    NSMutableArray *temps = [NSMutableArray new];
    for (int i = 0; i < self.titles.count; i++) {
        if (!onlyTitle) {
            if (i == 0) {
                [temps addObject:@(XCCategoryTitleImageType_ImageTitle)];
            }
            [temps addObject:@(XCCategoryTitleImageType_TopImage)];
        }else {
            if (i == 0) {
                [temps addObject:@(XCCategoryTitleImageType_TitleImg)];
            }
            [temps addObject:@(XCCategoryTitleImageType_OnlyTitle)];
        }
    }
    return temps;
}

- (void)reloadData {
        
    self.categoryTitleImageView.hidden = NO;
    self.categoryOnlyTitleView.hidden = YES;
    
    [self configCategory:self.categoryTitleImageView onlyTitle:NO];
    [self configCategory:self.categoryOnlyTitleView onlyTitle:YES];
    
}

@end
