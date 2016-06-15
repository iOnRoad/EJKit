//
//  WeatherApiRequest.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "WeatherApiRequestModel.h"

@implementation WeatherApiRequestModel

- (NSString *)ej_requestURLString{
    //此处如果写了域名http://wthrcdn.etouch.cn，则请求时会忽略注册的BaseURL
    return @"http://wthrcdn.etouch.cn/weather_mini";
}

- (NSString *)ej_responseClassName{
    return @"WeatherApiResponseModel";
}

- (NSString *)ej_loadingMessage{
    return @"请求天气信息中";
}

//其他的默认

@end
