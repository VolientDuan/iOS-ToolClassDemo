//
//  VDSSetPageTool.h
//  testToolDemo
//
//  Created by 段贤才 on 2017/4/21.
//  Copyright © 2017年 volientDuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 设置页分类

 - VDSetPageTypeApp: 本项目
 - VDSetPageTypeBluetooth: 蓝牙
 - VDSetPageTypeLocation: 定位服务
 - VDSetPageTypeVPN: VPN
 - VDSetPageTypeWIFI: WIFI
 - VDSetPageTypeKeyboard: 键盘
 - VDSetPageTypeGeneral: 通用
 */
typedef NS_ENUM(NSInteger, VDSetPageType){
    VDSetPageTypeApp = 0,
    VDSetPageTypeBluetooth,
    VDSetPageTypeLocation,
    VDSetPageTypeVPN,
    VDSetPageTypeWIFI,
    VDSetPageTypeKeyboard,
    VDSetPageTypeGeneral
};

@interface VDSSetPageTool : NSObject

+ (void)show:(VDSetPageType)type;

@end
