//
//  EJTools.m
//  EJDemo
//
//  Created by iOnRoad on 15/8/12.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "EJTools.h"
//Runtime
#import <objc/runtime.h>
//MAC Address
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <netinet/in.h>
//相册
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
//Other
#import "KeychainItemWrapper.h"
#import <SDWebImage/SDImageCache.h>

@implementation EJTools

#pragma mark - Controller
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)ej_currentController{
    //获取Window
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    //获取当前Controller
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }
    else{
        result = window.rootViewController;
    }
    
    if([result isKindOfClass:[UINavigationController class]]){
        result = ((UINavigationController *)result).topViewController;
    }
    return result;
}

#pragma mark - Guid
+ (NSString*)ej_GUIDString
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString*)string;
}

+ (NSString*)ej_GetGUIDString
{
    KeychainItemWrapper* wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"GUID" accessGroup:nil];
    
    //从keychain里取出GUID
    NSString* guid = [wrapper objectForKey:(__bridge id)kSecValueData];
    if (guid && ![guid isEqualToString:@""]) {
        return guid;
    }
    else {
        guid = [self ej_GUIDString];
        [wrapper setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"] forKey:(__bridge id)kSecAttrService];
        [wrapper setObject:guid forKey:(__bridge id)kSecValueData];
        return guid;
    }
}

+ (NSString*)ej_guidString
{
    NSString* guid = [self ej_GetGUIDString];
    return guid;
}

//MD5加密
//+ (NSString*)ej_MD5:(NSString*)str
//{
//    const char* cStr = [str UTF8String];
//    unsigned char result[16];
//    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
//    return [NSString stringWithFormat:
//            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]];
//}

#pragma mark - deviceInfo
//设备信息
+ (NSString*)ej_deviceInfo
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char* machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString* platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return [self ej_platformType:platform];
}

+ (NSString*)ej_platformType:(NSString*)platform
{
    if ([platform isEqualToString:@"iPhone1,1"])
        return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])
        return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])
        return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])
        return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])
        return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])
        return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])
        return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])
        return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])
        return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])
        return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])
        return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])
        return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])
        return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"])
        return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"])
        return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"])
        return @"iPhone 6S Plus";
    if ([platform isEqualToString:@"iPod1,1"])
        return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])
        return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])
        return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])
        return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])
        return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])
        return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])
        return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])
        return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])
        return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])
        return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])
        return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])
        return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])
        return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])
        return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])
        return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])
        return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])
        return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])
        return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])
        return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"i386"])
        return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])
        return @"Simulator";
    return platform;
}

#pragma mark - System FileDir
+ (NSString*)ej_getDocumentDir
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths.lastObject;
}

+ (NSString*)ej_getTempDir
{
    return NSTemporaryDirectory();
}

+ (NSString*)ej_getCacheDir
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return paths.lastObject;
}

+ (UIImage*)ej_getImageFromSDImageCache:(NSString*)url
{
    UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:url];
    if (image) {
        return image;
    }
    image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
    return image;
}

#pragma mark - Label Width Height
//计算Label的高度
+ (CGFloat)ej_heightOfLabelWithWidth:(float)width fontSize:(int)fontSize content:(NSString*)content minHeight:(float)minHeight
{
    if (![EJTools ej_stringIsAvailable:content]) {
        return minHeight;
    }
    
    NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize] }];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGFloat height = (rect.size.height <= minHeight) ? minHeight : (rect.size.height + 2);
    return height;
}

//计算Label的宽度
+ (CGFloat)ej_widthOfLabelWithHeight:(float)height fontSize:(int)fontSize content:(NSString*)content minWidth:(float)minWidth
{
    if (![EJTools ej_stringIsAvailable:content]) {
        return minWidth;
    }
    
    NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:content attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:fontSize] }];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGFloat width = (rect.size.width <= minWidth) ? minWidth : (rect.size.width+2);
    return width;
}

+ (CGSize)ej_sizeOfLabelWithSize:(CGSize)size fontSize:(int)fontSize content:(NSString*)content
{
    if (![EJTools ej_stringIsAvailable:content]) {
        return CGSizeZero;
    }
    CGRect rect = [content boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                     context:nil];
    return rect.size;
}


//AutoLayout Methods
//边距辅助方法，相等概念
+ (void)ej_setEdge:(UIView*)superview view:(UIView*)view attr:(NSLayoutAttribute)attr constant:(CGFloat)constant
{
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:attr relatedBy:NSLayoutRelationEqual toItem:superview attribute:attr multiplier:1.0 constant:constant]];
}

//相等辅助方法 宽高相等
+ (void)ej_setWidthEqualHeightWithView:(UIView*)view
{
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
}

//屏幕缩放率
+(CGFloat)ej_screenScale{
    return 1/[UIScreen mainScreen].scale;
}

//屏幕宽带
+(CGFloat)ej_screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}

//屏幕高度
+(CGFloat)ej_screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

+(BOOL)ej_isIPhone4{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO) || [self ej_screenHeight] == 480;
}
+(BOOL)ej_isIPhone5{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO) || [self ej_screenHeight] == 568;
}
+(BOOL)ej_isIPhone6{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO) || [self ej_screenHeight] == 667;
}

+(BOOL)ej_isIPhone6Plus{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO) || [self ej_screenHeight] == 736;
}

//是否有权限访问相册
+ (BOOL)ej_canAuthorizationAssetLibraryAndCamera{
    //验证相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        NSString *prodName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
        NSString *message = [NSString stringWithFormat:@"相机权限未授权，请到设置->隐私->相机开启【%@】相机权限。",prodName];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    //验证图片库权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
        //无权限,提示
        NSString *prodName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
        NSString *message = [NSString stringWithFormat:@"照片权限未授权，请到设置->隐私->照片开启【%@】照片权限。",prodName];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    return YES;
}

//是否有权限访问定位服务
+ (BOOL)ej_canAuthorizationLocation{
    if (![CLLocationManager locationServicesEnabled] || ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)) {
        NSString *prodName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
        NSString *message = [NSString stringWithFormat:@"请到设置->隐私->定位服务中开启【%@】定位服务，以便能够获取您的位置。",prodName];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    return YES;
}

//能否打电话
+(BOOL)ej_canTel{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]];
}
//拨打电话
+(void)ej_tel:(NSString *)telNo{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", telNo]]];
}
//能否打开这个URL
+(BOOL)ej_canOpenURL:(NSString *)url{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
}

//打开某个URL
+(void)ej_openURL:(NSString *)url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

//字符串是否有效
+(BOOL)ej_stringIsAvailable:(NSString *)string{
    if(string && [string isKindOfClass:[NSString class]] && [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0){
        return YES;
    }
    return NO;
}

//数组是否有效
+(BOOL)ej_arrayIsAvailable:(NSArray *)array{
    if(array && [array isKindOfClass:[NSArray class]] && [array count] > 0){
        return YES;
    }
    return NO;
}

//字典是否有效
+(BOOL)ej_dictionaryIsAvailable:(NSDictionary *)dictionary{
    if(dictionary && [dictionary isKindOfClass:[NSDictionary class]] && [dictionary count] > 0){
        return YES;
    }
    return NO;
}

//复制字符串
+(void)ej_pasteString:(NSString *)string{
    [[UIPasteboard generalPasteboard] setString:string];
}

//复制图片
+(void)ej_pasteImage:(UIImage *)image{
    [[UIPasteboard generalPasteboard] setImage:image];
}

//验证手机号是否正确
+ (BOOL)ej_validateMobile:(NSString *)mobile{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '1\\\\d{10}'"] evaluateWithObject:mobile];
}

//验证字符串是否为有效的email地址
+ (BOOL)ej_validateEmail:(NSString *)email{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$'"] evaluateWithObject:email];
}

//验证字符串是否为纯英文字符串
+ (BOOL)ej_validateOnyEnglishWord:(NSString *)string{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '^([a-zA-Z])'"] evaluateWithObject:string];
}

//验证字符串是否为纯数字字符串
+ (BOOL)ej_validateOnlyNumberWord:(NSString *)string{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '^([0-9\\n]+)'"] evaluateWithObject:string];
}

//验证是否只包含英文和汉字
+ (BOOL)ej_validateOnlyEnglishAndChineseWord:(NSString *)string{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '[/a-zA-Z\u4e00-\u9fa5\\\\s]{1,99}'"] evaluateWithObject:string];
}

//验证是否只包含英文和数字
+ (BOOL)ej_validateOnlyEnglishAndNumberWord:(NSString *)string{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES '^[A-Za-z0-9\\\\s\\n]+$'"] evaluateWithObject:string];
}


//检查身份证号是否合法
+ (NSString*)ej_getStringWithRange:(NSString*)str Value1:(NSInteger)value1 Value2:(NSInteger)value2;
{
    return [str substringWithRange:NSMakeRange(value1, value2)];
}

+ (BOOL)ej_areaCode:(NSString*)code
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        
        return NO;
    }
    return YES;
}

+ (BOOL)ej_chk18PaperId:(NSString*)sPaperId
{
    //判断位数
    if ([sPaperId length] != 15 && [sPaperId length] != 18) {
        return NO;
    }
    
    NSString* carid = sPaperId;
    long lSumQT = 0;
    //加权因子
    int R[] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11] = { '1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2' };
    
    //将15位身份证号转换成18位
    
    NSMutableString* mString = [NSMutableString stringWithString:sPaperId];
    if ([sPaperId length] == 15) {
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        const char* pid = [mString UTF8String];
        for (int i = 0; i <= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        NSString* string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    //判断地区码
    NSString* sProvince = [carid substringToIndex:2];
    
    if (![EJTools ej_areaCode:sProvince]) {
        return NO;
    }
    
    //判断年月日是否有效
    
    //年份
    int strYear = [[EJTools ej_getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    int strMonth = [[EJTools ej_getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    int strDay = [[EJTools ej_getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    NSTimeZone* localZone = [NSTimeZone localTimeZone];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01", strYear, strMonth, strDay]];
    if (date == nil) {
        return NO;
    }

    const char* PaperId = [carid UTF8String];
    
    //检验长度
    if (18 != strlen(PaperId))
        return NO;
    //校验数字
    for (int i = 0; i < 18; i++) {
        if (!isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i)) {
            return NO;
        }
    }
    //验证最末的校验码
    for (int i = 0; i <= 16; i++) {
        lSumQT += (PaperId[i] - 48) * R[i];
    }
    if (sChecker[lSumQT % 11] != PaperId[17]) {
        return NO;
    }
    
    return YES;
}


//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)ej_firstCharactor:(NSString *)aString {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}


@end
