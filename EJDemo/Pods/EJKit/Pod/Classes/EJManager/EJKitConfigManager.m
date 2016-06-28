//
//  EJKitConfigManager.m
//  Pods
//
//  Created by iOnRoad on 16/3/2.
//
//

#import "EJKitConfigManager.h"
#import "UIColor+EJExtension.h"

@implementation EJKitConfigManager
SYNTHESIZE_SINGLETON_FOR_CLASS(EJKitConfigManager)

- (NSDictionary *)ej_configInfo{
    NSString *configFilePath;
    if(self.ej_configPlistName){
        configFilePath = [[NSBundle mainBundle] pathForResource:self.ej_configPlistName ofType:nil];
    } else {
        configFilePath = [[NSBundle mainBundle] pathForResource:@"EJConfig" ofType:@"plist"];
    }
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:configFilePath];
    return config;
}

- (UIColor *)ej_colorWithKey:(NSString *)key{
    NSDictionary *colorInfo = [self ej_configInfo][@"color"];
    if(key&&key.length>0){
        NSString *colorString =  colorInfo[key];
        if(colorString){
            return [UIColor ej_colorWithHexString:colorString];
        }
    }
    return nil;
}

- (NSString *)ej_stringWithKey:(NSString *)key{
    NSDictionary *dataInfo = [self ej_configInfo][@"data"];
    if(key&&key.length>0){
        return dataInfo[key];
    }
    return nil;
}

- (UIFont *)ej_fontWithKey:(NSString *)key{
    NSDictionary *dataInfo = [self ej_configInfo][@"font"];
    if(key&&key.length>0){
        float fontSize = ((NSNumber *)dataInfo[key]).floatValue;
        return [UIFont systemFontOfSize:fontSize];
    }
    return [UIFont systemFontOfSize:[UIFont systemFontSize]];
}

@end


@implementation UIColor (EJKitStandard)

+ (UIColor *)ej_baseViewBgColor{
    return [[EJKitConfigManager shared] ej_colorWithKey:@"baseview_backgroundColor"];
}

+ (UIColor *)ej_navBarTextColor{
    return [[EJKitConfigManager shared] ej_colorWithKey:@"navigationBar_textColor"];
}

+ (UIColor *)ej_navBarBgColor{
    return [[EJKitConfigManager shared] ej_colorWithKey:@"navigationBar_backgroundColor"];
}

+ (UIColor *)ej_navBarShadowLineColor{
    return [[EJKitConfigManager shared] ej_colorWithKey:@"navigationBar_shadowLineColor"];
}

+ (UIColor *)ej_tabbarNormalStateColor{
    return [[EJKitConfigManager shared] ej_colorWithKey:@"tabbar_normalTextColor"];
}

+ (UIColor *)ej_tabbarSelectedStateColor{
    return [[EJKitConfigManager shared] ej_colorWithKey:@"tabbar_selectedTextColor"];
}

+ (UIColor *)ej_tabbarBgColor{
    return [[EJKitConfigManager shared] ej_colorWithKey:@"tabbar_backgroundColor"];
}

+ (UIColor *)ej_webView404TipColor{
    return [[EJKitConfigManager shared] ej_colorWithKey:@"webView404TipColor"];
}

@end


@implementation UIFont (EJKitStandard)

+ (UIFont *)ej_navBarTitleFont{
    return [[EJKitConfigManager shared] ej_fontWithKey:@"navigationbar_title"];
}

+ (UIFont *)ej_navBarItemFont{
    return [[EJKitConfigManager shared] ej_fontWithKey:@"navigationbar_item"];
}


+ (UIFont *)ej_tabbarTextFont{
    return [[EJKitConfigManager shared] ej_fontWithKey:@"tabbar_text"];
}

@end


@implementation EJConfigData

+ (NSString *)ej_navigationBarBackImgName{
    return [[EJKitConfigManager shared] ej_stringWithKey:@"navigatoinBar_backImgName"];
}

+ (NSString *)ej_tabBarBgImgName{
    return [[EJKitConfigManager shared] ej_stringWithKey:@"tabbar_bgImgName"];
}

+ (NSString *)ej_keyboradImgName{
    return [[EJKitConfigManager shared] ej_stringWithKey:@"keyboradImgName"];
}

+ (NSString *)ej_baseH5URL{
    return [[EJKitConfigManager shared] ej_stringWithKey:@"H5BaseURL"];
}

+ (NSString *)ej_webViewBackKey{
    return [[EJKitConfigManager shared] ej_stringWithKey:@"webViewBackKey"];
}

+ (NSString *)ej_webViewCloseKey{
    return [[EJKitConfigManager shared] ej_stringWithKey:@"webViewCloseKey"];
}

+ (NSString *)ej_webViewReferrer{
    return [[EJKitConfigManager shared] ej_stringWithKey:@"webViewReferrer"];
}

+ (NSString *)ej_webViewReferrerURL{
    return [[EJKitConfigManager shared] ej_stringWithKey:@"webViewReferrerURL"];
}

+ (NSString *)ej_webView404ImageName{
    return [[EJKitConfigManager shared] ej_stringWithKey:@"webView404ImageName"];
}


@end