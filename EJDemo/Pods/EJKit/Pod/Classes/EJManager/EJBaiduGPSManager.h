//
//  EJBaiduGPSManager.h
//  EJDemo
//
//  Created by iOnRoad on 14-8-20.
//  Copyright (c) 2014年 iOnRoad. All rights reserved.
//

//----------此管理器为百度定位管理------------

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "SynthesizeSingleton.h"

@class EJGPSInfo;

//分发通知监听
#define EJNoti_GetUserPosition @"EJNotification_GetUserPosition"
#define EJNoti_GetPositionFailed @"EJNotification_GetPositionFailed"

//block回调
typedef void (^EJGPSSuccessBlock) (EJGPSInfo *gpsInfo);
typedef void (^EJGPSFailedBlock) (NSError *error);

@interface EJBaiduGPSManager : NSObject <BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate,BMKGeneralDelegate>

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(EJBaiduGPSManager)

@property (nonatomic, strong) EJGPSInfo* ej_gpsInfo;     //GPS 信息
@property (strong,nonatomic) BMKUserLocation *ej_userLocation;         //用于定位地图标注信息

- (void)ej_registerBaiduGPSKey:(NSString *)key;     //注册BaiduGPSKey
- (void)ej_checkGPSFunction;   //检查定位是否开启权限
- (void)ej_startGPSSuccess:(EJGPSSuccessBlock)success fail:(EJGPSFailedBlock)fail;      //定位block调用
- (void)ej_startGPS;        //开始定位
- (void)ej_stopGPS;     //停止定位

@end


@interface EJGPSInfo : NSObject

@property (nonatomic, copy) NSString* ej_cityName;
@property (nonatomic, copy) NSString* ej_areaName;
@property (nonatomic, strong) BMKAddressComponent* ej_addressDetail;       //包含省市区
@property (nonatomic,assign) CLLocationCoordinate2D ej_coordinate;
@property (nonatomic, strong) NSArray* ej_poiList;
@property (nonatomic) BOOL ej_isCompleteGPS;           //是否完成定位

- (void)ej_resetValue;         //重置GPS信息


@end
