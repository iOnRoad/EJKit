//
//  EJCustomTabBarController.m
//  EJDemo
//
//  Created by iOnRoad on 15/4/18.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "EJCustomTabBarController.h"
#import "EJTools.h"
#import "NSString+EJExtension.h"
#import "UIImage+EJExtension.h"
#import "UIColor+EJExtension.h"
#import "EJKitConfigManager.h"

@interface EJCustomTabBarController () <UITabBarControllerDelegate,UINavigationControllerDelegate>

@end

@implementation EJCustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.navigationController.delegate = self;

    if([EJTools ej_stringIsAvailable:[EJConfigData ej_tabBarBgImgName]]){
        UIImage *radiusImg = [UIImage imageNamed:[EJConfigData ej_tabBarBgImgName]];
        UIImage *bgImage = [radiusImg resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        [self.tabBar setBackgroundImage:bgImage];
        [self.tabBar setShadowImage:[UIImage ej_imageWithColor:[UIColor clearColor]]];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Public
- (void)ej_fillTabBarWithTitles:(NSArray *)titles normalImgs:(NSArray *)normalImgs selectedImgs:(NSArray *)selectedImgs andControllerNames:(NSArray *)controllerNames{
    //设置Controllers
    NSMutableArray* viewControllers = [NSMutableArray arrayWithCapacity:0];
    for (NSString* controllerName in controllerNames) {
        id viewController = [controllerName ej_controller];
        UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [viewControllers addObject:navigationController];
    }
    [self setViewControllers:viewControllers];
    //设置Titles
    for (int i = 0; i < titles.count; i++) {
        UITabBarItem* barItem = [self.tabBar.items objectAtIndex:i];
        barItem.title = [titles objectAtIndex:i]; //设置标题
        [barItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor ej_tabbarNormalStateColor], NSForegroundColorAttributeName, [UIFont ej_tabbarTextFont],NSFontAttributeName,nil] forState:UIControlStateNormal];
        [barItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor ej_tabbarSelectedStateColor], NSForegroundColorAttributeName, [UIFont ej_tabbarTextFont],NSFontAttributeName,nil] forState:UIControlStateSelected];
        //设置图片
        UIImage* nImg = [UIImage imageNamed:[normalImgs objectAtIndex:i]];
        UIImage* sImg = [UIImage imageNamed:[selectedImgs objectAtIndex:i]];
        //此处设置是因为在iOS8下有问题，图片不要被系统渲染即可。
        nImg = [nImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        sImg = [sImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        barItem.image = nImg;
        barItem.selectedImage = sImg;
    }
    [self.tabBar setBackgroundColor:[UIColor ej_tabbarBgColor]];
}



- (void)ej_showRedDotAtIndex:(NSInteger)index{
    //移除之前的小红点
    [self ej_removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 1001 + index;
    badgeView.layer.cornerRadius = 4;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    
    //确定小红点的位置
    float percentX = (index +0.6) / self.tabBar.items.count;
    CGFloat x = ceilf(percentX * self.tabBar.frame.size.width);
    CGFloat y = ceilf(0.15 * self.tabBar.frame.size.height);
    if(index == 2){
        //中间的图标大，稍微高一些。
        y = 1;
    }
    badgeView.frame = CGRectMake(x, y, 8, 8);//圆形大小为10
    [self.tabBar addSubview:badgeView];
}

- (void)ej_showRedDotWithNumber:(NSInteger)number atIndex:(NSInteger)index{
    UITabBarItem *barItem = self.tabBar.items[index];
    if(number>0){
        barItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)number];
        if(number>99){
            barItem.badgeValue = @"99+";
        }
    }else{
        barItem.badgeValue = nil;
    }
}

//移除小红点
- (void)ej_removeBadgeOnItemIndex:(NSInteger)index{
    //按照tag值进行移除
    for (UIView *subView in self.tabBar.subviews) {
        if (subView.tag == 1001+index) {
            [subView removeFromSuperview];
        }
    }
    
}

#pragma mark - UITabbarController Delegate
- (void)tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController{
}


- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    UIViewController* tmpController = [navigationController.viewControllers objectAtIndex:0];
    if (viewController == tmpController) {
        navigationController.navigationBarHidden = YES;
    }
}

@end
