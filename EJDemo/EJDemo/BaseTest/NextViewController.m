//
//  NextViewController.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@property(assign,nonatomic) NSInteger p1;
@property(copy,nonatomic) NSString *p2;

@end

@implementation NextViewController

- (void)ej_nextValue:(NSDictionary *)parameter{
    self.p1 = [parameter[@"p1"] integerValue];
    self.p2 = parameter[@"p2"];
}

- (void)loadView{
    self.view = UIView.new;
    [self addTipLabel];
    [self addP1Label];
    [self addP2Label];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"下一页";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - views
- (void)addTipLabel{
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, [EJTools ej_screenWidth]-30, 21)];
    tipLabel.text = @"本页测试获取上一个页面传的参数信息";
    tipLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:tipLabel];
}

- (void)addP1Label{
    UILabel *p1Label = [[UILabel alloc] initWithFrame:CGRectMake(15, 24, [EJTools ej_screenWidth]-30, 21)];
    p1Label.text = [NSString stringWithFormat:@"%ld",(long)self.p1];
    [self.view addSubview:p1Label];
}

- (void)addP2Label{
    UILabel *p2Label = [[UILabel alloc] initWithFrame:CGRectMake(15, 64, [EJTools ej_screenWidth]-30, 21)];
    p2Label.text = self.p2;
    [self.view addSubview:p2Label];
}

@end
