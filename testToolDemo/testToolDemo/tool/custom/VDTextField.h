//
//  VDTextField.h
//  dingDaka
//
//  Created by 段贤才 on 2016/10/24.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, VDTextInputMode){
    VDTextInputModeZh_Hans = 0,
    VDTextInputModeEn_US,
    VDTextFieldModeOther
};

/**
 使用须知：此文本框禁止复制，粘贴和选择功能
 */
@interface VDTextField : UITextField

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

/**
 输入类型
 */
@property (nonatomic, assign,readonly)VDTextInputMode inputMode;

/**
 占位符的颜色
 */
@property (nonatomic, strong)UIColor *placeholderColor;

/**
 占位符的字体
 */
@property (nonatomic, strong)UIFont *placeholderFont;

/**
 真实长度（不计算高亮部分）
 */
@property (nonatomic, assign)NSInteger trueLength;
/**
 设置最大长度
 @warning 此值必须大于零
 */
@property (nonatomic, assign)NSInteger maxLength;

@end
