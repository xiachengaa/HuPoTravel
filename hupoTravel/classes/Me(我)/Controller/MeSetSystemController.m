//
//  MeSetSystemController.m
//  琥珀旅行
//
//  Created by mac on 16/2/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MeSetSystemController.h"
#import "HPTabBarController.h"
#import "OAuthViewController.h"
#import "MJAccount.h"
@interface MeSetSystemController ()

/**
 *  垃圾数
 */
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end

@implementation MeSetSystemController
#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //快出现的时候显示多少
    [self countCacheSize];
}


#pragma mark - Table view data source


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //当选中的时候就会调用
//    NSLog(@"%ld   %ld",indexPath.section,indexPath.row);
    //在这里实现各种方法
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
                //打开蝉游记链接
    
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/cn/app/chan-you-ji-gong-e-you-ji/id559653959?mt=8"]];
                
                break;
            case 2:
                
                break;
            case 3://清空缓存
                //这个是清空缓存的方法，弹出一个alert
                [self showClearAlertVC];

                break;
                
            default:
                break;
        }
    }else{
        //这里是退出账户
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"];
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        [mgr removeItemAtPath:path error:nil];
        
        
        self.view.window.rootViewController = [[OAuthViewController alloc] init];
    }
}



#pragma mark - 其他方法
/**
 *  计算还有多少垃圾
 */
- (void)countCacheSize{
    NSUInteger fileSize = [[SDImageCache sharedImageCache] getSize];
    _countLabel.text = [NSString stringWithFormat:@"%.1f M", fileSize / 1024.0 / 1024.0];
}

/**
 *  清楚缓存动作
 */
- (void)showClearAlertVC
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定清空缓存？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //添加动作
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //清楚掉缓存
        [[SDImageCache sharedImageCache] clearDisk];
        [self countCacheSize];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:yesAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
