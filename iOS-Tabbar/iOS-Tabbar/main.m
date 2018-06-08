//
//  main.m
//  iOS-Tabbar
//
//  Created by Ezreal on 2018/6/6.
//  Copyright © 2018年 liuyiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

/*
 UIApplicationMain：功能
 1. 创建UIApplication(应用程序唯一标识)：
    1.设置状态栏
    2.联网状态
    3.设置提醒数字
    4.打电话 发邮件 发短信 打开网页
 
 2. 创建UIApplication代理：
    1.监听应用程序的生命周期
    2.监听内存警告
 
 3. 开始主运行循环，保证程序一直运行，监听事件
 
 4. 判断info.plist文件是否指定Main.storyboard，然后就会去加载
    加载Main.storyboard：
    1.创建窗口（底层OpenGL）
    2.创建窗口根控制器，并设置窗口根控制器
    3.显示窗口
 */
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
