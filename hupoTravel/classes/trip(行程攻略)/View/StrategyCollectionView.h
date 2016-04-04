//
//  StrategyCollectionView.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^ContryOutBlock)(NSNumber *);

//国外界面
@interface StrategyCollectionView : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//判断要跳转到国内还是国外界面
//@property (nonatomic, assign) BOOL isContryInside;

//接收数据
@property (nonatomic, copy) NSDictionary *dicData;
//@property (nonatomic, copy) ContryOutBlock contryOutBlock;

@end
