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

- (NSString *)createFilePathWithFileName:(NSString *)fileName folder:(NSString *)folder type:(VDFileType)type;

- (BOOL)saveToLocalFolderWithFile:(id)file withFilePath:(NSString *)filePath;

- (BOOL)writeToFileWithContent:(NSString *)content path:(NSString *)path;
- (NSString *)readFileContentWithFilePath:(NSString *)path;

- (BOOL)deleteFileWithFilePath:(NSString *)path;

- (unsigned long long)folderSizeAtPath:(NSString *)path;
- (unsigned long long)fileSizeAtPath:(NSString *)path;


@end
