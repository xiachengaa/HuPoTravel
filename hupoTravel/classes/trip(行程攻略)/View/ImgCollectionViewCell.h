//
//  ImgCollectionViewCell.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StrategyCollectionCellModel;
@interface ImgCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *placeImgView;

@property (nonatomic, strong) UILabel *chNameLabel;
@property (nonatomic, strong) UILabel *enNameLabel;
@property (nonatomic, strong) UILabel *tripPlaceNumberLabel;

@property (nonatomic, strong) StrategyCollectionCellModel *cellModel;

@end
