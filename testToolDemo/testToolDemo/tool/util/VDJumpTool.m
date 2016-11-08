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
    
    if ([vc isKindOfClass:[UIViewController class]])
        vc = nextResponder;
    else
        vc = window.rootViewController;
    if ([vc isKindOfClass:[UITabBarController class]]) {
        navi = (UINavigationController *)(((UITabBarController *)vc).selectedViewController);
        visibleVC = navi.visibleViewController;
    }
    else{
        navi = ((UINavigationController *)vc);
        visibleVC = navi.visibleViewController;
    }
    //在这里可以做一些判断...
    UIViewController *jumpVC = nil;
    switch (vcType) {
        default:
            break;
    }
    if (visibleVC.navigationController == navi) {
        [visibleVC.navigationController pushViewController:jumpVC animated:YES];
    }else{
        [visibleVC presentViewController:jumpVC animated:YES completion:nil];
    }
    
    
}
@end
