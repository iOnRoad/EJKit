//
//  EJBaseRequestModel.h
//  EJDemo
//
//  Created by iOnRoad on 15/8/9.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EJHttpRequestDelegate.h"

/**
 *  网络请求基类,所有请求应该继承于它。
 */
@interface EJBaseRequestModel : NSObject <EJHttpRequestDelegate>

@end





