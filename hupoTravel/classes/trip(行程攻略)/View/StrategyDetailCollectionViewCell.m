//
//  StrategyDetailCollectionViewCell.m
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "StrategyDetailCollectionViewCell.h"
#import "StrategyDetailCollectionCellModel.h"
#import "PlayGuideViewController.h"
#import "UIView+ViewController.h"

@implementation StrategyDetailCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
//    [self _loadData];
}

- (void)setModel:(StrategyDetailCollectionCellModel *)model
{
    if (_model != model) {
        
        _model = model;
        
        [self _loadData];
    }
}

- (void)_loadData
{
    self.chnNameLabel.text = self.model.chName;
    self.enNameLabel.text = self.model.enName;
    
    self.journeyImgView.image = [UIImage imageNamed:@"CategoryIcon13@3x"];
    self.strategyImgView.image = [UIImage imageNamed:@"DestinationMenuIcon2@3x"];
    self.themeImgView.image = [UIImage imageNamed:@"DestinationMenuIcon1@3x"];
    [self.cityImgView sd_setImageWithURL:[NSURL URLWithString:self.model.imgPath]];
}

- (IBAction)journeyButtonAction:(id)sender {
    
}

- (IBAction)playDiretionButtonAction:(id)sender {
    
    //以下页面没做
//    PlayGuideViewController *pgVC = [[PlayGuideViewController alloc] init];
//    
//    [self.viewController.navigationController pushViewController:pgVC animated:YES];
}

- (IBAction)themeButtonAction:(id)sender {
}
@end
