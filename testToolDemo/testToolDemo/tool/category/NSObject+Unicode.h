//
//  NSObject+Unicode.h
//  testToolDemo
//
//  Created by 段贤才 on 16/7/6.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Unicode)
/**
 *  解决输出中文乱码问题
 *
 *  @return 字符串
 */
- (NSString *)my_description;

@end
