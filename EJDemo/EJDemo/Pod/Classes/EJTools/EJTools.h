//
//  EJTools.h
//  EJDemo
//
//  Created by iOnRoad on 15/8/12.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EJTools : NSObject

+ (UIViewController *)ej_currentController;      ///获取应用当前的Controller

+ (NSString*)ej_guidString; //设备唯一标识
+ (NSString*)ej_deviceInfo; //设备信息

+ (NSString*)ej_getDocumentDir;
+ (NSString*)ej_getTempDir;
+ (NSString*)ej_getCacheDir;
+ (UIImage*)ej_getImageFromSDImageCache:(NSString*)url;

+ (CGFloat)ej_heightOfLabelWithWidth:(float)width fontSize:(int)fontSize content:(NSString*)content minHeight:(float)minHeight; //计算Label的高度
+ (CGFloat)ej_widthOfLabelWithHeight:(float)height fontSize:(int)fontSize content:(NSString*)content minWidth:(float)minWidth; //计算Label的宽度
/**
 *  宽度和高度
 *
 *  @param size     宽度和最大高度
 *  @param fontSize 字体
 *  @param content  计算的字符串
 *
 *  @return 宽度和高度
 */
+ (CGSize)ej_sizeOfLabelWithSize:(CGSize)size fontSize:(int)fontSize content:(NSString*)content; //计算Label的宽度

//AutoLayout Methods
+ (void)ej_setEdge:(UIView*)superview view:(UIView*)view attr:(NSLayoutAttribute)attr constant:(CGFloat)constant;
+ (void)ej_setWidthEqualHeightWithView:(UIView*)view;

+(CGFloat)ej_screenScale;       //屏幕缩放率
+(CGFloat)ej_screenWidth;       //屏幕宽带
+(CGFloat)ej_screenHeight;       //屏幕高度
+(BOOL)ej_isIPhone4;
+(BOOL)ej_isIPhone5;
+(BOOL)ej_isIPhone6;
+(BOOL)ej_isIPhone6Plus;

+ (BOOL)ej_canAuthorizationAssetLibraryAndCamera;       //是否有权限访问相册和相机，两个需要同时判断
+ (BOOL)ej_canAuthorizationLocation;           //是否有权限访问定位服务

+(BOOL)ej_canTel;      //能否打电话
+(void)ej_tel:(NSString *)telNo;       //拨打电话
+(BOOL)ej_canOpenURL:(NSString *)url;      //能否打开这个URL
+(void)ej_openURL:(NSString *)url;     //打开某个URL

+(BOOL)ej_stringIsAvailable:(NSString *)string;        //字符串是否有效
+(BOOL)ej_arrayIsAvailable:(NSArray *)array;           //数组是否有效
+(BOOL)ej_dictionaryIsAvailable:(NSDictionary *)dictionary;        //字典是否有效

+(void)ej_pasteString:(NSString *)string;      //复制字符串
+(void)ej_pasteImage:(UIImage *)image;     //复制图片

//验证手机号是否正确
+ (BOOL)ej_validateMobile:(NSString *)mobile;
//验证字符串是否为有效的email地址
+ (BOOL)ej_validateEmail:(NSString *)email;
//验证字符串是否为纯英文字符串
+ (BOOL)ej_validateOnyEnglishWord:(NSString *)string;
//验证字符串是否为纯数字字符串
+ (BOOL)ej_validateOnlyNumberWord:(NSString *)string;
//验证是否只包含英文和汉字
+ (BOOL)ej_validateOnlyEnglishAndChineseWord:(NSString *)string;
//验证是否只包含英文和数字
+ (BOOL)ej_validateOnlyEnglishAndNumberWord:(NSString *)string;

//检查身份证号是否合法
+ (BOOL)ej_chk18PaperId:(NSString *)sPaperId;
//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)ej_firstCharactor:(NSString *)aString;

@end
