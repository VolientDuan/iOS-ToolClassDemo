//
//  DropLayout.m
//  testToolDemo
//
//  Created by volientDuan on 2017/10/29.
//  Copyright © 2017年 volientDuan. All rights reserved.
//

#import "DropLayout.h"
/* item的布局基本设置 */
//左右边距
#define PITCH_X 20.0
//上下边距
#define PITCH_Y 20.0
//cell的高度
#define CELL_H 34.0
//一行cell的个数
#define CELL_N 3
@interface DropLayout()
//左右边距
@property (nonatomic, assign)CGFloat pitch_x;
//上下边距
@property (nonatomic, assign)CGFloat pitch_y;
//cell的高度
@property (nonatomic, assign)CGFloat cell_h;
//一行cell的个数
@property (nonatomic, assign)NSInteger cell_n;


@end

@implementation DropLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        [self defaultSet];
    }
    return self;
}
- (void)defaultSet{
    self.pitch_x = 20.0;
    self.pitch_y = 20.0;
    self.cell_h = 33;
    self.cell_n = 3;
}
- (void)changeLayout{
    self.cell_n = self.cell_n == 3 ? 1 : 3;
    [self prepareLayout];
    [self.collectionView reloadData];
}
- (void)prepareLayout{
    [super prepareLayout];
}
- (CGSize)collectionViewContentSize{
    NSInteger num = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(SCREEN_WIDTH, (self.pitch_y+self.cell_h)*((num-1)/self.cell_n+1)+self.pitch_y);
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSInteger num = [self.collectionView numberOfItemsInSection:0];
    NSMutableArray *atrributesArray = [NSMutableArray array];
    CGFloat w = (SCREEN_WIDTH - (PITCH_X*(self.cell_n+1)))/self.cell_n;
    for (int i = 0; i < num; i ++) {
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        attributes.frame = CGRectMake(self.pitch_x + (self.pitch_x+w)*(i%self.cell_n), self.pitch_y + (self.pitch_y + self.cell_h)*(i/self.cell_n), w, self.cell_h);
        [atrributesArray addObject:attributes];
    }
    
    return atrributesArray;
}
@end
