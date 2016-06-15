//
//  EJBaseResponse.h
//  EJDemo
//
//  Created by iOnRoad on 15/8/9.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EJDBBaseModel.h"

/**
 *  网络通用响应业务数据基类，所有请求响应对象均需继承它。
 */
@interface EJBaseResponseModel : EJDBBaseModel

//此处的两个属性，只是用作示例，请求响应数据的通用参数。
//@property(copy,nonatomic) NSString *ej_bizMsg;
//@property(copy,nonatomic) NSString *ej_bizCode;


@end
