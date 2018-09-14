//
//  ViewController.m
//  iOS-Timer
//
//  Created by Ezreal on 2018/9/14.
//  Copyright © 2018年 liuyiming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) dispatch_source_t timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self timer1];
}

/**
 * NSTimer定时器
 */
- (void)timer1 {
    // 创建定时器对象
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    /**
     * 把定时器对象添加到runloop中，并制定运行模式为占位
     * timer：定时器对象
     * mode：runloop的运行模式（默认|界面追踪|占位）
     */
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 * NSTimer定时器
 */
- (void)timer2 {
    /**
     * 创建定时器对象
     * 该方法内部会自动将创建的定时器对象添加到当前的runloop，并且制定运行模式为默认
     */
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    /**
     * 把定时器对象添加到runloop中，并制定运行模式为占位
     * timer：定时器对象
     * mode：runloop的运行模式（默认|界面追踪|占位）
     */
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)run {
    NSLog(@"run---%@", [NSRunLoop currentRunLoop].currentMode);
}

/**
 * GCD中的定时器是精准的
 */
- (void)gcdTimer {
    /**
     * 创建定时器对象
     *
     * 第1个参数：source的类型 DISPATCH_SOURCE_TYPE_TIMER 定时器
     * 第2个参数：对第一个参数的描述
     * 第3个参数：更详细的描述
     * 第4个参数：决定代码块在哪个线程中执行
     */
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    /**
     * 设置定时器（开始时间|调用间隔|精准度）2
     *
     * 第1个参数：定时器对象
     * 第2个参数：开始计时时间 DISPATCH_TIME_NOW 现在开始
     * 第3个参数：间隔时间
     * 第4个参数：精准度（允许的误差）
     */
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    /**
     * 事件回调（定时器执行的任务）
     */
    dispatch_source_set_event_handler(_timer, ^{
        NSLog(@"GCD---%@", [NSRunLoop currentRunLoop].currentMode);
    });
    
    /**
     * 启动定时器
     */
    dispatch_resume(_timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
