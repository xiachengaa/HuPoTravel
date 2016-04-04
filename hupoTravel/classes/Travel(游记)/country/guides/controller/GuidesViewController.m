
//
//  GuidesViewController.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/16.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "GuidesViewController.h"
#import "GuideTableView.h"
#import "GuideModel.h"

@interface GuidesViewController ()

@property (weak, nonatomic) IBOutlet GuideTableView *guideTableView;

@end

@implementation GuidesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self setupConfig];
    [self setBackButton];
    [self loadGuideData];
}

- (void)setupConfig{
    self.title = [NSString stringWithFormat:@"%@攻略", self.desModel.name];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)loadGuideData{
    //----从网络请求数据
    NSURLSessionConfiguration *configration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configration];
    
    NSRange range = [GuideURL rangeOfString:@"="];
    NSInteger location = GuideURL.length - range.location - 1;
    range.length = location;
    range.location += 1;
    NSString *urlString = [GuideURL stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%@",self.desModel.ID]];
//        NSLog(@"%@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self loadDataFinish:responseObject];
    }];
    [dataTask resume];
}

//解析数据
- (void)loadDataFinish:(id)result{
    
    NSArray *array1 = result[@"data"];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dataDic in array1) {
        GuideModel *guideModel = [[GuideModel alloc] initWithDictionary:dataDic error:nil];
        [dataArray addObject:guideModel];
    }
    self.guideTableView.modelArray = dataArray;
    [self.guideTableView reloadData];
}

@end
