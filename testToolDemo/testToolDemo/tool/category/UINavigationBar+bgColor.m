//
//  UINavigationBar+bgColor.m
//  vdplayer
//
//  Created by 段贤才 on 2017/5/2.
//  Copyright © 2017年 volientDuan. All rights reserved.
//

#import "UINavigationBar+bgColor.h"
#import <objc/runtime.h>

static char bgColor;
@implementation UINavigationBar (bgColor)
- (void)setBgColor:(UIColor *)bgColor{
    [self willChangeValueForKey:@"bgColor"];
    objc_setAssociatedObject(self, &bgColor, bgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"bgColor"];
    // 核心方法 - 通过KVC对backgroundView赋值
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.bounds.size.width, 64)];
    view.backgroundColor = bgColor;
    [self setValue:view forKey:@"backgroundView"];
}

- (UIColor *)bgColor{
    return objc_getAssociatedObject(self, &bgColor);
}



@end
