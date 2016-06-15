//
//  EJBaseWebController.h
//  EJDemo
//
//  Created by iOnRoad on 15/8/12.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "EJBaseViewController.h"

/**
 *  JS调用拦截器协议
 */
@protocol EJWebHandleURLInterceptorDelegate <NSObject>

//如果要拦截URL集中做处理，创建处理类并实现该Delegate
//拦截的URL，如果拦截成功，则需返回NO，不拦截则返回YES
- (BOOL)ej_handlerEventWithURL:(NSString *)url webView:(UIWebView *)webView;
//如果所有继承EJBaseWebController都要执行js，通过调用此方法来执行
- (void)ej_excuteJSForwebView:(UIWebView *)webView;

@end


@interface EJBaseWebController : EJBaseViewController <UIWebViewDelegate>

//注册网页中URL通用拦截器
+ (void)ej_registerWebInterceptorClassName:(NSString *)interceptorClassName;

@property(copy,nonatomic,readonly) NSString *ej_baseH5URL;      //可在ejConfig.plist配置
@property (nonatomic, strong) UIWebView *ej_webView;       //默认的webView视图

- (instancetype)initWithURLString:(NSString *)urlString;

- (void)ej_loadURLString:(NSString *)urlString;  //默认webview
- (void)ej_loadURLString:(NSString *)urlString OfWebView:(UIWebView *)webView;       //加载指定webView的URL

/**
 *  子类可继承捕获链接,处理单个逻辑时可重写该方法，处理集中逻辑时采用新建类并实现EJWebHandleURLInterceptorDelegate
 *  @param url 捕获的连接
 *  @return 如果处理url，则返回NO，如果不处理，则返回YES
 */
- (BOOL)ej_handlerEventWithURL:(NSString *)url;

@end
