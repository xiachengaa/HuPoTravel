//
//  ZoomImageView.m
//  微博
//
//  Created by 朱晓涵 on 16/1/19.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "ZoomImageView.h"
#import "SDPieLoopProgressView.h"

@interface ZoomImageView () <NSURLSessionDataDelegate>

@end

@implementation ZoomImageView{
    UIScrollView *_scrollView;
    UIImageView *_fullImageView;
    SDPieLoopProgressView *_progressView;
    //网络请求
    NSURLSession *_session;
    NSMutableData *_data;
    NSURLSessionDataTask *_dataTask;
    UIImage *_saveImage;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomIn)];
    [self addGestureRecognizer:tap];
    
    self.userInteractionEnabled = YES;
}

- (void)_createView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.userInteractionEnabled = YES;
        [self.window addSubview:_scrollView];
        
        //----创建显示的大图
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.image = self.image;
        [_scrollView addSubview:_fullImageView];
        
        //----创建加载图片的视图
        _progressView = [SDPieLoopProgressView progressView];
        _progressView.frame = CGRectMake(0, 0, 100, 100);
        _progressView.center = _scrollView.center;
        _progressView.hidden = YES;
        [_scrollView addSubview:_progressView];
        
        //----为滑动视图添加单击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOut)];
        [_scrollView addGestureRecognizer:tap];
    }
}

- (void)zoomIn{
    [self _createView];
    _scrollView.backgroundColor = [UIColor blackColor];
    CGRect rect = [self convertRect:self.bounds toView:self.window];
    _fullImageView.frame = rect;
    
    [UIView animateWithDuration:0.3 animations:^{
        _fullImageView.frame = _scrollView.frame;
    } completion:^(BOOL finished) {
        _progressView.hidden = NO;
        //----网络请求
        if (self.urlString.length > 0) {
            NSURL *url = [NSURL URLWithString:self.urlString];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
            _dataTask = [_session dataTaskWithRequest:request];
            [_dataTask resume];
        }
    }];
    _data = [[NSMutableData alloc] init];
    
}

- (void)zoomOut{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = [self convertRect:self.bounds toView:self.window];
        _fullImageView.frame = rect;
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
        _fullImageView = nil;
    }];
    
}

#pragma mark - nsurlsession data delegate

//接收到了请求的数据调用的方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [_data appendData:data];
    
    _progressView.progress = (double)dataTask.countOfBytesReceived / dataTask.countOfBytesExpectedToReceive;
    if (dataTask.countOfBytesReceived == dataTask.countOfBytesExpectedToReceive) {
        _progressView.hidden = YES;
        UIImage *image = [UIImage imageWithData:_data];
        if (image) {
            _fullImageView.image = image;
            //----如果是长图，则需自己配置其高度
            CGFloat height = image.size.height / image.size.width * kScreenWidth;
            if (height < kScreenHeight) {
                _fullImageView.top = (kScreenHeight - height) / 2;
            }
            _fullImageView.height = height;
            _scrollView.contentSize = CGSizeMake(kScreenWidth, height);
            
        }
    }
    
}

@end
