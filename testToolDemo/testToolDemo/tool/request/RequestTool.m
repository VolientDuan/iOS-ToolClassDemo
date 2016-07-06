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
@implementation RequestTool

- (NSString *)baseUrl{
    return [RequestManage shareSessionManage].baseURL.absoluteString;
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
                 withClass:(Class)className
             responseBlock:(RequestResponse)response{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //修改为GBK编码
    [RequestManage shareSessionManage].requestSerializer.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //不处理cookie
    [RequestManage shareSessionManage].requestSerializer.HTTPShouldHandleCookies = NO;
    NSString *baseUrl = [RequestManage shareSessionManage].baseURL.absoluteString;
    //请求
    VDLog(@"\nRequest=====>URL:%@%@\nparams:%@",baseUrl,requestAPI,params);
    [[RequestManage shareSessionManage] POST:requestAPI parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //响应
        VDLog(@"\nResponse=====>URL:%@%@\nresult:%@",baseUrl,requestAPI,[responseObject my_description]);
        //对responseObject进行处理...(想咋写就咋写)
        
        
        
        
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
@end
