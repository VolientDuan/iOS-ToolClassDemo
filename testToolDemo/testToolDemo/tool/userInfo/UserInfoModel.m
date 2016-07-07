//
//  UserInfoModel.m
//  testToolDemo
//
//  Created by 段贤才 on 16/7/4.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+ (instancetype)sharedManage{
    static UserInfoModel *shareManage = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareManage = [[UserInfoModel alloc]init];
    });
    return shareManage;
}
#pragma mark [存入]
//存入字符串类型数据
- (void)saveInfoWithKey:(NSString *)key andValue:(NSString *)value{
    if (![value isNullString]) {
        value = @"";
    }
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    //同步存储到磁盘中
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//存入布朗型数据
- (void)saveBoolWithKey:(NSString *)key andValue:(BOOL)value{
    [self saveInfoWithKey:key andValue:value == YES?@"YES":@"NO"];
}
#pragma mark [取出]
//取出字符串类型数据
- (NSString *)getInfoWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}
//取出布朗型数据
- (BOOL)getBoolWithKey:(NSString *)key{
return [[self getInfoWithKey:key] isEqualToString:@"YES"];
}

#pragma mark [相关信息的set与get]
//token
- (void)setToken:(NSString *)token{
    [self saveInfoWithKey:@"token" andValue:token];
}
- (NSString *)token{
    return [self getInfoWithKey:@"token"];
}

//userName
- (void)setUserName:(NSString *)userName{
    [self saveInfoWithKey:@"userName" andValue:userName];
}
- (NSString *)userName{
    return [self getInfoWithKey:@"userName"];
}

//isBind
- (void)setIsBind:(BOOL)isBind{
    [self saveBoolWithKey:@"isBind" andValue:isBind];
}
- (BOOL)isBind{
    return [self getBoolWithKey:@"isBind"];
}

@end
