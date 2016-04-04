//
//  SectionReusableView.h
//  琥珀旅行游记
//
//  Created by 朱晓涵 on 16/2/6.
//  Copyright © 2016年 朱晓涵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *areaName;
@property (nonatomic, copy) NSString *name;

@end
