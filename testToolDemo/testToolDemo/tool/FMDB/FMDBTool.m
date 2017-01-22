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
    [self.queue inDatabase:^(FMDatabase *db) {
        callback([db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT);",name]],db);
    }];
}
- (void)createTable:(NSString *)name class:(Class)class{
    NSString *sql1 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@",name];
    NSMutableString *properties = [[NSMutableString alloc]initWithString:@"id integer PRIMARY KEY AUTOINCREMENT"];
    for (NSString *p in [self getProperties:class]) {
        [properties appendString:[NSString stringWithFormat:@",%@ text",p]];
    }
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL isCreated = [db executeUpdate:[NSString stringWithFormat:@"%@(%@)",sql1,properties]];
        NSLog(@"createTable---%d",isCreated);
    }];
}
- (void)insert:(id)data toTable:(NSString *)name{
    if ([data isKindOfClass:[NSString class]]||[data isKindOfClass:[NSNumber class]]) {
        NSLog(@"不支持该类型数据插入");
    }
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
- (NSArray *)getProperties:(Class)model{
    u_int count;
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}
#pragma mark - 自定义操作

//- (void)updateSecondViewData:(NSArray *)data{
//    [self deleteTable:@"t_second" callback:^(int result, FMDatabase *db) {
//        if (result) {
//            BOOL isCreated = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_second (t_id integer PRIMARY KEY AUTOINCREMENT, symbol text NOT NULL, name text NOT NULL, trade text NOT NULL, pricechange text NOT NULL, changepercent text NOT NULL, buy text NOT NULL, sell text NOT NULL, settlement text NOT NULL, open text NOT NULL, high text NOT NULL, low text NOT NULL, volume text NOT NULL, amount text NOT NULL, code text NOT NULL, ticktime text NOT NULL);"];
//            if (isCreated) {
//                for (SecondModel *model in data) {
//                    NSString *sql = @"INSERT INTO t_second(symbol,name,trade,pricechange,changepercent,buy,sell,settlement,open,high,low,volume,amount,code,ticktime) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
//                    [db executeUpdate:sql,model.symbol,model.name,model.trade,model.pricechange,model.changepercent,model.buy,model.sell,model.settlement,model.open,model.high,model.low,model.volume,model.amount,model.code,model.ticktime];
//                }
//            }
//        }
//    }];
//}
//
//- (void)appendSecondViewData:(NSArray *)data{
//    [self.queue inDatabase:^(FMDatabase *db) {
//        BOOL isCreated = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_second (t_id integer PRIMARY KEY AUTOINCREMENT, symbol text NOT NULL, name text NOT NULL, trade text NOT NULL, pricechange text NOT NULL, changepercent text NOT NULL, buy text NOT NULL, sell text NOT NULL, settlement text NOT NULL, open text NOT NULL, high text NOT NULL, low text NOT NULL, volume text NOT NULL, amount text NOT NULL, code text NOT NULL, ticktime text NOT NULL);"];
//        if (isCreated) {
//            for (SecondModel *model in data) {
//                NSString *sql = @"INSERT INTO t_second(symbol,name,trade,pricechange,changepercent,buy,sell,settlement,open,high,low,volume,amount,code,ticktime) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
//                [db executeUpdate:sql,model.symbol,model.name,model.trade,model.pricechange,model.changepercent,model.buy,model.sell,model.settlement,model.open,model.high,model.low,model.volume,model.amount,model.code,model.ticktime];
//            }
//        }
//    }];
//}
//
//- (NSMutableArray *)getSecondViewData:(void (^)(NSMutableArray *))callback{
//    __block NSMutableArray *data = [NSMutableArray array];
//    [self.queue inDatabase:^(FMDatabase *db) {
//        if ([self checkDB]) {
//            FMResultSet *resultSet = [db executeQuery:@"select * from t_second;"];
//            while ([resultSet  next]) {
//                SecondModel *model = [[SecondModel alloc]init];
//                model.symbol = [resultSet objectForColumnName:@"symbol"];
//                model.name = [resultSet objectForColumnName:@"name"];
//                model.trade = [resultSet objectForColumnName:@"trade"];
//                model.pricechange = [resultSet objectForColumnName:@"pricechange"];
//                model.changepercent = [resultSet objectForColumnName:@"changepercent"];
//                model.buy = [resultSet objectForColumnName:@"buy"];
//                model.sell = [resultSet objectForColumnName:@"sell"];
//                model.settlement = [resultSet objectForColumnName:@"settlement"];
//                model.open = [resultSet objectForColumnName:@"open"];
//                model.high = [resultSet objectForColumnName:@"high"];
//                model.low = [resultSet objectForColumnName:@"low"];
//                model.volume = [resultSet objectForColumnName:@"volume"];
//                model.amount = [resultSet objectForColumnName:@"amount"];
//                model.code = [resultSet objectForColumnName:@"code"];
//                model.ticktime = [resultSet objectForColumnName:@"ticktime"];
//                [data addObject:model];
//            }
//        }
//    }];
//    if (callback) {
//        callback(data);
//    }
//    return data;
//}

@end
