//
//  PlayGuideViewController.m
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PlayGuideViewController.h"
#import "PlayGuideModel.h"
#import "PlayGuideIntroduceCellModel.h"
#import "PlayGuideCellModel.h"

@interface PlayGuideViewController ()
{
    NSMutableArray *_arraySectionData;
    NSMutableArray *_arrayCellIntroduceData;
    NSMutableArray *_arrayCellSpeakData;
    
    BOOL _flag[100];
}

@end

@implementation PlayGuideViewController

- (instancetype)init
{
    if (self = [super init]) {
        
        self.view.backgroundColor = [UIColor cyanColor];
        self.hidesBottomBarWhenPushed = YES;
        
        self.playGuidetableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view addSubview:self.playGuidetableView];
        
        self.playGuidetableView.dataSource = self;
        self.playGuidetableView.delegate = self;
        
        [self.playGuidetableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [self _loadaData];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self _loadaData];
}

- (void)_loadaData
{
    //数组初始化
    _arraySectionData = [NSMutableArray array];
    _arrayCellIntroduceData = [NSMutableArray array];
    _arrayCellSpeakData = [NSMutableArray array];
    
    NSArray *arrAllData = [HWDataService DataService:@"playGuide.json"];
//    NSLog(@"%@", arr);
    
    
    for (NSDictionary *dic in arrAllData) {
        
        //头视图
        PlayGuideModel *modelHeader = [[PlayGuideModel alloc] init];
        modelHeader.classID = dic[@"id"];
        modelHeader.title = dic[@"title"];
        [_arraySectionData addObject:modelHeader];
        
        //单元格
        int a = [dic[@"id"] intValue];
        NSArray *arrIntroduce;
        
        if (a == 99) {
            
            //概览
            arrIntroduce = dic[@"sections"];
            
            for (NSDictionary *dicCell in arrIntroduce) {
                
                PlayGuideIntroduceCellModel *modelIntroduce = [[PlayGuideIntroduceCellModel alloc] init];
                modelIntroduce.introduceID = dicCell[@"id"];
                modelIntroduce.title = dicCell[@"title"];
                modelIntroduce.introduceDescription = dicCell[@"description"];
                modelIntroduce.arrayPhotoes = dicCell[@"photos"];
                
                [_arrayCellIntroduceData addObject:modelIntroduce];
            }
            
        } else {
            
            //旅行者说
            arrIntroduce = dic[@"sections"];
            
            for (NSDictionary *dicCell in arrIntroduce) {
                
                PlayGuideCellModel *modelJourney = [[PlayGuideCellModel alloc] init];
                modelJourney.journeyID = dicCell[@"id"];
                modelJourney.title = dicCell[@"title"];
                modelJourney.speakDescription = dicCell[@"description"];
                modelJourney.travelDate = dicCell[@"travel_date"];
                modelJourney.user = dicCell[@"user"];
                
                [_arrayCellSpeakData addObject:modelJourney];
            }
        }
    }
    
    [_playGuidetableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tabel view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"%ld", _arraySectionData.count);
    return _arraySectionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_flag[section]) {
        
        return 0;
    }else {
        
        if (section == 0) {
            
            return  _arrayCellIntroduceData.count;
        } else {
            
            return _arrayCellSpeakData.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor brownColor];
    
    return cell;
}

#pragma mark - tabel view delegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:_arraySectionData[section] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    button.tag = section;
    //以button的origin为原点，进行上下左右偏移————上下:y值；左右:x值
    button.backgroundColor = [UIColor lightGrayColor];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 180);
    
    //竖条
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 11, 2, 20)];
    view.backgroundColor = [UIColor blueColor];
    [button addSubview:view];
    
    //右侧图标
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    [_playGuidetableView reloadData];
    return button;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}

#pragma mark - button action
- (void)buttonAction:(UIButton *)button
{
    NSInteger section = button.tag;
    _flag[section] = !_flag[section];
    
    //刷新整个表
    [_playGuidetableView reloadData];
}

@end
