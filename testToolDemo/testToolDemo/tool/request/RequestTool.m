//
//  SimpleRequestTool.m
//  testToolDemo
//
//  Created by 段贤才 on 16/7/6.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import "RequestTool.h"
#import "RequestManage.h"
#import "NSObject+Unicode.h"

#import <objc/runtime.h>
#import "UIImage+tool.h"

@implementation RequestTool
+ (void)monitoringNetworkState:(void (^)(NSInteger))block{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                //未知网络
                VDLog(@"[网络状态切换]--未知网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                //无法联网
                VDLog(@"[网络状态切换]--无法联网");
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //手机自带网络
                VDLog(@"[网络状态切换]--当前使用的是2g/3g/4g网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //WIFI
                VDLog(@"[网络状态切换]--当前在WIFI网络下");
            }
                
        }
        block(status);
    }];
}
- (NSString *)baseUrl{
    return [RequestManage shareHTTPManage].baseURL.absoluteString;
}

+ (instancetype)shareManager{
    static RequestTool *shareManage = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        shareManage = [[RequestTool alloc] init];
    });
    return shareManage;
}
- (void)sendRequestWithAPI:(NSString *)requestAPI
                    withVC:(UIViewController *)vc
                withParams:(NSDictionary *)params
                 withClass:(NSString *)className
             responseBlock:(RequestResponse)response{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //修改为GBK编码
    [RequestManage shareHTTPManage].requestSerializer.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //不处理cookie
    [RequestManage shareHTTPManage].requestSerializer.HTTPShouldHandleCookies = NO;
    NSString *baseUrl = [RequestManage shareHTTPManage].baseURL.absoluteString;
    //请求
    VDLog(@"\nRequest=====>URL:%@%@\nparams:%@",baseUrl,requestAPI,params);
    [[RequestManage shareHTTPManage] POST:requestAPI parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //响应
        VDLog(@"\nResponse=====>URL:%@%@\nresult:%@",baseUrl,requestAPI,[responseObject my_description]);
        //对responseObject进行处理...(想咋写就咋写)
        if (className) {
            /* 关于如何使用这个class可以查看本工程下的'runtime常用方法.md' */
            Class class = NSClassFromString(className);
            NSObject *responseModel = [[class alloc]init];
            response(responseModel,[[responseObject valueForKey:@"code"] isEqualToString:@"0"] ? NO:YES,[responseObject valueForKey:@"message"],[[responseObject valueForKey:@"code"] integerValue]);
        }
        else{
            response(responseObject,[[responseObject valueForKey:@"code"] isEqualToString:@"0"] ? NO:YES,[responseObject valueForKey:@"message"],[[responseObject valueForKey:@"code"] integerValue]);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            response(nil,YES,@"互联网的连接似乎已经断开",error.code);
        }
        else if(error.code == -1001){
            response(nil,YES,@"请求超时",error.code);
        }
        else if(error.code == -1011){
            response(nil,YES,@"不支持该响应类型",error.code);
        }
        else{
            response(nil,YES,@"服务器需要休息片刻",error.code);
        }
            
    }];
    
}

#pragma mark [下载和上传]
- (NSArray *)finishTasks{
    
    NSArray *array = (NSArray *)[[UserInfoModel sharedManage]getObjWithKey:@"finishTasks"];
    if (array) {
        return array;
    }
    return [NSArray array];
}

- (void)setFinishTasks:(NSArray *)finishTasks{
    
    [[UserInfoModel sharedManage]saveObjWithKey:@"finishTasks" andValue:finishTasks];
}

- (NSArray *)taskList{
    
    NSArray *array = (NSArray *)[[UserInfoModel sharedManage]getObjWithKey:@"taskList"];
    if (array) {
        return array;
    }
    return [NSArray array];
}
- (void)setTaskList:(NSArray *)taskList{
    
    [[UserInfoModel sharedManage]saveObjWithKey:@"taskList" andValue:taskList];
}


- (void)createDownloadTaskWithURL:(NSString *)url
                      withFileName:(NSString *)fileName
                              Task:(DownloadTask)downloadTask
                          Progress:(TaskProgress)progress
                            Result:(TaskResult)result{
    /**
     *  创建下载队列，其中"download"为线程标示符
     */
    task_queue("download", ^{
        NSURL *requestUrl = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
        NSURLSessionDownloadTask *task = [[RequestManage shareTaskManage] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            //回到主线程
            main_view_queue(^{
                progress(downloadProgress.fractionCompleted,fileName);
            });
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            /**
             *  拼接返回路径，并返回给 destination block 块
             *
             *  @param NSCachesDirectory 沙盒中 Caches 的路径
             *  @param NSUserDomainMask  搜索文件的范围
             *  @param YES               是否返回绝对路径 YES 是返回绝对路径 NO 返回相对路径
             *
             *  @return 沙盒中 Caches 的绝对路径
             */
            NSString *cachaPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
            NSString *path = [cachaPath stringByAppendingPathComponent:fileName];
            
            NSURL *fileUrl = [NSURL fileURLWithPath:path];
            
            /*设置文件的存储路径(路径你想怎么设我管不着)*/
            return fileUrl;
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            BOOL isError = NO;
            if (error) {
                isError = YES;
                NSLog(@"error:%@",[error my_description]);
            }
            else{
                NSLog(@"%@下载完成",fileName);
                
            }
            result(response,isError);
            
        }];
        [task resume];
        /* 这个描述可以当做一个任务的标识，一般需要控制任务是才会使用 */
        task.taskDescription = fileName;
        downloadTask(task);
    });
    
}

- (void)createUploadTaskWithUrl:(NSString *)url
                       WithMark:(NSString *)mark
                       withData:(NSData *)data
                           Task:(UploadTask)uploadTask
                       Progress:(TaskProgress)progress
                         Result:(TaskResult)result{
    //创建上传队列
    task_queue("upload", ^{
        
        NSURL *requestUrl = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
        NSURLSessionUploadTask *task = [[RequestManage shareTaskManage]uploadTaskWithRequest:request fromData:data progress:^(NSProgress * _Nonnull uploadProgress) {
            //回到主线程
            main_view_queue(^{
                progress(uploadProgress.fractionCompleted,task.taskDescription);
                
            });
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            BOOL isError = NO;
            if (error) {
                isError = YES;
            }
            result(response,isError);
        }];
        [task resume];
        /* 这个描述可以当做一个任务的标识，一般需要控制任务是才会使用 */
        task.taskDescription = mark;
        
    });
}
- (void)uploadImageWithUrl:(NSString *)url WithImage:(UIImage *)image Params:(NSDictionary *)params Task:(UploadTask)uploadTask Progress:(TaskProgress)progress Result:(TaskResult)result{
    NSString *formatAPI = [NSString stringWithFormat:@"app/%@.htm?imgType=%ld",url,[[params objectForKey:@"imgType"] integerValue]];
    VDLog(@"\nRequest=====>URL:%@%@",[RequestManage shareHTTPManage].baseURL.absoluteString,formatAPI);
    NSData *data = [UIImage smallTheImageBackData:image];
    task_queue("uploadImage", ^{
        __block NSURLSessionDataTask * task = [[RequestManage shareHTTPManage]POST:formatAPI parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:data name:@"file" fileName:@"file.png" mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //回到主线程
            main_view_queue(^{
                progress(uploadProgress.fractionCompleted,task.taskDescription);
                
            });
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
            result(responseObject,code==0?NO:YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            result(error,YES);
        }];
    });
    
}
/**
 *  任务队列
 *
 *  @param ^block 在此代码块中创建任务
 */
static void task_queue(char *taskName,void (^block)(void))
{
    /**
     *  为下载任务开辟线程
     *
     *  @param "download"              线程标示符
     *  @param DISPATCH_QUEUE_CONCURRENT 并行队列宏
     *
     */
    dispatch_queue_t queue = dispatch_queue_create(taskName, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        block();
        
    });
}

/**
 *  回到主线程
 *
 *  @param ^block 需要在主线程执行的代码块
 */
static void main_view_queue(void (^block)(void))
{
    /**
     *  涉及到跟 UI 界面元素相关的操作，需要回到主线程执行相关代码
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });

}



@end
