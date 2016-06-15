//
//  TestWebInterceptor.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "TestWebInterceptor.h"

@implementation TestWebInterceptor

- (BOOL)ej_handlerEventWithURL:(NSString *)url webView:(UIWebView *)webView{
    //根据URL拦截
    if([@"xxx" isEqualToString:url]){
        //处理业务逻辑，并返回NO，表示不进行跳转
        return NO;
    }
    return  YES;
}

- (void)ej_excuteJSForwebView:(UIWebView *)webView{
    NSString *webTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [[[UIAlertView alloc] initWithTitle:@"执行JS获取网页标题" message:webTitle delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
}

@end
