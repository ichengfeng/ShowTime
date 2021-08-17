//
//  HomeContenListModel.m
//  ShowTime
//
//  Created by mac on 2021/8/16.
//

#import "HomeContenListModel.h"

@implementation HomeContenListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":[GoodsModel class]};
}

@end

@implementation GoodsModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pictures":[PictureModel class]};
}

@end

@implementation PictureModel

@end
