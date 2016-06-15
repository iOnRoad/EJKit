//
//  EJKeyValueObject.h
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"

@interface EJKeyValueModel : NSObject

@property(copy,nonatomic) NSString *ej_key;
@property(strong,nonatomic) NSDictionary *ej_value;

@end
