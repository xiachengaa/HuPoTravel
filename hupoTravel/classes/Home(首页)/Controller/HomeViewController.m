//
//  HomeViewController.m
//  琥珀旅行
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    //创建表示图
    [self _createTableView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_homeTableView.timer) {
        _homeTableView.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeBegin:) userInfo:nil repeats:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_homeTableView.timer invalidate];
    _homeTableView.timer = nil;
}

- (void)timeBegin:(NSTimer *)timer
{
    _homeTableView.count++;
    _homeTableView.count =_homeTableView.count % 4;
    [UIView animateWithDuration:0.4 animations:^{
        _homeTableView.headView.contentOffset = CGPointMake(kScreenWidth * _homeTableView.count, 0);
        _homeTableView.page.currentPage = (_homeTableView.headView.contentOffset.x/kScreenWidth);
    }];
    
}

- (void)_createTableView
{
    _homeTableView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _homeTableView.urlStr = @"http://q.chanyouji.com/api/v1/timelines.json?interests=118%2C116%2C119%2C139%2C141%2C145&page=1&per=50";
    [self.view addSubview:_homeTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        _homeTableView.page.currentPage = floor((_homeTableView.headView.contentOffset.x- kScreenWidth/2.0) /kScreenWidth) + 1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
