//
//  EJCommonRequest.h
//  EJDemo
//
//  Created by iOnRoad on 16/5/3.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *本类只是个示例，用于请求的公共请求参数对象
 *可依据项目在项目中建立新类，并在EJHttpClient调用ej_registerCommonRequestClassName...方法注册
 */
@interface EJCommonRequestModel : NSObject

//基本参数信息
@property (copy,nonatomic) NSString *client_id;
@property (copy,nonatomic) NSString *version;
@property (copy,nonatomic) NSString *version_code;
@property (copy,nonatomic) NSString *dev_type;
@property (copy,nonatomic) NSString *app_guid;
@property (copy,nonatomic) NSString *device_uuid;
@property (copy,nonatomic) NSString *channel_code;
@property (copy,nonatomic) NSString *view_id;
@property (copy,nonatomic) NSString *user_token;
@property (copy,nonatomic) NSString *push_channel;

@end
