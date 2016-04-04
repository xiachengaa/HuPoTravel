//
//  HomeViewController.h
//  琥珀旅行
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseViewController.h"
@class HomeTableView;
@interface HomeViewController : BaseViewController<UIScrollViewDelegate>

@property (nonatomic, strong)HomeTableView *homeTableView;

@end
