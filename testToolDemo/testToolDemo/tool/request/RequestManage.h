//
//  RequestManage.h
//  testToolDemo
//
//  Created by 段贤才 on 16/7/4.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface RequestManage : NSObject
/**
 *  普通HTTP请求
 *
 *  @return manage
 */
+ (AFHTTPSessionManager *)shareHTTPManage;
/**
 *  下载或上传任务
 *
 *  @return manage
 */
+ (AFURLSessionManager *)shareTaskManage;

@end
