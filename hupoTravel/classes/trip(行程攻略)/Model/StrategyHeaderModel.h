//
//  StrategyHeaderModel.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface StrategyHeaderModel : JSONModel

/*
 {
 "contry_id" : 2,
 "id" : 23,
 "class" : "更多旅行口袋书锐意制作中"
 }
 */

@property (nonatomic, copy) NSString *contryId;
@property (nonatomic, copy) NSString *areaId;
@property (nonatomic, copy) NSString *headerTitle;

@end
