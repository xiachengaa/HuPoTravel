//
//  Common.h
//  hupoTravel
//
//  Created by mac on 16/2/6.
//  Copyright © 2016年 mac. All rights reserved.
//
//
//  Common.h
//  琥珀旅行
//
//  Created by mac on 16/1/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#ifndef Common_h
#define Common_h
// RGB颜色
#define MJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#ifdef DEBUG    //开发阶段
#define MJLog(...) NSLog(__VA_ARGS__)
#else   //发布阶段
#define MJLog(...)
#endif

// RGB颜色
#define HPColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//账户信息
#define kAppkey @"18402344"
#define kAppSecret @"f24d907b8e33d88ee45e1bd4aebd02b2"
#define kAppRedirectURI @"http://www.baidu.com"



#import "UIViewExt.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "JSONModel.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

/**
 *  第二界面发现界面的宏定义
 */
#define DestinationURL @"http://q.chanyouji.com/api/v2/destinations.json"
#define PlaceURL @"http://q.chanyouji.com/api/v1/search.json?q=91&search_type=destination"
#define GuideURL @"http://q.chanyouji.com/api/v1/activity_collections.json?destination_id=450"
#define DetailURL @"http://q.chanyouji.com/api/v2/activity_collections/213.json"

#define CountryVCIdentifier @"countryViewController"
#define MainNavgationControllerIdentifier @"MainNavController"
#define GuideVCIdentifier @"GuideVC"
#define DetailVCIdentifier @"DetailVC"


/**
 *  第四界面宏定义
 */
#define kHeightWithButtonBaseView 38
#define kYBaseViewButton 64
#define kWidthWithAttractionButton 152
#define kHeightWithAttractionButton 25
#define kSpacingBetweenCellWithCollectionView 12
#define kHeightWithHeaderCollectionView 48

#define kminimumInteritemSpacing 7
#define kminimumLineSpacing 7

#define kNumberCornerRadius 3

#import "TripAttractionControl.h"
#import "SDWebImageManager.h"
#import "HWDataService.h"
#import "StrategyCellNumberService.h"
#import "StrategyDetailCellModelArray.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#define HPNotificationCenter [NSNotificationCenter defaultCenter]
#endif /* Common_h */