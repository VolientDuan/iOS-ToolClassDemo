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

/*任务进度回调*/
typedef void (^TaskProgress)(float progress,NSString *taskDesc);

/*下载任务回调*/
typedef void (^DownloadTask)(NSURLSessionDownloadTask *task);

/*上传任务回调*/
typedef void (^UploadTask)(NSURLSessionUploadTask *task);

typedef void (^TaskResult)(id response,BOOL isError);

@interface RequestTool : NSObject

@property (nonatomic, strong,readonly)NSString *baseUrl;

/*任务列表*/
@property (nonatomic, strong)NSArray *taskList;
/* 已完成列表 */
@property (nonatomic, strong)NSArray *finishTasks;

/**
 *  网络状态检测
 *  -1:位置网络 0:网络不可用 1:2g-4g 2:wifi
 */
+ (void)monitoringNetworkState:(void (^)(NSInteger status))block;

+ (instancetype)shareManager;

/**
 *  发送请求
 *
 *  @param requestAPI 请求的API
 *  @param vc         发送请求的视图控制器
 *  @param params     请求参数
 *  @param className  数据模型的类名(参数为空时:response为字典;参数不为空response为Model)
 *  @param response   请求的返回结果回调
 */
- (void)sendRequestWithAPI:(NSString *)requestAPI
                    withVC:(UIViewController *)vc
                withParams:(NSDictionary *)params
                 withClass:(NSString *)className
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
- (void)createDownloadTaskWithURL:(NSString *)url
              withFileName:(NSString *)fileName
                       Task:(DownloadTask)downloadTask
                   Progress:(TaskProgress)progress
                     Result:(TaskResult)result;

/**
 *  创建上传任务
 *
 *  @param url        上传地址
 *  @param mark       任务标识
 *  @param data       序列化文件
 *  @param uploadTask 任务
 *  @param progress   进度
 *  @param result     结果
 */
- (void)createUploadTaskWithUrl:(NSString *)url
                       WithMark:(NSString *)mark
                       withData:(NSData *)data
                           Task:(UploadTask)uploadTask
                       Progress:(TaskProgress)progress
                         Result:(TaskResult)result;

/**
 *  图片的表单上传
 *
 *  @param url        url
 *  @param image      图片
 *  @param uploadTask 任务
 *  @param progress   进度
 *  @param result     结果
 */
- (void)uploadImageWithUrl:(NSString *)url
                 WithImage:(UIImage *)image
                    Params:(NSDictionary *)params
                      Task:(UploadTask)uploadTask
                  Progress:(TaskProgress)progress
                    Result:(TaskResult)result;
@end
