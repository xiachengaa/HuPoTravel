//
//  HPTabBarController.m
//  琥珀旅行
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HPTabBarController.h"
#import "HomeViewController.h"
#import "ScenicSpotViewController.h"
#import "WriteViewController.h"
#import "TripViewController.h"
#import "MeViewController.h"
#import "HPNaviController.h"
#import "HPTabBar.h"
@interface HPTabBarController ()

@end

@implementation HPTabBarController
#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.在这里做初始化viewcontroller
//    [UIImage imageNamed:@"tab_home_selected"]
    //1.1首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self addChildViewController:homeVC title:@"首页" image:@"tab_home" selectImage:@"tab_home_selected"];
    //1.2消息
    UIStoryboard *scenicSpotSB = [UIStoryboard storyboardWithName:@"ScenicSpot" bundle:nil];
    UINavigationController *nav = [scenicSpotSB instantiateViewControllerWithIdentifier:MainNavgationControllerIdentifier];
    ScenicSpotViewController *sencondVC = (ScenicSpotViewController *)nav.topViewController;
    sencondVC.title = @"发现";
    
    sencondVC.tabBarItem.image = [UIImage imageNamed:@"tab_activities"];
    //解决图片自动渲染成蓝色问题
    sencondVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_activities_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    //解决文字自动渲染成蓝色的问题
    NSMutableDictionary *norDic = [NSMutableDictionary dictionary];
    norDic[NSForegroundColorAttributeName] = MJColor(123, 123, 123);
    NSMutableDictionary *selectDic = [NSMutableDictionary dictionary];
    selectDic[NSForegroundColorAttributeName] = MJColor(47, 173, 201);
    [sencondVC.tabBarItem setTitleTextAttributes:norDic forState:UIControlStateNormal];
    [sencondVC.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    nav.navigationBar.hidden = YES;
    
    [self addChildViewController:nav];
    
//    UIButton *writeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [writeBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
//    [writeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
//    writeBtn.size = writeBtn.currentBackgroundImage.size;
//    [self.tabBar addSubview:writeBtn];
    
    //1.3发现
    TripViewController *discoverVC = [[TripViewController alloc] init];
    [self addChildViewController:discoverVC title:@"行程" image:@"tab_plans" selectImage:@"tab_plans_selected"];
    //1.4我
    MeViewController *profileVC = [[MeViewController alloc] init];
    [self addChildViewController:profileVC title:@"我" image:@"tab_me" selectImage:@"tab_me_selected"];
    
    //更换系统的tabbar
    HPTabBar *tabbar = [[HPTabBar alloc] init];
    /**
     *  使用kvc强制更换系统的tabbar
     */
    [self setValue:tabbar forKey:@"tabBar"];
    
    tabbar.btnBlock = ^(){
        
        WriteViewController *vc = [[WriteViewController alloc] init];
        HPNaviController *navi = [[HPNaviController alloc] initWithRootViewController:vc];
        [self presentViewController:navi animated:YES completion:nil];
    };
    
    
}
    

#pragma mark - 其他方法
- (void)addChildViewController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    childVC.title = title;
    
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    //解决图片自动渲染成蓝色问题
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    //解决文字自动渲染成蓝色的问题
        NSMutableDictionary *norDic = [NSMutableDictionary dictionary];
        norDic[NSForegroundColorAttributeName] = MJColor(123, 123, 123);
        NSMutableDictionary *selectDic = [NSMutableDictionary dictionary];
        selectDic[NSForegroundColorAttributeName] = MJColor(47, 173, 201);
        [childVC.tabBarItem setTitleTextAttributes:norDic forState:UIControlStateNormal];
        [childVC.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    //添加为自控制器
    HPNaviController *navi = [[HPNaviController alloc] initWithRootViewController:childVC];
    [self addChildViewController:navi];
    
//    //更换系统的tabbar
//    HPTabBar *tabbar = [[HPTabBar alloc] init];
//    /**
//     *  使用kvc强制更换系统的tabbar
//     */
//    [self setValue:tabbar forKey:@"tabBar"];
//    
//    tabbar.btnBlock = ^(){
//        
//        WriteViewController *writeVC = [[WriteViewController alloc] init];
//        writeVC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 256.0 green:arc4random_uniform(256) / 256.0 blue:arc4random_uniform(256) / 256.0 alpha:1];
//        [self presentViewController:writeVC animated:YES completion:nil];
//    };
//
    
    
}




#pragma mark - 代理方法

@end
