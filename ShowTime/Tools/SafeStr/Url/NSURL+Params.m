//
//  NSURL+Params.m
//  zmjx
//
//  Created by yupuyang on 2019/5/3.
//  Copyright © 2019 于浦洋. All rights reserved.
//

#import "NSURL+Params.h"

@implementation NSURL (Params)

+ (instancetype)safeURL:(NSString *)URLString {
    NSURL *URL = [self URLWithString:URLString];
    if (!URL) {
        URL = [self URLWithString:[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    }
    return URL;
}

- (NSDictionary *)queryDict {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:self
                                                resolvingAgainstBaseURL:NO];
    NSArray *queryItems = urlComponents.queryItems;
    NSMutableDictionary *result = [NSMutableDictionary new];
    for (NSURLQueryItem *item in queryItems) {
        result[item.name] = item.value;
    }
    return result;
}

@end
