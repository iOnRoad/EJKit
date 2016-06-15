//
//  WeatherApiResponse.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "WeatherApiResponseModel.h"

@implementation WeatherApiResponseModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"forecast":[WeatherForecastResponseModel class]};
}

@end


@implementation WeatherYesterdayResponseModel

@end

@implementation WeatherForecastResponseModel

@end
