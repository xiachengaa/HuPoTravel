//
//  MJAccount.m
//  琥珀旅行
//
//  Created by mac on 16/2/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MJAccount.h"
@interface MJAccount()<NSCoding>

@end
@implementation MJAccount
+ (instancetype)accountWithDictionary:(NSDictionary *)dict
{
    MJAccount *account = [[MJAccount alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    // 获得账号存储的时间（accessToken的产生时间）
    account.created_time = [NSDate date];
    return account;
}


/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}


/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}


/**
 *  保存信息
 */
+ (void)saveAccount:(MJAccount *)account
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"];
    //保存的时候拿到创建的时间
    //    NSDate *createDate = [NSDate date];
    
    [NSKeyedArchiver archiveRootObject:account toFile:path];
}
/**
 *  读取信息到本地
 */
+ (MJAccount *)account
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"];
    MJAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    //但是我们要判断账号是否过期
    //所以获得过期的秒数
//    long long expires_in = [account.expires_in longLongValue];
//    NSDate *now = [NSDate date];
//    //过期的时间，几年几月几日
//    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    //    typedef NS_ENUM(NSInteger, NSComparisonResult)
    //    {NSOrderedAscending = -1L,升序，左小于右
    //    NSOrderedSame,
    //    NSOrderedDescending};降序，左大于右
//    //    MJLog(@"%@,%@",expiresTime,now);
//    NSComparisonResult result = [expiresTime compare:now];
//    if (result == NSOrderedAscending) {
//        //说明过期
//        return nil;
//    }else
//    {
//        //说明没过期
        return account;
//    }
    
    
    
//    
//    return account;
}

@end
