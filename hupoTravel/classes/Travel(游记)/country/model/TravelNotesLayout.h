//
//  TravelNotesLayout.h
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/14.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentModel.h"

#define kImageCountHeight 24 //显示图片张数的label
#define kImageHeight 220 //图片高度
#define kSpaceSize 15  //间距
#define kTextFont 13   //正文字体大小
#define kTopicTextFont 15  //标题字体大小
#define kAuthorNameFont 12 //作者名字字体大小
#define kBottomHeight 20   //底部的高度
#define kTextLineSpace 4  //正文行间距

@interface TravelNotesLayout : NSObject

@property (nonatomic, strong) ContentModel *contentModel;

@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, assign) CGRect imageCountFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect authorFrame;
@property (nonatomic, assign) CGRect topicFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end
