//
//  ViewController.m
//  iOS-NSCache
//
//  Created by Ezreal on 2018/9/11.
//  Copyright © 2018年 liuyiming. All rights reserved.
//

/**
 * NSCache：专门做缓存的类
 * NSCache简介：NSCache是苹果官方提供的缓存类，用法与NSMutableDictionary的用法很相似，
   在AFNetworking和SDWebImage中，使用它来管理缓存。
 
 * NSCache在系统内存很低时，会自动释放一些对象（出自苹果官方文档，不过在模拟器中模拟内存警告时，不会做缓存的清理动作） 为了确保接
   内存警告时能够真正释放内存，最好调用一下removeAllObjects方法。
 
 * NScache是线程安全的，在多线程操作中，不需要对Cache加锁。
 * NScache的key只是做强引用，不需要实现NScopying协议。
 * evictsObjectsWithDiscardedContent：标示是否回收废弃的内容，默认值是YES（自动回收）。
 **/

/**
 * NSCache的属性
 * delegate代理属性
 * totalCostLimit ：缓存空间的最大成本，超出上限会自动回收对象。默认值是0没有限制
 * countLimit：能够缓存对象的最大数量，默认值也是0（默认没有限制）。（当超出缓存最大成本或数量时，NSCache会把前面的数据即最开始存
   给清除掉）
 */

/**
 * NSCache的方法：
 * -objectForKey：返回与键值关联的对象。
 * -setObject: forKey: 在缓存中设置指定键名对应的值。与可变字典不同的是，缓存对象不会对键名做copy操作 0成本
 * -setObject: forKey: cost: 在缓存中设置指定键名对应的值，并且指定该键值对的成本。成本cost用于计算记录在缓冲中所有对象的总成本
   当出现内存警告，或者超出缓存的成本上限时，缓存会开启一个回收过程，删除部分元素。
 * -removeObjectForKey：删除缓存中指定键名的对象。
 * -removeAllObjects：删除缓存中的所有对象。
 **/

/**
 * 委托方法：
 * -cache: willEvictObject: 缓存将要删除对象时调用，不能在此方法中修改缓存。仅仅用于后台的打印，以便于程序员的测试。
 */


#import "ViewController.h"

@interface ViewController () <NSCacheDelegate>

@property(nonatomic, strong) NSCache *cache;

@property(nonatomic, strong) UIButton *storeBtn;
@property(nonatomic, strong) UIButton *checkBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _storeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _storeBtn.frame = CGRectMake(100, 100, 100, 40);
    _storeBtn.backgroundColor = [UIColor redColor];
    [_storeBtn setTitle:@"存数据" forState:UIControlStateNormal];
    [_storeBtn addTarget:self action:@selector(storeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_storeBtn];
    
    _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkBtn.frame = CGRectMake(100, 200, 100, 40);
    _checkBtn.backgroundColor = [UIColor redColor];
    [_checkBtn setTitle:@"取数据" forState:(UIControlStateNormal)];
    [_checkBtn addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_checkBtn];
}

- (void)storeAction {
    NSString *str = @"这是一条测试数据";
     NSLog(@"存数据：%@", str);
    [self.cache setObject:str forKey:@"temp"];
}

- (void)checkAction {
    NSString *str = [self.cache objectForKey:@"temp"];
    NSLog(@"取数据：%@", str);
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    
}

- (NSCache *)cache {
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        //设置最大缓存数据数量，当超出缓存最大成本或数量时，NSCache会把前面的数据即最开始存的给清除掉
        _cache.countLimit = 3;
        //设置最大的缓存成本（成本：单位概念）
//        _cache.totalCostLimit = 5;
        _cache.delegate = self;
    }
    
    return _cache;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
