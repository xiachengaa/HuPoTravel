//
//  MarkViewController.h
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarkTableView;
@interface MarkViewController : UIViewController

@property (nonatomic, strong)MarkTableView *markTableView;
@property (nonatomic, copy)NSString *idNumber;

@end
