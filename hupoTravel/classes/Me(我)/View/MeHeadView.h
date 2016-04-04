//
//  MeHeadView.h
//  琥珀旅行
//
//  Created by mac on 16/2/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeUserModel;
@class MeSetSystemController;
@protocol ChangeBgDelegate <NSObject>

/**
 *  更换背景图
 */
- (void)changeBgAction:(UIAlertController *)alertController;

/**
 *  打开相册
 */
- (void)openPicture;

/**
 *  跳转头像的push设置
 */
- (void)changeIconAction;


- (void)openMoreButtonAction:(UIAlertController *)alertController;


- (void)openSetSystemController:(MeSetSystemController *)meSetSystemController;
@end




@interface MeHeadView : UIImageView
@property (nonatomic,weak) UIButton *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *sexView;
@property (nonatomic, weak) UILabel *fanLabel;

@property (nonatomic, strong) MeUserModel *model;
@property (nonatomic, weak) id<ChangeBgDelegate> delegate;
@end
