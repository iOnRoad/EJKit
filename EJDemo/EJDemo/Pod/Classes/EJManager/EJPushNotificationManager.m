//
//  PushNotificationManager.m
//  LPKitDemo
//
//  Created by iOnRoad on 15/10/12.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import "EJPushNotificationManager.h"
#import <objc/runtime.h>
#import "UIAlertView+EJExtension.h"
#import <AudioToolbox/AudioToolbox.h>

@interface EJPushNotificationManager ()

@property(nonatomic,assign) id<EJPushNotificationDelegate> delegate;

@end

@implementation EJPushNotificationManager

SYNTHESIZE_SINGLETON_FOR_CLASS(EJPushNotificationManager)

- (void)ej_registerPushNotificatonWithLaunchingWithOptions:(NSDictionary *)launchOptions delegate:(id<EJPushNotificationDelegate>)aDelegate{
    self.delegate = aDelegate;
    
    [self ej_registerPushNotification];
    
    //从Push通知启动程序，减少badge显示
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //处理Push消息
    NSDictionary* notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (notification) {
        if([_delegate respondsToSelector:@selector(ej_executePushNotificationResult:)]){
            [_delegate ej_executePushNotificationResult:notification];
        }
    }
}

/**
 *  注册通知，区分8.0系统上或下
 */
- (void)ej_registerPushNotification{
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //8.0上注册通知
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else{
        //8.0下注册通知
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
}

- (void)ej_logoutPushToken{
    if([_delegate respondsToSelector:@selector(ej_logoutPushToken)]){
        [self.delegate ej_logoutPushToken];
    }
}


#pragma mark - PushNotificationManger methods
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"registerForRemote fail:%@", error);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString* token = [NSString stringWithFormat:@"%@", deviceToken];
    token = [token substringFromIndex:1];
    token = [token substringToIndex:(token.length - 1)];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //传递token
    if([_delegate respondsToSelector:@selector(ej_sendTokenToServer:)]){
        [self.delegate ej_sendTokenToServer:token];
    }
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    //需要时实现
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    //区分激活Or后台
    if (application.applicationState == UIApplicationStateActive) {
        NSMutableDictionary *notificationDic = [@{} mutableCopy];
        [notificationDic addEntriesFromDictionary:userInfo];
        
        NSDictionary* aps = [notificationDic objectForKey:@"aps"];
        NSString* message = [aps objectForKey:@"alert"];
        
        NSString*prodName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:prodName message:message delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"查看", nil];
        [alert show];
        [alert ej_handlerEventWith:^(NSInteger btnIndex) {
            if (btnIndex != 0) {
                if([_delegate respondsToSelector:@selector(ej_executePushNotificationResult:)]){
                    [_delegate ej_executePushNotificationResult:userInfo];
                }
            }
        }];
        
        if([_delegate respondsToSelector:@selector(ej_needSilentWhenAppActive)]){
            if(![self.delegate ej_needSilentWhenAppActive]){
                //播放系统声音
                AudioServicesPlaySystemSound(1007);
            }
            else{
                //播放静音
                AudioServicesPlaySystemSound(0);
            }
        }
        if([_delegate respondsToSelector:@selector(ej_needVibrateWhenAppActive)]){
            //播放振动
            if([self.delegate ej_needVibrateWhenAppActive]){
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
        }

    }else{
        if([_delegate respondsToSelector:@selector(ej_executePushNotificationResult:)]){
            [_delegate ej_executePushNotificationResult:userInfo];
        }
    }
}

@end
