//
//  YMTabBarController.m
//  iOS-Tabbar
//
//  Created by Ezreal on 2018/6/6.
//  Copyright © 2018年 liuyiming. All rights reserved.
//

#import "YMTabBarController.h"

#import "YMHomeViewController.h"
#import "YMNewsViewController.h"
#import "YMDiscoverViewController.h"
#import "YMMineViewController.h"

@interface YMTabBarController ()

@end

@implementation YMTabBarController

// 程序一启动就会把类加载到内存
+ (void)load {
    UITabBarItem *item = [UITabBarItem appearance];
}

// 第一次使用当前类或子类的时候调用
+ (void)initialize {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildController];
}

- (void)setupChildController {
    YMHomeViewController *homeController = [[YMHomeViewController alloc] init];
    [self addChildController:homeController title:@"首页" normalImage:@"tab_home_n" selectedImage:@"tab_home_s"];
    
    YMNewsViewController *bill = [[YMNewsViewController alloc] init];
    [self addChildController:bill title:@"消息" normalImage:@"tab_account_n" selectedImage:@"tab_account_s"];
    
    YMDiscoverViewController *mineController = [[YMDiscoverViewController alloc] init];
    [self addChildController:mineController title:@"发现" normalImage:@"tab_mine_n" selectedImage:@"tab_mine_s"];
    
    YMMineViewController *help = [[YMMineViewController alloc] init];
    [self addChildController:help title:@"我的" normalImage:@"tab_help_n" selectedImage:@"tab_help_s"];
}

- (void)addChildController:(UIViewController *)controller
                     title:(NSString *)title
               normalImage:(NSString *)normalImage
             selectedImage:(NSString *)selectedImage {
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.title = title;
    navController.tabBarItem.image = [UIImage imageNamed:normalImage];
    navController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
    [self addChildViewController:navController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
