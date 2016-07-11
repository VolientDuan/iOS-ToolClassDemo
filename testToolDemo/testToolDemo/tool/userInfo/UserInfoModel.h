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

- (void)saveInfoWithKey:(NSString *)key andValue:(NSString *)value;

- (NSString *)getInfoWithKey:(NSString *)key;

- (void)saveBoolWithKey:(NSString *)key andValue:(BOOL)value;

- (BOOL)getBoolWithKey:(NSString *)key;

- (void)saveObjWithKey:(NSString *)key andValue:(NSObject *)value;

- (id)getObjWithKey:(NSString *)key;

@property (nonatomic, strong) NSString       *token;//用户唯一标识

@property (nonatomic, strong) NSString       *userName;//用户名

@property (nonatomic, assign) BOOL           isBind;//是否绑定

@property (nonatomic, strong) NSMutableArray *orderList;//订单列表

@end
