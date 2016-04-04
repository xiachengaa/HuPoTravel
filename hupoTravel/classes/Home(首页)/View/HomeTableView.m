//
//  HomeTableView.m
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeTableView.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "HomeTableViewCell.h"
#import "HomeLayoutModel.h"
#import "UIImageView+WebCache.h"
#import "DetailCollectionView.h"
#import "HomeViewController.h"
#import "MarkCollectionView.h"

#define kHeadViewHeight 160
@interface HomeTableView()
{
    UIView *_backView;
}

@property (nonatomic, strong)id result;

@end


@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeadViewHeight)];
        _count = 0;
        
        [self registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"homeCell"];
        
    }
    return  self;
    
}

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }
    return nil;
}

- (void)setUrlStr:(NSString *)urlStr
{
    if (_urlStr != urlStr) {
        _urlStr = urlStr;
        [self requestData];
    }
}

- (void)requestData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [manager GET:_urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *asd = responseObject;
//        NSArray *data = [asd valueForKey:@"data"];
//        NSDictionary *dic = data[0];
//        NSDictionary *qwe = [dic valueForKey:@"activity"];
//        NSDictionary *zxc = [qwe valueForKey:@"user"];
//        NSLog(@"%@",asd);;
        [self distributeData:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    [manager GET:@"http://q.chanyouji.com/api/v1/adverts.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        _result = responseObject;
        [self _createHeadView];

        [self reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)_createHeadView
{
    _headView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeadViewHeight)];
    _headView.showsHorizontalScrollIndicator = NO;
    _headView.pagingEnabled = YES;
    _headView.contentSize = CGSizeMake(kScreenWidth * 4, kHeadViewHeight);
    self.headView.delegate = (HomeViewController *)[self viewController];
    _page = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 30, kHeadViewHeight - 30, 60, 30)];
    _page.numberOfPages = 4;

}

- (void)distributeData:(id)responseObject
{
    NSArray *data = [responseObject objectForKey:@"data"];
    _models = [[NSMutableArray alloc] initWithCapacity:data.count];
    for (NSDictionary *dic in data) {
        NSDictionary *activity = [dic valueForKey:@"activity"];
#warning 更改映射在AppDelegate里，合并任务时记得修改
        HomeModel *model = [[HomeModel alloc] initWithDictionary:activity error:nil];
        model.recommender = [dic objectForKey:@"user"];
        HomeLayoutModel *layoutModel = [[HomeLayoutModel alloc] init];
        layoutModel.homeModel = model;

        [_models addObject:layoutModel];

    }
      [self reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
    cell.layoutModel = _models[indexPath.row];
    cell.layoutModel.bigImageHeight = cell.firstImageHeight;
   
    return cell;

}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeLayoutModel *layoutModel = _models[indexPath.row];

    layoutModel.isAll = !layoutModel.isAll;
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeLayoutModel *layoutModel = _models[indexPath.row];
    CGFloat a = layoutModel.bigImageHeight;
    CGFloat b = layoutModel.textFrame.size.height;
    if ((b > 80) && (layoutModel.isAll == NO) && (layoutModel.homeModel.contents.count > 1)) {
        b = 80;
        return 235 + a + b;
    }else if((b > 80) && (layoutModel.isAll == NO) && (layoutModel.homeModel.contents.count <= 1))
    {
        b = 80;
        return 155 + a + b;
    }else if((b > 80) && (layoutModel.isAll == YES) && (layoutModel.homeModel.contents.count <= 1))
    {
        return 140 + a + b;
    }
    
    return 220 + a + b;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeadViewHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        //头视图接口解析
    NSArray *array = [_result objectForKey:@"data"];
    for (int i = 0; i < array.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kHeadViewHeight)];
        NSURL *url = [NSURL URLWithString:[[array[i] objectForKey:@"photo"] objectForKey:@"photo_url"]];
        [imageView sd_setImageWithURL:url];
        [_headView addSubview:imageView];
    }
    [_backView addSubview:_headView];
    [_backView addSubview:_page];
    return _backView;

}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    HomeTableViewCell *homeCell = (HomeTableViewCell*)cell;
    [homeCell.detailCollectionView setContentOffset:CGPointMake(0, 0)];
    [homeCell.markCollectionView setContentOffset:CGPointMake(0, 0)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
