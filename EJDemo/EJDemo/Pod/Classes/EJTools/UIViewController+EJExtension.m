//
//  UIViewController+EJExtension.m
//  EJDemo
//
//  Created by iOnRoad on 15/10/8.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import "UIViewController+EJExtension.h"

@implementation UIViewController (EJExtension)

- (UIViewController *)ej_existedControllerInNavigationQueue:(NSString *)className{
    for (UIViewController *tmpController in self.navigationController.viewControllers) {
        if ([NSStringFromClass([tmpController class]) isEqualToString:className]) {
            //返回存在的Controller
            return tmpController;
        }
    }
    return nil;
}

- (void)ej_openWithClassName:(NSString *)className{
    [self ej_openWithClassName:className parameter:nil];
}

- (void)ej_openWithClassName:(NSString *)className animated:(BOOL)animated{
    [self ej_openWithClassName:className parameter:nil animated:animated];
}

- (void)ej_openWithClassName:(NSString *)className parameter:(NSDictionary *)param{
    [self ej_openWithClassName:className parameter:param animated:YES];
}

- (void)ej_openWithClassName:(NSString *)className parameter:(NSDictionary *)param animated:(BOOL)animated{
    UIViewController *controller = [self ej_controllerWithClassName:className];
    if(controller){
        //push到下一页
        //传参数
        if(param && [controller respondsToSelector:@selector(ej_nextValue:)]){
            [controller ej_nextValue:param];
        }
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:animated];
    }
    else{
        NSLog(@"Controller is not exist！");
    }
}

- (void)ej_popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ej_popViewControllerWithAnimated:(BOOL)animated{
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)ej_popViewControllerWithParameter:(NSDictionary *)param{
    NSInteger index = self.navigationController.viewControllers.count-2;
    if(index>=0){
        UIViewController *controller = self.navigationController.viewControllers[index];
        if(param && [controller respondsToSelector:@selector(ej_upValue:)]){
            [controller ej_upValue:param];
        }
        [self.navigationController popToViewController:controller animated:YES];
    }
}

- (void)ej_popWithClassName:(NSString *)className{
    [self ej_popWithClassName:className parameter:nil];
}

- (void)ej_popWithClassName:(NSString *)className animated:(BOOL)animated{
    [self ej_popWithClassName:className parameter:nil animated:animated];
}


- (void)ej_popWithClassName:(NSString *)className parameter:(NSDictionary *)param{
    [self ej_popWithClassName:className parameter:param animated:YES];
}

- (void)ej_popWithClassName:(NSString *)className parameter:(NSDictionary *)param animated:(BOOL)animated{
    BOOL isExistController = NO;
    for(UIViewController *controller in self.navigationController.viewControllers){
        if([className isEqualToString:NSStringFromClass([controller class])]){
            //存在Contorller
            //传参数
            if(param && [controller respondsToSelector:@selector(ej_upValue:)]){
                [controller ej_upValue:param];
            }
            [self.navigationController popToViewController:controller animated:animated];
            isExistController = YES;
            break;
        }
    }
    
    if(!isExistController){
        //页面不存在
        NSLog(@"Page is not found!");
    }
}

- (void)ej_upValue:(NSDictionary *)parameter{
    
}

- (void)ej_nextValue:(NSDictionary *)parameter{

}


#pragma mark - Private methods
- (UIViewController *)ej_controllerWithClassName:(NSString *)className{
    UIViewController *controller = nil;
    if([className isKindOfClass:[NSString class]] && className.length>0){
        Class c = NSClassFromString(className);
        if(c){
            controller = [[c alloc] init];
        }
    }
    return controller;
}

@end
