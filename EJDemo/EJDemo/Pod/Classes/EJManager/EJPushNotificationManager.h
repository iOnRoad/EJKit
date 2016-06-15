//
//  PushNotificationManager.h
//  LPKitDemo
//
//  Created by iOnRoad on 15/10/12.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SynthesizeSingleton.h"

@protocol EJPushNotificationDelegate <NSObject>

/**
 *  处理通知方法，需要具体类实现该协议来处理业务逻辑
 *
 *  @param result info
 */
- (void)ej_executePushNotificationResult:(NSDictionary *)result;

@optional

/**
 *  收到通知是，是静音还是播放系统声音
 *
 *  @return BOOL
 */
- (BOOL)ej_needSilentWhenAppActive;
/**
 *  收到通知是否振动
 *
 *  @return BOOL
 */
- (BOOL)ej_needVibrateWhenAppActive;

/**
 *  发送token到Server
 *
 *  @param token 要发送的token
 */
- (void)ej_sendTokenToServer:(NSString *)token;
/**
 *  注销token
 */
- (void)ej_logoutPushToken;

@end


/**
 *  在APPDelegate中仍需要声明Push的五种方法，通过如[[PushNotificationManager shared] application:application didReceiveLocalNotification:notificationSettings];来实现逻辑填充
 */
@interface EJPushNotificationManager : NSObject <UIApplicationDelegate>

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(EJPushNotificationManager)

/**
 *  注册通知，如果是通知启动，则处理通知消息
 *
 *  @param launchOptions 启动时选项消息
 *  @param aDelegate     处理通知消息的实现类
 */
- (void)ej_registerPushNotificatonWithLaunchingWithOptions:(NSDictionary *)launchOptions delegate:(id<EJPushNotificationDelegate>)aDelegate;
/**
 *  注销Push
 */
- (void)ej_logoutPushToken;

@end
