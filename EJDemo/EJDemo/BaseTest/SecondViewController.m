//
//  SecondViewController.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "SecondViewController.h"
#import "WeatherApiRequestModel.h"
#import "WeatherApiResponseModel.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)loadView{
    self.view = UIView.new;
    [self addRequestBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"测试HttpClient相关";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - views
- (void)addRequestBtn{
    UIButton *requestBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    requestBtn.frame = CGRectMake(15, 24, [EJTools ej_screenWidth]-30, 44);
    [requestBtn setTitle:@"请求天气信息" forState:UIControlStateNormal];
    [requestBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [requestBtn addTarget:self action:@selector(requestWeatherInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:requestBtn];
}

#pragma mark - actions
- (void)requestWeatherInfo:(id)sender{
    WeatherApiRequestModel *requestModel = WeatherApiRequestModel.new;
    requestModel.city = @"上海";
    
    [[EJHttpClient shared] ej_requestParamObject:requestModel method:GET responseHandler:^(id respObject, BOOL success) {
        if(success){
            WeatherApiResponseModel *resp = (WeatherApiResponseModel *)respObject;
            NSLog(@"wetherInfo:wendu:%@",resp.wendu);
            //处理业务逻辑
        }
//        [[EJDefaultLoadingView new] ej_showInWindow];
    }];
}

@end
