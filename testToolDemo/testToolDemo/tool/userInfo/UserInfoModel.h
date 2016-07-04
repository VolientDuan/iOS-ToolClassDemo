//
//  UserInfoModel.h
//  testToolDemo
//
//  Created by 段贤才 on 16/7/4.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

//实现单例
+ (instancetype)sharedManage;

@property (nonatomic, strong) NSString     *token;//用户唯一标识

@property (nonatomic, strong) NSString     *userName;//用户名

@property (nonatomic, assign) BOOL         isBind;//是否绑定

@end
