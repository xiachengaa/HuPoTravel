//
//  TravelNotesCell.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/14.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "TravelNotesCell.h"

@interface TravelNotesCell () <WXLabelDelegate>

@end

@implementation TravelNotesCell

- (void)awakeFromNib {
    // Initialization code
    self.contentLabel.wxLabelDelegate = self;
    self.topicName.wxLabelDelegate = self;
    self.authorName.wxLabelDelegate = self;
    self.contentLabel.linespace = 2.0;
    self.imageCountLabel.layer.cornerRadius = 5;
    self.imageCountLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//给UI控件的内容赋值
- (void)setLayout:(TravelNotesLayout *)layout{
    if (_layout != layout) {
        _layout = layout;
        self.contentLabel.text = self.layout.contentModel.desc;
        self.topicName.text = self.layout.contentModel.topic;
        self.authorName.text = [NSString stringWithFormat:@"by %@", self.layout.contentModel.user.name];
        [self setAllFrame];
    }
}

- (void)setScenceImageArray:(NSArray *)scenceImageArray{
    if (_scenceImageArray != scenceImageArray) {
        _scenceImageArray = scenceImageArray;
        [self.touristImageView sd_setImageWithURL:[NSURL URLWithString:self.scenceImageArray[0]]];
        self.touristImageView.urlString = self.scenceImageArray[0];
        self.imageCountLabel.text = [NSString stringWithFormat:@"%li", self.scenceImageArray.count];
    }
}

//设置所有的UI控件的frame
- (void)setAllFrame{
    self.touristImageView.frame = self.layout.imageFrame;
    self.authorName.frame = self.layout.authorFrame;
    self.topicName.frame = self.layout.topicFrame;
    self.contentLabel.frame = self.layout.contentFrame;
    self.imageCountLabel.frame = self.layout.imageCountFrame;
}

#pragma mark - WXLabelDelegate
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel{
    NSString *regex = @"by \\w+";
    return regex;
}

- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel{
    return [UIColor colorWithRed:109.0 / 255 green:187.0 / 255 blue:242.0 / 255 alpha:1];
}

@end
