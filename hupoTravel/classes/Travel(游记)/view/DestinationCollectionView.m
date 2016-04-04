//
//  DestinationCollectionView.m
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/6.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import "DestinationCollectionView.h"
#import "PlaceCell.h"
#import "SectionReusableView.h"
#import "CountryViewController.h"
#import "ScenicSpotViewController.h"

#define kWidthSpace 20

#define CellReuseIdentifier @"placeCell"
#define SectionHeaderViewReuseIdentifier @"SectionHeaderViewCell"
#define SectionFooterViewReuseIdentifier @"SectionFooterViewCell"


@interface DestinationCollectionView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation DestinationCollectionView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupConfig];
    }
    return self;
}

- (void)setupConfig{
    self.delegate = self;
    self.dataSource = self;
    self.modelDic = [NSDictionary dictionary];
}

- (UIViewController *)viewController{
    
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder != nil);
    return nil;
}

//自定义push动画
- (void)transitionPush{
    CATransition *tran = [CATransition animation];
    tran.duration =.4;
    tran.type = kCATransitionMoveIn;
    tran.subtype = kCATransitionFromTop;
    [((ScenicSpotViewController *)[self viewController]).navigationController.view.layer addAnimation:tran forKey:nil];
}

#pragma mark - collectionView dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSLog(@"%ld",[_modelDic allKeys].count);
    return [_modelDic allKeys].count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = [_modelDic objectForKey:[_modelDic allKeys][section]];
    return array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PlaceCell *cell = [self dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    cell.model = [_modelDic objectForKey:[_modelDic allKeys][indexPath.section]][indexPath.row];
    return cell;
}

////注意！！！这不是代理方法，这是UICollectionView中的一个方法，需要自己调用
//- (UICollectionReusableView *)supplementaryViewForElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *reuseView = nil;
//    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
//        SectionReusableView *headerView = [self dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:SectionHeaderViewReuseIdentifier forIndexPath:indexPath];
//        headerView.name = [_modelDic allKeys][indexPath.section];
//        reuseView = headerView;
//    }
//    return reuseView;
//}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reuseView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SectionReusableView *headerView = [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:SectionHeaderViewReuseIdentifier forIndexPath:indexPath];
        headerView.name = [_modelDic allKeys][indexPath.section];
        reuseView = headerView;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        reuseView = [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:SectionFooterViewReuseIdentifier forIndexPath:indexPath];
    }
    return reuseView;
}

#pragma mark - UICollectionView delegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake((kScreenWidth - kWidthSpace * 2) / 3, kScreenWidth / 3 + kWidthSpace);
    return size;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 20);
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //----跳转出模态视图，并将点击的单元格对应model的id传入模态视图中用于请求数据
    UIStoryboard *countrySB = [UIStoryboard storyboardWithName:@"ScenicSpot" bundle:nil];
    CountryViewController *countryVC = [countrySB instantiateViewControllerWithIdentifier:CountryVCIdentifier];
    
//    UINavigationController *nav = [countrySB instantiateViewControllerWithIdentifier:@"NavController"];
//    CountryViewController *countryVC = (CountryViewController *)nav.topViewController;
    countryVC.navigationController.navigationBar.hidden = NO;
    NSArray *areaArray = _modelDic[[_modelDic allKeys][indexPath.section]];
    DestinationModel *model = areaArray[indexPath.row];
    countryVC.cityID = model.ID;
    countryVC.cityName = model.name;
    countryVC.searchDataDic = self.searchDataDic;
    
    [self transitionPush];
    [((ScenicSpotViewController *)[self viewController]).navigationController pushViewController:countryVC animated:NO];
}


@end
