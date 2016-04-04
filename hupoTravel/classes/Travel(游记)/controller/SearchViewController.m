//
//  SearchViewController.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/19.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchBar.h"
#import "CountryViewController.h"

#define SearchCellReuseIdentifier @"SearchReuseCell"

@interface SearchViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet SearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic, copy) NSArray *searchResultArray;

@end

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated{
    [self setupConfig];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupConfig{
    self.backButton.layer.cornerRadius = 5;
    self.backButton.layer.masksToBounds = YES;
    self.searchBar.searchDataDic = self.searchDataDic;
    self.searchBar.delegate = self;
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - UISearchBar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", searchText];
    self.searchResultArray = [[self.searchDataDic allKeys] filteredArrayUsingPredicate:predicate];
    [self.searchTableView reloadData];
    
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *scenicSB = [UIStoryboard storyboardWithName:@"ScenicSpot" bundle:nil];
    CountryViewController *countryVC = [scenicSB instantiateViewControllerWithIdentifier:CountryVCIdentifier];
    NSDictionary *dic = self.searchDataDic[self.searchResultArray[indexPath.row]];
    countryVC.cityID = dic[@"ID"];
    countryVC.cityName = dic[@"name"];
    [self.navigationController pushViewController:countryVC animated:YES];
}

#pragma mark - UITableView DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchCellReuseIdentifier forIndexPath:indexPath];
    NSDictionary *dic = self.searchDataDic[self.searchResultArray[indexPath.row]];
    cell.textLabel.text = dic[@"name"];
    return cell;
}

@end
