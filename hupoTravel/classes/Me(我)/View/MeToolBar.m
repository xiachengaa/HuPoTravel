
//
//  MeToolBar.m
//  琥珀旅行
//
//  Created by mac on 16/2/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MeToolBar.h"

@implementation MeToolBar

#pragma mark - 系统方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //这里进行buttton的创建
        [self setButton:[UIImage imageNamed:@"icon_grid"] selectImage:[UIImage imageNamed:@"icon_grid_selected"] type:MeToolBarButtonTypeMigong];
        [self setButton:[UIImage imageNamed:@"icon_list"] selectImage:[UIImage imageNamed:@"icon_list_selected"] type:MeToolBarButtonTypeTravel];
        
        [self setButton:[UIImage imageNamed:@"icon_grouped"] selectImage:[UIImage imageNamed:@"icon_grouped_selected"] type:MeToolBarButtonTypeComment];
        [self setButton:[UIImage imageNamed:@"icon_map"] selectImage:[UIImage imageNamed:@"icon_map_selected"] type:MeToolBarButtonTypeMap];
        
    }
    return self;
}


- (void)layoutSubviews
{
    //调整尺寸
    [super layoutSubviews];
    CGFloat buttonW = self.width * 0.25;
    CGFloat buttonH = self.height;
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        CGFloat buttonX = buttonW * i;
        CGFloat buttonY = 0;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}


#pragma mark - 自定义方法
/**
 *  添加按钮
 */
- (UIButton *)setButton:(UIImage *)image selectImage:(UIImage *)selectImage type:(MeToolBarButtonType)buttonType
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateSelected];
    //这里绑定tag值
    button.tag = buttonType;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    if (buttonType == MeToolBarButtonTypeMigong) {
        button.selected = YES;
    }
    return button;
}

/**
 *  button的点击事件
 */
- (void)buttonClick:(UIButton *)button
{
    //解决点击亮图片的问题
    button.selected = YES;
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *otherBtn = self.subviews[i];
        if (otherBtn.tag != button.tag) {
            otherBtn.selected = NO;
        }
    }
    //这里要进行tableview的切换
    //还是得跳回到主界面，因为还有地图的跳转
    if ([self.delegate respondsToSelector:@selector(buttonClickAction:)]) {
        [self.delegate buttonClickAction:(MeToolBarButtonType)button.tag];
    }
}




#pragma mark - 其他方法

@end
