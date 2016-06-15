//
//  EJHttpCookieManager.m
//  EJDemo
//
//  Created by iOnRoad on 15/10/9.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import "EJHttpCookieManager.h"

@implementation EJHttpCookieManager
SYNTHESIZE_SINGLETON_FOR_CLASS(EJHttpCookieManager)

- (void)ej_setCookieOfURLString:(NSString *)urlString withKey:(NSString *)key andValue:(NSString *)value{
    if(!([urlString isKindOfClass:[NSString class]] && urlString.length>0)){
        NSLog(@"URLString is NULL.");
        return;
    }
    if(!([key isKindOfClass:[NSString class]] && key.length>0)){
        NSLog(@"key is NULL.");
        return;
    }
    if(!([value isKindOfClass:[NSString class]] && value.length>0)){
        NSLog(@"value is NULL.");
        return;
    }
    NSURL *url = [NSURL URLWithString:urlString];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:@{NSHTTPCookieDomain:[url host],NSHTTPCookiePath:[url path],NSHTTPCookieName:key,NSHTTPCookieValue:value}];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}

- (void)ej_removeCookieOfURLString:(NSString *)urlString{
    if(!([urlString isKindOfClass:[NSString class]] && urlString.length>0)){
        NSLog(@"URLString is NULL.");
        return;
    }
    NSURL *url = [NSURL URLWithString:urlString];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
    for(NSHTTPCookie *cookie in cookies){
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

- (void)ej_removeAllCookie{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for(NSHTTPCookie *cookie in cookies){
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

- (NSString *)ej_cookie{
    NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    return [dictCookies objectForKey:@"Cookie"];
}

@end
