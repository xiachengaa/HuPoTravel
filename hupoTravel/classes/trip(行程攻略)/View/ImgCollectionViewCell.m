//
//  ImgCollectionViewCell.m
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ImgCollectionViewCell.h"
#import "StrategyCollectionCellModel.h"

#define kXNameLabel 5
#define kYNameLabel 5
#define kWidthNameLabel 125
#define kHeightNameLabel 23

#define kButtomSpacePlaceLabel 8
#define kWidthPlaceLabel 131
#define kHeightPlaceLabel 20

#define kCornerRadiusNumberPlaceLabel 8

@implementation ImgCollectionViewCell

- (void)awakeFromNib {
    
//    [self setNeedsLayout];
    
    [self _createSubViews];
}

- (void)layoutSubviews
{
    self.layer.cornerRadius = kNumberCornerRadius;
    
    CGFloat x = (self.frame.size.width - kWidthPlaceLabel)/2.0;
    CGFloat y = self.frame.size.height - kButtomSpacePlaceLabel - kHeightPlaceLabel;
    
    //改变tripPlaceNumberLabel的frame的值，会触发layoutSubviews方法的调用，对该label重新布局
    self.tripPlaceNumberLabel.frame = CGRectMake(x, y, kWidthPlaceLabel, kHeightPlaceLabel);
    
//    [self _createSubViews];
}

//- (void)setPlaceImgView:(UIImageView *)placeImgView
//{
//    if (_placeImgView != placeImgView) {
//        
//        _placeImgView = placeImgView;
//        
//        [self _createSubViews];
//    }
//}

- (void)_createSubViews
{
    //中文标题
    self.chNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kXNameLabel, kYNameLabel, kWidthNameLabel, kHeightNameLabel)];
    self.chNameLabel.backgroundColor = [UIColor clearColor];
    self.chNameLabel.font = [UIFont systemFontOfSize:13];
    self.chNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.chNameLabel];
    
    //英文标题
    self.enNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kXNameLabel, CGRectGetMaxY(self.chNameLabel.frame)-5, kWidthNameLabel, kHeightNameLabel)];
    self.enNameLabel.backgroundColor = [UIColor clearColor];
    self.enNameLabel.font = [UIFont systemFontOfSize:11];
    self.enNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.enNameLabel];
    
    //旅行地及数量
    
    self.tripPlaceNumberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
//    self.tripPlaceNumberLabel.text = [NSString stringWithFormat:@"旅行地 35"];
    self.tripPlaceNumberLabel.textColor = [UIColor whiteColor];
    self.tripPlaceNumberLabel.font = [UIFont systemFontOfSize:11];
    self.tripPlaceNumberLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //制造透明效果
    self.tripPlaceNumberLabel.layer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3].CGColor;
    self.tripPlaceNumberLabel.layer.cornerRadius = kCornerRadiusNumberPlaceLabel;
    [self insertSubview:self.tripPlaceNumberLabel belowSubview:self.placeImgView];
    //    [self.placeImgView addSubview:self.tripPlaceNumberLabel];
}

- (void)setCellModel:(StrategyCollectionCellModel *)cellModel
{
    if (_cellModel != cellModel) {
        
        _cellModel = cellModel;
        
        self.chNameLabel.text = _cellModel.chName;
        self.enNameLabel.text = _cellModel.enName;
        
        NSInteger number = [_cellModel.placeNumber integerValue];
        self.tripPlaceNumberLabel.text = [NSString stringWithFormat:@"旅行地 %ld", number];
        
        NSURL *url = [NSURL URLWithString:_cellModel.imgPath];
        [_placeImgView sd_setImageWithURL:url];//此处，不能用self.placeImgView设置
    }
}

@end
