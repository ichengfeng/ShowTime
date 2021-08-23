//
//  NSDictionary+Fetcher.h
//  vip8
//
//  Created by Rake Yang on 2020/2/18.
//  Copyright © 2020 xin818 inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Fetcher)

- (NSString *)xc_stringForKey:(NSString *)key;

- (NSNumber *)xc_numberForKey:(NSString *)key;

- (BOOL)xc_boolForKey:(NSString *)key;

- (int)xc_intForKey:(NSString *)key;

- (long)xc_longForKey:(NSString *)key;

- (long long)xc_longlongForKey:(NSString *)key;

- (float)xc_floatForKey:(NSString *)key;

- (double)xc_doubleForKey:(NSString *)key;

- (NSArray *)xc_arrayForKey:(NSString *)key;

- (NSDictionary *)xc_dictionaryForKey:(NSString *)key;

- (id)xc_objectForKey:(NSString *)key;

- (NSString *)queryString;

@end

NS_ASSUME_NONNULL_END
