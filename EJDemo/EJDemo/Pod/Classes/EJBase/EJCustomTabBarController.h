//
//  EJCustomTabBarController.h
//  EJDemo
//
//  Created by iOnRoad on 15/4/18.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EJCustomTabBarController : UITabBarController

/**
 *  填充tabBar信息
 *
 *  @param titles          标题集合
 *  @param normalImgs      正常图片集合
 *  @param selectedImgs    高亮图片集合
 *  @param controllerNames 类名字
 */
- (void)ej_fillTabBarWithTitles:(NSArray *)titles normalImgs:(NSArray *)normalImgs selectedImgs:(NSArray *)selectedImgs andControllerNames:(NSArray *)controllerNames;

/**
 *  显示不带数字的小红点,自定义
 *  @param index tabbarItem所在的索引
 */
- (void)ej_showRedDotAtIndex:(NSInteger)index;

/**
 *  显示带有数字的小红点，系统
 *
 *  @param number 数字
 *  @param index  tabbarItem所在的索引
 */
- (void)ej_showRedDotWithNumber:(NSInteger)number atIndex:(NSInteger)index;

/**
 *  移除小红点
 *
 *  @param index tabbarItem所在的索引
 */
- (void)ej_removeBadgeOnItemIndex:(NSInteger)index;

@end
