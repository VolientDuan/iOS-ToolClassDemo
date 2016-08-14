//
//  KeyChain.m
//  linju_ios
//
//  Created by LiZheng on 15/6/23.
//  Copyright (c) 2015年 focusoo. All rights reserved.
//

#import "KeyChain.h"
#import "BDKNotifyHUD.h"
#import "NSString+OAURLEncodingAdditions.h"

@implementation KeyChain

+ (instancetype)sharedManage {
    
    static KeyChain *shareManage = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        shareManage = [[KeyChain alloc] init];
    });
    return shareManage;
}

- (id) init {
    self = [super init];
    if(self) {
        _viewControllerDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    return self;
}

+ (BOOL) isNullString:(NSString *)string {
    if(string == nil) {
        return YES;
    }
    
    if((NSNull *)string == [NSNull null]) {
        return YES;
    }
    
    if(string.length == 0) {
        return YES;
    }
    
    if([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

+ (BOOL) validUsedIntValue:(NSString *)value {
    
    if(value == nil || (NSNull *)value == [NSNull null]) {
        return NO;
    }
    return YES;
}

+ (NSString *)stringWithGBK2312:(NSString *)source;
{
    //return [source URLEncodedString];
    
//    if (![KeyChain isContainMandarin:source]) {
//        return source;
//    }
    //NSString* temp =source;// [source URLEncodedString];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSData *data = [source dataUsingEncoding:enc];
//    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
//    NSLog(@"%@",retStr);
    
    char* c_test = "北京";
    
    unsigned long nLen = strlen(c_test);
    
    NSString* retStr = [[NSString alloc]initWithBytes:c_test length:nLen encoding:enc ];
    
    return retStr;
////
//    NSURL *url = [NSURL URLWithString:source];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    return [[NSString alloc] initWithData:data encoding:enc];
}

+ (BOOL) isContainMandarin:(NSString *)str;
{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
        
    }
    return NO;
}
- (void) showMessage:(NSString *) message {
    
    if([KeyChain isNullString:message]) {
        message = @"错误的信息处理";
    }
    
    BDKNotifyHUD *bdkNotifyHud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"notify"] text:message];
    
    [[UIApplication sharedApplication].keyWindow addSubview:bdkNotifyHud];//暂时先全部改成用APPlication的keywindow来展示
    bdkNotifyHud.frame = CGRectMake(SCREEN_WIDTH/2.0 - kBDKNotifyHUDDefaultWidth/2.0, SCREEN_HEIGHT/2.0 - 64 - 44,bdkNotifyHud.frame.size.width, bdkNotifyHud.frame.size.height);
    
    [bdkNotifyHud presentWithDuration:0.8f speed:0.5f inView:[UIApplication sharedApplication].keyWindow completion:^{
        [bdkNotifyHud removeFromSuperview];
    }];
}

- (void) showMessage:(NSString *) message withSuperView:(UIView *)superView {
    
    if([KeyChain isNullString:message]) {
        message = @"错误的信息处理";
    }
    
    BDKNotifyHUD *bdkNotifyHud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"notify"] text:message];
    
    [superView addSubview:bdkNotifyHud];//暂时先全部改成用APPlication的keywindow来展示
    bdkNotifyHud.frame = CGRectMake(SCREEN_WIDTH/2.0 - kBDKNotifyHUDDefaultWidth/2.0, SCREEN_HEIGHT/2.0 - 64 - 44,bdkNotifyHud.frame.size.width, bdkNotifyHud.frame.size.height);
    
    [bdkNotifyHud presentWithDuration:0.8f speed:0.5f inView:superView completion:^{
        [bdkNotifyHud removeFromSuperview];
    }];
}

- (void)saveUserToken:(NSString *)token {
    if([KeyChain isNullString:token]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getUserToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

@end
