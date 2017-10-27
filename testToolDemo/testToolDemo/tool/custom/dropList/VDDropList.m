//
//  VDDropList.m
//  testToolDemo
//
//  Created by volientDuan on 2017/10/26.
//  Copyright © 2017年 volientDuan. All rights reserved.
//

#import "VDDropList.h"
#import "DropCell.h"
//容器的高度
#define DROP_H 200.0
//collectView的高度
#define LIST_H 200.0

/* item的布局基本设置 */
//左右边距
#define PITCH_X 20.0
//上下边距
#define PITCH_Y 20.0
//cell的高度
#define CELL_H 34.0
//一行cell的个数
#define CELL_N 3

@interface VDDropList()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UIControl *bgView;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, copy)void (^block)(NSInteger row);
@end

@implementation VDDropList
- (UIControl *)bgView{
    if (!_bgView) {
        _bgView = [[UIControl alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _bgView.hidden = YES;
        [_bgView addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:self];
        [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    }
    return _bgView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat w = (self.frame.size.width - PITCH_X*(CELL_N + 1))/CELL_N;
        _flowLayout.itemSize = CGSizeMake(w, CELL_H);
        _flowLayout.minimumLineSpacing = PITCH_Y;
        _flowLayout.minimumInteritemSpacing = PITCH_X;
        _flowLayout.sectionInset = UIEdgeInsetsMake(PITCH_Y, PITCH_X, PITCH_Y, PITCH_X);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, LIST_H) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[DropCell class] forCellWithReuseIdentifier:@"DropCell"];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, DROP_H)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)showList:(NSArray *)list selectIndex:(NSInteger)idx block:(void (^)(NSInteger))block{
    self.block = block;
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:list];
    self.index = idx;
    [self.collectionView reloadData];
    self.bgView.hidden = NO;
}
- (void)hide{
    self.bgView.hidden = YES;
}
#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [DropCell cellWithCollectionView:collectionView indexPath:indexPath title:self.dataArray[indexPath.row] isSelected:(indexPath.row == self.index)];
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.index = indexPath.row;
    [self.collectionView reloadData];
    if (self.block) {
        self.block(indexPath.row);
    }
    [self hide];
}

@end
