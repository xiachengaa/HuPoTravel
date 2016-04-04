//
//  AppDelegate.m
//  琥珀旅行
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "HPTabBarController.h"
#import "MJAccount.h"
#import "OAuthViewController.h"
#import "JSONModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置JSONKey特殊字段的映射关系
    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ID",@"description":@"desc"}];
    [JSONModel setGlobalKeyMapper:mapper];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[HPTabBarController alloc] init];
   
    
    
//    //这里设置启动图片的效果
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
//    imageView.image = [UIImage imageNamed:@"launch_logo"];
//    imageView.alpha = 0;
//    [self.window addSubview:imageView];
//    [self.window bringSubviewToFront:imageView];
//    [UIView animateWithDuration:4 animations:^{
//        imageView.alpha = 1.0;
//        imageView.frame = CGRectMake(0, 0, 0, 0);
//    } completion:^(BOOL finished) {
//        [imageView removeFromSuperview];
//    }];
    
     [self.window makeKeyAndVisible];
    
    MJAccount *account = [MJAccount account];
    if (account) {
        //就进界面
        self.window.rootViewController = [[HPTabBarController alloc] init];
    }else{
        self.window.rootViewController = [[OAuthViewController alloc] init];
        
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/**
 *  清空图片缓存作用
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cancelAll];
    [manager.imageCache clearMemory];
}

@end
