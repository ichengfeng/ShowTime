//
//  XCCategoryTitleImageCellModel.h
//  CodeBook
//
//  Created by mac on 2021/6/22.
//  Copyright © 2021 Podinn. All rights reserved.
//

#import <JXCategoryView/JXCategoryView.h>

typedef NS_ENUM(NSUInteger, XCCategoryTitleImageType) {
    ///上面图片，下面文字
    XCCategoryTitleImageType_TopImage = 0,
    XCCategoryTitleImageType_LeftImage,
    XCCategoryTitleImageType_BottomImage,
    XCCategoryTitleImageType_RightImage,
    XCCategoryTitleImageType_OnlyImage,
    ///只有标题文字
    XCCategoryTitleImageType_OnlyTitle,
    ///上面image，下面title也用image
    XCCategoryTitleImageType_ImageTitle,
    ///只有title，且title用image展示
    XCCategoryTitleImageType_TitleImg,
};

@interface HomeCategoryTitleImageCellModel : JXCategoryTitleCellModel

@property (nonatomic, assign) XCCategoryTitleImageType imageType;

@property (nonatomic, strong) id imageInfo;
@property (nonatomic, strong) id selectedImageInfo;
@property (nonatomic, copy) void(^loadImageBlock)(UIImageView *imageView, id info);

@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);

@property (nonatomic, assign) CGSize imageSize;     //默认CGSizeMake(20, 20)

@property (nonatomic, assign) CGFloat titleImageSpacing;    //titleLabel和ImageView的间距，默认5

@property (nonatomic, assign, getter=isImageZoomEnabled) BOOL imageZoomEnabled;

@property (nonatomic, assign) CGFloat imageZoomScale;

@property (nonatomic, copy) NSString *imageName;    //加载bundle内的图片

@property (nonatomic, strong) NSURL *imageURL;      //图片URL

@property (nonatomic, copy) NSString *selectedImageName;

@property (nonatomic, strong) NSURL *selectedImageURL;

@end
