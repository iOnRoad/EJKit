//
//  UIAlertView+EJExtension.h
//  EJDemo
//
//  Created by iOnRoad on 15/8/12.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (EJExtension)

@property(nonatomic,assign) NSTextAlignment ej_contentTextAlignment;

-(void)ej_handlerEventWith:(void (^)(NSInteger btnIndex))aBlock;

@end
