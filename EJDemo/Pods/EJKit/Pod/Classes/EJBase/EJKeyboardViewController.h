//
//  EJKeyboardViewController.h
//  EJDemo
//
//  Created by iOnRoad on 15/8/15.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "EJBaseViewController.h"

@interface EJKeyboardViewController : EJBaseViewController

@property(nonatomic,assign,readonly) BOOL ej_isKeyboardShow;  //键盘是否展现
@property(nonatomic,assign,readonly) float ej_keyboardHeight;  //键盘高度
@property(nonatomic,assign) BOOL ej_closeAutoScrollInputView;       //当键盘弹出时，当前的输入框是否自动滚动.默认YES。

- (void)ej_keyboardWillShow:(NSNotification *)aNotification;       //键盘显示通知
- (void)ej_keyboardWillHidden:(NSNotification *)aNotification;     //键盘显示通知

@end