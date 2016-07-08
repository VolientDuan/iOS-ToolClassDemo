//
//  SimpleRequestTool.h
//  testToolDemo
//
//  Created by 段贤才 on 16/7/6.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/*普通请求回调*/
typedef void (^RequestResponse)(id response, BOOL isError , NSString *errorMessage,NSInteger errorCode);

/*下载任务回调*/
typedef void (^TaskProgress)(float progress);
typedef void (^DownloadTask)(NSURLSessionDownloadTask *task);
typedef void (^TaskResult)(id response,NSURL *filePath,BOOL isError);

@interface RequestTool : NSObject

@property (nonatomic, strong,readonly)NSString *baseUrl;

/*任务列表*/
@property (nonatomic, strong)NSMutableArray *taskList;

+ (instancetype)shareManager;

/**
 *  发送请求
 *
 *  @param requestAPI 请求的API
 *  @param vc         发送请求的视图控制器
 *  @param params     请求参数
 *  @param className  数据模型
 *  @param response   请求的返回结果回调
 */
- (void)sendRequestWithAPI:(NSString *)requestAPI
                    withVC:(UIViewController *)vc
                withParams:(NSDictionary *)params
                 withClass:(Class)className
             responseBlock:(RequestResponse)response;

/**
 *  创建下载任务
 *
 *  @param url          下载地址
 *  @param fileName     文件名
 *  @param downloadTask 任务
 *  @param progress     进度
 *  @param result       结果
 */
- (void)createDdownloadTaskWithURL:(NSString *)url
              withFileName:(NSString *)fileName
                       Task:(DownloadTask)downloadTask
                   Progress:(TaskProgress)progress
                     Result:(TaskResult)result;

@end
