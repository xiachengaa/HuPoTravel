
//
//  TripViewController.m
//  琥珀旅行
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TripViewController.h"
#import "StrategyCollectionView.h"
#import "StrategyCollectionViewContryInside.h"

@interface TripViewController ()
{
    UIView *_baseViewButton;
    UIImageView *_selectImgView;
    UIView *_baseViewWithInterface;
    StrategyCollectionView *_collectionViewOutSide;
    StrategyCollectionViewContryInside *_collectionViewInSide;
    
    NSInteger _flagInterface;
    NSDictionary *_dicStrategyData;
}

@end

@implementation TripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //数据请求————注：此处数据请求必须在“国内外基础视图”创建之前，否则界面拿不到数据
    _dicStrategyData = [HWDataService DataService:@"contry_out_and_inside.json"];
//        NSLog(@"%@", _dicStrategyData);
    //    NSLog(@"%@", _dicStrategyData[@"contry_out"]);
    
    //背景颜色
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    
    // 设置导航栏
    [self _setNavBar];
    
    //创建国内、国外button
    [self _createAttractionButton];
//    [self _createSegmented];
    
    //创建国内外基础视图
    [self _createBaseViewWithInterface];
    
    
}

- (void)_setNavBar
{
//    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    
    NSDictionary *textAttr = @{
                               NSForegroundColorAttributeName : [UIColor blackColor]
                               };
    self.navigationController.navigationBar.titleTextAttributes = textAttr;
}

- (void)_createSegmented
{
    
    UISegmentedControl *segCt = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, kYBaseViewButton, kScreenWidth, kHeightWithButtonBaseView)];
    [self.view addSubview:segCt];
}

- (void)_createAttractionButton
{
    
    //按钮底部视图
    _baseViewButton = [[UIView alloc] initWithFrame:CGRectMake(0, kYBaseViewButton, kScreenWidth, kHeightWithButtonBaseView)];
    _baseViewButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baseViewButton];
    
    //国外按钮
    NSInteger flag = 0;
    CGFloat x0 = (kScreenWidth - kWidthWithAttractionButton * 2)/2.0;
    CGFloat y0 = (kHeightWithButtonBaseView - kHeightWithAttractionButton)/2.0;
    [self _createButtonWithX:x0 Y:y0 Flag:flag];
    
    //国内按钮
    flag = 1;
    CGFloat x1 = x0 + kWidthWithAttractionButton;
    CGFloat y1 = y0;
    [self _createButtonWithX:x1 Y:y1 Flag:flag];
    
}

//创建按钮
- (void)_createButtonWithX:(CGFloat )x Y:(CGFloat )y Flag:(NSInteger )flag
{
    TripAttractionControl *button = [[TripAttractionControl alloc] initWithFrame:CGRectMake(x, y, kWidthWithAttractionButton, kHeightWithAttractionButton) imageName:@"AttractionButton_Pressed@3x.png"];
    
    if (flag == 0) {
        
        [button configButtonTitle:@"国外"];
        button.titleLabel.textColor = [UIColor blueColor];
        button.tag = 100;
        button.userInteractionEnabled = NO;
    }else {
        
        [button configButtonTitle:@"国内"];
        button.titleLabel.textColor = [UIColor blackColor];
        button.tag = 101;
        button.userInteractionEnabled = YES;
    }
    
    [_baseViewButton addSubview:button];
    
    //创建选择图片
    if (flag == 0 && _selectImgView == nil) {
        
        _selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidthWithAttractionButton, kHeightWithAttractionButton)];
        _selectImgView.image = [UIImage imageNamed:@"AttractionButton@3x.png"];
        [button insertSubview:_selectImgView aboveSubview:button.imgView];
        
    }
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_createBaseViewWithInterface
{
    _flagInterface = 0;
    _baseViewWithInterface = [[UIView alloc] initWithFrame:[self _interfaceFrame]];
    [self.view addSubview:_baseViewWithInterface];
    
    _flagInterface = 1;
    //国内界面必须加载在国外界面之前(下标：前者0，后者1)————因为国外界面要先显示
    //加载国内界面
    [self _createInterfaceInSide];
    
    //加载国外界面
    [self _createInterfaceOutSide];
}

//国内界面创建
- (void)_createInterfaceInSide
{
    _collectionViewInSide = [[StrategyCollectionViewContryInside alloc] initWithFrame:[self _interfaceFrame]];
    _collectionViewInSide.hidden = YES;
    _collectionViewInSide.dicData = _dicStrategyData[@"contry_inside"];
    [_baseViewWithInterface addSubview:_collectionViewInSide];
}

//国外界面创建
- (void)_createInterfaceOutSide
{
    _collectionViewOutSide = [[StrategyCollectionView alloc] initWithFrame:[self _interfaceFrame]];
//    collectionView.isContryInside = NO;
//    _collectionViewOutSide.hidden = NO;
    _collectionViewOutSide.dicData = _dicStrategyData[@"contry_out"];
//    NSLog(@"%ld", _collectionViewOutSide.dicData.count);
    [_baseViewWithInterface addSubview:_collectionViewOutSide];
}

//界面切换
- (void)_exchangeWithIntefaceView:(UIView *)forView Flag:(BOOL )flag
{
    
    [forView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"cube";
    if (flag) {
        
        transition.subtype = kCATransitionFromLeft;
    } else {
        
        transition.subtype = kCATransitionFromRight;
    }
    transition.speed = 1;
    [forView.layer addAnimation:transition forKey:nil];
}

//国内外界面frame
- (CGRect )_interfaceFrame
{
    CGFloat y;
    CGFloat height;
    if (_flagInterface == 0) {
        
        //国内外界面的承载界面
        y = CGRectGetMaxY(_baseViewButton.frame);
        height= kScreenHeight - y - CGRectGetHeight(self.tabBarController.tabBar.frame);
    } else {
        
        //国内外界面
        y = 0;
        height = CGRectGetHeight(_baseViewWithInterface.frame);
    }
    
    
    CGRect frame = CGRectMake(0, y, kScreenWidth, height);
    
    return frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (void)buttonAction:(TripAttractionControl *)button
{
    
    if (_selectImgView != nil) {
        
        //国内外按钮切换
        for (TripAttractionControl *control in _baseViewButton.subviews) {
            
            control.titleLabel.textColor = [UIColor blackColor];
        }
        
        [button insertSubview:_selectImgView aboveSubview:button.imgView];
        
//        if (_selectImgView.left != button.imgView.left) {
//        
//            _selectImgView.left = button.imgView.left;
//            [button insertSubview:_selectImgView aboveSubview:button.imgView];
        if (button.tag == 100) {
            _collectionViewOutSide.hidden = NO;
            _collectionViewInSide.hidden = YES;
            [self _exchangeWithIntefaceView:_baseViewWithInterface Flag:_collectionViewOutSide.hidden];
            button.userInteractionEnabled = NO;
            UIButton *but = [button.superview viewWithTag:101];
            but.userInteractionEnabled = YES;
        }
        if (button.tag == 101) {
            _collectionViewOutSide.hidden = YES;
            _collectionViewInSide.hidden = NO;
            [self _exchangeWithIntefaceView:_baseViewWithInterface Flag:_collectionViewOutSide.hidden];
            button.userInteractionEnabled = NO;
            UIButton *but = [button.superview viewWithTag:100];
            but.userInteractionEnabled = YES;

        }
     
//        }
        
        button.titleLabel.textColor = [UIColor blueColor];
        
    }
}

@end
