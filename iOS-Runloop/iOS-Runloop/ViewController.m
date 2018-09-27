//
//  ViewController.m
//  iOS-Runloop
//
//  Created by Ezreal on 2018/9/11.
//  Copyright © 2018年 liuyiming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSRunLoop currentRunLoop]; // 获取当前对象的Runloop对象
    [NSRunLoop mainRunLoop]; // 获取主线程的Runloop对象
    
    CFRunLoopGetCurrent(); // 获取当前对象的Runloop对象
    CFRunLoopGetMain(); // 获取主线程的Runloop对象
    
    [self performSelector:<#(nonnull SEL)#> withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>]
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    NSLog(@"主线程Runloop：\n %@", mainRunLoop);
    
    [NSThread detachNewThreadWithBlock:^{
        // 获取子线程对应的runloop
        // currentRunLoop方法是懒加载的，第一次调用的时候会创建当前线程对应的runloop并保存，以后调用直接获取。
        NSRunLoop *newRunloop = [NSRunLoop currentRunLoop];
        [newRunloop run];
        NSLog(@"子线程Runloop：\n %@", newRunloop);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
