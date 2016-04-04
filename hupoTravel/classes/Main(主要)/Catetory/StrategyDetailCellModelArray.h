//
//  StrategyDetailCellModelArray.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrategyDetailCellModelArray : NSObject

+ (NSMutableArray *)modelDataServiceWithArr:(NSArray *)array ID:(NSNumber *)placeID Flag:(BOOL )isStrategyDetail;

@end
