//
//  CountryViewController.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/9.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "CountryViewController.h"
#import "DestinationModel.h"
#import "CountryTableView.h"
#import "TravelNotesLayout.h"
#import "SearchBar.h"

#define kTableViewY 64
#define SearchCellReuseIdentifier @"ReuseSearchCell"

@interface CountryViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_searchTableView;
    NSArray *_searchReslutArray;
}

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet CountryTableView *countryTableView;
@property (weak, nonatomic) IBOutlet SearchBar *countrySearchBar;

@end

@implementation CountryViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self createTableView];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [self setupConfig];
    [self loadPlaceData];
}

- (void)setupConfig{
    self.backButton.layer.cornerRadius = 5;
    self.backButton.layer.masksToBounds = YES;
    self.navigationController.navigationBarHidden = YES;
    self.countrySearchBar.delegate = self;
    self.countrySearchBar.text = self.cityName;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)createTableView{
    _searchTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    [_searchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SearchCellReuseIdentifier];
}

- (void)loadPlaceData{
    //----从网络请求数据
    NSURLSessionConfiguration *configration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configration];
    
    NSRange range = [PlaceURL rangeOfString:@"="];
    NSRange range1 = [PlaceURL rangeOfString:@"&"];
    NSInteger location = range1.location - range.location - 1;
    range.length = location;
    range.location += 1;
    NSString *urlString = [PlaceURL stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%@",self.cityID]];
//    NSLog(@"%@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self loadDataFinish:responseObject];
    }];
    [dataTask resume];
}

//解析数据
- (void)loadDataFinish:(id)result{
    
    NSDictionary *dic = result[@"data"];
    NSArray *placeDic = dic[@"destinations"];
    
    //----旅游景点数据,存储在model中并放入数组
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic1 in placeDic) {
        DestinationModel *model = [[DestinationModel alloc] initWithDictionary:dic1 error:nil];

        [array addObject:model];
    }
    self.countryTableView.modelArray = array;
    
    //----用jsonModel解析数据并用contentModel储存，contentModel中有userModel（游记内容数据）
    NSArray *contentArray = dic[@"user_activities"];
    NSDictionary *contentDic = contentArray[0];
    ContentModel *model = [[ContentModel alloc] initWithDictionary:contentDic error:nil];
    TravelNotesLayout *layout = [[TravelNotesLayout alloc] init];
    layout.contentModel = model;
    self.countryTableView.layout = layout;
    
    //----游记中多图的数据存储
    NSArray *arr = contentDic[@"contents"];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSDictionary *imageDic in arr) {
        [imageArray addObject:imageDic[@"photo_url"]];
    }
    self.countryTableView.scenceImageArray = imageArray;
    self.countryTableView.cityName = self.cityName;
    [self.countryTableView reloadData];
    
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark - UISearchBar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _searchTableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - kTableViewY);
    [self.view addSubview:_searchTableView];
    [UIView animateWithDuration:0.3 animations:^{
        _searchTableView.transform = CGAffineTransformMakeTranslation(0, - _searchTableView.frame.size.height);
    }];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.3 animations:^{
        _searchTableView.transform = CGAffineTransformIdentity;
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", searchText];
    _searchReslutArray = [[self.searchDataDic allKeys] filteredArrayUsingPredicate:predicate];
    [_searchTableView reloadData];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.searchDataDic[_searchReslutArray[indexPath.row]];
    self.cityID = dic[@"ID"];
    [self loadPlaceData];
    [self.countrySearchBar resignFirstResponder];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchReslutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchCellReuseIdentifier forIndexPath:indexPath];
    NSDictionary *dic = self.searchDataDic[_searchReslutArray[indexPath.row]];
    cell.textLabel.text = dic[@"name"];
    return cell;
}

@end
