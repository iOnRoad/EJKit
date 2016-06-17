//
//  FirstViewController.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)loadView{
    self.view = UIView.new;
    [self addGoNextBtn];
    [self addGoWebBtn];
    [self addGoInputBtn];
    [self addNavBarSearchBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"测试Base相关";
}

#pragma mark - views
- (void)addGoNextBtn{
    UIButton *goNextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    goNextBtn.frame = CGRectMake(15, 24, [EJTools ej_screenWidth]-30, 44);
    [goNextBtn setTitle:@"进入下一页" forState:UIControlStateNormal];
    [goNextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [goNextBtn addTarget:self action:@selector(goNextView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goNextBtn];
}

- (void)addGoWebBtn{
    UIButton *goWebBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    goWebBtn.frame = CGRectMake(15, 84, [EJTools ej_screenWidth]-30, 44);
    [goWebBtn setTitle:@"查看Web视图" forState:UIControlStateNormal];
    [goWebBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [goWebBtn addTarget:self action:@selector(goWebView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goWebBtn];
}

- (void)addGoInputBtn{
    UIButton *goInputBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    goInputBtn.frame = CGRectMake(15, 144, [EJTools ej_screenWidth]-30, 44);
    [goInputBtn setTitle:@"进入输入页面" forState:UIControlStateNormal];
    [goInputBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [goInputBtn addTarget:self action:@selector(goInputView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goInputBtn];
}

- (void)addNavBarSearchBtn{
    EJBaseViewController *currentController = [EJBaseViewController ej_currentController];
//    [self ej_setNavBarRightItemWithTitle:@"搜索" action:@selector(goSearchView: )];
    //设置导航条右上角BarItem
    [self ej_setNavBarRightItemWithTitle:nil imageName:@"first_search" action:@selector(goSearchView:)];
    [self ej_setNavBarRightItemForImageInRightPositionWithTitle:@"搜索" imageName:@"first_search" action:@selector(goSearchView: )];
    
//    [self ej_setNavBarLeftItemWithTitle:@"搜索" action:@selector(goSearchView: )];
        [self ej_setNavBarLeftItemWithTitle:@"搜索" imageName:@"first_search" action:@selector(goSearchView:)];
//    [self ej_setNavBarLeftItemForImageInRightPositionWithTitle:@"搜索" imageName:@"first_search" action:@selector(goSearchView: )];
    
    //设置导航条右上角Item小红点显示
    [self ej_showRedDotInNavigationRightItem:YES];
}

#pragma mark - actions

- (void)goWebView:(id)sender{
    EJBaseWebController *webController = [[EJBaseWebController alloc] initWithURLString:@"http://www.xxsadadsadsfasdfasdf.com"];
    [webController ej_loadURLString:@"http://www.github.com"];
    webController.navigationItem.title = @"Web视图";
    webController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webController animated:YES];
    
    //注册拦截器用于处理公共拦截业务，本方法做到业务类和页面方法分离，降低耦合性
    [EJBaseWebController ej_registerWebInterceptorClassName:@"EJWebInterceptorMananger"];
}


- (void)goNextView:(id)sender{
    NSString *nextClassName = @"NextViewController";
    NSDictionary *nextParam = @{@"p1":@(1),@"p2":@"test"};
    [self ej_openWithClassName:nextClassName parameter:nextParam animated:YES];
}

- (void)goInputView:(id)sender{
    NSString *nextClassName = @"InputViewController";
    [self ej_openWithClassName:nextClassName];
}

- (void)goSearchView:(id)sender{
    
}

@end
