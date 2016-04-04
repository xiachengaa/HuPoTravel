//
//  DetailLayout.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/18.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "DetailLayout.h"

@implementation DetailLayout

- (void)setDetailModel:(DetailModel *)detailModel{
    if (_detailModel != detailModel) {
        _detailModel = detailModel;
        [self setLayoutFrame];
    }
}

- (void)setLayoutFrame{
    
    self.imageFrame = CGRectMake(0, 0, kScreenWidth + kRightSpace, kImageHeight);
    
    CGFloat contentHeight = [WXLabel getTextHeight:kTextFont width:kScreenWidth - 2 * kLineSpace text:self.detailModel.introduce linespace:kTextLineSpace];
    CGFloat contentY = CGRectGetMaxY(self.imageFrame);
    self.contentFrame = CGRectMake(kLineSpace + kRightSpace / 2, contentY + kLineSpace, kScreenWidth - 2 * kLineSpace + kRightSpace, contentHeight);
    
    self.cellHeight = CGRectGetMaxY(self.contentFrame) + kBottomHeight;
    
}
@end
