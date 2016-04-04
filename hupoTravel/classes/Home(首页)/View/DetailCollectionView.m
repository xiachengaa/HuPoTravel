//
//  DetailCollectionView.m
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DetailCollectionView.h"
#import "UIImageView+WebCache.h"
#import "ZoomShowImageView.h"
#define kImageWidth 150

@implementation DetailCollectionView

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
        
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
        
    }
    return self;
}

- (void)setContents:(NSArray *)contents
{
    if (_contents != contents) {
        _contents = contents;
        [self createImageArray];
    }
    [self reloadData];
}
//---寻找到控制器作为响应者
//- (UIViewController *)viewController
//{
//    UIResponder *next = self.nextResponder;
//    while (next != nil) {
//        if ([next isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)next;
//        }
//        next = next.nextResponder;
//    }
//    return nil;
//}

- (void)createImageArray
{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] initWithCapacity:8];
        for (int i = 0; i < 8; i++) {
            ZoomShowImageView *imageView = [[ZoomShowImageView alloc] init];
            [_imageArray addObject:imageView];
            
        }
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_contents.count == 0) {
        return 0;
    }
    return _contents.count - 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    if (_imageArray) {
        ZoomShowImageView *imageView = _imageArray[indexPath.item];
        imageView.frame = CGRectMake(0, 0, cell.frame.size.width - 2, cell.frame.size.height);
        
        NSURL *url = [NSURL URLWithString:[_contents[indexPath.row + 1] objectForKey:@"photo_url"]];
        [imageView sd_setImageWithURL:url];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:imageView];
    }

    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kImageWidth, CGRectGetHeight(self.frame));
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
