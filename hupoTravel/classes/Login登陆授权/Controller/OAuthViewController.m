//
//  OAuthViewController.m
//  琥珀旅行
//
//  Created by mac on 16/2/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "HPTabBarController.h"
#import "MJAccount.h"
@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=18402344&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.delegate = self;
    [webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    MJLog(@"请求开始");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    MJLog(@"加载完成");
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //    MJLog(@"%@",request.URL.absoluteString);
    //这个方法会多次调用，去网络点击数据，当我们点击登录(第一次为授权点击)的时候，会产生一个带有code的url，我们需要拿到这个code换取access_token
    NSString *url = request.URL.absoluteString;
    
    NSRange codeRange = [url rangeOfString:@"code="];
    
    if (codeRange.length > 0) {
        //即里面含有这个code
        NSInteger index = codeRange.location + codeRange.length;
        NSString *code = [url substringFromIndex:index];
        
        //        MJLog(@"%@",code);
        //        获取到这个code之后就可以开始进行access_token的访问
        //封装一个方法进行访问
        [self requestAccesstokenWithCode:code];
        
        //这一步是为了防止跳转到百度界面
        return NO;
    }
    
    return YES;
}



/*
 URL：https://api.weibo.com/oauth2/access_token
 
 请求参数：
 client_id：申请应用时分配的AppKey
 client_secret：申请应用时分配的AppSecret
 grant_type：使用authorization_code
 redirect_uri：授权成功后的回调地址
 code：授权成功后返回的code
 */
- (void)requestAccesstokenWithCode:(NSString *)code
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = kAppkey;
    parameters[@"client_secret"] = kAppSecret;
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"redirect_uri"] = kAppRedirectURI;
    parameters[@"code"] = code;
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        
        MJAccount *account = [MJAccount accountWithDictionary:(NSDictionary *)responseObject];
        //获取到access_token后存储到文件中
        //1.获取到doucuments路径
        //       NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //        NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
        //
        //
        //        //对象的存储必须用到archiver
        //         [NSKeyedArchiver archiveRootObject:account toFile:path];
        [MJAccount saveAccount:account];
        //跳转到主界面
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = [[HPTabBarController alloc]init];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    //    Error Domain=com.alamofire.error.serialization.response Code=-1016 "Request failed: unacceptable content-type: text/plain"
    //第一次会出现这样的错误，是因为新浪返回的是text/plain，但是manager里的responseSerializer中的acceptableContentTypes这个NSSet属性里面没有这个text/plain格式，所以我们要转换
    //方法1[AFJSONResponseSerializer serializer]点进去往下找就能看到，在里面添加
}

@end
