//
//  TripAttractionControl.m
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TripAttractionControl.h"

@implementation TripAttractionControl

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)name
{
    if (self = [super initWithFrame:frame]) {
        
       //imgView配置
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
       //图片配置
        _imgView.image = [UIImage imageNamed:@"AttractionButton_Pressed@3x.png"];
//        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        //视图加载
        [self addSubview:_imgView];
        
    }
    
    return self;
}

- (void)configButtonTitle:(NSString *)titleName
{
    //标题配置
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _titleLabel.text = titleName;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:11];
//    titleLabel.center = self.center;
    
    [self addSubview:_titleLabel];
}

@end
