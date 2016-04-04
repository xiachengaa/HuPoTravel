//
//  PlayGuideViewController.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayGuideViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *playGuidetableView;

@end
