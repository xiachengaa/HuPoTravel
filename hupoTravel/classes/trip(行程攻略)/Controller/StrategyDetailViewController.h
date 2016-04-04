//
//  StrategyDetailViewController.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrategyDetailViewController : UIViewController

//接收单元格代表的城市或国家的ID
@property (nonatomic, strong) NSNumber *placeID;

//区分国内外
@property (nonatomic, assign) BOOL isContryOut;

@end
