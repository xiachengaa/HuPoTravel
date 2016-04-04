//
//  HomeLayoutModel.m
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeLayoutModel.h"

@implementation HomeLayoutModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isAll = NO;
        _followStr = @"关注他";
    }
    return self;
}

-(void)setHomeModel:(HomeModel *)homeModel
{
    if (_homeModel != homeModel) {
        _homeModel = homeModel;
        
//        NSURL *firstIVURL = [NSURL URLWithString:[_homeModel.contents[0] objectForKey:@"photo_url"]];
//        NSData *data = [NSData dataWithContentsOfURL:firstIVURL];
//        UIImage *bigImage = [UIImage imageWithData:data];
//        
//        _bigImageHeight = bigImage.size.height / bigImage.size.width * kScreenWidth;
//        NSLog(@"%f",_bigImageHeight);
        
        NSString *str = _homeModel.desc;
        NSDictionary *dic = @{
                              NSFontAttributeName  : [UIFont systemFontOfSize:13] ,
                              NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle]
                              };
        
        CGRect rect = [str boundingRectWithSize:CGSizeMake(kScreenWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:NULL];
        _textFrame = rect;
        
        
    }
}

@end
