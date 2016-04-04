//
//  DetailLayout.h
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/18.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailModel.h"
#import "WXLabel.h"

#define kImageHeight 240
#define kLineSpace 15
#define kTextLineSpace 5
#define kTextFont 14
#define kBottomHeight 20
#define kRightSpace 4

@interface DetailLayout : NSObject

@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) DetailModel *detailModel;

@end
