//
//  TripAttractionControl.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripAttractionControl : UIControl

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)name;

- (void)configButtonTitle:(NSString *)titleName;

@end
