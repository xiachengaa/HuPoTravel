//
//  MeToolBar.h
//  琥珀旅行
//
//  Created by mac on 16/2/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    MeToolBarButtonTypeMigong, //迷宫一样，我也不知道是啥
    MeToolBarButtonTypeTravel,
    MeToolBarButtonTypeComment,
    MeToolBarButtonTypeMap,
}MeToolBarButtonType;

@protocol MeToolBarButtonClickDelegate <NSObject>

- (void)buttonClickAction:(MeToolBarButtonType)type;
@end

@interface MeToolBar : UIView

@property (nonatomic,weak) id<MeToolBarButtonClickDelegate> delegate;
@end
