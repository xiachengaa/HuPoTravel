//
//  WriteViewController.m
//  琥珀旅行
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WriteViewController.h"
#import "WriteTextView.h"
#import "MJAccount.h"
@interface WriteViewController ()<UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) UIButton *photoView;
@property (nonatomic, weak) UITextView *textView;

@end

@implementation WriteViewController
#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    /**
     *  设置导航栏
     */
    [self _createNavi];
    
    /**
     *  创建标题输入框
     */
    [self _createContentView];
}
/**
 *  移除观察者
 */
- (void)dealloc
{
    [HPNotificationCenter removeObserver:self];
}


#pragma mark - 初始化方法
/**
 *  设置导航栏
 */
- (void)_createNavi
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(goBackButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(postButton)];
    //让一开始变为不可用
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //设置中间的title样式
    UILabel *titleLabel = [[UILabel alloc ] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(0, 0, 200, 100);
    titleLabel.text = @"写游记";
    
    self.navigationItem.titleView = titleLabel;
    
    self.navigationController.navigationBar.translucent = NO;
}

/**
 *  创建标题输入框
 */
- (void)_createContentView
{
    //创建标题
    CGFloat textTitleViewX = 8;
    CGFloat textTitleViewY = 0;
    CGFloat textTitleViewW = kScreenWidth - 2 * textTitleViewX;
    CGFloat textTitleViewH = 50;
    UITextField *textTitleView = [[UITextField alloc] initWithFrame:CGRectMake(textTitleViewX, textTitleViewY, textTitleViewW, textTitleViewH)];
    textTitleView.placeholder = [NSString stringWithFormat:@"标题(一事一记)"];
    [textTitleView becomeFirstResponder];
    [self.view addSubview:textTitleView];
    
    //创建写字内容
    CGFloat textViewX = 4;
    CGFloat textViewY = CGRectGetMaxY(textTitleView.frame);
    CGFloat textViewW = textTitleViewW;
    CGFloat textViewH = kScreenHeight - CGRectGetMaxY(textTitleView.frame);
    WriteTextView *textView = [[WriteTextView alloc] initWithFrame:CGRectMake(textViewX, textViewY, textViewW, textViewH)];
    textView.placeholder = @"经历与感想...";
    [self.view addSubview:textView];
    textView.alwaysBounceVertical = YES;
    textView.showsVerticalScrollIndicator = NO;
    self.textView = textView;
    
    //添加通知给自己,当文本发生改变的时候
    [HPNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    textView.delegate = self;
    
    
    //创建相册视图
    CGFloat photoViewX = textTitleViewX;
    CGFloat photoViewY = 200;
    CGFloat photoViewWH = 100;
    UIButton *photoView = [[UIButton alloc] initWithFrame:CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH)];
    [photoView setImage:[UIImage imageNamed:@"add_photo"] forState:UIControlStateNormal];
    [photoView addTarget:self action:@selector(photoViewClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [textView addSubview:photoView];
    self.photoView = photoView;
    
}



#pragma mark - 其他方法
/**
 *  取消发送微博
 */
- (void)goBackButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  发送微博，待定
 */
- (void)postButton
{
#warning 这里做发送微博的方法
    if (self.photoView.currentImage) {
        //有图片
        [self sendWithImage];
    }else{
        //没有图片
        [self sendWithoutImage];
    }
}
/**
 *  发送带有图片的微博
 */
- (void)sendWithImage
{
    NSData *data = UIImageJPEGRepresentation(self.photoView.currentImage, 0.5);
    MJAccount *account = [MJAccount account];
    NSDictionary *params = @{
                             @"status" : self.textView.text,
                             @"access_token" : account.access_token
                             };
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //添加图片
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //发送成功
        [MBProgressHUD showSuccess:@"发送成功"];

        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //发送失败
        [MBProgressHUD showError:@"发送失败"];
        NSLog(@"%@",error);
    }];
    
}


/**
 *  发送
 */
- (void)sendWithoutImage
{
    MJAccount *account = [MJAccount account];
    NSDictionary *param = @{
                            @"status":self.textView.text,
                            @"access_token" : account.access_token
                            };
    
    [[AFHTTPSessionManager manager] POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //发送成功
        [MBProgressHUD showSuccess:@"发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //发送失败
        [MBProgressHUD showError:@"发送失败"];
    }];
}
/**
 *  发送没有图片的微博
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

/**
 *  相册点击事件
 */
- (void)photoViewClickAction:(UIButton *)photoView
{
    //打开相机
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //开始拖拽的时候让键盘落下
    [self.textView endEditing:YES];
}

/**
 *  相册的选定
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //    NSLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photoView setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //这里可以选择发送post请求给网络去更换图片，因为没有借口，所以自己不能实现
}
@end
