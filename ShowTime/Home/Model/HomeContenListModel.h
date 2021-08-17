//
//  HomeContenListModel.h
//  ShowTime
//
//  Created by mac on 2021/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsModel;
@interface HomeContenListModel : NSObject

@property(nonatomic, strong)NSArray <GoodsModel *> *data;

@end


@class PictureModel;
@interface GoodsModel : NSObject

@property(nonatomic, strong)NSString *item_name;

@property(nonatomic, strong)NSString *item_subs;

@property(nonatomic, strong)NSString *item_price;

@property(nonatomic, strong)NSString *itemId;

@property(nonatomic, strong)NSArray <PictureModel *> *pictures;

@end



@interface PictureModel : NSObject

@property(nonatomic, strong)NSString *imgUrl;

@property(nonatomic, strong)NSString *itemId;

@end


NS_ASSUME_NONNULL_END
