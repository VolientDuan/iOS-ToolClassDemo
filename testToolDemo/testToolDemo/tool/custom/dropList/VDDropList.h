//
//  VDDropList.h
//  testToolDemo
//
//  Created by volientDuan on 2017/10/26.
//  Copyright © 2017年 volientDuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VDDropList : UIView
- (instancetype)init;
//在初始化list后调用
- (void)changeLayout;

- (void)showList:(NSArray *)list selectIndex:(NSInteger)idx block:(void(^)(NSInteger row))block;
- (void)hide;

@end
