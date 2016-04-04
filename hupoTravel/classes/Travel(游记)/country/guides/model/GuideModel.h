//
//  GuideModel.h
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/17.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "JSONModel.h"

@interface GuideModel : JSONModel

@property (nonatomic, copy) NSString *topic;   //景点攻略的标题
@property (nonatomic, copy) NSString *photo_url; //景点攻略的背景图片的url
@property (nonatomic, strong) NSNumber *inspiration_activities_count; //旅行灵感的条数
@property (nonatomic, strong) NSNumber *ID;    //景点攻略的id，用于进入下一个界面

@end
