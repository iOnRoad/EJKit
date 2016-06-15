//
//  EJDBModel.h
//  EJDemo
//
//  Created by iOnRoad on 16/5/14.
//
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"

/**
 *  数据库操作基类，注册数据库文件以及可操作数据库的对象
 */
@interface EJDBBaseModel : NSObject

//注册数据库文件名,不同的账户需要注册不同的数据库
+ (void)ej_registerSqliteFileName:(NSString *)filename;

@end



@interface NSObject(PrintSQL)
//打印数据库表操作信息
+(NSString*)ej_getCreateTableSQL;
@end