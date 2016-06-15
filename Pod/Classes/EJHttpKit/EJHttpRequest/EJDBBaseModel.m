//
//  EJDBModel.m
//  EJDemo
//
//  Created by iOnRoad on 16/5/14.
//
//

#import "EJDBBaseModel.h"

@implementation EJDBBaseModel

static NSString *ej_sqliteFileName=nil;
+ (void)ej_registerSqliteFileName:(NSString *)filename{
    NSString *newFileName = nil;
    if ([filename hasSuffix:@".db"] == NO) {
        newFileName = [NSString stringWithFormat:@"%@.db", filename];
    }
    else {
        newFileName = filename;
    }
    ej_sqliteFileName = newFileName;
    ej_db = nil;
}

static LKDBHelper* ej_db = nil;
+(LKDBHelper *)getUsingLKDBHelper
{
    if(ej_db==nil){
        if(ej_sqliteFileName.length>0){
            NSString *sqlitePath = [EJDBBaseModel ej_sqlitePath];
            NSString* dbpath = [sqlitePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",ej_sqliteFileName]];
            ej_db = [[LKDBHelper alloc] initWithDBPath:dbpath];
        }
    }
    return ej_db;
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

@end

@implementation NSObject(PrintSQL)

+(NSString *)ej_getCreateTableSQL
{
    LKModelInfos* infos = [self getModelInfos];
    NSString* primaryKey = [self getPrimaryKey];
    NSMutableString* table_pars = [NSMutableString string];
    for (int i=0; i<infos.count; i++) {
        
        if(i > 0)
            [table_pars appendString:@","];
        
        LKDBProperty* property =  [infos objectWithIndex:i];
        [self columnAttributeWithProperty:property];
        
        [table_pars appendFormat:@"%@ %@",property.sqlColumnName,property.sqlColumnType];
        
        if([property.sqlColumnType isEqualToString:LKSQL_Type_Text])
        {
            if(property.length>0)
            {
                [table_pars appendFormat:@"(%ld)",(long)property.length];
            }
        }
        if(property.isNotNull)
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_NotNull];
        }
        if(property.isUnique)
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_Unique];
        }
        if(property.checkValue)
        {
            [table_pars appendFormat:@" %@(%@)",LKSQL_Attribute_Check,property.checkValue];
        }
        if(property.defaultValue)
        {
            [table_pars appendFormat:@" %@ %@",LKSQL_Attribute_Default,property.defaultValue];
        }
        if(primaryKey && [property.sqlColumnName isEqualToString:primaryKey])
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_PrimaryKey];
        }
    }
    NSString* createTableSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",[self getTableName],table_pars];
    return createTableSQL;
}

@end
