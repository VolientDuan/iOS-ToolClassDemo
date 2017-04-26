//
//  VDSSetPageTool.m
//  testToolDemo
//
//  Created by 段贤才 on 2017/4/21.
//  Copyright © 2017年 volientDuan. All rights reserved.
//
#define num 1
#import "VDSSetPageTool.h"

@implementation VDSSetPageTool

+ (void)show:(VDSetPageType)type{
    NSString * strUrl = @"";
    NSString *prefs = [[UIDevice currentDevice].systemVersion floatValue] >= 10.0?@"APP-Prefs:root=":@"prefs:root=";
    switch (type) {
        case VDSetPageTypeApp:
            strUrl = UIApplicationOpenSettingsURLString;
            break;
        case VDSetPageTypeLocation:
            strUrl = [NSString stringWithFormat:@"%@LOCATION_SERVICES  ",prefs];
            break;
        case VDSetPageTypeBluetooth:
            strUrl = [NSString stringWithFormat:@"%@General&path=Bluetooth",prefs];
            break;
        case VDSetPageTypeVPN:
            strUrl = [NSString stringWithFormat:@"%@General&path=Network/VPN",prefs];
            break;
        case VDSetPageTypeWIFI:
            strUrl = [NSString stringWithFormat:@"%@WIFI",prefs];
            break;
        case VDSetPageTypeGeneral:
            strUrl = [NSString stringWithFormat:@"%@General",prefs];
            break;
        case VDSetPageTypeKeyboard:
            strUrl = [NSString stringWithFormat:@"%@General&path=Keyboard",prefs];
            break;
        default:
            strUrl = UIApplicationOpenSettingsURLString;
            break;
    }
    NSURL *url = [NSURL URLWithString:strUrl];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }else{
        NSLog(@"can't open url:%@",strUrl);
    }
}

@end
