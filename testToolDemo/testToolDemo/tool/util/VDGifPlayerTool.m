//
//  VDGifPlayerTool.m
//  xiangsheng_ios
//
//  Created by 段贤才 on 2016/11/19.
//  Copyright © 2016年 zeptolee. All rights reserved.
//

#import "VDGifPlayerTool.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface VDGifPlayerTool()
@property (nonatomic, strong)UIView *gifContentView;

@property (nonatomic, assign)CGImageSourceRef gif;
@property (nonatomic, strong)NSDictionary *gifDic;
@property (nonatomic, assign)size_t index;
@property (nonatomic, assign)size_t count;
@property (nonatomic, strong)NSTimer *timer;

@end
@implementation VDGifPlayerTool


- (void)addGifWithName:(NSString *)gifName toView:(UIView *)view{
    self.gifContentView = view;
    [self createGif:gifName];
}

- (void)createGif:(NSString *)name{
    
    //    _gifContentView.layer.borderColor = UIColorFromRGB(No_Choose_Color).CGColor;
    //    _gifContentView.layer.borderWidth = 1.0;
    NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    _gifDic = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:name ofType:@"gif"]];
    _gif = CGImageSourceCreateWithData((CFDataRef)gif, (CFDictionaryRef)_gifDic);
    _count = CGImageSourceGetCount(_gif);
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(startLoading) userInfo:nil repeats:YES];
    [_timer fire];
}
-(void)startLoading
{
    _index ++;
    _index = _index%_count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(_gif, _index, (CFDictionaryRef)_gifDic);
    self.gifContentView.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}
- (void)stopGif
{
    [_timer invalidate];
    _timer = nil;
}
- (void)dealloc{
    if (_gif) {
        CFRelease(_gif);
    }
}
@end
