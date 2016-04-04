//
//  HPTabBar.h
//  琥珀旅行
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//定义一个block
typedef void(^BtnBlock)();
@interface HPTabBar : UITabBar



@property (nonatomic, copy) BtnBlock btnBlock;
@end
