//
//  StrategyCollectionViewContryInside.m
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "StrategyCollectionViewContryInside.h"
#import "HeaderCollectionViewStrategy.h"
#import "BrowseCollectionViewCell.h"
#import "ImgCollectionViewCell.h"
#import "StrategyDetailViewController.h"
#import "HPNaviController.h"
#import "UIView+ViewController.h"
#import "StrategyCollectionCellModel.h"
#import "StrategyHeaderModel.h"

#define kIdentifyHeaderCollectionView @"HeaderCollectionViewStrategy"
#define kHeightHeaderCollectionCell 18
#define kHeightImgCollectionCell 180

@interface StrategyCollectionViewContryInside ()
{
    NSMutableArray *_arrayHeaderModel;
    NSMutableArray *_arrayCellModel;
    NSMutableArray *_arraySectionZeroCellModel;
    
    NSMutableArray *_arr21;
    NSMutableArray *_arr22;
}

@end

@implementation StrategyCollectionViewContryInside

- (instancetype)initWithFrame:(CGRect)frame
{
    //设置：滑动方向、头视图大小、单元格间的横向和纵向间距
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //设置头视图大小
    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, kHeightWithHeaderCollectionView);
    
    flowLayout.minimumInteritemSpacing = kminimumInteritemSpacing;
    flowLayout.minimumLineSpacing = kminimumLineSpacing;
    
    //设置距两侧的间隔————只针对单元格有效，头视图无效
    flowLayout.sectionInset = UIEdgeInsetsMake(0, kSpacingBetweenCellWithCollectionView, 0, kSpacingBetweenCellWithCollectionView);
    
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.dataSource = self;
        self.delegate = self;
        
        //头视图、单元格注册
        [self registerClass:[HeaderCollectionViewStrategy class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kIdentifyHeaderCollectionView];
        [self registerNib:[UINib nibWithNibName:@"BrowseCollectionViewCell" bundle:NULL] forCellWithReuseIdentifier:@"kIdentifyBrowseCollectionCell"];
        [self registerNib:[UINib nibWithNibName:@"ImgCollectionViewCell" bundle:NULL] forCellWithReuseIdentifier:@"kIdentifyImgCollectionCell"];
    }
    
    return self;
}

- (void)setDicData:(NSDictionary *)dicData
{
    if (_dicData != dicData) {
        
        _dicData = dicData;
        //        NSLog(@"%ld", _dicData.count);
        
        //    NSLog(@"%ld",self.arrayData.count);
        
        //*********一定要创建并初始化，否则就显示不出界面****************
        _arrayHeaderModel = [[NSMutableArray alloc] init];
        _arrayCellModel = [[NSMutableArray alloc] init];
        
        //头视图
        NSArray *arrHeader = _dicData[@"header"];
        //        NSLog(@"%@", arrHeader);
        for (NSDictionary *dic in arrHeader) {
            
            //            NSLog(@"%@", dic);
            //            StrategyHeaderModel *model = [[StrategyHeaderModel alloc] initWithDictionary:dic error:NULL];
            StrategyHeaderModel *model = [[StrategyHeaderModel alloc] init];
            
            model.contryId = dic[@"contry_id"];
            model.areaId = dic[@"id"];
            model.headerTitle = dic[@"class"];
            //            NSLog(@"%@", model);
            [_arrayHeaderModel addObject:model];
            
        }
        //            NSLog(@"----%ld", _arrayHeaderModel.count);
        
        //单元格
        NSArray *arrCell = _dicData[@"cell"];
        for (NSDictionary *dic in arrCell) {
            
            StrategyCollectionCellModel *model = [[StrategyCollectionCellModel alloc] init];
            model.contryID = dic[@"contry_id"];
            model.areaID = dic[@"class_id"];
//            NSLog(@"%@", model.areaID);
            model.placeID = dic[@"id"];
            model.imgPath = dic[@"image"];
            model.chName = dic[@"ch_name"];
            model.enName = dic[@"en_name"];
            model.placeNumber = dic[@"palce_number"];
            //            NSLog(@"%@", model);
            [_arrayCellModel addObject:model];
        }
        //        NSLog(@"-----%ld", _arrayCellModel.count);
//        NSLog(@"%@", _arrayCellModel);
        
        //第一组单元格数据：默认
        _arraySectionZeroCellModel = [NSMutableArray arrayWithCapacity:6];
        
        for (int i = 0; i < 6; i++) {
            
            [_arraySectionZeroCellModel addObject:_arrayCellModel[i]];
        }
        
        [self reloadData];
    }
}

#pragma mark - UICollection view dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    // 国内
    return _arrayHeaderModel.count;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return _arraySectionZeroCellModel.count;
    }else if (section == 1) {
        
        //        NSLog(@"%ld", [StrategyCellNumberService numberServiceWithMutaArray:_arrayCellModel Area:11]);
        
        return [StrategyCellNumberService numberServiceWithMutaArray:_arrayCellModel Area:21];
    }else if (section == 2) {
        
        return [StrategyCellNumberService numberServiceWithMutaArray:_arrayCellModel Area:22];
    }else {
        
        return 0;
    }

    
}

//头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderCollectionViewStrategy *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kIdentifyHeaderCollectionView forIndexPath:indexPath];
    headerView.headerModel = _arrayHeaderModel[indexPath.section];
    
    headerView.endXLeft = self.left + kSpacingBetweenCellWithCollectionView;
    headerView.endXRight = self.right - kSpacingBetweenCellWithCollectionView;
    
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kIdentifyImgCollectionCell" forIndexPath:indexPath];
    
    NSNumber *number;
    int i;
    
    if (indexPath.section == 0) {
        
        BrowseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kIdentifyBrowseCollectionCell" forIndexPath:indexPath];
        cell.brownCellModel = _arraySectionZeroCellModel[indexPath.item];
        
        return cell;
    }else if (indexPath.section == 1) {
        
        i = 21;
        number = [NSNumber numberWithInt:i];
        _arr21 = [StrategyDetailCellModelArray modelDataServiceWithArr:_arrayCellModel ID:number Flag:NO];
        cell.cellModel = _arr21[indexPath.item];
    }else if (indexPath.section == 2) {
        
        i = 22;
        number = [NSNumber numberWithInt:i];
        _arr22 = [StrategyDetailCellModelArray modelDataServiceWithArr:_arrayCellModel ID:number Flag:NO];
        cell.cellModel = _arr22[indexPath.item];
    }else {
        
        return NULL;
    }
    
    return cell;
}

#pragma mark - UICollection view delegate flowLayout

//单元格尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = 0;
    CGFloat height = 0;
    
    if (indexPath.section == 0) {
        
        width = (self.width - kminimumInteritemSpacing * 2 - kSpacingBetweenCellWithCollectionView * 2) / 3;
        height = kHeightHeaderCollectionCell;
        CGSize size = CGSizeMake(width, height);
        
        return size;
    }
    
    width = (self.width - kminimumInteritemSpacing - kSpacingBetweenCellWithCollectionView * 2) / 2;
    height = kHeightImgCollectionCell;
    CGSize size = CGSizeMake(width, height);
    
    return size;
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

#pragma mark - UICollection view deletate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StrategyDetailViewController *strDTC = [[StrategyDetailViewController alloc] init];
    
    strDTC.isContryOut = NO;
    StrategyCollectionCellModel *model;
    NSNumber *number;
    
    if (indexPath.section == 0) {
        
        model = _arraySectionZeroCellModel[indexPath.item];
    }
    else if (indexPath.section == 1) {
        
        model = _arr21[indexPath.item];
    }else if (indexPath.section == 2) {
        
        model = _arr22[indexPath.item];
    }else {
        
        return;
    }
    
//    NSLog(@"%@", model);
    
    //记录浏览信息
    _arraySectionZeroCellModel = [StrategyCellNumberService brownServiceWithMutaArray:_arraySectionZeroCellModel StrategyCollectionCellModel:model];
//        NSLog(@"%@", _arraySectionZeroCellModel);
    
    for (int i = 0; i < 6; i++) {
        
        BrowseCollectionViewCell *cell = self.subviews[i];
        //        cell.brownCellModel = model;
        //        _arraySectionZeroCellModel[i] = model;
        cell.brownCellModel = _arraySectionZeroCellModel[i];
    }
    
    [self reloadData];
    
    number = model.placeID;
    strDTC.placeID = number;
    
    //    HPNaviController *nav = [[HPNaviController alloc] initWithRootViewController:strDTC];
    //    [self.viewController presentViewController:nav animated:YES completion:NULL];
    
    [self.viewController.navigationController pushViewController:strDTC animated:YES];
}

@end
