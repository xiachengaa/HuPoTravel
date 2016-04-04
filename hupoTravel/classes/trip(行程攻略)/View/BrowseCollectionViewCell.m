//
//  BrowseCollectionViewCell.m
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BrowseCollectionViewCell.h"
#import "StrategyCollectionCellModel.h"

@implementation BrowseCollectionViewCell

- (void)awakeFromNib {
    
//    [self setNeedsLayout];
    [self _configButton];
}

- (void)_configButton
{
    //虽然外部没有对browseNameButton进行赋值（即代码创建），但此时的browseNameButton已经存在————因为其是通过nib创建的
    self.layer.cornerRadius = kNumberCornerRadius;//圆角设置
    self.browseNameButton.backgroundColor = [UIColor colorWithWhite:0.88 alpha:1];
    [self.browseNameButton setTitleColor:[UIColor colorWithWhite:0.2 alpha:1] forState:UIControlStateNormal];
//    [self.browseNameButton setFont:[UIFont systemFontOfSize:11]];//字体通过xib文件设置
}

//- (void)layoutSubviews
//{
////    _browseNameLabel.backgroundColor = [UIColor lightGrayColor];
////    self.browseNameLabel.layer.cornerRadius = 50;
//    for (NSInteger i = 0; i < 6; i++) {
//        
//        _browseNameButton.titleLabel.text = _brownCellModel.chName;
//    }
//}

-(void)setBrownCellModel:(StrategyCollectionCellModel *)brownCellModel
{
    if (_brownCellModel != brownCellModel) {
        
        _brownCellModel = brownCellModel;
        
        //self.browseNameButton.titleLabel.text = _brownCellModel.chName;//无效
        [self.browseNameButton setTitle:_brownCellModel.chName forState:UIControlStateNormal];//有效————前提：xib文件中要讲system设置成cuntom
    }
}

@end
