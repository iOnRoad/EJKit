//
//  UIImage+EJExtension.m
//  EJDemo
//
//  Created by iOnRoad on 15/7/11.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "UIImage+EJExtension.h"

@implementation UIImage (EJExtension)

+ (UIImage*)ej_stretchableImageNamed:(NSString*)imageName
{
    UIImage* image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height / 2 - 1, image.size.width / 2 - 1, image.size.height / 2 - 1, image.size.width / 2 - 1) resizingMode:UIImageResizingModeStretch];
    return image;
}

+ (UIImage*)ej_imageWithColor:(UIColor*)color
{
    CGRect imgRect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(imgRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, imgRect);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage*)ej_imageWithColor:(UIColor*)color size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)ej_lineWithColor:(UIColor *)color{
    CGRect imgRect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(imgRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置颜色
    CGContextSetStrokeColorWithColor(context, color.CGColor);    //默认
    //设置线宽
    CGContextSetLineWidth(context, 1/[UIScreen mainScreen].scale);
    //绘制路径
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(imgRect), CGRectGetMinY(imgRect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(imgRect), CGRectGetMinY(imgRect));
    CGContextStrokePath(context);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*)ej_screenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow* window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            
            CGContextConcatCTM(context, [window transform]);
            
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

//两张图片合成一张
+ (UIImage *)ej_composeImageWithBgImage:(UIImage *)bgImage image:(UIImage *)image inBGRect:(CGRect)rect scale:(CGFloat)scale{
    UIGraphicsBeginImageContextWithOptions([bgImage size], NO, scale); // 0.0 for scale means "scale for device's main screen".
    // Draw image1
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    // Draw image2
    [image drawInRect:rect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

- (UIImage*)ej_imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage* sourceImage = self;
    UIImage* newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil)
        //pop the context to get back to the default
        UIGraphicsEndImageContext();
    return newImage;
}

//保留透明度信息
- (UIImage *)ej_imageWithTintColor:(UIColor *)tintColor
{
    return [self ej_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

//保留灰度信息
- (UIImage *)ej_imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self ej_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)ej_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

//给图片加上文字水印
- (UIImage *)ej_imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font
{
    UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    //原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //文字颜色
    [color set];
    //水印文字
    [markString drawInRect:rect withAttributes:@{NSFontAttributeName:font}];
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newPic;
}

@end
