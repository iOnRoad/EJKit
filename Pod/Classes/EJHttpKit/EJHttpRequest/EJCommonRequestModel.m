//
//  EJCommonRequest.m
//  EJDemo
//
//  Created by iOnRoad on 16/5/3.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "EJCommonRequestModel.h"
#import "MJExtension.h"
#import "EJTools.h"
#import "OpenUDID.h"

@implementation EJCommonRequestModel

MJCodingImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        [EJCommonRequestModel mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    }
    return self;
}

//默认返回xxx
-(NSString *)client_id {
    return @"xxx";
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

- (NSString *)dev_type {
    return @"1";
}

- (NSString *)app_guid {
    return @"";
}

- (NSString *)view_id {
    return [EJTools ej_guidString];
}

- (NSString *)push_channel {
    return @"2";
}

- (NSString *)user_token {
    NSString *userToken = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"EJUserToken"];
    return userToken;
}

- (NSString *)device_uuid {
    return [OpenUDID value];
}

//channel
- (NSString *)channel_code {
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    if([@"com.ejdemo.channel" isEqualToString:bundleId]){
        return @"ios_channel";
    }
    else if([@"com.ejdemo.channel1" isEqualToString:bundleId]){
        return @"ios_channel1";
    }
    return @"ios_channel";
}


@end
