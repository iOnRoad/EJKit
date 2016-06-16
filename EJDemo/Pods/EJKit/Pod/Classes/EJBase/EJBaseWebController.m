//
//  EJBaseWebController.m
//  EJDemo
//
//  Created by iOnRoad on 15/8/12.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "EJBaseWebController.h"
#import "EJKitConfigManager.h"
#import "EJTools.h"
#import "UIViewController+EJExtension.h"
#import "UIView+EJExtension.h"

@interface EJBaseWebController () 

@property(copy,nonatomic) NSString *ej_URLString;       //当前准备访问的URL

/**该两个字段来决定webView返回时返回到指定的URL界面上 */
@property(assign,nonatomic) BOOL ej_referrer;       //是否开启返回指定URL功能
@property(copy,nonatomic) NSString *ej_referrerURLString;     //准备返回的URL地址

@end

@implementation EJBaseWebController

static NSString *ej_InterceptorClassName = nil;
+ (void)ej_registerWebInterceptorClassName:(NSString *)interceptorClassName{
    ej_InterceptorClassName = interceptorClassName;
}

- (instancetype)initWithURLString:(NSString *)urlString{
    self = [super init];
    if (self) {
        _ej_URLString = urlString;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _ej_referrer = NO;
        _ej_referrerURLString = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self ej_loadURLString:self.ej_URLString];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self ej_setNavBarRightItemWithTitle:@"关闭" action:@selector(ej_closeWebPage)];
}

/**
 *  懒加载ej_webView
 *  @return UIWebView
 */
- (UIWebView *)ej_webView{
    if (!_ej_webView) {
        _ej_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [EJTools ej_screenWidth], [EJTools ej_screenHeight]-64)];
        _ej_webView.scalesPageToFit = YES;
        _ej_webView.scrollView.bounces = NO;
        _ej_webView.scrollView.showsHorizontalScrollIndicator = NO;
        _ej_webView.scrollView.showsVerticalScrollIndicator = NO;
        _ej_webView.backgroundColor = [UIColor ej_baseViewBgColor];
        _ej_webView.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_ej_webView];
        [self.view layoutIfNeeded];
    }
    return _ej_webView;
}

#pragma mark - Actions
- (NSString *)ej_baseH5URL{
    return [EJConfigData ej_baseH5URL];
}

/**
 *  关闭Web页面
 */
- (void)ej_closeWebPage{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  默认调用当前controller的webview
 *
 *  @param urlString 指定加载url
 */
- (void)ej_loadURLString:(NSString *)urlString{
    self.ej_URLString = urlString;
    [self ej_loadURLString:urlString OfWebView:self.ej_webView];
}

/**
 *  在相应的webView上加载指定的URL
 *
 *  @param urlString 访问参数
 *  @param webView  指定的WebView
 */
- (void)ej_loadURLString:(NSString *)urlString OfWebView:(UIWebView *)webView{
    if([EJTools ej_stringIsAvailable:urlString]){
        webView.delegate = self;
        [webView ej_startLoadingByStyle:UIActivityIndicatorViewStyleGray];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
        [webView loadRequest:urlRequest];
    }
}

/**
 *  重写父类方法，返回时返回网页上一页，最后返回首页
 */
-(void)ej_popViewController{
    if (self.ej_referrer) {
        //如果开启返回指定URL功能，则点击返回按钮时跳转到指定URL
        if([EJTools ej_stringIsAvailable:self.ej_referrerURLString]){
            [self ej_loadURLString:self.ej_referrerURLString];
        } else{
            [super ej_popViewController];
        }
    } else {
            if([self.ej_webView canGoBack]){
                [self.ej_webView goBack];
            } else{
                [super ej_popViewController];
            }
    }
}

/**
 *  子类可以继承该方法，截取相对应的链接进行处理，并返回是否继续加载
 *  @param url  要处理的URL
 *  @return 是否继续加载
 */
- (BOOL)ej_handlerEventWithURL:(NSString *)url{
    //点击H5页面中的按钮，调用客户端的关闭页面功能
    if([EJTools ej_stringIsAvailable:url] && [url rangeOfString:[EJConfigData ej_webViewCloseKey]].location != NSNotFound){
        [self ej_closeWebPage];
        return NO;
    }
    //点击H5页面中的按钮，调用客户端的返回功能
    if ([EJTools ej_stringIsAvailable:url] && [url rangeOfString:[EJConfigData ej_webViewBackKey]].location != NSNotFound) {
        [self ej_popViewController];
        return NO;
    }
    
    return YES;
}

#pragma mark - UIWebView Delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self ej_remove404View];
    NSString *ej_url = request.URL.absoluteString;
    
    //下发业务拦截
    if([EJTools ej_stringIsAvailable:ej_InterceptorClassName]){
        Class interceptorClass = NSClassFromString(ej_InterceptorClassName);
        if(interceptorClass){
            //如果存在协议名，则拦截
            __strong NSObject *interceptorObject = [interceptorClass new];
            if([interceptorObject conformsToProtocol:@protocol(EJWebHandleURLInterceptorDelegate)]){
                BOOL flag = [(id<EJWebHandleURLInterceptorDelegate>)(interceptorObject) ej_handlerEventWithURL:ej_url webView:webView];
                if(!flag){
                    return flag;
                }
            }
        }
    }
    
    return [self ej_handlerEventWithURL:ej_url];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView ej_endLoading];
    self.navigationItem.title =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];   //获取网页Title
    
    //获取是否启用返回指定URL功能
    NSString *tReferrer = [webView stringByEvaluatingJavaScriptFromString:[EJConfigData ej_webViewReferrer]];
    self.ej_referrer = NO;
    if ([EJTools ej_stringIsAvailable:tReferrer]) {
        self.ej_referrer = [tReferrer boolValue];
        //获取准备要返回的url地址
        NSString *tReferrerURLString = [webView stringByEvaluatingJavaScriptFromString:[EJConfigData ej_webViewReferrerURL]];
        self.ej_referrerURLString = @"";
        if([EJTools ej_stringIsAvailable:tReferrerURLString]){
            self.ej_referrerURLString = tReferrerURLString;
        }
    }
    
    //执行JS
    if([EJTools ej_stringIsAvailable:ej_InterceptorClassName]){
        Class interceptorClass = NSClassFromString(ej_InterceptorClassName);
        if(interceptorClass){
            //如果存在协议名，则拦截
            __strong NSObject *interceptorObject = [interceptorClass new];
            if([interceptorObject conformsToProtocol:@protocol(EJWebHandleURLInterceptorDelegate)]){
                [(id<EJWebHandleURLInterceptorDelegate>)(interceptorObject) ej_excuteJSForwebView:webView];
            }
        }
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [webView ej_endLoading];
    NSString *failTip = @"";
    if(error.code == NSURLErrorBadURL || error.code == NSURLErrorUnsupportedURL || error.code == NSURLErrorCannotFindHost || error.code == NSURLErrorCannotConnectToHost){
        //超时
        failTip = @"链接地址无效";
    }
    else if(error.code == NSURLErrorTimedOut || error.code == NSURLErrorNotConnectedToInternet){
        //无网
        failTip = @"请求超时";
    }
    
    if([EJTools ej_stringIsAvailable:failTip]){
        self.navigationItem.title = failTip;
        [self ej_show404ViewWithTip:failTip];
    }

}

#pragma mark - private methods
- (void)ej_show404ViewWithTip:(NSString *)tip{
    //containerView
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height-64;
    
    UIImage *errorImage = [UIImage imageNamed:[EJConfigData ej_webView404ImageName]];
    UIView *errorContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, height/2-155, width, errorImage.size.height+20)];
    [self.view addSubview:errorContainerView];
    errorContainerView.tag = 404;
    errorContainerView.backgroundColor = [UIColor clearColor];
    //errorImgView
    UIImageView *errorImgView = [[UIImageView alloc] initWithFrame:CGRectMake((width-errorImage.size.width)/2, 0, errorImage.size.width, errorImage.size.height)];
    errorImgView.image = errorImage;
    [errorContainerView addSubview:errorImgView];
    //errorTipLabel
    UILabel *errorTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, errorImage.size.height+10, width, 20)];
    errorTipLabel.backgroundColor = [UIColor clearColor];
    errorTipLabel.font = [UIFont systemFontOfSize:14];
    errorTipLabel.textAlignment = NSTextAlignmentCenter;
    errorTipLabel.text = tip;
    errorTipLabel.textColor = [UIColor ej_webView404TipColor];
    [errorContainerView addSubview:errorTipLabel];
}

- (void)ej_remove404View{
    UIView *errorContainerView =  [self.view viewWithTag:404];
    if(errorContainerView){
        [errorContainerView removeFromSuperview];
    }
}

@end
