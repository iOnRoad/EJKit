//
//  EJHttpCookieManager.h
//  EJDemo
//
//  Created by iOnRoad on 15/10/9.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface EJHttpCookieManager : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(EJHttpCookieManager)

/**
 *  设置指定URL的Cookie信息。
 *
 *  @param urlString 指定URL
 *  @param key       对应的key
 *  @param value     对应的value
 */
- (void)ej_setCookieOfURLString:(NSString *)urlString withKey:(NSString *)key andValue:(NSString *)value;

/**
 *  移除指定URL下的Cookie信息。
 *
 *  @param urlString 指定URL
 */
- (void)ej_removeCookieOfURLString:(NSString *)urlString;
/**
 *  移除本APP所有Cookie信息
 */
- (void)ej_removeAllCookie;

/**
 *  获取系统当期存储的cookie
 *  @return String
 */
- (NSString *)ej_cookie;

@end
