//
//  EJBaseViewController.h
//  EJDemo
//
//  Created by iOnRoad on 15/10/12.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  基类
 */
@interface EJBaseViewController : UIViewController

//获取当前显示视图最前面的类
+ (nullable EJBaseViewController *)ej_currentController;

- (void)ej_initNavBarSetting;  //默认导航条设置
- (void)ej_setTransparentBar;//设置透明的导航条
- (void)ej_hiddenNavigationBackBtn;        //隐藏返回按钮
- (void)ej_popViewController;       //返回上一页，如在返回时需要业务操作，则子类继承它



#pragma mark - NavigationItem setting
//设置导航右边纯文字按钮
- (nonnull UIBarButtonItem *)ej_setNavBarRightItemWithTitle:(nullable NSString *)title action:(nullable SEL)action;
//设置图片+文字按钮,图片默认左边
- (nonnull UIBarButtonItem *)ej_setNavBarRightItemWithTitle:(nullable NSString *)title imageName:(nullable NSString *)imgName action:(nullable SEL)action;
//设置带图片的功能按钮,图片显示在文字右边
- (nonnull UIBarButtonItem *)ej_setNavBarRightItemForImageInRightPositionWithTitle:(nullable NSString *)title imageName:(nullable NSString *)imgName action:(nullable SEL)action ;

//设置左边按钮文字
- (nonnull UIBarButtonItem *)ej_setNavBarLeftItemWithTitle:(nullable NSString *)title action:(nullable SEL)action;
//设置带图片的功能按钮,图片默认左边
- (nonnull UIBarButtonItem *)ej_setNavBarLeftItemWithTitle:(nullable NSString *)title imageName:(nullable NSString *)imgName action:(nullable SEL)action;
//设置带图片的功能按钮,图片显示在文字右边
- (nonnull UIBarButtonItem *)ej_setNavBarLeftItemForImageInRightPositionWithTitle:(nullable NSString *)title imageName:(nullable NSString *)imgName action:(nullable SEL)action ;

//显示小红点
- (void)ej_showRedDotInNavigationRightItem:(BOOL)show;

@end
