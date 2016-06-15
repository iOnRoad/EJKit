//
//  NSDate+EJExtension.h
//  EJDemo
//
//  Created by iOnRoad on 15/8/12.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate (EJExtension)

+ (NSDate *)ej_dateFromString:(NSString*)dateStr format:(NSString*)format; //根据格式化的字符串，生成日期
+ (NSString *)ej_stringFromDate:(NSDate*)date; //默认格式日期
+ (NSString *)ej_stringFromDate:(NSDate*)date format:(NSString*)format; //根据日期，生成格式化的字符串
+ (NSString *)ej_getYearFromDate:(NSDate*)date;     //获取年的信息
+ (NSString *)ej_getDayFromDate:(NSDate*)date; //根据日期获取当月的第几天
+ (NSString *)ej_getHourFromeDate:(NSDate *)date;   //根据日期，返回当期小时
+ (NSString *)ej_getMinuteFromeDate:(NSDate *)date;   //根据日期，返回当期分钟
+ (NSString *)ej_getSecondFromeDate:(NSDate *)date;   //根据日期，返回当期秒数
+ (NSString *)ej_getMonthFromDate:(NSDate*)date; //根据日期，获取当年的第几月
+ (NSString *)ej_getWeekFromDate:(NSDate*)date; //根据日期，获取当前的周几，有今日，明日区分。
+ (NSString *)ej_getWeekStrFromeDate:(NSDate *)date;   //根据日期，返回当期周几

+ (NSString *)ej_getAMPMFromDate:(NSDate*)date; //根据日期获取当前是下午还是上午
+ (NSString *)ej_currentSecondOfTime; //当前时间，精确到毫秒

+ (NSString *)ej_getLunarHoliDayDate:(NSDate *)date;        //获取假日信息
+ (NSString *)ej_getLunarSpecialDate:(NSDate *)date;   //获取节气信息

@end
