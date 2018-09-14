//
//  ViewController.m
//  iOS-GCD
//
//  Created by Ezreal on 2018/6/20.
//  Copyright © 2018年 liuyiming. All rights reserved.
//



#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIButton *startBtn;
@property(nonatomic, strong) UIButton *pauseBtn;
@property(nonatomic, strong) UIButton *resumeBtn;
@property(nonatomic, strong) UIButton *cancleBtn;

@property(nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startBtn.frame = CGRectMake(100, 100, 100, 40);
    _startBtn.backgroundColor = [UIColor redColor];
    [_startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startBtn];
    
    _pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pauseBtn.frame = CGRectMake(100, 150, 100, 40);
    _pauseBtn.backgroundColor = [UIColor redColor];
    [_pauseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [_pauseBtn addTarget:self action:@selector(pauseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pauseBtn];
    
    _resumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _resumeBtn.frame = CGRectMake(100, 200, 100, 40);
    _resumeBtn.backgroundColor = [UIColor redColor];
    [_resumeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_resumeBtn setTitle:@"恢复" forState:UIControlStateNormal];
    [_resumeBtn addTarget:self action:@selector(resumeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resumeBtn];
    
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleBtn.frame = CGRectMake(100, 250, 100, 40);
    _cancleBtn.backgroundColor = [UIColor redColor];
    [_cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancleBtn];
}

- (void)startClick {
    _queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"--- NSBlockOperation1 ---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"--- NSBlockOperation2 ---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"--- NSBlockOperation3 ---%@", [NSThread currentThread]);
    }];
    
    [_queue addOperation:op1];
    [_queue addOperation:op2];
    [_queue addOperation:op3];
}

- (void)pauseClick {
    // 只能暂停当前操作后面的操作，当前操作不可分割，必须执行完毕
    // 操作都是有状态的
    [_queue setSuspended:YES];
}

- (void)resumeClick {
    [_queue setSuspended:NO];
}

- (void)cancleClick {
    // 只能取消队列中处于等待状态的操作
    [_queue cancelAllOperations];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self changeSerialQueue];
}

/********************************* NSOperation ********************************/
- (void)invocationOperation {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    [queue addOperation:op1]; // 该方法内部会自动的调用start方法
    [queue addOperation:op2];
    [queue addOperation:op3];
}

- (void)download {
    NSLog(@"--- download ---%@", [NSThread currentThread]);
}

- (void)blockOperation {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"--- NSBlockOperation1 ---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"--- NSBlockOperation2 ---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"--- NSBlockOperation3 ---%@", [NSThread currentThread]);
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
    // 简便方法
    [queue addOperationWithBlock:^{
        NSLog(@"--- NSBlockOperation4 ---%@", [NSThread currentThread]);
    }];
}

- (void)changeSerialQueue {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"--- NSBlockOperation1 ---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"--- NSBlockOperation2 ---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"--- NSBlockOperation3 ---%@", [NSThread currentThread]);
    }];
    
    // 设置最大并发数：同一时间最多有多少条线程在执行
    // queue.maxConcurrentOperationCount = 1：可以变成串行队列
    queue.maxConcurrentOperationCount = 1;
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}
/********************************* NSOperation ********************************/

// 延迟执行
- (void)delay {
    
}


/**
 * 队列组
 *
 * 作用：封装任务、把任务添加到队列、监听任务的执行情况
 *
 */
- (void)dispatch_group {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.liu", DISPATCH_QUEUE_CONCURRENT);
    
     dispatch_group_async(group, queue, ^{
        NSLog(@"--- 任务1 ---%@", [NSThread currentThread]);
    });
    
     dispatch_group_async(group, queue, ^{
        NSLog(@"--- 任务2 ---%@", [NSThread currentThread]);
    });
    
     dispatch_group_async(group, queue, ^{
        NSLog(@"--- 任务3 ---%@", [NSThread currentThread]);
    });
    
    // 所有的任务都执行完后在执行
    // 内部原理：
    dispatch_group_notify(group, queue, ^{
        NSLog(@"--- 任务都执行完了 ---");
    });
}


/**
 * 栅栏函数
 * 前面的任务并发执行，后面的任务也是并发执行
 * 当前面的任务执行完毕之后执行栅栏函数中的任务，等该任务执行完毕后再执行后面的任务
 * 注意：不能使用全局并发队列
 */
- (void)barrier {
    dispatch_queue_t queue = dispatch_queue_create("com.liu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1------%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2------%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"--- dispatch_barrier_async ---");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3------%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"4------%@", [NSThread currentThread]);
    });
}

/**
 * 异步函数 + 并发队列：回开启多条子线程，所有的任务并发执行
 * 注意：开几条线程并不是由任务的数量决定的，是GCD内部自动决定的
 */
- (void)asyncConcurrent {
    dispatch_queue_t queue = dispatch_queue_create("com.liu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"--- 异步函数 + 并发队列 1 ---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"--- 异步函数 + 并发队列 2 ---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"--- 异步函数 + 并发队列 3 ---%@", [NSThread currentThread]);
    });
}

/**
 * 异步函数 + 串行队列：回开启一条子线程，所有的任务在改子线程中串行执行
 */
- (void)asyncSerial {
    dispatch_queue_t queue = dispatch_queue_create("com.liu", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"--- 异步函数 + 串行队列 1 ---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"--- 异步函数 + 串行队列 2 ---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"--- 异步函数 + 串行队列 3 ---%@", [NSThread currentThread]);
    });
}

// 同步函数 + 并发队列：不会开启子线程，所有的任务在当前线程中串行执行
- (void)syncConcurrent {
    dispatch_queue_t queue = dispatch_queue_create("com.liu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"--- 同步函数 + 并发队列 1 ---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"--- 同步函数 + 并发队列 2 ---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"--- 同步函数 + 并发队列 3 ---%@", [NSThread currentThread]);
    });
}

// 同步函数 + 串行队列：不会开启子线程，所有的任务在当前线程中串行执行
- (void)syncSerial {
    dispatch_queue_t queue = dispatch_queue_create("com.liu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"--- 同步函数 + 串行队列 1 ---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"--- 同步函数 + 串行队列 2 ---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"--- 同步函数 + 串行队列 3 ---%@", [NSThread currentThread]);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
