//
//  MarkCollectionView.m
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MarkCollectionView.h"
#import "MarkViewController.h"

@implementation MarkCollectionView


- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        _markVC = [[MarkViewController alloc] init];
        
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"markCollectionCell"];
        
    }
    return self;
}

//- (void)setDistricts:(NSArray *)districts
//{
//    if (_districts != districts) {
//        _districts = districts;
//    }
//    [self reloadData];
//}

- (void)setCategories:(NSArray *)categories
{
    if (_categories != categories) {
        _categories = categories;
        [self createArray];
    }
    [self reloadData];
}

- (void)createArray
{
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc] initWithCapacity:10];

        for (int i = 0; i < 10; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( 5, 0, 80, 20)];
            [button setTitleColor:[UIColor colorWithRed:180.0/255 green:180.0/255 blue:180.0/255 alpha:1] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setBackgroundColor:[UIColor colorWithRed:220.0/255 green:232.0/255 blue:235.0/255 alpha:1]];
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 10;
            [button addTarget:self action:@selector(markButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonArray addObject:button];
            
        }
    }
}

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }
    return nil;
}

- (void)markButtonAction:(UIButton *)sender
{
    NSString *result = [self findID:sender];
    _markVC.idNumber = result;
    [[self viewController].navigationController pushViewController:_markVC animated:YES];
}

- (NSString *)findID:(UIButton *)sender
{
    
    for (int i = 0; i < _districts.count; i++) {
        if([[_districts[i] objectForKey:@"name"] isEqualToString:sender.titleLabel.text])
        {
            NSNumber *result = [_districts[i] objectForKey:@"id"];
            return [NSString stringWithFormat:@"district_id=%@",result];
        }
    }
    for (int i = 0; i < _categories.count; i++) {
        if([[_categories[i] objectForKey:@"name"] isEqualToString:sender.titleLabel.text])
        {
            NSNumber *result = [_categories[i] objectForKey:@"id"];
            return [NSString stringWithFormat:@"category_id=%@",result];
        }
    }
    return 0;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _categories.count + _districts.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"markCollectionCell" forIndexPath:indexPath];
    


    if (indexPath.item < _districts.count) {
        if (_buttonArray.count > 0) {

            UIButton *button = _buttonArray[indexPath.item];
            [button setTitle:[_districts[indexPath.item] objectForKey:@"name"] forState:UIControlStateNormal];
            [cell.contentView addSubview:button];
        }

    }

    
    if ((indexPath.item >= _districts.count) && (indexPath.item < _categories.count + _districts.count))
    {
        if (_buttonArray.count > 0)
        {
            UIButton *button = _buttonArray[indexPath.item];
            [button setTitle:[_categories[indexPath.item - _districts.count] objectForKey:@"name"] forState:UIControlStateNormal];
            [cell.contentView addSubview:button];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(90, CGRectGetHeight(self.frame));
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
