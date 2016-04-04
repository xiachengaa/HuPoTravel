//
//  PlaceCell.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/5.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "PlaceCell.h"

@implementation PlaceCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.destinationImageView.layer.cornerRadius = 5;
    self.destinationImageView.layer.masksToBounds = YES;
}

- (void)setModel:(DestinationModel *)model{
    if (_model != model) {
        _model = model;
        [self.destinationImageView sd_setImageWithURL:[NSURL URLWithString:model.photo_url]];
        self.countryNameCN.text = model.name;
        self.countryNameEN.text = model.name_en;
        self.countryNameEN.textColor = [UIColor grayColor];
    }
}

@end
