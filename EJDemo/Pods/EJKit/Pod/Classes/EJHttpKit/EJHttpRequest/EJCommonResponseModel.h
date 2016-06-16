//
//  EJCommonResponseModel.h
//  HttpTest
//
//  Created by iOnRoad on 16/5/3.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EJHttpResponseDelegate.h"

/*
 *本类只是个示例，用于请求的公共响应参数对象
 *可依据项目在项目中建立新类，并在EJHttpClient调用ej_registerCommonResponseClassName...方法注册
 */
@interface EJCommonResponseModel : NSObject <EJHttpResponseDelegate>

@property(assign,nonatomic) NSInteger flag;
@property(copy,nonatomic) NSString *msg;
@property(copy,nonatomic) NSString *code;

@end
