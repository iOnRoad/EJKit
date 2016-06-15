//
//  UIViewController+EJExtension.h
//  EJDemo
//
//  Created by iOnRoad on 15/10/8.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController  (EJExtension)

/**
 *  获取拿到当前Controller所在NavigationController队列中的指定Controller
 *
 *  @param className 类名
 *
 *  @return UIController
 */
- (UIViewController *)ej_existedControllerInNavigationQueue:(NSString *)className;

/**
 *  Push到下一页
 *
 *  @param className 页面类名
 *  @param parameter 传给下一页的参数
 *  @param animated  是否动画
 */
- (void)ej_openWithClassName:(NSString *)className;
- (void)ej_openWithClassName:(NSString *)className animated:(BOOL)animated;
- (void)ej_openWithClassName:(NSString *)className parameter:(NSDictionary *)param;
- (void)ej_openWithClassName:(NSString *)className parameter:(NSDictionary *)param animated:(BOOL)animated;


/**
 *  pop到上一页
 *
 *  @param className 页面类名
 *  @param parameter 传给上一页的参数
 *  @param animated  是否动画
 */
- (void)ej_popViewController;
- (void)ej_popViewControllerWithAnimated:(BOOL)animated;
- (void)ej_popViewControllerWithParameter:(NSDictionary *)param;
- (void)ej_popWithClassName:(NSString *)className;
- (void)ej_popWithClassName:(NSString *)className animated:(BOOL)animated;
- (void)ej_popWithClassName:(NSString *)className parameter:(NSDictionary *)param;
- (void)ej_popWithClassName:(NSString *)className parameter:(NSDictionary *)param animated:(BOOL)animated;


/**
 *  当pop上一页时传递给上一页的参数，该方法无具体实现，当需要接受参数时，重写实现该方法
 *
 *  @param param 要传递的参数
 */
- (void)ej_upValue:(NSDictionary *)parameter;

/**
 *  当push下一页时传递给下一页的参数，该方法无具体实现，当需要接受参数时，重写实现该方法
 *
 *  @param param 要传递的参数
 */
- (void)ej_nextValue:(NSDictionary *)parameter;



@end
