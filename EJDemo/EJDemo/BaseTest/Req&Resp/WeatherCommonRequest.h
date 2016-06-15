//
//  WeatherCommonRequest.h
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>


//此处请求WeatherApi没用到通用请求，只是示例
@interface WeatherCommonRequest : NSObject

@property (copy,nonatomic) NSString *version;
@property (copy,nonatomic) NSString *version_code;

@end
