//
//  UIView+tool.m
//  categoryTest
//
//  Created by 段贤才 on 16/6/22.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import "UIView+tool.h"

@implementation UIView (tool)

#pragma mark [frame]
// [GET方法]

- (CGFloat)v_x{
    return self.frame.origin.x;
}

- (CGFloat)v_y{
    return self.frame.origin.y;
}

- (CGFloat)v_w{
    return self.frame.size.width;
}

- (CGFloat)v_h{
    return self.frame.size.height;
}

// [SET方法]

- (void)setV_x:(CGFloat)v_x{
    self.frame = CGRectMake(v_x, self.v_y, self.v_w, self.v_h);
}

- (void)setV_y:(CGFloat)v_y{
    self.frame = CGRectMake(self.v_x, v_y, self.v_w, self.v_h);
}

- (void)setV_w:(CGFloat)v_w{
    self.frame = CGRectMake(self.v_x, self.v_y, v_w, self.v_h);
}

- (void)setV_h:(CGFloat)v_h{
    self.frame = CGRectMake(self.v_x, self.v_y, self.v_w, v_h);
}


#pragma mark [layer]

- (CGFloat)v_cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setV_cornerRadius:(CGFloat)v_cornerRadius{
    self.layer.cornerRadius = v_cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
