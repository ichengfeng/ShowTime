//
//  CategoryListResponse.h
//  ShowTime
//
//  Created by mac on 2021/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CenterCategoryModel;
@interface CategoryListResponse : NSObject

@property(nonatomic,strong) NSMutableArray <CenterCategoryModel*> * data;

@end

@interface CenterCategoryModel : NSObject

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, strong) NSString *iconUrl;

@end


NS_ASSUME_NONNULL_END
