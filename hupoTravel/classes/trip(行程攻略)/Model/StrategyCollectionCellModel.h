//
//  StrategyCollectionCellModel.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface StrategyCollectionCellModel : JSONModel

/*
 {
 "contry_id" : 1,
 "class_id" : 11,
 "id" : 1005,
 "image" : "http://m.chanyouji.cn/destinations/418-landscape.jpg-600x360",
 "ch_name" : "斯里兰卡",
 "en_name" : "SRI LANKA",
 "palce_number" : 173
 }
 */

@property (nonatomic, copy) NSString *contryID;//国内还是国外
@property (nonatomic, strong) NSNumber *areaID;//国外：哪个洲；国内：大陆还是港澳台
@property (nonatomic, strong) NSNumber *placeID;//国外：国家；国内：城市
@property (nonatomic, copy) NSString *imgPath;
@property (nonatomic, copy) NSString *chName;
@property (nonatomic, copy) NSString *enName;
@property (nonatomic, strong) NSNumber *placeNumber;

@end
