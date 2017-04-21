//
//  VDSSetPageTool.m
//  testToolDemo
//
//  Created by 段贤才 on 2017/4/21.
//  Copyright © 2017年 volientDuan. All rights reserved.
//

#import "VDSSetPageTool.h"

@implementation VDSSetPageTool

+ (void)show:(VDSetPageType)type{
    NSString * strUrl = @"";
    switch (type) {
        case VDSetPageTypeApp:
            strUrl = UIApplicationOpenSettingsURLString;
            break;
            
        default:
            break;
    }
    NSURL *url = [NSURL URLWithString:strUrl];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
@end
