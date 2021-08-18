//
//  CategoryListResponse.m
//  ShowTime
//
//  Created by mac on 2021/8/18.
//

#import "CategoryListResponse.h"

@implementation CategoryListResponse

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":[CenterCategoryModel class]};
}

@end

@implementation CenterCategoryModel

@end
