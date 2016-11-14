//
//  UIView+tool.h
//  categoryTest
//
//  Created by 段贤才 on 16/6/22.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (tool)

#pragma mark [frame]

/**
*  view的x(横)坐标
*/
@property (nonatomic, assign)CGFloat v_x;
/**
 *  view的y(纵)坐标
 */
@property (nonatomic, assign)CGFloat v_y;
/**
 *  view的宽度
 */
@property (nonatomic, assign)CGFloat v_w;
/**
 *  view的高度
 */
@property (nonatomic, assign)CGFloat v_h;
/**
 *  view的中心横坐标
 */
@property (nonatomic, assign)CGFloat v_centerX;
/**
 *  view的中心纵坐标
 */
@property (nonatomic, assign)CGFloat v_centerY;

#pragma mark [layer]

/**
 *  view的圆角半径
 */
@property (nonatomic, assign)CGFloat v_cornerRadius;


@end
