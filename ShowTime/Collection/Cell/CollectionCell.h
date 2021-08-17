//
//  CollectionCell.h
//  ShowTime
//
//  Created by chengfeng on 2021/8/15.
//

#import <UIKit/UIKit.h>
#import "UserListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionCell : UITableViewCell

@property(nonatomic,strong)UserModel *model;

@end

NS_ASSUME_NONNULL_END
