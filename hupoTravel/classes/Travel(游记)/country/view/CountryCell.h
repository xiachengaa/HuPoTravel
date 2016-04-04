//
//  CountryCell.h
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/10.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestinationModel.h"

@interface CountryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *desImageView;
@property (weak, nonatomic) IBOutlet UILabel *desNameCN;
@property (weak, nonatomic) IBOutlet UILabel *desTouristInspiration;

@property (nonatomic, strong) DestinationModel *desModel;

@end
