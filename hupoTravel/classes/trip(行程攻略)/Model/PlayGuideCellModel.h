//
//  PlayGuideCellModel.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface PlayGuideCellModel : JSONModel

/*
 "id":1283,
 "title":"东京都内以购物为主",
 "description_user_ids":{},
 "ctrip_attraction_ids":null,
 "description":"东京旅游最大的特点就是逛，几个所谓的景点（新宿，涩谷，池袋，银座啥的）其实都是购物商圈，聚集了一堆大商场，这个商圈卖的，另一处也能买到。如果说特色，也就秋叶原和台场，连涩谷特色都不明显。\n东京都内的建筑景点在日本不算太有特色，有特色的都在东京周边1小时车程外的地方。美食方面，东京没自己的特色（非要说特色，筑地市场的海鲜算个特色），但汇聚了日本各地的特色美食。",
 "travel_date":"2014-03 出行",
 "user":{"id":209300,"name":"Web"},
 "attractions":[],
 "hotels":[],
 "pages":[],
 "photos":[],
 "items":[]
 */

@property (nonatomic, strong) NSNumber *journeyID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *speakDescription;
@property (nonatomic, copy) NSString *travelDate;
@property (nonatomic, copy) NSDictionary *user;


@end
