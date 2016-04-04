//
//  MarkCollectionView.h
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarkViewController;
@interface MarkCollectionView : UICollectionView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *districts;    //标签数组一
@property (nonatomic, strong) NSArray *categories;    //标签数组二
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) MarkViewController *markVC;

@end
