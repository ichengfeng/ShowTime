//
//  NSURL+Params.h
//  zmjx
//
//  Created by yupuyang on 2019/5/3.
//  Copyright © 2019 于浦洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Params)

+ (instancetype)safeURL:(NSString *)URLString;

- (NSDictionary *)queryDict;

@end

NS_ASSUME_NONNULL_END
