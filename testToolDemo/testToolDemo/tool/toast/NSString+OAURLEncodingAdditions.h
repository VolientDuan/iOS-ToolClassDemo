//
//  NSString+OAURLEncodingAdditions.h
//  linju_ios
//
//  Created by LiZheng on 15/8/14.
//  Copyright (c) 2015年 focusoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OAURLEncodingAdditions)
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
@end
