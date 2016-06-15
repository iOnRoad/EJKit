//
//  InputViewController.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController ()

@end

@implementation InputViewController

- (void)loadView{
    self.view = UIView.new;
    [self addTipLabel];
    [self addInputTextField];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"输入页";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - views
- (void)addTipLabel{
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, [EJTools ej_screenWidth]-30, 21)];
    tipLabel.text = @"本页测试点击输入框，键盘弹出时输入框自动网上滚动功能";
    tipLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:tipLabel];
}

- (void)addInputTextField{
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(15, 400, [EJTools ej_screenWidth]-30, 44)];
    tf.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:tf];
}


@end
