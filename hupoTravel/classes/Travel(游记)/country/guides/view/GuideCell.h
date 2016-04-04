//
//  GuideCell.h
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/17.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuideModel.h"

@interface GuideCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (nonatomic, strong) GuideModel *guideModel;

@end
