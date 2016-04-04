//
//  DetailCell.h
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/18.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailLayout.h"
#import "ZoomImageView.h"


@interface DetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ZoomImageView *detailImageView;
@property (weak, nonatomic) IBOutlet WXLabel *detailLabel;

@property (nonatomic, strong) DetailLayout *detailLayout;
@end
