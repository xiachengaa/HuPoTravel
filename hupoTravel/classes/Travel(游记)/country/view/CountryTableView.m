//
//  CountryTableView.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/9.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "CountryTableView.h"
#import "CountryCell.h"
#import "TravelNotesCell.h"
#import "CountryViewController.h"
#import "GuidesViewController.h"

#define CountryCellReuseIdentifier @"CountryReuseCell"
#define TravelCellReuseIdentifier @"TravelNotesReuseCell"

#define kGuideCellHeight 80
#define kHeaderViewHeight 20
#define kFooterViewHeight 10
#define kFooterButtonHeight 25

@interface CountryTableView () <UITableViewDelegate, UITableViewDataSource>
{
    bool _moreClickState;
}
@end

@implementation CountryTableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupConfig];
    }
    return self;
}

- (void)setupConfig{
    self.delegate = self;
    self.dataSource = self;
    self.modelArray = [[NSArray alloc] init];
    [self registerNib:[UINib nibWithNibName:@"TravelNotesCell" bundle:nil] forCellReuseIdentifier:TravelCellReuseIdentifier];
    _moreClickState = NO;
}

- (void)clickButtonAction:(UIButton *)sender{
    sender.titleLabel.text = @"隐藏更多攻略";
    _moreClickState = !_moreClickState;
    [self reloadData];
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 120, 15)];
        topicLabel.text = @"目的地攻略";
        topicLabel.textColor = [UIColor lightGrayColor];
        topicLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:topicLabel];
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 120, 15)];
        topicLabel.text = @"相关琥珀游记";
        topicLabel.textColor = [UIColor lightGrayColor];
        topicLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:topicLabel];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 && self.modelArray.count == 0) {
        return 0;
    }
    return kHeaderViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0 && self.modelArray.count == 0) {
        return 0;
    }else if(section == 0 && self.modelArray.count > 3){
        return kFooterButtonHeight + kFooterViewHeight;
    }else{
        return kFooterViewHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0 && self.modelArray.count > 3) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFooterViewHeight + kFooterButtonHeight)];
        view.backgroundColor = [UIColor colorWithRed:239.0 / 255 green:239.0 / 255 blue:239.0 / 255 alpha:1];
        
        UIView *clickView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFooterButtonHeight)];
        clickView.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, kFooterButtonHeight)];
        button.center = clickView.center;
        if (_moreClickState) {
            [button setTitle:@"隐藏更多攻略" forState:UIControlStateNormal];
        }else{
            [button setTitle:[NSString stringWithFormat:@"更多%@攻略", self.cityName] forState:UIControlStateNormal];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor colorWithRed:0 green:212.0 / 255 blue:212.0 / 255 alpha:1] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [clickView addSubview:button];
        [view addSubview:clickView];
        
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFooterViewHeight)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.modelArray.count == 0) {
            return 0;
        }else{
            return kGuideCellHeight;
        }
    }else{
        return self.layout.cellHeight;
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.modelArray.count > 3 && _moreClickState == NO) {
            return 3;
        }else{
            return self.modelArray.count;
        }
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:CountryCellReuseIdentifier forIndexPath:indexPath];
        cell.desModel = self.modelArray[indexPath.row];
        return cell;
    }else{
        TravelNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:TravelCellReuseIdentifier forIndexPath:indexPath];
        cell.layout = self.layout;
        cell.scenceImageArray = self.scenceImageArray;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UIStoryboard *guideSB = [UIStoryboard storyboardWithName:@"ScenicSpot" bundle:nil];
        GuidesViewController *guideVC = [guideSB instantiateViewControllerWithIdentifier:GuideVCIdentifier];
        guideVC.desModel = self.modelArray[indexPath.row];
        [((CountryViewController *)self.nextResponder.nextResponder).navigationController pushViewController:guideVC animated:YES];
    }
}



@end
