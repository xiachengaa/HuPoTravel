//
//  HomeLayoutModel.h
//  琥珀旅行
//
//  Created by 李迪琛 on 16/2/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"

@interface HomeLayoutModel : NSObject

@property (nonatomic, strong)HomeModel *homeModel;

@property (nonatomic, assign)CGRect textFrame;      //正文内容
@property (nonatomic, assign)CGRect titleFrame;     //正文标题
@property (nonatomic, assign)CGFloat bigImageHeight;    //大图高度
@property (nonatomic, assign) BOOL isAll;   //是否展开
@property (nonatomic, copy) NSString *followStr;  //关注情况

@property (nonatomic, assign)CGRect collectionViewFrame;   //collectionView位置
//@property (nonatomic, strong)NSURL *firstIVURL;



@end
