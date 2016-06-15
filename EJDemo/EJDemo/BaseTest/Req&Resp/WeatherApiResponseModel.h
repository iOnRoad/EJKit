//
//  WeatherApiResponse.h
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "EJBaseResponseModel.h"

@class WeatherYesterdayResponseModel;
@interface WeatherApiResponseModel : EJBaseResponseModel

@property(copy,nonatomic) NSString *wendu;
@property(copy,nonatomic) NSString *ganmao;
@property(copy,nonatomic) NSString *aqi;
@property(copy,nonatomic) NSArray *city;
@property(strong,nonatomic) WeatherYesterdayResponseModel *yesterday;
@property(strong,nonatomic) NSArray *forecast;

@end

@interface WeatherYesterdayResponseModel : NSObject

@property(copy,nonatomic) NSArray *fl;
@property(copy,nonatomic) NSArray *fx;
@property(copy,nonatomic) NSArray *high;
@property(copy,nonatomic) NSArray *type;
@property(copy,nonatomic) NSArray *low;
@property(copy,nonatomic) NSArray *date;

@end

@interface WeatherForecastResponseModel : NSObject

@property(copy,nonatomic) NSArray *fengxiang;
@property(copy,nonatomic) NSArray *fengli;
@property(copy,nonatomic) NSArray *high;
@property(copy,nonatomic) NSArray *type;
@property(copy,nonatomic) NSArray *low;
@property(copy,nonatomic) NSArray *date;

@end
