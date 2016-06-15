//
//  EJBaseViewController.m
//  EJDemo
//
//  Created by iOnRoad on 15/10/12.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import "EJBaseViewController.h"
#import "UIImage+EJExtension.h"
#import "EJKitConfigManager.h"

@interface EJBaseViewController ()

@end

@implementation EJBaseViewController

-(void)dealloc{
    if(ejCurrentControllerNames){
        [ejCurrentControllerNames removeObject:NSStringFromClass([self class])];
        NSLog(@"_currentControllerNames:-----------%@",ejCurrentControllerNames.debugDescription);
    }
    NSLog(@"ClassName:%@ dealloc",NSStringFromClass([self class]));
}

static EJBaseViewController *ejCurrentVC = nil;
static NSMutableArray *ejCurrentControllerNames = nil;
+ (EJBaseViewController *)ej_currentController{
    return ejCurrentVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ejCurrentVC = self;       //此处也需要赋值，有很多请求在ViewDidLoad中实现。
    self.view.backgroundColor = [UIColor ej_baseViewBgColor]; //统一设置背景色
    if(ejCurrentControllerNames == nil){
        ejCurrentControllerNames = [@[] mutableCopy];
    }
    [ejCurrentControllerNames addObject:NSStringFromClass([self class])];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ejCurrentVC = self;       //此处再次赋值
    [self ej_initNavBarSetting];   //默认导航条设置
    [self ej_customNavBackItemStyle];      //统一自定义返回按钮
}

#pragma mark - NavigationBar Setting
/**
 *  初始化导航条样式设置
 */
- (void)ej_initNavBarSetting {
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    //设置navBar黑色字体
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor ej_navBarTextColor], NSForegroundColorAttributeName, [UIFont ej_navBarTitleFont], NSFontAttributeName, nil]];
    //设置navBar前景色
    [self.navigationController.navigationBar setTintColor:[UIColor ej_navBarTextColor]];
    //navBar前景设置
    self.navigationController.navigationBar.translucent = NO;       //不透明
    //设置navBar底部阴影线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage ej_imageWithColor:[UIColor ej_navBarBgColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage ej_lineWithColor:[UIColor ej_navBarShadowLineColor]]];
}

//设置透明的导航条
- (void)ej_setTransparentBar{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    //navBar前景设置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage ej_imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
    //设置navBar底部阴影线
    [self.navigationController.navigationBar setShadowImage:[UIImage ej_imageWithColor:[UIColor clearColor]]];
}

/**
 *  自定义返回按钮样式设置
 */
- (void)ej_customNavBackItemStyle {
    //设置NavBar返回按钮,
    //先隐藏原有的backBtn和返回字体，否则第一次运行时会出现...省略号
    [self.navigationItem setHidesBackButton:YES animated:NO];
    UIBarButtonItem* backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backBarItem;
    //在设置自定义的返回按钮
    UIViewController* rootViewController = [self.navigationController.viewControllers objectAtIndex:0];
    if (rootViewController != self) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:[EJConfigData ej_navigationBarBackImgName]] style:UIBarButtonItemStylePlain target:self action:@selector(ej_popViewController)];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = - 5;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,backItem];
    }
}

- (void)ej_popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏返回按钮
- (void)ej_hiddenNavigationBackBtn{
    self.navigationItem.leftBarButtonItems = nil;
}

#pragma mark - UINavigationItem Setting
//设置右侧BarItem
- (nonnull UIBarButtonItem *)ej_setNavBarRightItemWithTitle:(nullable NSString *)title action:(nullable SEL)action{
    UIBarButtonItem *rightItem =  [self ej_setNavBarRightItemWithTitle:title imageName:nil action:action];
    return rightItem;
}

//设置图片+文字按钮,图片默认左边
- (nonnull UIBarButtonItem *)ej_setNavBarRightItemWithTitle:(nullable NSString *)title imageName:(nullable NSString *)imgName action:(nullable SEL)action{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    if(title.length>0){
        [rightBtn setTitle:[NSString stringWithFormat:@" %@",title] forState:UIControlStateNormal];
    }
    [rightBtn setTitleColor:[UIColor ej_navBarTextColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont ej_navBarItemFont]];
    if(imgName.length>0){
        [rightBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    [rightBtn sizeToFit];
    [rightBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    return rightItem;
}

//设置带图片的功能按钮,图片显示在文字右边
- (nonnull UIBarButtonItem *)ej_setNavBarRightItemForImageInRightPositionWithTitle:(nullable NSString *)title imageName:(nullable NSString *)imgName action:(nullable SEL)action {
    UIBarButtonItem *rightItem =  [self ej_setNavBarRightItemWithTitle:title imageName:imgName action:action];
    UIButton *rightBtn = (UIButton *)rightItem.customView;
    if(title.length>0){
        [rightBtn setTitle:[NSString stringWithFormat:@"%@ ",title] forState:UIControlStateNormal];
    }
    
    UIImage *img = nil;
    if(imgName.length>0){
        img = [UIImage imageNamed:imgName];
    }
    CGFloat left = rightBtn.frame.size.width- img.size.width ;
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, left, 0, 0)];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -img.size.width, 0, img.size.width)];
    
    return rightItem;
}

//设置左边按钮文字
- (nonnull UIBarButtonItem *)ej_setNavBarLeftItemWithTitle:(nullable NSString *)title action:(nullable SEL)action{
    UIBarButtonItem *leftItem =  [self ej_setNavBarLeftItemWithTitle:title imageName:nil action:action];
    return leftItem;
}

//设置带图片的功能按钮,图片默认左边
- (nonnull UIBarButtonItem *)ej_setNavBarLeftItemWithTitle:(nullable NSString *)title imageName:(nullable NSString *)imgName action:(nullable SEL)action{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    if(title.length>0){
        [leftBtn setTitle:[NSString stringWithFormat:@" %@",title] forState:UIControlStateNormal];
    }
    [leftBtn setTitleColor:[UIColor ej_navBarTextColor] forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont ej_navBarItemFont]];
    [leftBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    [leftBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    return leftItem;
}

//设置带图片的功能按钮,图片显示在文字右边
- (nonnull UIBarButtonItem *)ej_setNavBarLeftItemForImageInRightPositionWithTitle:(nullable NSString *)title imageName:(nullable NSString *)imgName action:(nullable SEL)action {
    UIBarButtonItem *leftItem =  [self ej_setNavBarLeftItemWithTitle:title imageName:imgName action:action];
    UIButton *leftBtn = (UIButton *)leftItem.customView;
    if(title.length>0){
        [leftBtn setTitle:[NSString stringWithFormat:@"%@ ",title] forState:UIControlStateNormal];
    }
    
    UIImage *img = nil;
    if(imgName.length>0){
        img = [UIImage imageNamed:imgName];
    }
    CGFloat left = leftBtn.frame.size.width- img.size.width ;
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, left, 0, 0)];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -img.size.width, 0, img.size.width)];
    
    return leftItem;
}

//显示小红点
- (void)ej_showRedDotInNavigationRightItem:(BOOL)show{
    if(show){
        //新建小红点
        UIView *badgeView = [[UIView alloc]init];
        badgeView.tag = 1001;
        badgeView.layer.cornerRadius = 4;//圆形
        badgeView.backgroundColor = [UIColor redColor];//颜色：红色
        
        UIView *customView = self.navigationItem.rightBarButtonItem.customView;
        [customView addSubview:badgeView];
        badgeView.frame = CGRectMake(customView.frame.size.width-4, customView.frame.size.height/2-8, 8, 8);
    }
    else{
        [self ej_removeRedDotInNavigationRightItem];
    }
}

- (void)ej_removeRedDotInNavigationRightItem{
    UIView *badgeView = [self.navigationItem.rightBarButtonItem.customView viewWithTag:1001];
    if(badgeView){
        [badgeView removeFromSuperview];
    }
}


@end
