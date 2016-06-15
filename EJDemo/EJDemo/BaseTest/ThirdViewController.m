//
//  ThirdViewController.m
//  EJDemo
//
//  Created by iOnRoad on 16/6/7.
//  Copyright © 2016年 iOnRoad. All rights reserved.
//

#import "ThirdViewController.h"

@interface UserModel : NSObject

@property(copy,nonatomic) NSString *username;
@property(copy,nonatomic) NSString *password;

@end

@implementation UserModel

@end



@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)loadView{
    self.view = UIView.new;
    [self addSaveBtn];
    [self addQueryBtn];
    [self addDeleteBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"测试DB相关";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - views
- (void)addSaveBtn{
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    saveBtn.frame = CGRectMake(15, 24, [EJTools ej_screenWidth]-30, 44);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}

- (void)addQueryBtn{
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    queryBtn.frame = CGRectMake(15, 84, [EJTools ej_screenWidth]-30, 44);
    [queryBtn setTitle:@"查询" forState:UIControlStateNormal];
    [queryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [queryBtn addTarget:self action:@selector(query) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryBtn];
}

- (void)addDeleteBtn{
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    deleteBtn.frame = CGRectMake(15, 144, [EJTools ej_screenWidth]-30, 44);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
}

#pragma mark - actions
- (void)save{
    [EJDBKeyValue ej_setDBValue:@(2) forKey:@"t1"];
    [EJDBKeyValue ej_setDBValue:@"test1" forKey:@"t2"];
    [EJDBKeyValue ej_setDBValue:@[@"test11",@"test12"] forKey:@"t3"];
    [EJDBKeyValue ej_setDBValue:@{@"k11":@"v11",@"k22":@"v22",@"k33":@[@"test3"]} forKey:@"t4"];
    
    UserModel *model = [UserModel new];
    model.username = @"username1";
    model.password = @"password1";
    [EJDBKeyValue ej_setDBValue:model forKey:@"t5"];
    
    UserModel *model1 = [UserModel new];
    model1.username = @"username11";
    model1.password = @"password11";
    
    UserModel *model2 = [UserModel new];
    model2.username = @"username2";
    model2.password = @"password2";
    [EJDBKeyValue ej_setDBValue:@[model,model1,model2] forKey:@"t6"];
}

- (void)query{
    NSInteger t1 = [[EJDBKeyValue ej_dbValueForKey:@"t1"] integerValue];
    NSString *t2 = [EJDBKeyValue ej_dbValueForKey:@"t2"];
    NSArray *t3 = [EJDBKeyValue ej_dbValueForKey:@"t3"];
    NSDictionary *t4 = [EJDBKeyValue ej_dbValueForKey:@"t4"];
    UserModel *t5 = (UserModel *)[EJDBKeyValue ej_dbValueForKey:@"t5"];
    NSArray *t6 = [EJDBKeyValue ej_dbValueForKey:@"t6"];

    NSLog(@"t1:%ld , t2: %@ , t3:%@ , t4:%@",(long)t1,t2,t3,t4);
    NSLog(@"model:%@ -- %@",t5.username,t5.password);
    
    for(UserModel *um in t6){
        NSLog(@"model:%@ -- %@",um.username,um.password);
    }
}

- (void)delete{
    [EJDBKeyValue ej_removeDBValueForKey:@"t4"];

}


@end
