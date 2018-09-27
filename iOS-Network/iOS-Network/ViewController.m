//
//  ViewController.m
//  iOS-Network
//
//  Created by Ezreal on 2018/9/17.
//  Copyright © 2018年 liuyiming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDataDelegate>

@property(nonatomic, strong) NSMutableData *resultData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self networkTest];
}


- (void)networkTest {
    NSString *urlStr = @"http://mobile.weather.com.cn/data/sk/101010100.html?_=1381891661455";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *requet = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:requet];
    
    [dataTask resume];
}

#pragma mark - NSURLSessionDataDelegate
// 接受到服务器相应时调用
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"接受到服务器相应");
    completionHandler(NSURLSessionResponseAllow);
}

// 接收到服务器返回数据时调用
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"接受到服务器返回数据");
    
    [self.resultData appendData:data];
}


// 请求完成或者失败时调通
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        NSLog(@"请求失败");
    } else {
        NSLog(@"请求完成: %@", [[NSString alloc] initWithData:self.resultData encoding:NSUTF8StringEncoding]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableData *)resultData {
    if (_resultData == nil) {
        _resultData = [NSMutableData data];
    }
    return _resultData;
}


@end
