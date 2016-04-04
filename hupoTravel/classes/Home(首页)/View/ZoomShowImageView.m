//
//  ZoomImageView.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/19.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "ZoomShowImageView.h"
#import "SDPieProgressView.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
//#import <ImageIO/ImageIO.h>

@interface ZoomShowImageView ()<NSURLSessionDataDelegate>

@end
@implementation ZoomShowImageView
{
    UIScrollView *_scrollView;
    UIImageView *_fullImageView;
    SDPieProgressView *_progress;
    NSMutableData *_data;
    NSURLSession *_session;
    NSURLSessionDataTask *_datatask;
    UIImage *_saveImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomIn)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
//        self.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomIn)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
//        self.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)_createView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.window addSubview:_scrollView];
       
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fullImageView.image = self.image;

        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_fullImageView];
        
        _progress = [[SDPieProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _progress.center = self.window.center;
        _progress.hidden = YES;
        [_scrollView addSubview:_progress];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOut)];
        [_scrollView addGestureRecognizer:tap];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePhoto:)];
        [_scrollView addGestureRecognizer:longPress];
    }
}

- (void)savePhoto:(UIGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        UIImage *image = self.image;
//        [UIImage imageWithData:_data];
        if (image) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
            hud.labelText = @"正在保存";
            hud.dimBackground = YES;
            
            //@selector(image:didFinishSavingWithError:contextInfo:)必须这么写，下面方法使用的时候有解释格式要求
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void*)hud);

        }

    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    MBProgressHUD *hud = (__bridge MBProgressHUD *)contextInfo;
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    
    [hud hide:YES afterDelay:1.5];
}

- (void)zoomIn
{
    [self _createView];
    
    CGRect rect = [self convertRect:self.bounds toView:self.window];
    
    _fullImageView.frame = rect;
    
    _fullImageView.frame = _scrollView.bounds;
    _scrollView.backgroundColor = [UIColor blackColor];

//          _progress.hidden = NO;
     
          
//         _data = [[NSMutableData alloc] init];
//         NSURL *url = [NSURL URLWithString:self.urlString];
//         NSURLRequest *requset = [[NSURLRequest alloc] initWithURL:url];
//         _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//         
//         _datatask = [_session dataTaskWithRequest:requset];
//         [_datatask resume];

    
}

- (void)zoomOut
{
    [_datatask cancel];
        CGRect rect = [self convertRect:self.bounds toView:self.window];
        _fullImageView.frame = rect;
        [_scrollView removeFromSuperview];
        _scrollView = nil;
        _fullImageView = nil;
        _progress = nil;

}

#pragma - mark NSURLSession data delegate

//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
//    didReceiveData:(NSData *)data
//{
//    [_data appendData:data];
//    _progress.progress = (double)dataTask.countOfBytesReceived/dataTask.countOfBytesExpectedToReceive;
//    
//    if (dataTask.countOfBytesReceived == dataTask.countOfBytesExpectedToReceive) {
//        
//        UIImage *image = [UIImage imageWithData:_data];
//        if (_saveImage != image) {
//            _saveImage = image;
//        }
//        _fullImageView.image = image;
//    }
//    
//    CGFloat height = self.image.size.height/self.image.size.width * kScreenWidth;
//    if (height < kScreenHeight) {
//        _fullImageView.top = (kScreenHeight - height)/2;
//    }
//    _fullImageView.height = height;
//    _scrollView.contentSize = CGSizeMake(kScreenHeight, height);
//    
//    if (self.isGif) {
//        _fullImageView.image = [UIImage sd_animatedGIFWithData:_data];
//    }
//
//}



@end
