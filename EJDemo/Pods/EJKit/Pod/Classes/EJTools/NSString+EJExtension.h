//
//  NSString+EJExtension.h
//  EJDemo
//
//  Created by iOnRoad on 15-4-21.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (EJExtension)

///对字符串进行URL编码和解码
- (NSString*)ej_urlDecode;
- (NSString*)ej_urlEncode;

///根据字符串，生成响应的Controller，View和加载xib的View
- (UIViewController *)ej_controller;
- (UIView *)ej_view;
- (UIView *)ej_xibViewWithOwner:(id)owner;

@end
