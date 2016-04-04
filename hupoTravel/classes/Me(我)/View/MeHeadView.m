//
//  Meself.m
//  琥珀旅行
//
//  Created by mac on 16/2/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MeHeadView.h"
#import "MeUserModel.h"
#import "MeSetSystemController.h"
@interface MeHeadView ()

@end
@implementation MeHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"bg1"];
        //1.添加头像
        UIButton *iconView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
//        iconView.backgroundColor = [UIColor yellowColor];
        iconView.center = self.center;
        iconView.layer.cornerRadius = 40;
        iconView.clipsToBounds = YES;
        [self addSubview:iconView];
        self.iconView = iconView;
        [iconView addTarget:self action:@selector(iconViewClick) forControlEvents:UIControlEventTouchUpInside];
        
        //2.添加名字标签
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        nameLabel.textColor = [UIColor whiteColor];
//        nameLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        //3.添加性别图片
        UIImageView *sexView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gender1"]];
        
        [self addSubview:sexView];
        self.sexView = sexView;
        
        //4.添加粉丝和关注
        UILabel *fanLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 25)];
        fanLabel.textColor = [UIColor whiteColor];
        fanLabel.textAlignment = NSTextAlignmentCenter;
//        fanLabel.backgroundColor = [UIColor magentaColor];
        [self addSubview:fanLabel];
        self.fanLabel = fanLabel;
        
        //5.添加左上角的button
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"nav_more"] forState:UIControlStateNormal];
        leftBtn.size = leftBtn.currentBackgroundImage.size;
        leftBtn.left = 8;
        leftBtn.top = 20;
        [leftBtn addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
    }
    return self;
}

- (void)moreButtonClick
{
    //还是要通知跳转
    if ([self.delegate respondsToSelector:@selector(openMoreButtonAction:)]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //这里实现跳转到相册
            if ([self.delegate respondsToSelector:@selector(openSetSystemController:)]) {
                
                //拿到storyBoard的controller
                UIStoryboard *board = [UIStoryboard storyboardWithName:@"MeSetSystemStoryboard" bundle:nil];
                MeSetSystemController *meSetSystemController = [board instantiateViewControllerWithIdentifier:@"MeSetSystemController"];
                [self.delegate openSetSystemController:meSetSystemController];
            }
            
        }];
        UIAlertAction *collectionAction = [UIAlertAction actionWithTitle:@"我的收藏" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *draftsAction = [UIAlertAction actionWithTitle:@"我的草稿箱" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *giftCardAction = [UIAlertAction actionWithTitle:@"我的琥珀礼品卡" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:cancelAction];
        [alertController addAction:setAction];
        [alertController addAction:collectionAction];
        [alertController addAction:draftsAction];
        [alertController addAction:giftCardAction];
        
        [self.delegate openMoreButtonAction:alertController];
    }
}

/**
 *  头像点击，跳转到设置界面
 */
- (void)iconViewClick
{
//    NSLog(@"头像点击，跳转到设置界面");
    //还是要通知跳转
    if ([self.delegate respondsToSelector:@selector(changeIconAction)]) {
        [self.delegate changeIconAction];
    }
}

/**
 *  更换封面图点击动作
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更换封面图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这里实现跳转到相册
        /**
         *  因为view什么都做不了,气死老子了
         */
        if ([self.delegate respondsToSelector:@selector(openPicture)]) {
            [self.delegate openPicture];
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    
    //传到主控制器调用alert的弹出
    if ([self.delegate respondsToSelector:@selector(changeBgAction:)]) {
        [self.delegate changeBgAction:alertController];
    }
    
    
}


- (void)setModel:(MeUserModel *)model
{
    if (_model != model) {
        _model = model;
        //设置头像
        NSURL *iconUrl = [NSURL URLWithString:model.avatar_large];
        [self.iconView sd_setImageWithURL:iconUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"user_image"]];
       //设置用户名
        self.nameLabel.text = model.screen_name;
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        //设置性别
        if ([model.gender isEqualToString:@"f"]) {
            self.sexView.image = [UIImage imageNamed:@"gender0"];
        }else{
            self.sexView.image = [UIImage imageNamed:@"gender1"];
        }
       
        //设置粉丝的情况
        self.fanLabel.text = [NSString stringWithFormat:@"%@ 关注  |  %@ 粉丝", model.followers_count,model.friends_count];
        
    }
}

/**
 *  输出子视图的时候重置位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置中心点
//    CGSize nameLabelSize = [self sizeWithText:_nameLabel.text font:_nameLabel.font maxW:MAXFLOAT];
//    _nameLabel.size = nameLabelSize;
//    NSLog(@"%@",NSStringFromCGRect(_nameLabel.frame));
    _nameLabel.centerX = _iconView.centerX;
    _nameLabel.centerY = CGRectGetMaxY(_iconView.frame) + CGRectGetHeight(_nameLabel.frame) * 0.5;
    
    
    _sexView.left = CGRectGetMaxX(_nameLabel.frame);
    _sexView.centerY = _nameLabel.centerY;
    
    
    _fanLabel.centerX = _nameLabel.centerX;
    _fanLabel.centerY = CGRectGetMaxY(_nameLabel.frame) + _fanLabel.height * 0.5;
}



/**
 *  计算尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
