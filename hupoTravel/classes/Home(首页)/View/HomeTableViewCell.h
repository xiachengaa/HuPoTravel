//
//  HomeTableViewCell.h
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeLayoutModel.h"

@class ZoomShowImageView;
@class DetailCollectionView;
@class MarkCollectionView;
@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;  //头像
@property (weak, nonatomic) IBOutlet UILabel *userName;  //用户名
@property (weak, nonatomic) IBOutlet UILabel *recommend;  //推荐人
@property (weak, nonatomic) IBOutlet UIButton *followButton;    //关注他按钮
@property (weak, nonatomic) IBOutlet UIButton *like;   //点赞
@property (weak, nonatomic) IBOutlet UIButton *comment;  //评论
@property (weak, nonatomic) IBOutlet UIButton *star;   //星号
@property (weak, nonatomic) IBOutlet UIButton *more;   //更多
- (IBAction)moreAction:(id)sender;

@property (nonatomic, strong) ZoomShowImageView *firstImageView;  //最大的那张图
@property (nonatomic, assign) float firstImageHeight;   //最大图高度
@property (nonatomic, assign) float descriptionHeight;   //正文最大高度
@property (nonatomic, strong) DetailCollectionView *detailCollectionView;
@property (nonatomic, strong) HomeLayoutModel *layoutModel;   //传入数据
@property (nonatomic, strong) UILabel *topic;   //文章标题
@property (nonatomic, strong) UILabel *desc;   //文章内容
@property (nonatomic, strong) UIButton *button;  //展开全文按钮
@property (nonatomic, strong) MarkCollectionView *markCollectionView;   //标签栏滚动视图
@property (nonatomic, assign) CGFloat collectionViewHeight;


@end
