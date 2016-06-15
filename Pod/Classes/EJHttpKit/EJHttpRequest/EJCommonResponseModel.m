//
//  EJCommonResponseModel.m
//  HttpTest
//
//  Created by iOnRoad on 16/5/3.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "EJCommonResponseModel.h"
#import "MJExtension.h"

@implementation EJCommonResponseModel

MJCodingImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        [EJCommonResponseModel mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    }
    return self;
}

-(BOOL)ej_resultFlag{
    return self.flag;
}

-(NSString *)ej_errorTitle{
    return @"";
}

-(NSString *)ej_errorMessage{
    return self.msg;
}

@end
