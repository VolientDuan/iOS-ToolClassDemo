//
//  DropCell.m
//  testToolDemo
//
//  Created by volientDuan on 2017/10/26.
//  Copyright © 2017年 volientDuan. All rights reserved.
//

#import "DropCell.h"
@interface DropCell()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *selectedIcon;

@end
@implementation DropCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath title:(NSString *)title isSelected:(BOOL)isSelected{
    static NSString *identifier = @"DropCell";
    DropCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.titleLabel.text = title;
    [cell checkSelected:isSelected];
    return cell;
}
- (void)checkSelected:(BOOL)isSelected{
    if (isSelected) {
        self.backgroundColor = [UIColor yellowColor];
        self.selectedIcon.hidden = NO;
    }else{
        self.backgroundColor = [UIColor whiteColor];
        self.selectedIcon.hidden = YES;
    }
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 2.0;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor greenColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:self.titleLabel];
    
    self.selectedIcon = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-10, self.frame.size.height-10, 10, 10)];
    self.selectedIcon.backgroundColor = [UIColor greenColor];
    [self addSubview:self.selectedIcon];
    
    
}
@end
