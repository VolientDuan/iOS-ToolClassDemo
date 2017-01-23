//
//  FMDBTool.h
//  YSDemo
//
//  Created by 段贤才 on 2017/1/16.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
typedef void(^DBReslutCallback)(int result,FMDatabase *db);
typedef void(^ReslutCallback)(int result,FMDatabase *db);

@interface FMDBTool : NSObject

+ (instancetype)shareDbTool;
/**
 创建表
 
 @param name 表名
 */
- (void)createTable:(NSString *)name callback:(DBReslutCallback)callback;

- (void)createTable:(NSString *)name class:(Class)model callback:(DBReslutCallback)callback;

- (void)insert:(id)data toTable:(NSString *)name;
/**
 表是否存在

 @param name 表名
 */
- (void)isTable:(NSString *)name callback:(DBReslutCallback)callback;

/**
 清除表数据

 @param t_name 表名
 @param callback 结果
 */
- (void)clearTable:(NSString *)t_name callback:(DBReslutCallback)callback;

/**
 删除表

 @param name 表名
 */
- (void)deleteTable:(NSString *)name callback:(DBReslutCallback)callback;

/**
 删除数据库

 @param path 路径
 */
- (BOOL)deleteDB:(NSString *)path;

/**
 添加列（添加字段）

 @param col_name 列名（字段名）
 @param t_name 表名
 */
- (void)addColumn:(NSString *)col_name table:(NSString *)t_name callback:(DBReslutCallback)callback;

#pragma mark - 根据需要自定义操作


@end
