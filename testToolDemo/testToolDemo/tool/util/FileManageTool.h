//
//  FileManageTool.h
//  downloadTastsDemo
//
//  Created by 段贤才 on 2016/11/2.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 文件目录类型

 - VDFileTypeDocument:    最常用的目录，iTunes同步该应用时会同步此文件夹中的内容，适合存储重要数据。
 - VDFileTypeCaches:      不会同步此文件夹，适合存储体积大，不需要备份的非重要数据。
 - VDFileTypeTmp:         iTunes不会同步此文件夹，系统可能在应用没运行时就删除该目录下的文件，所以此目录适合保存应用中的一些临时文件，用完就删除。
 */
typedef NS_ENUM(NSInteger, VDFileType){
    VDFileTypeDocument = 0,
    VDFileTypeCaches,
    VDFileTypeTmp,
};

typedef void(^FileCallBack)(BOOL isSuccess,NSString *filePath);

@interface FileManageTool : NSObject

+ (instancetype)shareManager;

/**
 创建文件路径

 @param fileName 文件名
 @param folder   子文件夹
 @param type     文件父目录

 @return 文件的绝对路径
 */
- (NSString *)createFilePathWithFileName:(NSString *)fileName folder:(NSString *)folder type:(VDFileType)type;

/**
 保存文件

 @param file     文件（支持Data和image）
 @param filePath 文件的绝对路径

 @return 结果
 */
- (BOOL)saveToLocalFolderWithFile:(id)file withFilePath:(NSString *)filePath;

/**
 文件的写入

 @param content 支持字符串数组和字典
 @param path    文件路径

 @return 结果
 */
- (BOOL)writeToFileWithContent:(id)content path:(NSString *)path;

/**
 读取文件中的字符串信息

 @param path 文件路径

 @return 字符串
 */
- (NSString *)readFileContentWithFilePath:(NSString *)path;


/**
 删除文件

 @param path 文件路径

 @return 结果
 */
- (BOOL)deleteFileWithFilePath:(NSString *)path;

/**
 获取文件夹大小

 @param path 文件夹的路径

 @return 大小（B）
 */
- (unsigned long long)folderSizeAtPath:(NSString *)path;

/**
 获取单个文件的大小

 @param path 文件路径

 @return 大小（B）
 */
- (unsigned long long)fileSizeAtPath:(NSString *)path;


@end
