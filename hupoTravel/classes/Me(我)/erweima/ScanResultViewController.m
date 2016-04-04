//
//  ScanResultViewController.m
//  LBXScanDemo
//
//  Created by lbxia on 15/11/17.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "ScanResultViewController.h"

@interface ScanResultViewController ()

- (IBAction)buttonAction:(UIButton *)sender;
@property (nonatomic, weak) UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *scanImg;
@property (weak, nonatomic) IBOutlet UILabel *labelScanText;
@property (weak, nonatomic) IBOutlet UILabel *labelScanCodeType;
@end

@implementation ScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    _scanImg.image = _imgScan;
    _labelScanText.text = _strScan;
    _labelScanCodeType.text = [NSString stringWithFormat:@"码的类型:%@",_strCodeType];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.webView.hidden = YES;
}

#pragma mark - 自定义方法

- (IBAction)buttonAction:(UIButton *)sender {
    
    self.webView.hidden = NO;
    self.webView.backgroundColor = [UIColor redColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.strScan]]];
    
    
//    [self.navigationController popViewControllerAnimated:YES];
}

- (UIWebView *)webView
{
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.hidden = YES;
        [self.view addSubview:webView];
        _webView = webView;
        
    }
    return _webView;
}



@end
