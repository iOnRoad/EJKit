//
//  UIAlertView+EJExtension.m
//  EJDemo
//
//  Created by iOnRoad on 15/8/12.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "UIAlertView+EJExtension.h"
#import <objc/runtime.h>

@implementation UIAlertView (EJExtension)
@dynamic ej_contentTextAlignment;

static char UIAlertView_key_clicked = 'U';
static char kConttentTextAlignmentKey = 'c';

-(void)ej_handlerEventWith:(void (^)(NSInteger btnIndex))aBlock{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_clicked, aBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTextAlignment)ej_contentTextAlignment{
    NSString *align = objc_getAssociatedObject(self, &kConttentTextAlignmentKey);
    return (NSTextAlignment)[align integerValue];
}

-(void)setEj_contentTextAlignment:(NSTextAlignment)contentTextAlignment{
    self.delegate = self;
    
    NSString *align = [NSString stringWithFormat:@"%ld",(long)contentTextAlignment];
    objc_setAssociatedObject(self, &kConttentTextAlignmentKey, align, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - UIAlertView Delegate
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    void (^block)(NSInteger btnIndex) = objc_getAssociatedObject(self, &UIAlertView_key_clicked);
    if (block){
        block(buttonIndex);
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    if(alertView.alertViewStyle == UIAlertViewStyleSecureTextInput ||
       alertView.alertViewStyle == UIAlertViewStylePlainTextInput){
        UITextField *tf = [alertView textFieldAtIndex:0];
        if(tf && tf.text.length<=0){
            return NO;
        }
    }
 
    return YES;
}

- (void)willPresentAlertView:(UIAlertView *)alertView{
    for( UIView * view in alertView.subviews ){
        if( [view isKindOfClass:[UILabel class]] ){
            UILabel* label = (UILabel*) view;
            label.textAlignment = self.ej_contentTextAlignment;
            break;
        }
    }
}

@end
