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

+ (AFHTTPSessionManager *)shareSessionManage;

@end
