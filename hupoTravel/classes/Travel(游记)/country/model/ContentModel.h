//
//  ContentModel.h
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/9.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "JSONModel.h"
#import "UserModel.h"

@interface ContentModel : JSONModel


@property (nonatomic, copy) NSString *topic;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) UserModel *user;
@property (nonatomic, copy) NSNumber *ID;



@end
