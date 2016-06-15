//
//  EJDBKeyValue.h
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EJKeyValueModel.h"

@interface EJDBKeyValue : NSObject

/**
 *  存入数据库
 *  @param value 存储的值
 *  @param key  
 */
+ (void)ej_setDBValue:(id)value forKey:(NSString *)key;
+ (id)ej_dbValueForKey:(NSString *)key;
+ (BOOL)ej_removeDBValueForKey:(NSString *)key;

@end
