//
//  TravelNotesLayout.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/14.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "TravelNotesLayout.h"
#import "WXLabel.h"

@implementation TravelNotesLayout

- (void)setContentModel:(ContentModel *)contentModel{
    if (_contentModel != contentModel) {
        _contentModel = contentModel;
        [self layoutFrame];
    }
}

//根据传入的contentModel的数据计算每个控件的frame
- (void)layoutFrame{
    
    //----图片的frame
    self.imageFrame = CGRectMake(kSpaceSize, kSpaceSize, kScreenWidth - kSpaceSize * 2, kImageHeight);
    self.imageCountFrame = CGRectMake(self.imageFrame.size.width + kSpaceSize * 0.5 - kImageCountHeight, kSpaceSize * 1.5, kImageCountHeight, kImageCountHeight);
    
    //----作者名的frame
    CGFloat authorHeight = [WXLabel getTextHeight:kAuthorNameFont width:kScreenWidth - 2 * kSpaceSize text:[NSString stringWithFormat:@"by %@", self.contentModel.user.name] linespace:kTextLineSpace];
    CGFloat authorY = CGRectGetMaxY(self.imageFrame);
    self.authorFrame = CGRectMake(kSpaceSize, authorY + kSpaceSize, kScreenWidth - kSpaceSize * 2, authorHeight);
    
    //----标题的frame
    CGFloat topicHeight = [WXLabel getTextHeight:kTopicTextFont width:kScreenWidth - 2 *kSpaceSize text:self.contentModel.topic linespace:kTextLineSpace];
    CGFloat topicY = CGRectGetMaxY(self.authorFrame) + kSpaceSize / 2;
    self.topicFrame = CGRectMake(kSpaceSize, topicY, kScreenWidth - 2 * kSpaceSize, topicHeight);
    
    //----游记正文的frame
    CGFloat textHeight = [WXLabel getTextHeight:kTextFont width:kScreenWidth - 2 * kSpaceSize text:self.contentModel.desc linespace:kTextLineSpace];
    CGFloat textY = CGRectGetMaxY(self.topicFrame) + kSpaceSize / 2;
    self.contentFrame = CGRectMake(kSpaceSize, textY, kScreenWidth - 2 * kSpaceSize, textHeight);
    
    //----单元格的高度
    self.cellHeight = CGRectGetMaxY(self.contentFrame) + kSpaceSize;
    
}

@end
