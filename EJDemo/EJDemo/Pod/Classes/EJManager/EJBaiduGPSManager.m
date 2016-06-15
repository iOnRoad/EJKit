//
//  EJBaiduGPSManager.m
//  EJDemo
//
//  Created by iOnRoad on 14-8-20.
//  Copyright (c) 2014年 iOnRoad. All rights reserved.
//

#import "EJBaiduGPSManager.h"
#import "UIAlertView+EJExtension.h"

@interface EJBaiduGPSManager ()

@property (nonatomic, strong) BMKMapManager* ej_mapManager; //必须使用全局变量，否则反地理编码会失败
@property (nonatomic, strong) BMKLocationService* ej_locationManager;
@property(nonatomic,strong) BMKGeoCodeSearch* ej_geoCodeSearch;

@property(nonatomic,copy) EJGPSSuccessBlock ej_successBlock;
@property(nonatomic,copy) EJGPSFailedBlock ej_failBlock;

@end

@implementation EJBaiduGPSManager
SYNTHESIZE_SINGLETON_FOR_CLASS(EJBaiduGPSManager)

- (id)init
{
    self = [super init];
    if (self) {
        [self ej_checkGPSFunction];
        
        if (!_ej_mapManager) {
            _ej_mapManager = [[BMKMapManager alloc] init];
        }
        
        if (!_ej_locationManager) {
            _ej_locationManager = [[BMKLocationService alloc] init];
        }
        //设置定位精确度，默认：kCLLocationAccuracyBest
        _ej_locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
        _ej_locationManager.distanceFilter = kCLDistanceFilterNone;

        if (!_ej_gpsInfo) {
            _ej_gpsInfo = [[EJGPSInfo alloc] init];
        }

    }
    return self;
}

/**
 *  检查GPS是否开启
 */
- (void)ej_checkGPSFunction{
    if (![CLLocationManager locationServicesEnabled] || ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)) {
        NSString *prodName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
        NSString *message = [NSString stringWithFormat:@"请到设置->隐私->定位服务中开启【%@】定位服务，以便能够获取您的位置。",prodName];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alertView ej_handlerEventWith:^(NSInteger btnIndex) {
            if (btnIndex != 0) {
                //跳入设置页面
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                    BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
                    if (canOpenSettings) {
                        NSURL* url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }
            }
        }];
        [alertView show];
    }
}

/* register baidu key */
- (void)ej_registerBaiduGPSKey:(NSString *)key{
    [self.ej_mapManager start:key generalDelegate:self];
}


/* Start Gps */
- (void)ej_startGPS
{
    [self.ej_locationManager stopUserLocationService]; //stop location
    [self.ej_gpsInfo ej_resetValue];
    
    self.ej_locationManager.delegate = self;
    [self.ej_locationManager startUserLocationService]; //update location
}

/**
 *  Start GPS With Block
 *  @param success
 *  @param fail
 */
- (void)ej_startGPSSuccess:(EJGPSSuccessBlock)success fail:(EJGPSFailedBlock)fail{
    _ej_successBlock = [success copy];
    _ej_failBlock = [fail copy];
    [self ej_startGPS];
}

/* Stop GPS  */
- (void)ej_stopGPS
{
    self.ej_locationManager.delegate = nil;
    [self.ej_locationManager stopUserLocationService]; //stop location
    
    _ej_successBlock = nil;
    _ej_failBlock = nil;
}

//反地理编码
- (void)ej_startGeoCodeSearch:(CLLocationCoordinate2D)coordinate{
    BMKReverseGeoCodeOption* geoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    geoCodeOption.reverseGeoPoint = coordinate;
    if(_ej_geoCodeSearch){
        _ej_geoCodeSearch.delegate = nil;
        _ej_geoCodeSearch = nil;
    }
    _ej_geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    _ej_geoCodeSearch.delegate = self;
    [_ej_geoCodeSearch reverseGeoCode:geoCodeOption];
}

#pragma mark - BMKGeneralDelegate
- (void)onGetNetworkState:(int)iError{
    if(iError ==0 ){
        NSLog(@"准备定位，网络状态正常。");
    }else{
        NSLog(@"无法定位，网络出现问题。");
    }
}

- (void)onGetPermissionState:(int)iError{
    if(iError ==0 ){
        NSLog(@"百度Key校验通过。");
    }else{
        NSLog(@"请检查百度KEY是否正确，获取权限失败。");
    }
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation*)userLocation
{
    //定位成功
    self.ej_locationManager.delegate = nil;
    [self.ej_locationManager stopUserLocationService]; //stop location

    self.ej_userLocation = userLocation;
    self.ej_gpsInfo.ej_coordinate = userLocation.location.coordinate;
    
    [self ej_startGeoCodeSearch:userLocation.location.coordinate];
}

- (void)didFailToLocateUserWithError:(NSError*)error
{
    //定位失败
    self.ej_locationManager.delegate = nil;
    [self.ej_locationManager stopUserLocationService]; //stop location
    
    if (self.ej_failBlock) {
        self.ej_failBlock(error);
        self.ej_failBlock  = nil;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:EJNoti_GetPositionFailed object:nil];
}

#pragma mark - BMKGeoCodeSearchDelegate
//根据坐标反地理编码
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch*)searcher result:(BMKReverseGeoCodeResult*)result errorCode:(BMKSearchErrorCode)error
{
    self.ej_gpsInfo.ej_coordinate = result.location;
    self.ej_gpsInfo.ej_cityName = result.addressDetail.city;
    self.ej_gpsInfo.ej_areaName = [NSString stringWithFormat:@"%@%@%@", result.addressDetail.district, result.addressDetail.streetName, result.addressDetail.streetNumber];
    self.ej_gpsInfo.ej_addressDetail = result.addressDetail;
    self.ej_gpsInfo.ej_poiList = [NSArray arrayWithArray:result.poiList];
    //一般第一个值相对准确
    if(result.poiList.count>0){
        BMKPoiInfo *poiInfo = result.poiList[0];
        self.ej_gpsInfo.ej_coordinate = poiInfo.pt;
        self.ej_gpsInfo.ej_cityName = poiInfo.city;
        self.ej_gpsInfo.ej_areaName = poiInfo.address;
    }
    self.ej_gpsInfo.ej_isCompleteGPS = YES;

    //下发通知或回调，保证只更新一次成功的数据
    if (self.ej_successBlock) {
        self.ej_successBlock(self.ej_gpsInfo);
        self.ej_successBlock = nil;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EJNoti_GetUserPosition object:nil];
}

@end

#pragma mark - GPSInfo Object
@implementation EJGPSInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self ej_resetValue];
    }
    return self;
}

//重置GPS信息
- (void)ej_resetValue{
    self.ej_cityName = @"";
    self.ej_areaName = @"";
    self.ej_addressDetail = nil;
    self.ej_coordinate = CLLocationCoordinate2DMake(0.0, 0.0);
    self.ej_poiList = @[];
    self.ej_isCompleteGPS = NO;
}

@end
