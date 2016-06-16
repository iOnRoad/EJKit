//
//  EJBaseResponse.m
//  EJDemo
//
//  Created by iOnRoad on 15/8/9.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "EJBaseResponseModel.h"
#import "MJExtension.h"

/**
 *  网络通用响应数据基类，所有请求响应对象均需继承它。
 */
@implementation EJBaseResponseModel
MJCodingImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        [EJBaseResponseModel mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    }
    return self;
}


@end

