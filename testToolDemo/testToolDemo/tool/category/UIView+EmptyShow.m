//
//  UIView+EmptyShow.m
//  emptyViewDemo
//
//  Created by 段贤才 on 16/6/29.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import "UIView+EmptyShow.h"

#import <Masonry/Masonry.h>

#import <objc/runtime.h>

static char WarningViewKey;

@implementation UIView (EmptyShow)

//利用runtime给类别添加属性
- (void)setWarningView:(CustomerWarnView *)warningView{
    [self willChangeValueForKey:@"WarningViewKey"];
    objc_setAssociatedObject(self, &WarningViewKey, warningView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"WarningViewKey"];
}

- (CustomerWarnView *)warningView{
    return objc_getAssociatedObject(self, &WarningViewKey);
}

- (void)emptyDataCheckWithType:(ViewDataType)dataType andHaveData:(BOOL)haveData andReloadBlock:(ReloadDataBlock)block{
    if (self.warningView) {
        [self.warningView removeFromSuperview];
    }
    if (!haveData) {
        self.warningView = [CustomerWarnView initWithFrame:self.bounds andType:dataType];
        if (!block) {
            self.warningView.loadBtn.hidden = YES;
        }
        self.warningView.reloadBlock = block;
        [self addSubview:self.warningView];
    }
}

@end



@implementation CustomerWarnView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]init];
        [self addSubview:_imageView];
        
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.textColor = [UIColor grayColor];
        _tipLabel.font = [UIFont systemFontOfSize:15.0];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
        
        _loadBtn = [[UIButton alloc]init];
        [_loadBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _loadBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _loadBtn.layer.borderWidth = 1;
        _loadBtn.layer.cornerRadius = 2.0;
        _loadBtn.layer.masksToBounds = YES;
        [_loadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [_loadBtn addTarget:self action:@selector(loadClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loadBtn];
        
        [self prepareSubView];
    }
    return self;
}

- (void)loadClick{
    
    if (_reloadBlock) {
        _reloadBlock();
    }
    //淡出，不喜可去
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

//布局
- (void)prepareSubView{
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.and.height.equalTo(self.mas_width).multipliedBy(0.5);
        make.top.equalTo(self.mas_top).offset(100);
    }];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(_imageView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width, 20));
    }];
    
    [_loadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(_tipLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
}

+ (CustomerWarnView *)initWithFrame:(CGRect)frame andType:(ViewDataType)type{
    CustomerWarnView *warningView = [[CustomerWarnView alloc]initWithFrame:frame];
    NSString *imageName,*tip;
    switch (type) {
        case ViewDataTypeMyOrder:
            imageName = @"noOrder";
            tip = @"订单空空如也，我好可怜";
            break;
        case ViewDataTypeLoadFail:
            imageName = @"NetFail";
            tip = @"挂了挂了怎么就挂了";
            break;
        default:
            break;
    }
    [warningView.imageView setImage:[UIImage imageNamed:imageName]];
    warningView.tipLabel.text = tip;
    
    return warningView;
}

@end

