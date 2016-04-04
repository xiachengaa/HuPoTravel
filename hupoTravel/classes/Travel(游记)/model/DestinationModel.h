//
//  DestinationModel.h
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/6.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "JSONModel.h"

@interface DestinationModel : JSONModel

@property (nonatomic, copy) NSString *name; //旅游地中文名
@property (nonatomic, copy) NSString *name_en; //旅游地英文名
@property (nonatomic, copy) NSString *photo_url; //旅游地图片
@property (nonatomic, copy) NSNumber *ID; //旅游地的id
//下面为可以有的数据
@property (nonatomic, copy) NSString *inspiration_activities_count;

@end
