//
//  EJHttpWebCacheManager.h
//  EJDemo
//
//  Created by iOnRoad on 15/10/10.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

typedef void(^EJHttpCacheResponse)(NSCachedURLResponse *response);

@interface EJHttpWebCacheManager : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(EJHttpWebCacheManager)

/**
 *  存储缓存，并得到对应的数据响应
 *
 *  @param request       请求
 *  @param cacheResponse 响应
 */
- (void)ej_cachedRequest:(NSURLRequest *)request withResponse:(EJHttpCacheResponse)cacheResponse;
/**
 *  移除对应请求的缓存
 *
 *  @param request 请求
 */
- (void)ej_removeCacheForRequest:(NSURLRequest *)request;
/**
 *  移除所有请求的缓存
 */
- (void)ej_removeAllRequestCache;

@end
