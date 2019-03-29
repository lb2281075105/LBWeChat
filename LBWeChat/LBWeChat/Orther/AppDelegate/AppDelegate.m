//
//  AppDelegate.m
//  LBWeChat
//
//  Created by liubo on 2019/3/29.
//  Copyright © 2019 刘博. All rights reserved.
//

#import "AppDelegate.h"
#import "LBWCMainController.h"
#import <SDWebImageDownloader.h>
#import <UMMobClick/MobClick.h>

#define kUmAK       @"5c77c0370cafb212f80009d2"
#define kVersion    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[LBWCMainController alloc] init];
    [self.window makeKeyAndVisible];
    
    // 友盟统计(默认以设备[非用户]为标准,日志非加密)
    [MobClick setAppVersion:kVersion];// 获取应用版本号
    UMConfigInstance.appKey = kUmAK;// appKey
    [MobClick startWithConfigure:UMConfigInstance];// 配置以上参数后调用此方法初始化SDK
#if DEBUG
    [MobClick setLogEnabled:YES];// 调试模式,输出log信息
#else
    [MobClick setLogEnabled:NO];// 发布模式,不输出log信息
#endif
    

    return YES;
}

@end
