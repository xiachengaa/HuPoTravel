//
//  DetailViewController.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/18.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableView.h"
#import "DetailLayout.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet DetailTableView *detailTableView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupConfig{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = self.guideModel.topic;
}

- (void)setBackButton{
    UIImage *backImage = [UIImage imageNamed:@"BackIndicator"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:backImage forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)backButtonAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [self setupConfig];
    [self setBackButton];
    [self loadDetailData];
}

- (void)loadDetailData{
    //----从网络请求数据
    NSURLSessionConfiguration *configration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configration];
    
    NSRange range = [DetailURL rangeOfString:@"s/"];
    NSRange range1 = [DetailURL rangeOfString:@".json"];
    NSInteger location = range1.location - range.location - 2;
    range.length = location;
    range.location += 2;
    NSString *urlString = [DetailURL stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%@",self.guideModel.ID]];
//            NSLog(@"%@", urlString);
    
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
    NSArray *arr = dic[@"inspirations"];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dataDic in arr) {
        DetailModel *detailModel = [[DetailModel alloc] initWithDictionary:dataDic error:NULL];
        DetailLayout *detailLayout = [[DetailLayout alloc] init];
        detailLayout.detailModel = detailModel;
        [dataArray addObject:detailLayout];
    }
    self.detailTableView.modelArray = dataArray;
    [self.detailTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
