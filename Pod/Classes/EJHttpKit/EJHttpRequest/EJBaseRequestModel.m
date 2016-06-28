//
//  EJBaseRequestModel.m
//  EJDemo
//
//  Created by iOnRoad on 15/8/9.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "EJBaseRequestModel.h"
#import "MJExtension.h"
#import "EJBaseViewController.h"

/**
 *  网络请求基类
 */
@implementation EJBaseRequestModel
MJCodingImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        [EJBaseRequestModel mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    }
    return self;
}

- (NSString *)ej_requestURLString{
    return @"";
}

- (NSString *)ej_responseClassName{
    return @"EJBaseResponse";
}

- (BOOL)ej_showLoading{
    return YES;
}

- (NSString *)ej_loadingMessage{
    return @"加载中";
}

- (UIView *)ej_loadingContainerView{
    return [EJBaseViewController ej_currentController].view;
}

- (BOOL)ej_endLoadingWhenFinished{
    return YES;
}

- (BOOL)ej_showErrorMessage{
    return YES;
}

- (BOOL)ej_ignoreDuplicateRequest{
    return YES;
}



@end


