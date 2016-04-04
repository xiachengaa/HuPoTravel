//
//  ScenicSpotViewController.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/5.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "ScenicSpotViewController.h"
#import "DestinationModel.h"
#import "DestinationCollectionView.h"
#import "SearchBar.h"

@interface ScenicSpotViewController ()

@property (weak, nonatomic) IBOutlet DestinationCollectionView *placeCollectionView;
@property (weak, nonatomic) IBOutlet SearchBar *searchBar;

@end

@implementation ScenicSpotViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        [self loadDestinationData];
//        [self setupConfig];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [self setupConfig];
    [self loadDestinationData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.searchBar resignFirstResponder];
}

- (void) setupConfig{
    _dataDic = [NSMutableDictionary dictionary];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)loadDestinationData{
    //----从网络请求数据
    NSURLSessionConfiguration *configration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configration];
    
    NSURL *url = [NSURL URLWithString:DestinationURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self loadDataFinish:responseObject];
    }];
    [dataTask resume];
}

//解析网络请求数据
- (void)loadDataFinish:(id)result{
    
//    NSLog(@"%@",result);
    NSArray *data = [result objectForKey:@"data"];
    for (NSDictionary *dic in data) {
        
        NSArray *inArray = dic[@"destinations"];
        if (![[self.dataDic allKeys] containsObject:dic[@"name"]]) {
            [self.dataDic setObject:[NSMutableArray array] forKey:dic[@"name"]];
        }
        NSMutableArray *arr = [self.dataDic objectForKey:dic[@"name"]];
        for (NSDictionary *destinationDic in inArray) {
            DestinationModel *model = [[DestinationModel alloc] initWithDictionary:destinationDic error:nil];
            [arr addObject:model];
        }
    }
    [self createSearchDic:self.dataDic];
    self.placeCollectionView.modelDic = self.dataDic;
//    NSLog(@"%@",self.dataDic);
    self.placeCollectionView.searchDataDic = self.searchBar.searchDataDic;
    [self.placeCollectionView reloadData];
}

- (void)createSearchDic:(NSDictionary *)dic{
    NSMutableDictionary *searchDic = [NSMutableDictionary dictionary];
    NSArray *array = [dic allKeys];
    for (NSString *nameStr in array) {
        NSArray *modelArray = dic[nameStr];
//        NSLog(@"%@", modelArray);
        for (DestinationModel *model in modelArray) {
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
            [dic1 setObject:model.ID forKey:@"ID"];
            [dic1 setObject:model.name forKey:@"name"];
            [searchDic setObject:dic1 forKey:model.name];
            [searchDic setObject:dic1 forKey:model.name_en];
        }
    }
    self.searchBar.searchDataDic = searchDic;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
