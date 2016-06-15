//
//  EJKeyValueObject.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "EJKeyValueModel.h"

@implementation EJKeyValueModel

static LKDBHelper* ej_kvdb = nil;
+(LKDBHelper *)getUsingLKDBHelper
{
    if(ej_kvdb==nil){
        NSString *sqlitePath = [EJKeyValueModel ej_sqlitePath];
        NSString* dbpath = [sqlitePath stringByAppendingPathComponent:@"AppKeyValue.db"];
        ej_kvdb = [[LKDBHelper alloc] initWithDBPath:dbpath];
    }
    return ej_kvdb;
}

/**
 *  @brief  路径
 *  @return sql
 */
+ (NSString *)ej_sqlitePath{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *sqlitePath = [documentPath stringByAppendingPathComponent:@"sqlite"];
    NSLog(@"%@",sqlitePath);
    return sqlitePath;
}

+ (NSString *)getPrimaryKey{
    return @"ej_key";
}

@end
