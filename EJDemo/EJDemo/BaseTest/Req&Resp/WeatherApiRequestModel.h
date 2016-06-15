//
//  WeatherApiRequest.h
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "EJBaseRequestModel.h"

@interface WeatherApiRequestModel : EJBaseRequestModel

@property(copy,nonatomic) NSString *city;

@end
