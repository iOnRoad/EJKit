# EJKit
这是一个快速搭建iOS项目所用的项目框架，包含基类，网络，数据库、工具以及常用功能管理器。使用它，可几分钟可搭建项目框架。

##它包含什么？  
- **基类**：控制器基类，用于通用属性的获取和设置。
- **网络**：利用AFNetworking+MJExtension+JSONKit,一句话封装成快速请求网络数据的接口。
- **数据库**：利用FMDB+LKDBHelper，封装了仿NSUserDefault的键值对数据存储。
- **管理器**：利用BaiduMapKit，封装了定位功能的方法调用，以及Cookie写入读取和iOS推送的快捷接入。
- **工具**：封装了开发应用中常用的一些方法以及一些系统方法类的扩展。

##如何使用它？

###一.基类
>包含EJBaseViewController,EJBaseWebController,EJKeywordViewController,EJCustomTabBarController

##### 1.  EJBaseViewController，所有控制器需继承它，可用于项目**获取当前控制器**以及**设置UINavigationBar和UINavigationItem**。

```objc
//获取当前所在的页面控制器
EJBaseViewController *currentController = [EJBaseViewController ej_currentController];
//设置导航条右上角BarItem
[self ej_setNavBarRightItemWithTitle:nil imageName:@"first_search" action:@selector(goSearchView:)];
//设置导航条右上角Item小红点显示
[self ej_showRedDotInNavigationRightItem:YES];
```

##### 2. EJBaseWebController，所有app内访问H5网页的控制器需要继承它，可快捷搭建访问H5的页面控制器

```objc
//获取当前所在的页面控制器
EJBaseWebController *webController = [[EJBaseWebController alloc] initWithURLString:@"http://www.baidu.com"];
//更换访问地址
[webController ej_loadURLString:@"http://www.github.com"];
//指定页面内某个WebView更换访问地址
[webController ej_loadURLString:@"http://www.github.com" OfWebView:self.secondWebView];
//注册拦截器用于处理公共拦截业务，本方法做到业务类和页面方法分离，降低耦合性
[EJBaseWebController ej_registerWebInterceptorClassName:@"EJWebInterceptorMananger"];

//拦截器类需要继承协议EJWebHandleURLInterceptorDelegate，并实现其方法
//拦截的URL，如果拦截成功，则需返回NO，不拦截则返回YES
- (BOOL)ej_handlerEventWithURL:(NSString *)url webView:(UIWebView *)webView;
//如果所有继承EJBaseWebController都要执行js，通过调用此方法来执行
- (void)ej_excuteJSForwebView:(UIWebView *)webView;
```

##### 3. EJCustomTabBarController，快捷创建UITabBarController
```objc
//加载APP根视图控制器
- (void)loadAppRootViewController{
    NSArray *tbTitles = @[@"视图一",@"视图二",@"视图三"];
    NSArray *tbNormalImageNames = @[@"tb_second",@"tb_first",@"tb_third"];
    NSArray *tbSelectedImageNames = @[@"tb_second_s",@"tb_first_s",@"tb_third_s"];
    NSArray *tbControllerNames = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController"];

    EJCustomTabBarController *ej_customTBCtrl = [EJCustomTabBarController new];
	//一个方法设置tabbar的显示
    [ej_customTBCtrl ej_fillTabBarWithTitles:tbTitles normalImgs:tbNormalImageNames selectedImgs:tbSelectedImageNames andControllerNames:tbControllerNames];
    UINavigationController *ej_navCtrl = [[UINavigationController alloc] initWithRootViewController:ej_customTBCtrl];
    ej_customTBCtrl.navigationController.navigationBar.hidden = YES;
    self.window.rootViewController = ej_navCtrl;
    //tabbar显示小红点
    [ej_customTBCtrl ej_showRedDotAtIndex:0];
	//tabbar显示数字
    [ej_customTBCtrl ej_showRedDotWithNumber:2 atIndex:1];
}
```

##### 4. EJKeyboardViewController，所有有输入功能的控制器需要继承它，包含对键盘弹出的监听以及自动滚动输入框，以防止键盘的遮挡

```objc
//当键盘弹出时，当前的输入框是否自动滚动.默认NO为自动滚动。
@property(nonatomic,assign) BOOL ej_closeAutoScrollInputView;       
- (void)ej_keyboardWillShow:(NSNotification *)aNotification;       //键盘显示通知
- (void)ej_keyboardWillHidden:(NSNotification *)aNotification;     //键盘隐藏通知
```

###二.网络的使用方法，以请求天气数据为例

> 该框架封装了网络请求、加载符以及错误符的信息展示，采用封装请求为Model的形式，极大的方便了网络请求的调用。通过此框架，无需采用MVVM的方式去实现请求代码。


##### 第一步.：在AppDelegate中注册网络设置

```objc
- (void)registerAppSetting{
    //注册http请求基本信息
	//基本URL
    [[EJHttpClient shared] ej_registerBaseURL:@"http://wthrcdn.etouch.cn"];
	//注册响应拦截器
    [[EJHttpClient shared] ej_registerInterceptorClassName:@"TestHttpInterceptor"];
	//注册通用请求实体类名以及对应的KEY,本示例中暂未用到
//    [[EJHttpClient shared] ej_registerCommonRequestClassName:@"WeatherCommonRequestModel"  bizRequestKey:@"data"];
	//注册通用响应实体类名以及KEY
    [[EJHttpClient shared] ej_registerCommonResponseClassName:@"WeatherCommonResponseModel" bizResponseKey:@"data"];
	//还可以注册自定义的请求加载符和错误提示符，但需要继承EJLoadingView和EJErrorView
    [[EJHttpClient shared] ej_registerLoadingViewClassName:@"EJDefaultLoadingView" errorViewClassName:@"EJDefaultErrorView"];
	//如果有需要GZIP压缩请求的，还可以启用GZIP
    [[EJHttpClient shared] ej_enableGzipRequestSerializer];
}
```

##### 第二步.：创建请求参数实体
参考Demo中的WeatherApiRequestModel类，该类需要实现EJHttpRequestDelegate，
类实现中需要提供请求URL，响应实体的类名，是否显示加载符和错误提示
#### 第三步：创建响应实体类
参考Demo中的WeatherApiResponseModel类，该类会在EJHttpClient中通过MJExtension框架将JSON转换为该Model

#####第四步：调用请求方法

```objc
- (void)requestWeatherInfo:(id)sender{
    WeatherApiRequestModel *requestModel = WeatherApiRequestModel.new;
    requestModel.city = @"上海";
    
    [[EJHttpClient shared] ej_requestParamObject:requestModel method:GET responseHandler:^(id respObject, BOOL success) {
        if(success){
            WeatherApiResponseModel *resp = (WeatherApiResponseModel *)respObject;
            NSLog(@"wetherInfo:wendu:%@",resp.wendu);
            //处理业务逻辑
        }
    }];
}
```

###三.采用数据库的方式，进行KeyValue的存储

> 由于NSUserDefault采用文件的方式存储，数据过大时可能访问较慢。但通过KeyValue方式去存储又可极大的快速的去存储一些app数据。由于数据库访问速度较快，因此利用LKDBHelper和FMDB出现了此框架的封装。


##### 第一步.：数据库的KeyValue的增，删，查

```objc
//如果Key存在数据库，则是更新操作，如果Key不存在，则是保存数据到数据库操作
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
```

###四.工具类和管理器类

工具类提供了一些系统类的扩展，可简化开发时的调用。
管理类，提供了一些功能的封装，如调用定位功能等，局部示例如下：

```objc
//注册百度GPS key
    [[EJBaiduGPSManager shared] ej_registerBaiduGPSKey:@"xxx"];
    //检查权限
    [[EJBaiduGPSManager shared] ej_checkGPSFunction];
    //调用
    [[EJBaiduGPSManager shared] ej_startGPSSuccess:^(EJGPSInfo *gpsInfo) {
        
    } fail:^(NSError *error) {
        
    }];
    
    //写Cookie,向访问链接中写入token
    [[EJHttpCookieManager shared] ej_setCookieOfURLString:@"http://www.xxx.com" withKey:@"token" andValue:@"xxxx"];
    //获取项目中使用的所有的cookie
    [[EJHttpCookieManager shared] ej_cookie];
    
    //配置基类中的颜色、字体等信息
    //复制EJConfig.plist文件至项目中，修改名字为XXConfig.plist文件，通过EJKitConfigManager指定
    //之后的所有配置信息根据自己项目配置导航条颜色、tabbar的字体大小、颜色等，如果使用默认的加载符，还可以指定加载的图片
    [EJKitConfigManager shared].ej_configPlistName = @"TestConfig.plist";
```

**特别说明一下工具类中UIViewController的扩展**

>通过调用ej_openWithClassName:nextClassName传入要跳转的控制器类名，通过upValue和nextValue进行参数的接收和回传。可极大的进行控制器之间的解耦。

```objc
  NSString *nextClassName = @"NextViewController";
    NSDictionary *nextParam = @{@"p1":@(1),@"p2":@"test"};
    [self ej_openWithClassName:nextClassName parameter:nextParam animated:YES];
```

##更多用法
请下载demo查阅。我相信该框架对于您会有一定的启发。  
本文中的网络请求封装的使用和UIViewController的扩展，推荐您去阅读。

##感谢
本文中用到很多优秀的框架库，在日常开发中，它们极大的方便了我的工作，可以让我更多的时间专注于业务开发和优化。感谢这些作者的贡献。  
同时，感谢一路走来给予支持的同事伙伴们。

##期待：
这是我利用工作之余，抽离出的框架代码，有一些出入之处，请Issues我。  
如果有一些更好的优化建议，也可以Issues我，非常期待您更好的优化建议。

