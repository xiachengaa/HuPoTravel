//
//  MarkViewController.m
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MarkViewController.h"
#import "MarkTableView.h"

@interface MarkViewController ()

@end

@implementation MarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createBackButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _markTableView = [[MarkTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 + 49) style:UITableViewStylePlain];
    NSString *str = [NSString stringWithFormat:@"http://q.chanyouji.com/api/v1/user_activities.json?%@&filter=&page=1&sort=",_idNumber];
    _markTableView.urlStr = str;
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.view addSubview:_markTableView];

    
}

- (void)_createBackButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [button setImage:[UIImage imageNamed:@"BackIndicator"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
}

- (void)backButtonAction:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
