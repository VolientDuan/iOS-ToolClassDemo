//
//  VDJumpTool.m
//  dingDaka
//
//  Created by 段贤才 on 2016/11/7.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import "VDJumpTool.h"

@implementation VDJumpTool

+ (void)jumpWithVCType:(NSInteger)vcType{
    
    UIViewController *vc = nil;
    UINavigationController *navi = nil;
    UIViewController *visibleVC;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    // 获取 UIWindowLevelNormal 下的窗口
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    //获取vc
    if ([vc isKindOfClass:[UIViewController class]])
        vc = nextResponder;
    else
        vc = window.rootViewController;
    //获取模态跳转的最后一个页面
    vc = [self getPresentedViewController:vc];
    //tabbar-navi的结构
    if ([vc isKindOfClass:[UITabBarController class]]) {
        navi = (UINavigationController *)(((UITabBarController *)vc).selectedViewController);
        visibleVC = navi.visibleViewController;
    }
    //navi-tabbar的结构
    else if([vc isKindOfClass:[UINavigationController class]]){
        navi = ((UINavigationController *)vc);
        visibleVC = navi.visibleViewController;
    }
    else{
        visibleVC = vc;
    }
    //需要跳转的页面的一些处理（比如传参...）
    UIViewController *jumpVC = nil;
    switch (vcType) {
        default:
            break;
    }
    
    //跳转的一些处理 完全可以自定义
    //有导航控制器直接push过去
    if (visibleVC.navigationController == navi&&navi) {
        [visibleVC.navigationController pushViewController:jumpVC animated:YES];
    }
    //当前页就是需要跳转的控制器在这处理
    else if ([visibleVC isKindOfClass:jumpVC.class]){
        
    }
    //当前页无导航控制器可以直接模态过去
    else{
        [visibleVC presentViewController:jumpVC animated:YES completion:nil];
    }
    
    
}

/**
 获取模态跳转的最后一个视图

 @param vc 控制器

 @return 结果控制器
 */
+ (UIViewController *)getPresentedViewController:(UIViewController *)vc{
    UIViewController *this_vc = vc.presentedViewController;
    if (this_vc) {
        return [self getPresentedViewController:this_vc];
    }
    return vc;
}
@end
