//
//  UIColor+EJExtension.h
//  EJDemo
//
//  Created by iOnRoad on 15/8/10.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (EJExtension)

/**
 *  根据十六进制，生成颜色值
 *
 *  @param hexString #000000
 *
 *  @return UIColor
 */
+ (UIColor *)ej_colorWithHexString:(NSString *)hexString;


@end
