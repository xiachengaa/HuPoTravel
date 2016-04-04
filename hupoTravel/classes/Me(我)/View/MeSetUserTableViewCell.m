//
//  MeSetUserTableViewCell.m
//  琥珀旅行
//
//  Created by mac on 16/2/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MeSetUserTableViewCell.h"

@implementation MeSetUserTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.iconView.layer.cornerRadius = self.iconView.width * 0.5;
    self.iconView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
