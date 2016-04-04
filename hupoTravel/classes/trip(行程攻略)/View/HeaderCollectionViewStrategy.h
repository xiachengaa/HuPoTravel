//
//  HeaderCollectionViewStrategy.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StrategyHeaderModel;
@interface HeaderCollectionViewStrategy : UICollectionReusableView

@property (nonatomic, assign) CGFloat endXLeft;
@property (nonatomic, assign) CGFloat endXRight;
@property (nonatomic, strong) StrategyHeaderModel *headerModel;

@end
