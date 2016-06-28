//
//  EJKitConfigManager.h
//  Pods
//
//  Created by iOnRoad on 16/3/2.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SynthesizeSingleton.h"

@interface EJKitConfigManager : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(EJKitConfigManager)

//配置文件名，每个项目中需单独设置plist文件信息，可配置基类等基本信息，不设置，则采用默认plist
@property(copy,nonatomic) NSString *ej_configPlistName;
//配置信息，只读
@property(strong,nonatomic,readonly) NSDictionary *ej_configInfo;

/**
 *  获取配置好的颜色信息
 *
 *  @param key 颜色Key，包含在plist中的color字段下
 *
 *  @return UIColor对应的颜色
 */
- (UIColor *)ej_colorWithKey:(NSString *)key;
/**
 *  获取配置数据
 *
 *  @param key 数据Key，包含在plist中的data字段下
 *
 *  @return String对应的文本
 */
- (NSString *)ej_stringWithKey:(NSString *)key;

/**
 *  获取配置字体
 *
 *  @param key 字体Key，包含在plist中的font字段下
 *
 *  @return 字体
 */
- (UIFont *)ej_fontWithKey:(NSString *)key;

@end


#pragma mark - UIColor Standard
@interface UIColor (EJKitStandard)

+ (UIColor *)ej_baseViewBgColor;               //所有视图默认的背景色
+ (UIColor *)ej_navBarTextColor;               //导航栏文本颜色
+ (UIColor *)ej_navBarBgColor;                 //导航栏背景色
+ (UIColor *)ej_navBarShadowLineColor;     //导航栏阴影线颜色
+ (UIColor *)ej_tabbarNormalStateColor;            //选项卡未选中时的颜色
+ (UIColor *)ej_tabbarSelectedStateColor;          //选项卡选中时的颜色
+ (UIColor *)ej_tabbarBgColor;                     //选项卡背景色
+ (UIColor *)ej_webView404TipColor;     //webView显示404提示文案的颜色

@end

#pragma mark - UIFont Standard
@interface UIFont (EJKitStandard)

+ (UIFont *)ej_navBarTitleFont;            //导航栏字体大小
+ (UIFont *)ej_navBarItemFont;             //导航栏Item字体
+ (UIFont *)ej_tabbarTextFont;             //选项卡字体

@end

#pragma mark - ConfigData Standard
@interface EJConfigData : NSObject

+ (NSString *)ej_navigationBarBackImgName;         //导航栏返回按钮图片名字
+ (NSString *)ej_tabBarBgImgName;                         //选项卡背景图片名
+ (NSString *)ej_keyboradImgName;                      //键盘图标，默认显示，可设置名字为空即不展示

+ (NSString *)ej_baseH5URL;        //H5页面的基本URL
+ (NSString *)ej_webViewBackKey;                           //返回上一页，如果内容有多次跳转，则内部先调用webView的goback，如果无，则调用popView
+ (NSString *)ej_webViewCloseKey;                          //返回根视图，调用nav的popView
+ (NSString *)ej_webViewReferrer;                          //返回页面时，是否需要返回到一个新的H5页面，BOOL型
+ (NSString *)ej_webViewReferrerURL;                       //返回页面时，不执行popView，指定加载的新页面URL
+ (NSString *)ej_webView404ImageName;                 //404目录名字

@end
