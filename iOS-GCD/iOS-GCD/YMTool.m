//
//  YMTool.m
//  iOS-GCD
//
//  Created by Ezreal on 2018/6/21.
//  Copyright © 2018年 liuyiming. All rights reserved.
//

#import "YMTool.h"

@implementation YMTool

static YMTool *instance;

+ (instancetype)shareTool {
    
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}


@end
