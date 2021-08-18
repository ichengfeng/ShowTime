//
//  XCCategoryTitleImageView.m
//  CodeBook
//
//  Created by mac on 2021/6/22.
//  Copyright © 2021 Podinn. All rights reserved.
//

#import "HomeCategoryTitleImageView.h"
#import "HomeCategoryTitleImageCell.h"
#import "HomeCategoryTitleImageCellModel.h"
//#import "JXCategoryFactory.h"
#import <JXCategoryView/JXCategoryFactory.h>

@implementation HomeCategoryTitleImageView

- (void)dealloc {
    self.loadImageCallback = nil;
}

- (void)initializeData {
    [super initializeData];

    _imageSize = CGSizeMake(20, 20);
    _titleImageSpacing = 5;
    _imageZoomEnabled = NO;
    _imageZoomScale = 1.2;
}

- (Class)preferredCellClass {
    return [HomeCategoryTitleImageCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.titles.count];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategoryTitleImageCellModel *cellModel = [[JXCategoryTitleImageCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = [NSArray arrayWithArray:tempArray];
    
    if (!self.imageTypes || (self.imageTypes.count == 0)) {
        NSMutableArray *types = [NSMutableArray arrayWithCapacity:self.titles.count];
        for (int i = 0; i< self.titles.count; i++) {
            [types addObject:@(JXCategoryTitleImageType_LeftImage)];
        }
        self.imageTypes = [NSArray arrayWithArray:types];
    }
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    HomeCategoryTitleImageCellModel *myCellModel = (HomeCategoryTitleImageCellModel *)cellModel;
    myCellModel.loadImageCallback = self.loadImageCallback;
    myCellModel.imageType = [self.imageTypes[index] integerValue];
    myCellModel.imageSize = self.imageSize;
    myCellModel.titleImageSpacing = self.titleImageSpacing;
    if (self.imageInfoArray && self.imageInfoArray.count != 0) {
        myCellModel.imageInfo = self.imageInfoArray[index];
    }else if (self.imageNames && self.imageNames.count != 0) {
        myCellModel.imageName = self.imageNames[index];
    }else if (self.imageURLs && self.imageURLs.count != 0) {
        myCellModel.imageURL = self.imageURLs[index];
    }
    if (self.selectedImageInfoArray && self.selectedImageInfoArray.count != 0) {
        myCellModel.selectedImageInfo = self.selectedImageInfoArray[index];
    }else if (self.selectedImageNames && self.selectedImageNames.count != 0) {
        myCellModel.selectedImageName = self.selectedImageNames[index];
    }else if (self.selectedImageURLs && self.selectedImageURLs.count != 0) {
        myCellModel.selectedImageURL = self.selectedImageURLs[index];
    }
    myCellModel.imageZoomEnabled = self.imageZoomEnabled;
    myCellModel.imageZoomScale = ((index == self.selectedIndex) ? self.imageZoomScale : 1.0);
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    HomeCategoryTitleImageCellModel *myUnselectedCellModel = (HomeCategoryTitleImageCellModel *)unselectedCellModel;
    myUnselectedCellModel.imageZoomScale = 1.0;

    HomeCategoryTitleImageCellModel *myselectedCellModel = (HomeCategoryTitleImageCellModel *)selectedCellModel;
    myselectedCellModel.imageZoomScale = self.imageZoomScale;
}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

    HomeCategoryTitleImageCellModel *leftModel = (HomeCategoryTitleImageCellModel *)leftCellModel;
    HomeCategoryTitleImageCellModel *rightModel = (HomeCategoryTitleImageCellModel *)rightCellModel;

    if (self.isImageZoomEnabled) {
        leftModel.imageZoomScale = [JXCategoryFactory interpolationFrom:self.imageZoomScale to:1.0 percent:ratio];
        rightModel.imageZoomScale = [JXCategoryFactory interpolationFrom:1.0 to:self.imageZoomScale percent:ratio];
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    if (self.cellWidth == JXCategoryViewAutomaticDimension) {
        CGFloat titleWidth = [super preferredCellWidthAtIndex:index];
        JXCategoryTitleImageType type = [self.imageTypes[index] integerValue];
        CGFloat cellWidth = 0;
        switch (type) {
            case XCCategoryTitleImageType_OnlyTitle:
                cellWidth = titleWidth;
                break;
            case XCCategoryTitleImageType_OnlyImage:
                cellWidth = self.imageSize.width;
                break;
            case XCCategoryTitleImageType_LeftImage:
            case XCCategoryTitleImageType_RightImage:
                cellWidth = titleWidth + self.titleImageSpacing + self.imageSize.width;
                break;
            case XCCategoryTitleImageType_TopImage:
            case XCCategoryTitleImageType_BottomImage:
                cellWidth = MAX(titleWidth, self.imageSize.width);
                break;
            case XCCategoryTitleImageType_ImageTitle: {
                cellWidth = MAX(titleWidth, self.imageSize.width);
                break;
            }
            case XCCategoryTitleImageType_TitleImg: {
                cellWidth = titleWidth;
                break;
            }
        }
        return cellWidth;
    }
    return self.cellWidth;
}
@end
