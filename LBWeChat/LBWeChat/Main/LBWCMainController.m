//
//  LBWCMainController.m
//  LBWeChat
//
//  Created by liubo on 2019/3/29.
//  Copyright © 2019 刘博. All rights reserved.
//

#import "LBWCMainController.h"
#import "LBWCDiscoverController.h"
#import "LBWCMineController.h"
#import "LBWCMessageController.h"
#import "LBWCContactsController.h"

@interface LBWCMainController ()

@end

@implementation LBWCMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBar.layer.borderWidth = 0.5;
    self.tabBar.layer.borderColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0].CGColor;
    self.tabBar.tintColor = [UIColor colorWithRed:14.0/255.0 green:178.0/255.0 blue:10.0/255.0 alpha:1.0];
    [self.tabBar setBackgroundImage:[Utility imageWithRenderColor:[UIColor whiteColor] renderSize:CGSizeMake(3, 3)]];
    
    // 初始化
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MomentUtil initMomentData];
    });

   
    [self addChildControllers];
}
- (void)addChildControllers{
    // 控制器
    LBWCMessageController *messageVC = [[LBWCMessageController alloc] init];
    LBWCContactsController *contactsVC = [[LBWCContactsController alloc] init];
    LBWCDiscoverController *discoverVC = [[LBWCDiscoverController alloc] init];
    LBWCMineController *mineVC = [[LBWCMineController alloc] init];
    NSArray *controllers = @[messageVC,contactsVC,discoverVC,mineVC];
    // tabbar
    NSArray *titles = @[@"微信",@"通讯录",@"发现",@"我"];
    NSMutableArray * viewControllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i ++)
    {
        // 图片
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d",i]];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_hl_%d",i]];
        // 项
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titles[i] image:image selectedImage:selectedImage];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:10.0]} forState:UIControlStateNormal];
        // 控制器
        UIViewController *controller = controllers[i];
        controller.title = [titles objectAtIndex:i];
        controller.tabBarItem = item;
        // 导航
        UINavigationController * navigation = [[UINavigationController alloc] initWithRootViewController:controller];
        navigation.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:19.0]};
        [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigaitonbar"] forBarMetrics:UIBarMetricsDefault];
        navigation.navigationBar.tintColor = [UIColor whiteColor];
        navigation.navigationBar.barStyle = UIBarStyleBlackOpaque;
        navigation.navigationBar.translucent = NO;
        [viewControllers addObject:navigation];
    }
    self.viewControllers = viewControllers;
}

@end
