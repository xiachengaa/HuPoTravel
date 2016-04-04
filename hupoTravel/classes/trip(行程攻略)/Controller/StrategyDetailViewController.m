//
//  StrategyDetailViewController.m
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "StrategyDetailViewController.h"
#import "StrategyDetailCollectionViewCell.h"
#import "StrategyDetailCollectionCellModel.h"
#import "StrategyDetailCellModelArray.h"

#define kSpaceWithCollectionCellToTopAndBottom 8
#define kSpaceWithCollectionCellToRightAndLeft 9
#define kHeightCollectionCell 230//此处必须与xib文件中的cell高度保持一致
#define kLineSpaceWithStrategyCollectionCell 6

@interface StrategyDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSDictionary *_dic;
    NSMutableArray *_arrayContryOutContryData;
    NSMutableArray *_arrayContryInsideCityData;
}

@end

@implementation StrategyDetailViewController

- (instancetype)init
{
    if (self = [super init]) {
        
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"日本攻略";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = kLineSpaceWithStrategyCollectionCell;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(kSpaceWithCollectionCellToTopAndBottom, kSpaceWithCollectionCellToRightAndLeft, kSpaceWithCollectionCellToTopAndBottom, kSpaceWithCollectionCellToRightAndLeft);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self.view addSubview:_collectionView];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"StrategyDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    //数据加载
    [self _loadData];
}

//- (void)setPlaceID:(NSNumber *)placeID
//{
//    if (placeID != placeID) {
//        
//        _placeID = placeID;
//        
////        [self _loadData];
//    }
//}

//页面数据
- (void)_loadData
{
    _dic = [HWDataService DataService:@"strategyDetail.json"];
//    NSLog(@"%ld", dic.count);
    
    //国外国家
    _arrayContryOutContryData = [self _catchDataWithName:@"contry_out"];
    
    //国内城市
    _arrayContryInsideCityData = [self _catchDataWithName:@"contry_inside"];
    
    [_collectionView reloadData];
}

- (NSMutableArray *)_catchDataWithName:(NSString *)name
{
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *arrayAllData = [NSMutableArray array];//切记
    
    NSArray *arrContryOut = _dic[name];
    //    NSLog(@"%ld", arrContryOut.count);
    
    for (NSDictionary *dic in arrContryOut) {
        
        StrategyDetailCollectionCellModel *model = [[StrategyDetailCollectionCellModel alloc] init];
        model.placeID = dic[@"place_id"];
        model.chName = dic[@"ch_name"];
        model.enName = dic[@"en_name"];
        model.imgPath = dic[@"image"];
        
        //        NSLog(@"%@", model);
        [arrayAllData addObject:model];
    }
    
    //    NSLog(@"%ld", arrayAllData.count);
    arr = [StrategyDetailCellModelArray modelDataServiceWithArr:arrayAllData ID:_placeID Flag:YES];
    
    return arr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollection view dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.isContryOut) {
        
        return _arrayContryOutContryData.count;
    }else {
        
        return _arrayContryInsideCityData.count;
    }
}

//头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    return NULL;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    StrategyDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor cyanColor];
    
    if (self.isContryOut) {
        
        cell.model = _arrayContryOutContryData[indexPath.item];
    }else {
        
        cell.model = _arrayContryInsideCityData[indexPath.item];
    }
    
    return cell;
}

#pragma mark - UICollection view delegate flowLayout

//单元格大小设置
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = 0;
    CGFloat height = 0;
    
    width = _collectionView.frame.size.width -  kSpaceWithCollectionCellToRightAndLeft * 2;
    height = kHeightCollectionCell;
    CGSize size = CGSizeMake(width, height);
    
    return size;
}

@end
