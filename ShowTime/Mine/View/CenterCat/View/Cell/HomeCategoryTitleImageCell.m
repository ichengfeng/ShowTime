//
//  XCCategoryTitleImageCell.m
//  CodeBook
//
//  Created by mac on 2021/6/22.
//  Copyright © 2021 Podinn. All rights reserved.
//

#import "HomeCategoryTitleImageCell.h"
#import "HomeCategoryTitleImageCellModel.h"

@interface HomeCategoryTitleImageCell ()

@property (nonatomic, strong) id currentImageInfo;
@property (nonatomic, strong) NSString *currentImageName;
@property (nonatomic, strong) NSURL *currentImageURL;
//@property (nonatomic, strong) UIStackView *stackView;
//@property (nonatomic, strong) NSLayoutConstraint *imageViewWidthConstraint;
//@property (nonatomic, strong) NSLayoutConstraint *imageViewHeightConstraint;

@end

@implementation HomeCategoryTitleImageCell

- (void)prepareForReuse {
    [super prepareForReuse];

    self.currentImageName = nil;
    self.currentImageURL = nil;
}

- (void)initializeViews {
    [super initializeViews];
    
    [self.titleLabel removeFromSuperview];

    self.itemImg.hidden = NO;
    self.itemLabel.hidden = NO;
    self.titleImg.hidden = YES;
    
}

- (UIImageView *)itemImg {
    if (!_itemImg) {
        _itemImg = [[UIImageView alloc]init];
        _itemImg.layer.anchorPoint = CGPointMake(0.5, 1);
        _itemImg.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_itemImg];
        [_itemImg mas_makeConstraints:^(MASConstraintMaker *make) {
            ///由于上面设置了anchorPoint（0.5,1）
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.itemLabel.mas_top).offset(22*adjustRatio);
            make.width.height.mas_equalTo(55*adjustRatio);
        }];
    }
    return _itemImg;
}

- (UILabel *)itemLabel {
    if (!_itemLabel) {
        _itemLabel = [[UILabel alloc]init];
        _itemLabel.textColor = [UIColor colorWithHexString:@"#BB1B42"];
        _itemLabel.textAlignment = NSTextAlignmentCenter;
        _itemLabel.font = [UIFont systemFontOfSize:12*adjustRatio weight:UIFontWeightRegular];
        [self.contentView addSubview:_itemLabel];
        [_itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(15*adjustRatio);
            make.bottom.equalTo(self.contentView).offset(-10*adjustRatio);
        }];
    }
    return _itemLabel;
}

- (UIImageView *)titleImg {
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc]init];
        _titleImg.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_titleImg];
        [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.itemLabel);
            make.width.mas_equalTo(55*adjustRatio);
            make.height.mas_equalTo(13.5*adjustRatio);
        }];
    }
    return _titleImg;
}


- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    HomeCategoryTitleImageCellModel *myCellModel = (HomeCategoryTitleImageCellModel *)cellModel;

    self.itemLabel.text = myCellModel.title;
    
    self.itemImg.hidden = NO;
    self.itemLabel.hidden = NO;
    self.titleImg.hidden = NO;
    
    switch (myCellModel.imageType) {
        case XCCategoryTitleImageType_TopImage: {
            self.itemImg.hidden = NO;
            self.itemLabel.hidden = NO;
            self.titleImg.hidden = YES;
            break;
        }
        case XCCategoryTitleImageType_LeftImage: {
//            self.stackView.axis = UILayoutConstraintAxisHorizontal;
//            [self.stackView addArrangedSubview:self.imageView];
//            [self.stackView addArrangedSubview:self.titleLabel];
            break;
        }
        case XCCategoryTitleImageType_BottomImage: {
//            self.stackView.axis = UILayoutConstraintAxisVertical;
//            [self.stackView addArrangedSubview:self.titleLabel];
//            [self.stackView addArrangedSubview:self.imageView];
            break;
        }
        case XCCategoryTitleImageType_RightImage: {
//            self.stackView.axis = UILayoutConstraintAxisHorizontal;
//            [self.stackView addArrangedSubview:self.titleLabel];
//            [self.stackView addArrangedSubview:self.imageView];
            break;
        }
        case XCCategoryTitleImageType_OnlyImage: {
//            self.stackView.axis = UILayoutConstraintAxisVertical;
//            self.titleLabel.hidden = YES;
//            self.imageView.hidden = NO;
//            [self.stackView addArrangedSubview:self.imageView];
            break;
        }
        case XCCategoryTitleImageType_OnlyTitle: {
            self.itemImg.hidden = YES;
            self.itemLabel.hidden = NO;
            self.titleImg.hidden = YES;
            [self.itemLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
            }];
            break;
        }
        case XCCategoryTitleImageType_ImageTitle: {
            self.itemImg.hidden = NO;
            self.itemLabel.hidden = YES;
            self.titleImg.hidden = NO;
            if (myCellModel.isSelected) {
                self.titleImg.image = [UIImage imageNamed:@"title_white_1"];
            }else {
                self.titleImg.image = [UIImage imageNamed:@"title_red_large"];
            }
            break;
        }
        case XCCategoryTitleImageType_TitleImg: {
            self.itemImg.hidden = YES;
            self.itemLabel.hidden = YES;
            self.titleImg.hidden = NO;
            [self.itemLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
            }];
            if (myCellModel.isSelected) {
                self.titleImg.image = [UIImage imageNamed:@"title_red_small_2"];
            }else {
                self.titleImg.image = [UIImage imageNamed:@"title_white_small"];
            }
            break;
        }
    }

    //因为`- (void)reloadData:(JXCategoryBaseCellModel *)cellModel`方法会回调多次，尤其是左右滚动的时候会调用无数次，如果每次都触发图片加载，会非常消耗性能。所以只会在图片发生了变化的时候，才进行图片加载。
    if (myCellModel.loadImageBlock != nil) {
        id currentImageInfo = myCellModel.imageInfo;
        if (myCellModel.isSelected) {
            currentImageInfo = myCellModel.selectedImageInfo;
        }
        if (currentImageInfo && ![currentImageInfo isEqualToString:self.currentImageInfo]) {
            if (myCellModel.loadImageBlock) {
                myCellModel.loadImageBlock(self.itemImg, currentImageInfo);
            }
        }
    }else {
        NSString *currentImageName;
        NSURL *currentImageURL;
        if (myCellModel.imageName) {
            currentImageName = myCellModel.imageName;
        } else if (myCellModel.imageURL) {
            currentImageURL = myCellModel.imageURL;
        }
        if (myCellModel.isSelected) {
            if (myCellModel.selectedImageName) {
                currentImageName = myCellModel.selectedImageName;
            } else if (myCellModel.selectedImageURL) {
                currentImageURL = myCellModel.selectedImageURL;
            }
        }
        if (currentImageName && ![currentImageName isEqualToString:self.currentImageName]) {
            self.currentImageName = currentImageName;
            self.itemImg.image = [UIImage imageNamed:currentImageName];
        } else if (currentImageURL && ![currentImageURL.absoluteString isEqualToString:self.currentImageURL.absoluteString]) {
            self.currentImageURL = currentImageURL;
            
            if ([currentImageURL.absoluteString containsString:@"http"]) {
                NSString *placeHolderName = @"ic_lion";
                if (myCellModel.index > 0) {
                    placeHolderName = [NSString stringWithFormat:@"ic_cat_%d",(int)myCellModel.index];
                    if (myCellModel.index >= 12) {
                        NSInteger pIndex = arc4random()%11;
                        placeHolderName = [NSString stringWithFormat:@"ic_cat_%d",(int)(pIndex+1)];
                    }
                }
                [self.itemImg sd_setImageWithURL:currentImageURL placeholderImage:[UIImage imageNamed:placeHolderName]];
            }else {
                self.itemImg.image = [UIImage imageNamed:currentImageURL.absoluteString];
            }
        }
    }
    
    if (myCellModel.isSelected) {
        self.itemLabel.font = [UIFont systemFontOfSize:14*adjustRatio weight:UIFontWeightMedium];
    }else {
        self.itemLabel.font = [UIFont systemFontOfSize:12*adjustRatio weight:UIFontWeightRegular];
    }

    if (myCellModel.isImageZoomEnabled) {
        self.itemImg.transform = CGAffineTransformMakeScale(myCellModel.imageZoomScale, myCellModel.imageZoomScale);
    } else {
        self.itemImg.transform = CGAffineTransformIdentity;
    }
    
    if (myCellModel.isSelectedAnimationEnabled && [self checkCanStartSelectedAnimation:myCellModel]) {
        JXCategoryCellSelectedAnimationBlock block = [self preferredTitleColorAnimationBlock:myCellModel];
        [self addSelectedAnimationBlock:block];
    } else {
       self.itemLabel.textColor = myCellModel.titleCurrentColor;
    }
}

- (JXCategoryCellSelectedAnimationBlock)preferredTitleColorAnimationBlock:(JXCategoryTitleCellModel *)cellModel {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat percent) {
        if (cellModel.isSelected) {
            //将要选中，textColor从titleNormalColor到titleSelectedColor插值渐变
            cellModel.titleCurrentColor = [JXCategoryFactory interpolationColorFrom:cellModel.titleNormalColor to:cellModel.titleSelectedColor percent:percent];
        } else {
            //将要取消选中，textColor从titleSelectedColor到titleNormalColor插值渐变
            cellModel.titleCurrentColor = [JXCategoryFactory interpolationColorFrom:cellModel.titleSelectedColor to:cellModel.titleNormalColor percent:percent];
        }
        weakSelf.itemLabel.textColor = cellModel.titleCurrentColor;
    };
}


@end
