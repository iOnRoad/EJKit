//
//  UIView+EJExtension.m
//  EJDemo
//
//  Created by iOnRoad on 15/8/12.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "UIView+EJExtension.h"

@implementation UIView (EJExtension)

#pragma mark - Functions
/**
 *  返回当前View所在的Controller
 *  @return 当前所在视图的根控制器
 */
- (UIViewController*)ej_viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

/**
 *  视图截屏功能
 *  @return 截屏后的Image
 */
- (UIImage *)ej_snapshot
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}

//移除所有子视图
- (void)ej_removeAllSubviews
{
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

#pragma mark - Actions
- (void)ej_startLoadingByStyle:(UIActivityIndicatorViewStyle)style
{
    [self ej_startLoadingByStyle:style AtPoint:self.center];
}

- (void)ej_startLoadingByStyle:(UIActivityIndicatorViewStyle)style AtPoint:(CGPoint)activityCenter
{
    for (UIActivityIndicatorView* aView in self.subviews) {
        if ([aView isKindOfClass:[UIActivityIndicatorView class]]) {
            [aView startAnimating];
            return;
        }
    }
    
    self.userInteractionEnabled = NO;
    UIActivityIndicatorView* aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    [self addSubview:aiView];
    aiView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:aiView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:aiView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

    [aiView startAnimating];
}

- (void)ej_endLoading
{
    for (UIActivityIndicatorView* aView in self.subviews) {
        if ([aView isKindOfClass:[UIActivityIndicatorView class]]) {
            [aView removeFromSuperview];
        }
    }
    self.userInteractionEnabled = YES;
}

#pragma mark - Location
- (CGFloat)ej_left{
    return self.frame.origin.x;
}

- (void)setEj_left:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = ceilf(x);
    self.frame = frame;
}

- (CGFloat)ej_top{
    return self.frame.origin.y;
}

- (void)setEj_top:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = ceilf(y);
    self.frame = frame;
}

- (CGFloat)ej_right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setEj_right:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = ceilf(right - frame.size.width);
    self.frame = frame;
}

- (CGFloat)ej_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setEj_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = ceilf(bottom - frame.size.height);
    self.frame = frame;
}

- (CGFloat)ej_centerX
{
    return self.center.x;
}

- (void)setEj_centerX:(CGFloat)centerX
{
    self.center = CGPointMake(ceilf(centerX), self.center.y);
}

- (CGFloat)ej_centerY
{
    return self.center.y;
}

- (void)setEj_centerY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, ceilf(centerY));
}

- (CGFloat)ej_width
{
    return self.frame.size.width;
}

- (void)setEj_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = ceilf(width);
    self.frame = frame;
}

- (CGFloat)ej_height
{
    return self.frame.size.height;
}

- (void)setEj_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = ceilf(height);
    self.frame = frame;
}

- (CGPoint)ej_origin
{
    return self.frame.origin;
}

- (void)setEj_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)ej_size
{
    return self.frame.size;
}

- (void)setEj_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
