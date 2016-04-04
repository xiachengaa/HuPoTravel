//
//  CountryCell.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/10.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//  

#import "CountryCell.h"

@implementation CountryCell

- (void)setConfig{
    self.desImageView.layer.cornerRadius = 5;
    self.desImageView.layer.masksToBounds = YES;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setConfig];
}

- (void)setDesModel:(DestinationModel *)desModel{
    if (_desModel != desModel) {
        _desModel = desModel;
        [self.desImageView sd_setImageWithURL:[NSURL URLWithString:desModel.photo_url]];
        self.desNameCN.text = desModel.name;
        self.desTouristInspiration.text = [NSString stringWithFormat:@"%@条旅行灵感", desModel.inspiration_activities_count];
    }
}

@end
