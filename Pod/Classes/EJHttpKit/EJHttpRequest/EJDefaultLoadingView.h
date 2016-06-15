//
//  EJDefaultLoadingView.h
//  EJDemo
//
//  Created by iOnRoad on 15/8/25.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "EJLoadingView.h"

/**
 *  根据项目的需要，修改本类属性
 *  本类仅用作加载提示用，如果需要加载符定制，则需要在自己的项目中创建新类
 *  并继承EJLoadingView，可在EJHttpClient中调用ej_registerLoadingViewClassName注册
 */
@interface EJDefaultLoadingView : EJLoadingView

@end
