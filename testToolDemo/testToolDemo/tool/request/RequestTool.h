//
//  SimpleRequestTool.h
//  testToolDemo
//
//  Created by 段贤才 on 16/7/6.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RequestResponse)(id response, BOOL isError , NSString *errorMessage,NSInteger errorCode);

@interface RequestTool : NSObject

@property (nonatomic, strong,readonly)NSString *baseUrl;

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

@end
