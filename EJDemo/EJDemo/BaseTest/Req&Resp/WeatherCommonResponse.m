//
//  WeatherCommonResponse.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "WeatherCommonResponse.h"

@implementation WeatherCommonResponse
MJCodingImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        [WeatherCommonResponse mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    }
    return self;
}

- (BOOL)ej_resultFlag{
    if([@"OK" isEqualToString:_desc]){
        return YES;
    }
    return NO;
}

-(NSString *)ej_errorTitle{
    return @"";
}

-(NSString *)ej_errorMessage{
    return self.desc;
}


@end
