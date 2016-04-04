//
//  DetailCell.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/18.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (void)awakeFromNib {
    // Initialization code
    self.detailLabel.linespace = 5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetailLayout:(DetailLayout *)detailLayout{
    if (_detailLayout != detailLayout) {
        _detailLayout = detailLayout;
        [self setAllFrame];
        self.detailLabel.text = self.detailLayout.detailModel.introduce;
        self.detailImageView.urlString = self.detailLayout.detailModel.photo[@"photo_url"];
        [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:self.detailLayout.detailModel.photo[@"photo_url"]]];
    }
}

- (void)setAllFrame{
    self.detailImageView.frame = self.detailLayout.imageFrame;
    self.detailLabel.frame = self.detailLayout.contentFrame;
}

@end
