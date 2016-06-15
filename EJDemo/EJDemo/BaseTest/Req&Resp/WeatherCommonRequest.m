//
//  WeatherCommonRequest.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "WeatherCommonRequest.h"

@implementation WeatherCommonRequest

MJCodingImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        [WeatherCommonRequest mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    }
    return self;
}

//默认返回app版本号
- (NSString *)version {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//默认返回系统版本
- (NSString *)version_code {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    version = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
    return version;
}

@end
