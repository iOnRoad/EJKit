//
//  UIImage+EJExtension.h
//  EJDemo
//
//  Created by iOnRoad on 15/7/11.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EJExtension)

+ (UIImage*)ej_stretchableImageNamed:(NSString*)imageName; //拉伸图片
+ (UIImage*)ej_imageWithColor:(UIColor*)color; //根据颜色生成图片
+ (UIImage*)ej_imageWithColor:(UIColor*)color size:(CGSize)size; //根据颜色生成图片
+ (UIImage *)ej_lineWithColor:(UIColor *)color;  //生成分割线
+ (UIImage*)ej_screenshot; //屏幕截图
//两张图片合成一张
+ (UIImage *)ej_composeImageWithBgImage:(UIImage *)bgImage image:(UIImage *)image inBGRect:(CGRect)rect scale:(CGFloat)scale;

- (UIImage*)ej_imageByScalingAndCroppingForSize:(CGSize)targetSize; //压缩成指定大小的图片
//改变图片背景颜色
- (UIImage *) ej_imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) ej_imageWithGradientTintColor:(UIColor *)tintColor;
//给图加上文字水印
- (UIImage *)ej_imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;

@end
