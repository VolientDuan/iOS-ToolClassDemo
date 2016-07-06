//
//  RequestManage.m
//  testToolDemo
//
//  Created by 段贤才 on 16/7/4.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import "RequestManage.h"

static NSString *baseUrl = @"http://apis.juhe.cn";

@implementation RequestManage

+ (AFHTTPSessionManager *)shareSessionManage{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceSession;
    dispatch_once(&onceSession, ^{
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:baseUrl]];
    });
    return manager;
}

@end
