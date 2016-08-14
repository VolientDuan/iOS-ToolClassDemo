//
//  KeyChain.h
//  linju_ios
//
//  Created by LiZheng on 15/6/23.
//  Copyright (c) 2015年 focusoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChain : NSObject

@property (strong, nonatomic) NSMutableDictionary *viewControllerDic;

+ (instancetype) sharedManage;
+ (BOOL) isNullString:(NSString *)string;
+ (BOOL) validUsedIntValue:(NSString *)value;

/**
 *  避免汉字乱码进行GBK2312转码
 *
 *  @param source source description
 *
 *  @return return value description
 */
+ (NSString *)stringWithGBK2312:(NSString *)source;

/**
 *  判断是否包含汉字
 *
 *  @param source source description
 *
 *  @return return value description
 */
+ (BOOL) isContainMandarin:(NSString *)str;
- (void) showMessage:(NSString *) message;

- (void)saveUserToken:(NSString *)token;
- (NSString *)getUserToken;
- (void) showMessage:(NSString *) message withSuperView:(UIView *)superView;
@end
