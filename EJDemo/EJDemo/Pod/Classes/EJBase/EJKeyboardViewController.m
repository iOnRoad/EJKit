//
//  EJKeyboardViewController.m
//  EJDemo
//
//  Created by iOnRoad on 15/8/15.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "EJKeyboardViewController.h"
#import "EJKitConfigManager.h"
#import "EJTools.h"

#pragma mark - UIResponder+FirstResponder
//获取响应
@interface UIResponder (EJFirstResponder)

+ (id)ej_currentFirstResponder;

@end


@implementation UIResponder (FirstResponder)

//获取当前的第一响应
static __weak id ej_currentFirstResponder;
+ (id)ej_currentFirstResponder {
    ej_currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(ej_findFirstResponder:) to:nil from:nil forEvent:nil];
    return ej_currentFirstResponder;
}

-(void)ej_findFirstResponder:(id)sender {
    ej_currentFirstResponder = self;
}

@end


#pragma mark - KeyboardViewController

@interface EJKeyboardViewController ()

@property(nonatomic,strong) UIImageView* ej_keyBoardIcon;      //取消键盘响应图片

@end

@implementation EJKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //增加键盘图片
    [self ej_addKeyboardIconImageView];
    //增加点击视图，自动取消键盘事件
    [self ej_addCancelKeyBoardShowEvent];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self ej_registerKeyboardEvent];       //注册键盘事件通知
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self ej_resignKeyboardEvent];     //取消键盘通知
    [self.view endEditing:YES];
}


#pragma mark - 键盘相关
//注册键盘事件
-(void)ej_registerKeyboardEvent{
    self.ej_keyBoardIcon.hidden = NO;
    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ej_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ej_keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ej_keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//取消键盘显示
- (void)ej_addCancelKeyBoardShowEvent{
    //视图增加点击取消键盘
    UITapGestureRecognizer *ej_cancelKeyBoardGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ej_cancelKeyBoardShow)];
    ej_cancelKeyBoardGesture.cancelsTouchesInView = NO;        //这句话为了防止屏蔽视图的所有点击事件。
    [self.view addGestureRecognizer:ej_cancelKeyBoardGesture];
    //ScrollView增加滑动取消键盘
    for(UIView *subView in self.view.subviews){
        if([subView isKindOfClass:[UIScrollView class]]){
            ((UIScrollView *)subView).keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        }
    }
}

//移除键盘通知
- (void)ej_resignKeyboardEvent{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.ej_keyBoardIcon.hidden = YES;
}

//增加键盘图片
-(void)ej_addKeyboardIconImageView{
    //增加键盘图片
    _ej_keyBoardIcon = [[UIImageView alloc] initWithFrame:CGRectMake([EJTools ej_screenWidth]-_ej_keyBoardIcon.image.size.width,
                                                                  [EJTools ej_screenHeight],
                                                                  _ej_keyBoardIcon.image.size.width,
                                                                  _ej_keyBoardIcon.image.size.height)];
    _ej_keyBoardIcon.image = [UIImage imageNamed:[EJConfigData ej_keyboradImgName]];
    [[[UIApplication sharedApplication] delegate].window addSubview:self.ej_keyBoardIcon];
    self.ej_keyBoardIcon.userInteractionEnabled=YES;
    
    UITapGestureRecognizer* keyBoarTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ej_cancelKeyBoardShow)];
    [self.ej_keyBoardIcon addGestureRecognizer:keyBoarTap];
}

- (void)ej_cancelKeyBoardShow{
    [self.view endEditing:YES];
}

#pragma mark - notification methods
//键盘隐藏通知
- (void)ej_keyboardWillHidden:(NSNotification *)aNotification{
    CGRect rect=CGRectMake([EJTools ej_screenWidth]-self.ej_keyBoardIcon.image.size.width,
                           [EJTools ej_screenHeight],
                           self.ej_keyBoardIcon.image.size.width,
                           self.ej_keyBoardIcon.image.size.height);
    
    NSNumber *duration = [aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [aNotification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    if(duration&& curve){
        [self ej_keyBoardAnimation:rect duration:duration.floatValue curve:curve.intValue];
    }
    _ej_isKeyboardShow=NO;
    
    if(!self.ej_closeAutoScrollInputView){
        [self ej_recoverInputViewWhenKeyboardHidden:aNotification];
    }
}

//键盘显示通知
- (void)ej_keyboardWillShow:(NSNotification *)aNotification
{
    
    [self.view bringSubviewToFront:self.ej_keyBoardIcon];
    [self ej_changeKeyboardIconFrame:aNotification];
    _ej_isKeyboardShow=YES;
    
    if(!self.ej_closeAutoScrollInputView){
        [self ej_scrollInputViewWhenKeyboardShow:aNotification];
    }
}

//键盘高度改变通知
- (void)ej_keyboardFrameChanged:(NSNotification *)aNotification{
    [self ej_changeKeyboardIconFrame:aNotification];
    
    if(!self.ej_closeAutoScrollInputView){
        [self ej_scrollInputViewWhenKeyboardShow:aNotification];
    }
}


#pragma mark - private
//当键盘弹出时，自动滚动响应高度的视图
- (void)ej_scrollInputViewWhenKeyboardShow:(NSNotification *)aNotification{
    //UI动画要在主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        _ej_keyboardHeight = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        CGFloat shouldScrollHeight = [self ej_shouldScrollWithKeyboardHeight:_ej_keyboardHeight];
        if(shouldScrollHeight == 0){
            return;
        }
        
        NSNumber *duration = [aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:[duration floatValue] animations:^{
            CGRect bounds = weakSelf.view.bounds;
            weakSelf.view.bounds = CGRectMake(0, shouldScrollHeight + 10, bounds.size.width, bounds.size.height);
        }];
    });
}

//当键盘消失时，自动恢复视图高度
- (void)ej_recoverInputViewWhenKeyboardHidden:(NSNotification *)aNotification{
    //UI动画要在主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        NSNumber *duration = [aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:[duration floatValue] animations:^{
            CGRect bounds = weakSelf.view.bounds;
            weakSelf.view.bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
        }];
    });
}

//计算键盘弹出时要滚动的视图高度
- (CGFloat)ej_shouldScrollWithKeyboardHeight:(CGFloat)keyboardHeight{
    id responder = [UIResponder ej_currentFirstResponder];
    if([responder isKindOfClass:[UITextView class]] || [responder isKindOfClass:[UITextField class]]){
        UIView *view = responder;
        CGFloat y = [responder convertPoint:CGPointZero toView:[UIApplication sharedApplication].delegate.window].y;
        CGFloat bottom = y + view.frame.size.height;
        if(bottom > ([EJTools ej_screenHeight] - _ej_keyboardHeight - 70)){
            return bottom - ([EJTools ej_screenHeight] - _ej_keyboardHeight - 70);
        }
    }
    return 0;
}

//改变键盘图标的高度
- (void)ej_changeKeyboardIconFrame:(NSNotification *)aNotification{
    NSDictionary *userInfo  =  [aNotification userInfo];
    NSValue *aValue  =  [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect  =  [aValue CGRectValue];
    _ej_keyboardHeight  =  keyboardRect.size.height;
    
    NSNumber *duration = [aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [aNotification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGRect rect=CGRectMake([EJTools ej_screenWidth]-self.ej_keyBoardIcon.image.size.width,
                           [EJTools ej_screenHeight]-_ej_keyboardHeight-self.ej_keyBoardIcon.image.size.height,
                           self.ej_keyBoardIcon.image.size.width,
                           self.ej_keyBoardIcon.image.size.height);
    [self ej_keyBoardAnimation:rect duration:duration.floatValue curve:curve.intValue];
}

//隐藏键盘动画
- (void)ej_keyBoardAnimation:(CGRect)containerFrame duration:(float)duration curve:(int)curve
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    UIViewAnimationCurve cu = UIViewAnimationCurveEaseInOut;
    switch (curve) {
        case 0:
            cu = UIViewAnimationCurveEaseInOut;
            break;
        case 1:
            cu = UIViewAnimationCurveEaseIn;
            break;
        case 2:
            cu = UIViewAnimationCurveEaseOut;
            break;
        case 3:
            cu = UIViewAnimationCurveLinear;
            break;
    }
    [UIView setAnimationCurve:cu];
    self.ej_keyBoardIcon.frame = containerFrame;
    [UIView commitAnimations];
}


@end

