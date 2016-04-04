//
//  MarkTableView.m
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MarkTableView.h"
#import "HomeLayoutModel.h"
#import "HomeTableViewCell.h"

@implementation MarkTableView

- (void)requestData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [manager GET:self.urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self distributeData:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)distributeData:(id)responseObject
{
    NSDictionary *data = [responseObject objectForKey:@"data"];
    NSArray *userActivities = [data objectForKey:@"user_activities"];
    self.models = [[NSMutableArray alloc] initWithCapacity:userActivities.count];
    for (NSDictionary *dic in userActivities) {
#warning 更改映射在AppDelegate里，合并任务时记得修改
        HomeModel *model = [[HomeModel alloc] initWithDictionary:dic error:nil];
        HomeLayoutModel *layoutModel = [[HomeLayoutModel alloc] init];
        layoutModel.homeModel = model;
        
        [self.models addObject:layoutModel];
        
    }
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
    cell.layoutModel = self.models[indexPath.row];
    cell.layoutModel.bigImageHeight = cell.firstImageHeight;
    cell.recommend.text = @"来自 氢大V 推荐";
    
    return cell;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
