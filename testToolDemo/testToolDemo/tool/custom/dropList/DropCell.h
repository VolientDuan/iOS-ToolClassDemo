//
//  DropCell.h
//  testToolDemo
//
//  Created by volientDuan on 2017/10/26.
//  Copyright © 2017年 volientDuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropCell : UICollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath title:(NSString *)title isSelected:(BOOL)isSelected;
- (instancetype)initWithFrame:(CGRect)frame;
@end
