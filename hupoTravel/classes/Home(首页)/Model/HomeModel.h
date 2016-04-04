//
//  HomeModel.h
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface HomeModel : JSONModel

@property (nonatomic, strong)NSDictionary<Optional> *recommender;  //推荐人
@property (nonatomic, copy)NSString *topic;  //标题
@property (nonatomic, assign)int likes_count;  //喜欢数
@property (nonatomic, assign)int comments_count;  //评论数
@property (nonatomic, assign)int favorites_count;  //收藏数
@property (nonatomic, strong)NSArray *contents;  //图片
@property (nonatomic, strong)NSDictionary *user;  //用户
@property (nonatomic, copy)NSString *desc;  //文章主体
@property (nonatomic, strong)NSArray *districts;   //下部标签一
@property (nonatomic, strong)NSArray *categories;  //下部标签二

@end
