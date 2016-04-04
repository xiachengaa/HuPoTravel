//
//  DetailTableView.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/18.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "DetailTableView.h"
#import "DetailCell.h"
#import "DetailLayout.h"

#define DetailCellReuseIdentifier @"DetailReuseCell"
#define HeaderCelHeight 60

@interface DetailTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *clickStateArray;
@property (nonatomic, strong) NSMutableArray *buttonClickStateArray;

@end

@implementation DetailTableView

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
    self.clickStateArray = [NSMutableArray array];
    self.buttonClickStateArray = [NSMutableArray array];
    [self registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:DetailCellReuseIdentifier];
}

- (void)setModelArray:(NSArray *)modelArray{
    if (_modelArray != modelArray) {
        _modelArray = modelArray;
        for (int i = 0; i < _modelArray.count; i++) {
            if (i == 0) {
                NSNumber *clickState = [NSNumber numberWithBool:YES];
                [self.clickStateArray addObject:clickState];
            }else{
                NSNumber *clickState = [NSNumber numberWithBool:NO];
                [self.clickStateArray addObject:clickState];
            }
            NSNumber *clickButtonState = [NSNumber numberWithBool:NO];
            [self.buttonClickStateArray addObject:clickButtonState];
        }
    }
}

- (void)likeButtonAction:(UIButton *)sender{
    bool clickState = [self.buttonClickStateArray[sender.tag - 200] boolValue];
    clickState = !clickState;
    NSNumber *number = [NSNumber numberWithBool:clickState];
    [self.buttonClickStateArray replaceObjectAtIndex:sender.tag - 200 withObject:number];
    sender.selected = !sender.selected;
}

- (void)clickButtonAction:(UIButton *)sender{
    bool clickState = [self.clickStateArray[sender.tag] boolValue];
    clickState = !clickState;
    NSNumber *number = [NSNumber numberWithBool:clickState];
    [self.clickStateArray replaceObjectAtIndex:sender.tag withObject:number];
    [self reloadData];
    
}

#pragma mark - UITableView delegate


#pragma mark - UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailCellReuseIdentifier forIndexPath:indexPath];
    cell.detailLayout = self.modelArray[indexPath.section];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
    imageView.image = [UIImage imageNamed:@"icon_plan_cell_attraction"];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, 260, 30)];
    DetailLayout *layout = (DetailLayout *)self.modelArray[section];
    label.text = layout.detailModel.topic;
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    UIButton *likeButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 15, 30, 30)];
    if ([self.buttonClickStateArray[section] boolValue] == YES) {
        likeButton.selected = YES;
    }
    [likeButton setImage:[UIImage imageNamed:@"button_list_wish"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"button_list_wished"] forState:UIControlStateSelected];
    [likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    likeButton.tag = section + 200;
    [view addSubview:likeButton];
    
    UIButton *clickButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, HeaderCelHeight)];
    clickButton.backgroundColor = [UIColor clearColor];
    [clickButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    clickButton.tag = section;
    [view addSubview:clickButton];
    
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeaderCelHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.clickStateArray[indexPath.section] boolValue]) {
        DetailLayout *layout = self.modelArray[indexPath.section];
        return layout.cellHeight;
    }else{
        return 0;
    }
}


@end
