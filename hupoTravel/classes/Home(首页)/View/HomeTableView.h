//
//  HomeTableView.h
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *headView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, assign) int count;
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, strong) UIPageControl *page;

- (void)requestData;

- (void)distributeData:(id)responseObject;

@end
