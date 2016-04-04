//
//  HWDataService.m
//  HWMtime
//
//  Created by mac on 15/11/3.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "HWDataService.h"

@implementation HWDataService

+(id)DataService:(NSString *)fileName
{
    //获取路径
    NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:NULL];
    //转换格式
    NSData *data = [NSData dataWithContentsOfFile:path];
    //取出json数据
    id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    return dic;
}

@end
