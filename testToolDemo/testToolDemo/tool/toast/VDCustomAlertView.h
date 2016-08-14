//
//  VDCustomAlertView.h
//  xiangsheng_ios
//
//  Created by 段贤才 on 16/8/12.
//  Copyright © 2016年 zeptolee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AlertCallBack)();

@interface VDCustomAlertView : UIView

+ (void)showMsg:(NSString *)msg callBack:(AlertCallBack)callBack cancel:(AlertCallBack)cancelCallBack;

@end
