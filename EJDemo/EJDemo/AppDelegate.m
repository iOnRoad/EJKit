//
//  AppDelegate.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/6.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "AppDelegate.h"
#import "TestHandlerPushNotificationResult.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self registerAppSetting];
    [self loadAppRootViewController];
    
    //EJPushNotificationManager提供系统的Push管理
    //将EJPushNotificationManager.m中以application开头的方法分别在AppDelegate中进行调用
    // 如：在AppDelegate中的 didReceiveRemoteNotification方法中调用  [[EJPushNotificationManager shared] application: didReceiveRemoteNotification:];
    
    //在项目中新建基类，实现EJPushNotificationDelegate，并通过ej_registerPushNotificatonWithLaunchingWithOptions:delegate指定
    TestHandlerPushNotificationResult *handlerPNR = [TestHandlerPushNotificationResult new];
    [[EJPushNotificationManager shared] ej_registerPushNotificatonWithLaunchingWithOptions:launchOptions delegate:handlerPNR];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//加载APP根视图控制器
- (void)loadAppRootViewController{
    NSArray *tbTitles = @[@"视图一",@"视图二",@"视图三"];
    NSArray *tbNormalImageNames = @[@"tb_second",@"tb_first",@"tb_third"];
    NSArray *tbSelectedImageNames = @[@"tb_second_s",@"tb_first_s",@"tb_third_s"];
    NSArray *tbControllerNames = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController"];

    EJCustomTabBarController *ej_customTBCtrl = [EJCustomTabBarController new];
    [ej_customTBCtrl ej_fillTabBarWithTitles:tbTitles normalImgs:tbNormalImageNames selectedImgs:tbSelectedImageNames andControllerNames:tbControllerNames];
    UINavigationController *ej_navCtrl = [[UINavigationController alloc] initWithRootViewController:ej_customTBCtrl];
    ej_customTBCtrl.navigationController.navigationBar.hidden = YES;
    self.window.rootViewController = ej_navCtrl;
    
    [ej_customTBCtrl ej_showRedDotAtIndex:0];
    [ej_customTBCtrl ej_showRedDotWithNumber:2 atIndex:1];
}

- (void)registerAppSetting{
    //注册webView拦截器
    [EJBaseWebController ej_registerWebInterceptorClassName:@"TestWebInterceptor"];
    //注册http请求基本信息
    [[EJHttpClient shared] ej_registerBaseURL:@"http://wthrcdn.etouch.cn"];
    [[EJHttpClient shared] ej_registerInterceptorClassName:@"TestHttpInterceptor"];
    [[EJHttpClient shared] ej_registerCommonResponseClassName:@"WeatherCommonResponse" bizResponseKey:@"data"];
    [[EJHttpClient shared] ej_registerLoadingViewClassName:@"EJDefaultLoadingView" errorViewClassName:@"EJDefaultErrorView"];
    
    //注册百度GPS key
    [[EJBaiduGPSManager shared] ej_registerBaiduGPSKey:@"xxx"];
    //检查权限
    [[EJBaiduGPSManager shared] ej_checkGPSFunction];
    //调用
    [[EJBaiduGPSManager shared] ej_startGPSSuccess:^(EJGPSInfo *gpsInfo) {
        
    } fail:^(NSError *error) {
        
    }];
    
    //写Cookie,向访问链接中写入token
    [[EJHttpCookieManager shared] ej_setCookieOfURLString:@"http://www.xxx.com" withKey:@"token" andValue:@"xxxx"];
    //获取项目中使用的所有的cookie
    [[EJHttpCookieManager shared] ej_cookie];
    
    //配置基类中的颜色、字体等信息
    //赋值EJConfig.plist文件至项目中，修改名字为XXConfig.plist文件，通过EJKitConfigManager指定
    //之后的所有配置信息根据自己项目配置导航条颜色、tabbar的字体大小、颜色等，如果使用默认的加载符，还可以指定加载的图片
    [EJKitConfigManager shared].ej_configPlistName = @"TestConfig.plist";
}


@end
