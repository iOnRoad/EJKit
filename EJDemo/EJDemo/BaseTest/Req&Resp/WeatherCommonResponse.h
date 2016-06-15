//
//  WeatherCommonResponse.h
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EJHttpResponseDelegate.h"

@interface WeatherCommonResponse : NSObject<EJHttpResponseDelegate>

@property(copy,nonatomic) NSString *desc;
@property(assign,nonatomic) NSInteger status;

@end
