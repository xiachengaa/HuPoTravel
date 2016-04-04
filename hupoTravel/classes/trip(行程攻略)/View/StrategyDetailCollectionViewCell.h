//
//  StrategyDetailCollectionViewCell.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StrategyDetailCollectionCellModel;
@interface StrategyDetailCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cityImgView;
@property (weak, nonatomic) IBOutlet UILabel *chnNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *enNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *strategyImgView;
@property (weak, nonatomic) IBOutlet UIImageView *journeyImgView;
@property (weak, nonatomic) IBOutlet UIImageView *themeImgView;

- (IBAction)journeyButtonAction:(id)sender;
- (IBAction)playDiretionButtonAction:(id)sender;
- (IBAction)themeButtonAction:(id)sender;

@property (nonatomic, strong) StrategyDetailCollectionCellModel *model;

@end
