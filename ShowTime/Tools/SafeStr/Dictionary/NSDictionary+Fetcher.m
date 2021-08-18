//
//  NSDictionary+Fetcher.m
//  vip8
//
//  Created by Rake Yang on 2020/2/18.
//  Copyright © 2020 xin818 inc. All rights reserved.
//

#import "NSDictionary+Fetcher.h"

@implementation NSDictionary (Fetcher)

- (void)xc_valueForKey:(NSString *)key
                string:(void (^)(NSString *val))string
                number:(void (^)(NSNumber *val))number
                array:(void (^)(NSArray *val))array
                dictionary:(void (^)(NSDictionary *val))dictionary
                  null:(void (^)(id val))null {
    if ([key isKindOfClass:[NSNull class]] || key.length <= 0) {
        return;
    }
    id value = self[key];
    if ([value isKindOfClass:[NSString class]]) {
        !string?:string(value);
    } else if ([value isKindOfClass:[NSNumber class]]) {
        !number?:number(value);
    } else if ([value isKindOfClass:[NSArray class]]) {
        !array?:array(value);
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        !dictionary?:dictionary(value);
    } else if ([value isKindOfClass:[NSNull class]]) {
        !null?:null(nil);
    } else {
        !null?:null(value);
    }
}

- (NSString *)xc_stringForKey:(NSString *)key {
    __block NSString *retValue;
    [self xc_valueForKey:key string:^(NSString *val) {
        retValue = val;
    } number:^(NSNumber *val) {
        retValue = val.stringValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (BOOL)xc_boolForKey:(NSString *)key {
    __block BOOL retValue = NO;
    [self xc_valueForKey:key string:^(NSString *val) {
        retValue = val.boolValue;
    } number:^(NSNumber *val) {
        retValue = val.boolValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (NSNumber *)xc_numberForKey:(NSString *)key {
    __block NSNumber *retValue;
    [self xc_valueForKey:key string:^(NSString *val) {
        retValue = @(val.doubleValue);
    } number:^(NSNumber *val) {
        retValue = val;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (int)xc_intForKey:(NSString *)key {
    __block int retValue = 0;
    [self xc_valueForKey:key string:^(NSString *val) {
        retValue = val.intValue;
    } number:^(NSNumber *val) {
        retValue = val.intValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (long)xc_longForKey:(NSString *)key {
    return [self xc_longlongForKey:key];
}

- (long long)xc_longlongForKey:(NSString *)key {
    __block long retValue = 0;
    [self xc_valueForKey:key string:^(NSString *val) {
        retValue = val.longLongValue;
    } number:^(NSNumber *val) {
        retValue = val.longLongValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (float)xc_floatForKey:(NSString *)key {
    __block float retValue = 0.0;
    [self xc_valueForKey:key string:^(NSString *val) {
        retValue = val.floatValue;
    } number:^(NSNumber *val) {
        retValue = val.floatValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (double)xc_doubleForKey:(NSString *)key {
    __block double retValue = 0;
    [self xc_valueForKey:key string:^(NSString *val) {
        retValue = val.doubleValue;
    } number:^(NSNumber *val) {
        retValue = val.doubleValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (NSArray *)xc_arrayForKey:(NSString *)key {
    __block NSArray *retValue;
    [self xc_valueForKey:key string:nil number:nil array:^(NSArray *val) {
        retValue = val;
    } dictionary:nil null:nil];
    return retValue;
}

- (NSDictionary *)xc_dictionaryForKey:(NSString *)key {
    __block NSDictionary *retValue;
    [self xc_valueForKey:key string:nil number:nil array:nil dictionary:^(NSDictionary *val) {
        retValue = val;
    } null:nil];
    return retValue;
}

- (id)xc_objectForKey:(NSString *)key {
    __block id retValue;
    [self xc_valueForKey:key string:^(NSString *val) {
        retValue = val;
    } number:^(NSNumber *val) {
        retValue = val;
    } array:^(NSArray *val) {
        retValue = val;
    } dictionary:^(NSDictionary *val) {
        retValue = val;
    } null:^(id val) {
        retValue = val;
    }];
    return retValue;
}

- (NSString *)queryString {
    if (self.count) {
        NSMutableString *mstr = [NSMutableString string];
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *str = [self xc_stringForKey:key];
            if (str.length) {
                if (mstr.length) {
                    [mstr appendString:@"&"];
                }
                [mstr appendFormat:@"%@=%@", key, str];
            }
        }];
        return mstr;
    }
    return @"";
}

@end
