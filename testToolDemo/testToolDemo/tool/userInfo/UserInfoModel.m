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
//存入
- (void)saveInfoWithKey:(NSString *)key andValue:(NSString *)value{
    if (value == nil) {
        value = @"";
    }
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//取出
- (NSString *)getInfoWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

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
    [self saveInfoWithKey:@"isBind" andValue:isBind == YES?@"YES":@"NO"];
}
- (BOOL)isBind{
    return [[self getInfoWithKey:@"isBind"] isEqualToString:@"YES"];
}

@end
