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

+ (AFHTTPSessionManager *)shareHTTPManage{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceSession;
    dispatch_once(&onceSession, ^{
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:baseUrl]];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return manager;
}

+ (AFURLSessionManager *)shareTaskManage{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    return [[AFURLSessionManager alloc]initWithSessionConfiguration:config];
}

@end
