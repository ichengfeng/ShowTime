//
//  CenterItemController.h
//  ShowTime
//
//  Created by mac on 2021/8/18.
//

#import <UIKit/UIKit.h>
#import "CategoryListResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface CenterItemController : UIViewController<JXPagerViewListViewDelegate>

@property(nonatomic, strong)CenterCategoryModel *categoryModel;

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@end

NS_ASSUME_NONNULL_END
