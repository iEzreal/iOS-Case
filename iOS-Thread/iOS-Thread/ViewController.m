//
//  ViewController.m
//  iOS-Thread
//
//  Created by Ezreal on 2018/9/27.
//  Copyright © 2018年 liuyiming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self gcd];
}

- (void)startDown {
    NSLog(@"startDown运行线程：%@", [NSThread currentThread]);
    NSThread *thred = [[NSThread alloc] initWithTarget:self selector:@selector(download) object:nil];
    [thred start];
    //[NSThread detachNewThreadSelector:@selector(download) toTarget:self withObject:nil];
}

- (void)download {
    NSLog(@"download运行线程：%@", [NSThread currentThread]);
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:YES];
}

- (void)updateUI {
     NSLog(@"updateUI运行线程：%@", [NSThread currentThread]);
}

- (void)gcd {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"耗时操作运行线程：%@", [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"更新UI运行线程：%@", [NSThread currentThread]);
        });
    });
}

@end
