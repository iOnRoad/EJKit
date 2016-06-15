//
//  EJErrorTip.m
//  EJDemo
//
//  Created by iOnRoad on 15/9/29.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import "EJDefaultErrorView.h"
#import "Toast+UIView.h"

@implementation EJDefaultErrorView

- (void)ej_show{
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    [window.rootViewController.view makeToast:self.ej_errorMsg duration:3.0 position:@"center"];
}

@end
