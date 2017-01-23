//
//  FMDBTool.m
//  YSDemo
//
//  Created by 段贤才 on 2017/1/16.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import "FMDBTool.h"
#import <objc/runtime.h>

#define DBNAME @"myApp.sqlite"
#define DBPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:DBNAME]

/**
 数据类型（除了数组其它数据类型的数据结构只能是单层）

 - FMDBDataTypeInvalid: 无效
 - FMDBDataTypeModel: 实体类(可以自定义一个BaseModel)
 - FMDBDataTypeDictionary: 字典
 - FMDBDataTypeArray: 数组
 */
typedef NS_ENUM(NSInteger, FMDBDataType){
    FMDBDataTypeInvalid = 0,
    FMDBDataTypeModel,
    FMDBDataTypeDictionary,
    FMDBDataTypeArray
};
@interface FMDBTool()
@property (nonatomic, strong)FMDatabaseQueue *queue;

@end
@implementation FMDBTool

+ (instancetype)shareDbTool{
    static FMDBTool *dbTool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbTool = [[FMDBTool alloc]init];
        dbTool.queue = [FMDatabaseQueue databaseQueueWithPath:DBPATH];//没有自动创建
        NSLog(@"\n%s-%@",__func__,DBPATH);
    });
    return dbTool;
}

- (BOOL)checkDB{
    if (!self.queue) {
        self.queue = [FMDatabaseQueue databaseQueueWithPath:DBPATH];//没有自动创建
    }
    return YES;
}
- (BOOL)closeDB{
    //关闭数据库
    __block BOOL result = YES;
    [self.queue inDatabase:^(FMDatabase *db) {
        result = [db close];
    }];
    return result;
}
- (void)openDB:(DBReslutCallback)callback{
    if (!self.queue) {
        self.queue = [FMDatabaseQueue databaseQueueWithPath:DBPATH];
    }
    [self.queue inDatabase:^(FMDatabase *db) {
        callback(YES,db);
    }];
}
- (BOOL)deleteDB:(NSString *)path{
    BOOL success;
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]){
        if ([self closeDB]){
            success = [fileManager removeItemAtPath:path error:&error];
            if (!success) {
                return NO;
            }
        }
    }
    return YES;
}
- (void)createTable:(NSString *)name callback:(DBReslutCallback)callback{
    [self openDB:^(int result, FMDatabase *db) {
        callback([db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT);",name]],db);
    }];
}
- (void)createTable:(NSString *)name class:(__unsafe_unretained Class)model callback:(DBReslutCallback)callback{
    NSString *sql1 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@",name];
    NSMutableString *properties = [[NSMutableString alloc]initWithString:@"id integer PRIMARY KEY AUTOINCREMENT"];
    for (NSString *p in [self getProperties:model]) {
        [properties appendString:[NSString stringWithFormat:@",%@ text",p]];
    }
    [self openDB:^(int result, FMDatabase *db) {
        BOOL isCreated = [db executeUpdate:[NSString stringWithFormat:@"%@(%@)",sql1,properties]];
        NSLog(@"%@ is created %@!",name,isCreated?@"success":@"fail");
        callback(isCreated,db);
    }];
}
- (void)insert:(id)data toTable:(NSString *)name{
    FMDBDataType type = [self checkData:data];
    [self openDB:^(int result, FMDatabase *db) {
        if (type == FMDBDataTypeArray) {
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self splitModel:obj callback:^(NSArray *keys, NSArray *values) {
                    [db executeUpdate:[self formartInsertSQL:name andKeys:keys] values:values error:nil];
                }];
            }];
        }else if (type == FMDBDataTypeModel){
            [self splitModel:data callback:^(NSArray *keys, NSArray *values) {
                [db executeUpdate:[self formartInsertSQL:name andKeys:keys] values:values error:nil];
            }];
        }
        
    }];
}

- (void)isTable:(NSString *)name callback:(DBReslutCallback)callback{
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type ='table' and name = ?", name];
        while ([rs next]){
            NSInteger count = [rs intForColumn:@"count"];
            if (0 == count){
                callback(NO,db);
            }else{
                callback(YES,db);
            }
        }
    }];
    
}
- (void)getTableItemCount:(NSString *)name callback:(DBReslutCallback)callback{
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *sqlstr = [NSString stringWithFormat:@"SELECT count(*) as 'count' FROM %@", name];
        int count = 0;
        FMResultSet *rs = [db executeQuery:sqlstr];
        while ([rs next]){
            count = [rs intForColumn:@"count"];
        }
        callback(count,db);
    }];
    
}
- (void)clearTable:(NSString *)t_name callback:(DBReslutCallback)callback{
    [self isTable:t_name callback:^(int result, FMDatabase *db) {
        BOOL isDeleted = YES;
        if (result) {
            isDeleted = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@;",t_name]];
        }
        callback(isDeleted,db);
    }];
    
}

- (void)deleteTable:(NSString *)name callback:(DBReslutCallback)callback{
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:DBPATH];
    [queue inDatabase:^(FMDatabase *db) {
        NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@", name];
        callback([db executeUpdate:sqlstr],db);
    }];
}

- (void)addColumn:(NSString *)col_name table:(NSString *)t_name callback:(DBReslutCallback)callback{
    [self.queue inDatabase:^(FMDatabase *db) {
        if (![db columnExists:col_name inTableWithName:t_name]) {
            NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ INTEGER",t_name,col_name];
            callback([db executeUpdate:sql],db);
        }else{
            callback(YES,db);
        }
    }];
    
}
#pragma mark - 工具

- (NSArray *)getProperties:(Class)class{
    u_int count;
    objc_property_t *properties = class_copyPropertyList([class class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        const char* propertyName = property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}
- (FMDBDataType)checkData:(id)data{
    FMDBDataType type;
    if ([data isKindOfClass:[NSString class]]||[data isKindOfClass:[NSNumber class]]) {
        type = FMDBDataTypeInvalid;
    }else if ([data isKindOfClass:[NSDictionary class]]){
        type = FMDBDataTypeDictionary;
    }else if ([data isKindOfClass:[NSArray class]]){
        type = FMDBDataTypeArray;
    }else{
        type = FMDBDataTypeModel;
    }
    return type;
}

- (void)splitDic:(NSDictionary *)dic callback:(void(^)(NSArray *keys,NSArray *values))callback{
    
}

- (void)splitModel:(id)model callback:(void(^)(NSArray *keys,NSArray *values))callback{
    NSString *className = NSStringFromClass([model class]);
    NSArray *keys = [self getProperties:NSClassFromString(className)];
    NSMutableArray *values = [NSMutableArray array];
    for (NSString *key in keys) {
        [values addObject:[model valueForKey:key]];
    }
    callback(keys,values);
}
- (NSString *)formartInsertSQL:(NSString *)tableName andKeys:(NSArray *)keys{
    NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT INTO %@",tableName];
    NSMutableString *keySql,*valueSql;
    for (NSString *key in keys) {
        if (keySql) {
            [keySql appendString:[NSString stringWithFormat:@", %@",key]];
            [valueSql appendString:@",?"];
        }else{
            keySql = [[NSMutableString alloc]initWithString:key];
            valueSql = [[NSMutableString alloc]initWithString:@"?"];
        }
    }
    [sql appendString:[NSString stringWithFormat:@"(%@) VALUES (%@)",keySql,valueSql]];
    return sql;
}

#pragma mark - 自定义操作


@end
