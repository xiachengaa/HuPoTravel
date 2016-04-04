//
//  PlayGuideModel.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface PlayGuideModel : JSONModel

@property (nonatomic, strong) NSNumber *classID;
@property (nonatomic, copy) NSString *title;

@end
