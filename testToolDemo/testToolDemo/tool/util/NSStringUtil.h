//
//  NSStringUtil.h
//  testToolDemo
//
//  Created by 段贤才 on 16/7/7.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStringUtil : NSObject
/**
 *  校验邮箱格式
 *
 *  @param email 需要校验的邮箱
 *
 *  @return 返回结果
 */
+(BOOL) isValidateEmail:(NSString *)email;
/**
 *  校验手机号格式
 *
 *  @param mobile 手机号
 *
 *  @return 结果
 */
+(BOOL) isValidateMobile:(NSString *)mobile;
/**
 *  校验车牌号
 *
 *  @param carNo 车牌号
 *
 *  @return 结果
 */
+(BOOL) isValidateCarNo:(NSString*)carNo;
/**
 *  校验身份证号
 *
 *  @param idCardNo 身份证号
 *
 *  @return 结果
 */
+(BOOL) isValidateIDCardNo:(NSString *)idCardNo;

@end
