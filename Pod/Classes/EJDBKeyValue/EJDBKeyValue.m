//
//  EJDBKeyValue.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "EJDBKeyValue.h"

@implementation EJDBKeyValue

//耗时操作放在异步队列，具体根据情况
static dispatch_queue_t db_queue()
{
    static dispatch_queue_t db_queue = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db_queue = dispatch_queue_create("com.ej.keyvalue", NULL);
    });
    return db_queue;
}

+ (void)ej_setDBValue:(id)value forKey:(NSString *)key{
    if(key && key.length>0){
        EJKeyValueModel *model = EJKeyValueModel.new;
        model.ej_key = key;
        if(value){
            model.ej_value = @{@"key":value};
            
            dispatch_async(db_queue(), ^{
                [model saveToDB];
            });
        }
    }
}

+ (id)ej_dbValueForKey:(NSString *)key{
    if(key && key.length>0){
        EJKeyValueModel *model = [EJKeyValueModel searchSingleWithWhere:@{@"ej_key":key} orderBy:nil];
        if(model && model.ej_value){
            return [model.ej_value objectForKey:@"key"];
        }
    }
    return nil;
}

+ (BOOL)ej_removeDBValueForKey:(NSString *)key{
    if(key && key.length>0){
        EJKeyValueModel *model = [EJKeyValueModel searchSingleWithWhere:@{@"ej_key":key} orderBy:nil];
        return [model deleteToDB];
    }
    return false;
}


@end
