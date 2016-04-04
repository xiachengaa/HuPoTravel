//
//  StrategyDetailCollectionCellModel.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface StrategyDetailCollectionCellModel : JSONModel

/*
 {
 "place_id" : 2019,
 "ch_name" : "哈尔滨概览",
 "en_name" : "HARBIN",
 "image" : "http://m.chanyouji.cn/destinations/156-landscape.jpg-600x360"
 }
 */

@property (nonatomic, strong) NSNumber *placeID;
@property (nonatomic, copy) NSString *chName;
@property (nonatomic, copy) NSString *enName;
@property (nonatomic, copy) NSString *imgPath;

@end
