//
//  FileManageTool.m
//  downloadTastsDemo
//
//  Created by 段贤才 on 2016/11/2.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import "FileManageTool.h"
@interface FileManageTool()
@property (nonatomic, strong)NSFileManager *fileManager;

@end
@implementation FileManageTool

- (NSFileManager *)fileManager{
    
    if (!_fileManager) {
        
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}

+ (instancetype)shareManager{
    
    static FileManageTool *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[FileManageTool alloc]init];;
    });
    return manager;
}

- (NSString *)createFilePathWithFileName:(NSString *)fileName folder:(NSString *)folder type:(VDFileType)type{
    
    NSString *path,*folderPath,*filePath;
    switch (type) {
            case VDFileTypeDocument:
            path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            break;
            case VDFileTypeCaches:
            path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            break;
            case VDFileTypeTmp:
            path = NSTemporaryDirectory();
            break;
        default:
            break;
    }
    if (folder.length>0) {
        
        folderPath = [path stringByAppendingPathComponent:folder];
        BOOL isDir = YES;
        if (![self.fileManager fileExistsAtPath:folderPath isDirectory:&isDir]) {
            
            [self.fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }else{
        
        folderPath = path;
    }
    filePath = [folderPath stringByAppendingPathComponent:fileName];
    NSLog(@"file path:%@",filePath);
    
    return filePath;
}

- (BOOL)saveToLocalFolderWithFile:(id)file withFilePath:(NSString *)filePath{
    if ([self.fileManager fileExistsAtPath:filePath]) {
        
        return NO;
    }
    NSData *fileData;
    if ([file isKindOfClass:[NSData class]]) {
        
        fileData = file;
    }
    else if ([file isKindOfClass:[UIImage class]]) {
        
        fileData = UIImageJPEGRepresentation(file, 1.0);
    }
    else{

        return NO;
    }
    return [fileData writeToFile:filePath atomically:YES];
}

- (BOOL)writeToFileWithContent:(id)content path:(NSString *)path{
    //文件的读取可以直接使用NSArray，NSDictionary和NSString的相应方法
    if ([content isKindOfClass:[NSString class]]) {
        return [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    else{
        return [content writeToFile:path atomically:YES];
    }
}
- (NSString *)readFileContentWithFilePath:(NSString *)path{
    
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

- (BOOL)deleteFileWithFilePath:(NSString *)path{
    
    return [self.fileManager removeItemAtPath:path error:nil];
}

- (unsigned long long)fileSizeAtPath:(NSString *)path{
    
    if ([self.fileManager fileExistsAtPath:path]){
        
        unsigned long long fileSize = [[self.fileManager attributesOfItemAtPath:path error:nil] fileSize];
        return fileSize;
    } else {
        
        return 0;
    }
}

- (unsigned long long)folderSizeAtPath:(NSString *)path{
    
    if ([self.fileManager fileExistsAtPath:path]) {
        
        NSEnumerator *childFileEnumerator = [[self.fileManager subpathsAtPath:path] objectEnumerator];
        unsigned long long folderSize = 0;
        NSString *fileName = @"";
        while ((fileName = [childFileEnumerator nextObject]) != nil){
            NSString* fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
        }
        return folderSize;
    }else{
        
        return 0;
    }
}
@end
