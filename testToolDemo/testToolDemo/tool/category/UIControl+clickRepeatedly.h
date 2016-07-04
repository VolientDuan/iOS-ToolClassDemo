//
//  UIControl+clickRepeatedly.h
//  btnClickRepeatedlyDemo
//
//  Created by 段贤才 on 16/7/1.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (clickRepeatedly)

/**
 *  设置点击的间隔（防止反复点击）
 */
@property (nonatomic, assign)NSTimeInterval clickInterval;

@property (nonatomic, assign)BOOL ignoreClick;

@end
