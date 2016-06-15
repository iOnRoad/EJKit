//
//  UIActionSheet+EJExtension.m
//  EJDemo
//
//  Created by iOnRoad on 15/8/12.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "UIActionSheet+EJExtension.h"
#import <objc/runtime.h>

@implementation UIActionSheet (EJExtension)

static void *UIActionSheet_key_clicked;

-(void)ej_handlerEventWith:(void (^)(NSInteger btnIndex))aBlock{
    self.delegate = self;
    objc_setAssociatedObject(self, UIActionSheet_key_clicked, aBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - UIActionSheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    void (^block)(NSInteger btnIndex) = objc_getAssociatedObject(self, UIActionSheet_key_clicked);
    if (buttonIndex > self.numberOfButtons || buttonIndex < 0) {
        [self dismissWithClickedButtonIndex:0 animated:YES];
    }
    if (block) block(buttonIndex);
}

@end
