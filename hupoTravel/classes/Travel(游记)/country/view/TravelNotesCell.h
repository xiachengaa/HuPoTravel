//
//  TravelNotesCell.h
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/14.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelNotesLayout.h"
#import "WXLabel.h"
#import "ZoomImageView.h"

@interface TravelNotesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ZoomImageView *touristImageView;
@property (weak, nonatomic) IBOutlet WXLabel *authorName;
@property (weak, nonatomic) IBOutlet WXLabel *topicName;
@property (weak, nonatomic) IBOutlet WXLabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *imageCountLabel;

@property (nonatomic ,strong) TravelNotesLayout *layout;
@property (nonatomic, copy) NSArray *scenceImageArray;//存储旅游景点游记图片的数组

@end
