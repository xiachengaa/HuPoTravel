//
//  CountryTableView.h
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/9.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelNotesLayout.h"

@interface CountryTableView : UITableView

@property (nonatomic, copy) NSArray *modelArray;//存储旅游景点model的数组
@property (nonatomic, strong) TravelNotesLayout *layout;//存储旅游景点游记的layout,里面包含contentModel
@property (nonatomic, copy) NSArray *scenceImageArray;//存储旅游景点游记图片的数组
@property (nonatomic, copy) NSString *cityName;

@end
