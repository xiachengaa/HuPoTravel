//
//  PlayGuideIntroduceCellModel.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface PlayGuideIntroduceCellModel : JSONModel

/*
 "id":119,
 "title":"东京概览",
 "description_user_ids":{},
 "ctrip_attraction_ids":null,
 "description":"东京是日本的首都，世界第一大城市，往往作为游客游览日本的第一站。按范围分为东京都内，首都圈，东京周边。\n#东京都内#\n主要包含了东京市中心的23个区，聚集了历史与传统的观光地。以JR山手线为交通中心。\n#首都圈#\n包括了东京都以及周边的神奈川县、千叶县和埼玉县，主要涵盖了东京都边缘的三鹰宫崎骏美术馆，神奈川县的横滨，镰仓•江之岛和箱根，千叶县的迪士尼等游客熟知的热门景点。\n#东京周边#\n主要包含了富士山，伊豆热海，轻井泽，日光等著名景点。\n#游玩建议#\n东京都内的景点一般一天可以安排3-5个，首都圈的景点一般可以当天来回，要是时间充裕，可以考虑住宿温泉地，东京周边的景点可以考虑安排至少一天。一般来说东京都内以购物和一般游览为主，较为精华的景区都在首都圈外围和东京周边。\n市面有东京都内游览的一日票，也有从东京都内到首都圈或东京周边的一日票。",
 "travel_date":null,
 "":null,
 "attractions":[],
 "hotels":[],
 "pages":[],
 "photos":
 [
 {
 "image_url":"http://w.chanyouji.cn/1407495059434p18uqjsdv31hig1n7bo5n18vf1i761.jpg",
 "image_width":1272,"image_height":878,
 "description":"东京都，首都圈，东京周边的范围地图",
 "trip_id":null,
 "note_id":null,
 "user_name":null
 },
 {
 "image_url":"http://p.chanyouji.cn/101499/1393903259114p18i5hmsjpmr11qsnggv1vfpd231g.jpg",
 "image_width":720,
 "image_height":480,
 "description":"东京市区：浅草寺，图片来自@粉团子PINK 的蝉游记《日本的味道@东京、箱根与镰仓》",
 "trip_id":101499,
 "note_id":4127522,
 "user_name":"粉团子PINK"
 },
 {
 "image_url":"http://p.chanyouji.cn/53520/1373703709177p17vbgvks5ham1iso22c1hc51ugc30.jpg",
 "image_width":800,
 "image_height":533,
 "description":"首都圈：镰仓，图片来自@游啊游 的蝉游记《东京二次目》",
 "trip_id":53520,
 "note_id":2076852,
 "user_name":"游啊游"
 },
 {
 "image_url":"http://p.chanyouji.cn/93740/1388042707062p18cmsjuajsrn1e941c7u1rju3l812.jpg",
 "image_width":1600,
 "image_height":1176,
 "description":"东京周边：富士山，图片来自@白宇_小白 的蝉游记《迷失东瀛》",
 "trip_id":93740,
 "note_id":3654277,
 "user_name":"白宇_小白"
 }
 ],
 "items":[]
 */

@property (nonatomic, strong) NSNumber *introduceID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *introduceDescription;
@property (nonatomic, copy) NSArray *arrayPhotoes;

@end
