//
//  UserListModel.h
//  ShowTime
//
//  Created by chengfeng on 2021/8/15.
//

#import <Foundation/Foundation.h>

@class UserModel;
@interface UserListModel : NSObject

@property(nonatomic,strong)NSArray<UserModel *> *data;

@end

@interface UserModel : NSObject

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *nickname;

@property(nonatomic,strong)NSString *phone;

@property(nonatomic,strong)NSString *user_icon;

@end

