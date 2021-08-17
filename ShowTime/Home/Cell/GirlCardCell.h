//
//  GirlCardCell.h
//  ShowTime
//
//  Created by mac on 2021/8/16.
//

#import <UIKit/UIKit.h>
#import "HomeContenListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GirlCardCell : UICollectionViewCell

@property(nonatomic, strong)PictureModel *model;
@property(nonatomic, assign) NSUInteger index;

@end

NS_ASSUME_NONNULL_END
