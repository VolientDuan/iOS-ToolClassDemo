//
//  VDCustomAlertView.m
//  xiangsheng_ios
//
//  Created by 段贤才 on 16/8/12.
//  Copyright © 2016年 zeptolee. All rights reserved.
//

#import "VDCustomAlertView.h"
/* 专业UI计算过的尺寸 😄 */
#define ALERT_MSG_WIDTH GetFloatContrastHightWithPX(200.0)
#define ALERT_MSG_HIGHT GetFloatContrastHightWithPX(111.0)

@interface VDCustomAlertView()
@property (nonatomic, strong)UILabel *msgLabel;
@property (nonatomic, strong)UIControl *bgView;

@property (nonatomic, copy)AlertCallBack callBack;
@property (nonatomic, copy)AlertCallBack cancelCallBack;

@end
@implementation VDCustomAlertView

+ (void)showMsg:(NSString *)msg callBack:(AlertCallBack)callBack cancel:(AlertCallBack)cancelCallBack{
    VDCustomAlertView *alert = [[VDCustomAlertView alloc]initWithMsg:msg];
    alert.callBack = callBack;
    alert.cancelCallBack = cancelCallBack;
    [alert show];
    
    
}

- (instancetype)initWithMsg:(NSString *)msg{
    self = [super initWithFrame:CGRectMake(0, GetFloatContrastHightWithPX(160.0), ALERT_MSG_WIDTH, ALERT_MSG_HIGHT)];
    self.v_centerX = SCREEN_WIDTH/2;
    if (self) {
        self.backgroundColor = UIColorFromRGB(WHITE_COLOR);
        [self prepareMsgView:msg];
        self.v_cornerRadius = GetFloatContrastHightWithPX(4.0);
    }
    return self;
}

- (void)show{
    self.bgView = [[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.backgroundColor = UIColorFromRGBWithAlpha(MAIN_BLACK_COLOR, 0.3);
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.bgView];
    [keyWindow addSubview:self];
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.1;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)prepareMsgView:(NSString *)msg{
    //从下到上
    //按钮
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeSystem];
    okButton.frame = CGRectMake(0, GetFloatContrastHightWithPX(75), self.v_w/2, ALERT_MSG_HIGHT-GetFloatContrastHightWithPX(75.0));
    okButton.titleLabel.font = [UIFont systemFontOfSize:GetFloatContrastHightWithPX(12.0)];
    [okButton setTitleColor:UIColorFromRGB(THEME_COLOR) forState:UIControlStateNormal];
    [okButton setTitle:@"确认" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:okButton];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(self.v_w/2, GetFloatContrastHightWithPX(75), self.v_w/2, ALERT_MSG_HIGHT-GetFloatContrastHightWithPX(75.0));
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:GetFloatContrastHightWithPX(12.0)];
    [cancelButton setTitleColor:UIColorFromRGB(MAIN_BLACK_COLOR) forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    
    //划线
    UIView *shuXian = [[UIView alloc]initWithFrame:CGRectMake(0, GetFloatContrastHightWithPX(75), 1.0, ALERT_MSG_HIGHT-GetFloatContrastHightWithPX(75.0))];
    shuXian.v_centerX = self.v_w/2;
    shuXian.backgroundColor = UIColorFromRGB(TABLEVIEW_LINE_COLOR);
    [self addSubview:shuXian];
    UIView *hongXian = [[UIView alloc]initWithFrame:CGRectMake(0, GetFloatContrastHightWithPX(75), self.v_w, 1.0)
                        ];
    hongXian.backgroundColor = UIColorFromRGB(TABLEVIEW_LINE_COLOR);
    [self addSubview:hongXian];
    
    //标签
    _msgLabel = [[UILabel alloc]init];
    _msgLabel.font = [UIFont systemFontOfSize:GetFloatContrastHightWithPX(12.0)];
    CGRect rect = [msg boundingRectWithSize:CGSizeMake(ALERT_MSG_WIDTH-GetFloatContrastHightWithPX(40.0), GetFloatContrastHightWithPX(50)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_msgLabel.font} context:nil];
    _msgLabel.frame = CGRectMake(GetFloatContrastHightWithPX(20.0), GetFloatContrastHightWithPX(32.0)+GetFloatContrastHightWithPX(6.0)-rect.size.height/2, ALERT_MSG_WIDTH-GetFloatContrastHightWithPX(40.0), rect.size.height);
    _msgLabel.numberOfLines = 0;
    _msgLabel.textColor = UIColorFromRGB(MAIN_BLACK_COLOR);
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    self.msgLabel.text = msg;
    if (rect.size.height > GetFloatContrastHightWithPX(12.0)*3) {
        _msgLabel.adjustsFontSizeToFitWidth = YES;
    }
    [self addSubview:_msgLabel];
    
}

- (void)okClick{
    if (self.callBack) {
        self.callBack();
    }
    [self closeAlert];
    
}

- (void)cancelClick{
    if (self.cancelCallBack) {
        self.cancelCallBack();
    }
    [self closeAlert];
}

- (void)closeAlert{
    //可以考虑加个动画
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.bgView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
