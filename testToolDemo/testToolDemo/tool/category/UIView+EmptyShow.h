//
//  UIView+EmptyShow.h
//  emptyViewDemo
//
//  Created by 段贤才 on 16/6/29.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReloadDataBlock)();

typedef NS_ENUM(NSInteger, ViewDataType)
{
    ViewDataTypeMyOrder = 0,//我的订单
    ViewDataTypeLoadFail//web页加载失败
};

@interface CustomerWarnView : UIView
//提示图
@property (nonatomic, strong) UIImageView     *imageView;
//提示文字
@property (nonatomic, strong) UILabel         *tipLabel;
//刷新按钮
@property (nonatomic, strong) UIButton        *loadBtn;
//用于回调
@property (nonatomic, copy) ReloadDataBlock reloadBlock;
//初始化
+ (CustomerWarnView *)initWithFrame:(CGRect)frame andType:(ViewDataType)type;


@end

@interface UIView (EmptyShow)

@property (strong, nonatomic) CustomerWarnView *warningView;
/**
 *  空页面显示提醒图与文字并添加重新刷新
 *
 *  @param emptyType 页面的展示的数据类别（例如：我的订单或者web页）
 *  @param haveData  是否有数据
 *  @param block     重新加载页面（不需要时赋空）
 */
- (void)emptyDataCheckWithType:(ViewDataType)emptyType
                   andHaveData:(BOOL)haveData
                andReloadBlock:(ReloadDataBlock)block;

@end



