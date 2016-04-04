//
//  HomeTableViewCell.m
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "DetailCollectionView.h"
#import "UIImageView+WebCache.h"
#import "ZoomShowImageView.h"
#import "MarkCollectionView.h"

#define kBigImageBeginHeight 50
#define kCollectionViewHeight 80
#define kTopicLabelHeight 25
#define kBetweenCVTopic 5
#define kButtonHeight 15
#define kScrollHeight 20

@interface HomeTableViewCell()
{
    UILabel *_reportLabel;
}

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _firstImageHeight = 160;
    _descriptionHeight = 40;
    _headImageView.layer.cornerRadius = 20;
    _headImageView.layer.masksToBounds = YES;
    
    [self _createFirstImgV];
    [self _changeFollowButton];
    [self _createContentLabel];
    if (_detailCollectionView == nil) {
        _detailCollectionView = [[DetailCollectionView alloc] initWithFrame:CGRectMake(0, kBigImageBeginHeight + _firstImageHeight + 2, kScreenWidth, kCollectionViewHeight)];
        [self.contentView addSubview:_detailCollectionView];
    }
    [self _createDistricts];
     _reportLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _reportLabel.alpha = 0;

}

- (void)_createDistricts
{
    if (_markCollectionView == nil) {
        _markCollectionView = [[MarkCollectionView alloc] init];
        
        _markCollectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_markCollectionView];
    }

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_layoutModel != nil) {
    
        _descriptionHeight = _layoutModel.textFrame.size.height;

        if ((_descriptionHeight > 80) && (_layoutModel.isAll == NO)) {
            _descriptionHeight = 80;
            _button.hidden = NO;
        }else if((_descriptionHeight > 80) && (_layoutModel.isAll == YES))
        {
            _descriptionHeight = _layoutModel.textFrame.size.height;
            _button.hidden = YES;
        }else
        {
            _button.hidden = YES;
        }
        
        if (_layoutModel.homeModel.contents.count > 1) {
            _collectionViewHeight = kCollectionViewHeight;
        }else
        {
            _collectionViewHeight = 0;
        }

        _detailCollectionView.frame = CGRectMake(0, kBigImageBeginHeight + _firstImageHeight + 2, kScreenWidth, _collectionViewHeight);

        _topic.frame = CGRectMake(0, kBigImageBeginHeight + _firstImageHeight + _collectionViewHeight + kBetweenCVTopic, kScreenWidth, kTopicLabelHeight);
        _desc.frame = CGRectMake(0, kBigImageBeginHeight + _firstImageHeight + _collectionViewHeight + kBetweenCVTopic + kTopicLabelHeight, kScreenWidth, _descriptionHeight);
        _firstImageView.frame = CGRectMake(0, kBigImageBeginHeight, kScreenWidth, _firstImageHeight);
        _button.frame = CGRectMake( 0, kBigImageBeginHeight + _firstImageHeight + _collectionViewHeight + kBetweenCVTopic + kTopicLabelHeight + _descriptionHeight, 70, kButtonHeight);
        if (_button.hidden == NO) {
            _markCollectionView.frame = CGRectMake(0, kBigImageBeginHeight + _firstImageHeight + _collectionViewHeight + kBetweenCVTopic + kTopicLabelHeight + _descriptionHeight + kButtonHeight + 5, kScreenWidth, kScrollHeight);
        }else
        {
            _markCollectionView.frame = CGRectMake(0, kBigImageBeginHeight + _firstImageHeight + _collectionViewHeight + kBetweenCVTopic + kTopicLabelHeight + _descriptionHeight + 5, kScreenWidth, kScrollHeight);
        }

    }
}

//   创建正文
- (void)_createContentLabel
{
    if (!_topic) {
        _topic = [[UILabel alloc] initWithFrame:CGRectMake(0, kBigImageBeginHeight + _firstImageHeight + _collectionViewHeight + kBetweenCVTopic, kScreenWidth, kTopicLabelHeight)];
        _topic.font = [UIFont systemFontOfSize:14 weight:1];
        [self.contentView addSubview:_topic];
    }

    if (!_desc) {
        _desc = [[UILabel alloc] initWithFrame:CGRectMake(0, kBigImageBeginHeight + _firstImageHeight + _collectionViewHeight + kBetweenCVTopic + kTopicLabelHeight, kScreenWidth, _descriptionHeight)];
        _desc.numberOfLines = 0;
        _desc.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_desc];
    }
    _button = [[UIButton alloc] init];
    [_button setTitle:@"展开全文" forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:13];
    [_button setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.contentView addSubview:_button];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)_changeFollowButton
{
    _followButton.layer.cornerRadius = 5;
    _followButton.layer.masksToBounds = YES;
    _followButton.layer.borderWidth = 0.5;
    _followButton.layer.borderColor = [UIColor cyanColor].CGColor;
    [_followButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [_followButton addTarget:self action:@selector(followAction:) forControlEvents:UIControlEventTouchUpInside];
}

//   创建第一张大图
- (void)_createFirstImgV
{
    if (!_firstImageView) {
        _firstImageView = [[ZoomShowImageView alloc] init];
        _firstImageView.frame = CGRectMake(0, kBigImageBeginHeight, kScreenWidth, _firstImageHeight);
        _firstImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_firstImageView];
    }

}

- (void)setLayoutModel:(HomeLayoutModel *)layoutModel
{
    if (_layoutModel != layoutModel) {
        _layoutModel = layoutModel;
        
        _firstImageHeight = [[_layoutModel.homeModel.contents[0] objectForKey:@"height"] floatValue]/[[_layoutModel.homeModel.contents[0] objectForKey:@"width"] floatValue] * kScreenWidth;
        [self layoutSubviews];
        NSURL *firstIVURL = [NSURL URLWithString:[_layoutModel.homeModel.contents[0] objectForKey:@"photo_url"]];
        
        [_followButton setTitle:_layoutModel.followStr forState:UIControlStateNormal];
        [_firstImageView sd_setImageWithURL:firstIVURL];
            
        NSURL *url = [NSURL URLWithString:[_layoutModel.homeModel.user objectForKey:@"photo_url"]];
        [_headImageView sd_setImageWithURL:url];
        _userName.text = [_layoutModel.homeModel.user objectForKey:@"name"];
        _recommend.text = [NSString stringWithFormat:@"来自 %@ 推荐",[_layoutModel.homeModel.recommender objectForKey:@"name"]];
            
        [_like setTitle:[NSString stringWithFormat:@" %d",_layoutModel.homeModel.likes_count] forState:UIControlStateNormal];
        [_comment setTitle:[NSString stringWithFormat:@" %d",_layoutModel.homeModel.comments_count] forState:UIControlStateNormal];
        [_star setTitle:[NSString stringWithFormat:@" %d",_layoutModel.homeModel.favorites_count] forState:UIControlStateNormal];
        _topic.text = [NSString stringWithFormat:@"   %@",_layoutModel.homeModel.topic];
        _desc.text = _layoutModel.homeModel.desc;
            _detailCollectionView.contents = _layoutModel.homeModel.contents;
        
        _markCollectionView.districts = _layoutModel.homeModel.districts;
        
        _markCollectionView.categories = _layoutModel.homeModel.categories;

    }
}

- (void)buttonAction:(UIButton *)sender
{
     _layoutModel.isAll = YES;
     _descriptionHeight = _layoutModel.textFrame.size.height;
    [[self tableView] reloadData];
}

- (UITableView *)tableView
{
    
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UITableView class]]) {
            
            return (UITableView *)next;
        }
        
        next = next.nextResponder;
    }
    
    return nil;
}

- (void)followAction:(UIButton *)sender
{
    _layoutModel.followStr = @"已关注";
    [sender setTitle:_layoutModel.followStr forState:UIControlStateNormal];
//    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)moreAction:(id)sender {
    UIAlertController *alertCV = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *share = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *report = [UIAlertAction actionWithTitle:@"举报不良内容" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *reportCV = [UIAlertController alertControllerWithTitle:@"确定举报这篇游记" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *reportCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *reportEnsure = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _reportLabel.alpha = 0.9;
            _reportLabel.center = self.superview.center;
            _reportLabel.text = @"举报已提交";
            _reportLabel.textColor = [UIColor blackColor];
            _reportLabel.backgroundColor = [UIColor lightGrayColor];
            _reportLabel.layer.masksToBounds = YES;
            _reportLabel.layer.cornerRadius = 10;
            _reportLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.window addSubview:_reportLabel];

            [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
                 _reportLabel.alpha = 0;
            } completion:nil];
            
        }];
        [reportCV addAction:reportCancel];
        [reportCV addAction:reportEnsure];
        [[self viewController] presentViewController:reportCV animated:YES completion:^{
            
        }];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCV addAction:share];
    [alertCV addAction:report];
    [alertCV addAction:cancel];
    [[self viewController] presentViewController:alertCV animated:YES completion:^{
        
    }];
}

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }
    return nil;
}
@end
