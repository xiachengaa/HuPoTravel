//
//  MeUserModel.h
//  琥珀旅行
//
//  Created by mac on 16/2/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface MeUserModel : JSONModel
//friends_count	int	关注数
//followers_count	int	粉丝数
//gender	string	性别，m：男、f：女、n：未知
//screen_name	string	用户昵称
//avatar_large	string	用户头像地址（大图），180×180像素
/**
 * 用户昵称
 */
@property (nonatomic, copy) NSString *screen_name;
/**
 * 用户头像地址（大图），180×180像素
 */
@property (nonatomic, copy) NSString *avatar_large;
/**
 * 性别，m：男、f：女、n：未知
 */
@property (nonatomic, copy) NSString *gender;
/**
 * 粉丝数
 */
@property (nonatomic, copy) NSString *followers_count;
/**
 * 关注数
 */
@property (nonatomic, copy) NSString *friends_count;
@end
