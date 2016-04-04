//
//  MJAccount.h
//  琥珀旅行
//
//  Created by mac on 16/2/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJAccount : NSObject

//返回值字段	字段类型	字段说明
//access_token	string	用于调用access_token，接口获取授权后的access token。
@property (nonatomic, copy) NSString *access_token;
//expires_in	string	access_token的生命周期，单位是秒数。
@property (nonatomic, assign) NSNumber *expires_in;
//remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
//uid	string	当前授权用户的UID。
@property (nonatomic, copy) NSString *uid;
/**
 access token的创建时间
 */
@property (nonatomic, strong) NSDate *created_time;

/**
 *  用户名称
 */
@property (nonatomic, copy) NSString *name;


+ (instancetype)accountWithDictionary:(NSDictionary *)dict;



/**
 *  保存信息
 */
+ (void)saveAccount:(MJAccount *)account;
/**
 *  读取信息到本地
 */
+ (MJAccount *)account;
@end
