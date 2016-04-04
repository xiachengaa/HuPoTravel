//
//  StrategyCellNumberService.h
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StrategyCollectionCellModel.h"

@interface StrategyCellNumberService : NSObject

//+ (NSMutableArray *)numberServiceWithMutaArray:(NSMutableArray *)mutaArray Flag:(NSInteger )flag;

+ (NSInteger )numberServiceWithMutaArray:(NSMutableArray *)mutaArray Area:(NSInteger )number;

+ (NSMutableArray *)brownServiceWithMutaArray:(NSMutableArray *)mutaArray StrategyCollectionCellModel:(StrategyCollectionCellModel *)model;

@end
