//
//  MeViewController.m
//  琥珀旅行
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MeViewController.h"
#import "MeHeadView.h"
#import "AFNetworking.h"
#import "MJAccount.h"
#import "MeUserModel.h"
#import "MeToolBar.h"
#import "MeMapController.h"
#import "MeSetUserInfoTableViewController.h"

#import "LBXScanView.h"
#import "LBXScanViewController.h"
#import "SubLBXScanViewController.h"
//#import <>
@interface MeViewController ()<ChangeBgDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MeToolBarButtonClickDelegate>
@property (nonatomic, weak) MeHeadView *headView;
@end



@implementation MeViewController

#pragma mark - 系统方法


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.0创建头视图
    self.headView = [self _createHeadView];
    //    这里进行请求头视图数据
    [self requestHeadViewData];
    
    //2.0创建工具条视图
    CGFloat toolBarY = CGRectGetMaxY(self.headView.frame);
    MeToolBar *toolBar = [[MeToolBar alloc] initWithFrame:CGRectMake(0, toolBarY, kScreenWidth, 40)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    
}

/**
 *  设置状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
}


- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}


#pragma mark - 自定义方法
/**
 *  创建头视图
 */
- (MeHeadView *)_createHeadView
{
    MeHeadView *headView = [[MeHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
    headView.userInteractionEnabled = YES;
    headView.delegate = self;
    [self.view addSubview:headView];
    return headView;
}

/**
 *  这里进行请求头视图数据,比如头像url，粉丝，关注
 */
- (void)requestHeadViewData
{
    //拿到access_token
    MJAccount *account = [MJAccount account];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //这里能请求到数据，我可以建一个模型接受这些数据，然后把模型传递给headView,进行设置数据
        [self loadUserDataFinish:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败,%@",error);
    }];
}


/**
 *  发送完请求后处理接受的数据
 */
-(void)loadUserDataFinish:(id)result
{
    MeUserModel *model = [[MeUserModel alloc] initWithDictionary:result error:nil];
    self.headView.model = model;
    //把数据传给setUserController
}


#pragma mark - 头视图的代理方法
/**
 *  因为headView是不可以调用这个控制器的方法的
 */
- (void)changeBgAction:(UIAlertController *)alertController
{
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openPicture
{
    //打开相机
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    NSLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.headView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //这里可以选择发送post请求给网络去更换图片，因为没有借口，所以自己不能实现
}







- (void)openMoreButtonAction:(UIAlertController *)alertController
{
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - MeToolBarButtonClickDelegate 工具条点击事件代理方法
- (void)buttonClickAction:(MeToolBarButtonType)type
{
    if (type == MeToolBarButtonTypeMap) {
        //说明是地图，开始跳转
        
        MeMapController *mapController = [[MeMapController alloc] init];
        
        [self.navigationController pushViewController:mapController animated:YES];
    }
    
    if (type == MeToolBarButtonTypeComment) {
        [self qqStyle];
    }
}

- (void)qqStyle
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 头像的跳转代理方法
- (void)changeIconAction
{
    MeSetUserInfoTableViewController *suc = [[MeSetUserInfoTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    suc.model = self.headView.model;
    [self.navigationController pushViewController:suc animated:YES];
}


/**
 *  打开设置系统设置界面
 */
- (void)openSetSystemController:(MeSetSystemController *)meSetSystemController
{
    [self.navigationController pushViewController:(UIViewController *)meSetSystemController animated:YES];
}


@end
