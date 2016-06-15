//
//  EJHttpWebCacheManager.m
//  EJDemo
//
//  Created by iOnRoad on 15/10/10.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import "EJHttpWebCacheManager.h"

@implementation EJHttpWebCacheManager
SYNTHESIZE_SINGLETON_FOR_CLASS(EJHttpWebCacheManager)

+ (NSString *)ej_defaultCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"EJURLCache"];
}

- (void)ej_cachedRequest:(NSURLRequest *)request withResponse:(EJHttpCacheResponse)cacheResponse{
    NSCachedURLResponse *urlCacheResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    if(urlCacheResponse){
        //如果有缓存，则直接取缓存
        if(cacheResponse){
            cacheResponse(urlCacheResponse);
        }
    }
    else{
        //如果没有缓存，则存储
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSError *error = nil;
            NSURLResponse *response = nil;
            NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            if (error) {
                if(cacheResponse){
                    cacheResponse(nil);
                }
            }else
            {
                NSCachedURLResponse *urlCacheResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:responseData];
                [[NSURLCache sharedURLCache] storeCachedResponse:urlCacheResponse forRequest:request];
                if(cacheResponse){
                    cacheResponse(urlCacheResponse);
                }
            }
        });
    }
}

- (void)ej_removeCacheForRequest:(NSURLRequest *)request{
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
}


- (void)ej_removeAllRequestCache{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
