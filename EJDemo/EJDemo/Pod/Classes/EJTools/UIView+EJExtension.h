//
//  UIView+EJExtension.h
//  EJDemo
//
//  Created by iOnRoad on 15/8/12.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EJExtension)

#pragma mark - Functions
- (UIViewController*)ej_viewController; //返回当前View所在的Controller
- (UIImage *)ej_snapshot;  //截屏功能
- (void)ej_removeAllSubviews;

#pragma mark - Actions
// 加入loading动画
- (void)ej_startLoadingByStyle:(UIActivityIndicatorViewStyle)style;
- (void)ej_startLoadingByStyle:(UIActivityIndicatorViewStyle)style AtPoint:(CGPoint)activityCenter;
// 结束loading动画
- (void)ej_endLoading;

#pragma mark - Location
//简化视图操作代码量
- (CGFloat)ej_left;
- (void)setEj_left:(CGFloat)x;
- (CGFloat)ej_top;
- (void)setEj_top:(CGFloat)y;
- (CGFloat)ej_right;
- (void)setEj_right:(CGFloat)right;
- (CGFloat)ej_bottom;
- (void)setEj_bottom:(CGFloat)bottom;
- (CGFloat)ej_centerX;
- (void)setEj_centerX:(CGFloat)centerX;
- (CGFloat)ej_centerY;
- (void)setEj_centerY:(CGFloat)centerY;
- (CGFloat)ej_width;
- (void)setEj_width:(CGFloat)width;
- (CGFloat)ej_height;
- (void)setEj_height:(CGFloat)height;
- (CGPoint)ej_origin;
- (void)setEj_origin:(CGPoint)origin;
- (CGSize)ej_size;
- (void)setEj_size:(CGSize)size;

@end
