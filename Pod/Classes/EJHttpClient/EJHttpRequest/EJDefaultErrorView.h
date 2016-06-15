//
//  EJErrorTip.h
//  EJDemo
//
//  Created by iOnRoad on 15/9/29.
//  Copyright © 2015年 iOnRoad. All rights reserved.
//

#import "EJErrorView.h"

/**
 *  根据项目的需要，修改本类属性
 *  本类仅用作弹出toast错误提示用，如果需要错误定制，则需要在自己的项目中创建新类
 *  并集成EJErrorView，可在EJHttpClient中调用ej_registerLoadingViewClassName注册
 */
@interface EJDefaultErrorView : EJErrorView

@end
