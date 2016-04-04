//
//  StrategyDetailCellModelArray.m
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "StrategyDetailCellModelArray.h"
#import "StrategyDetailCollectionCellModel.h"
#import "StrategyCollectionCellModel.h"

@implementation StrategyDetailCellModelArray

+ (NSMutableArray *)modelDataServiceWithArr:(NSMutableArray *)arrModel ID:(NSNumber *)placeID Flag:(BOOL)isStrategyDetail
{
    NSMutableArray *arr = [NSMutableArray array];
    
    if (isStrategyDetail) {
        
        for (StrategyDetailCollectionCellModel *model in arrModel) {
            
            if ([model.placeID intValue] == [placeID intValue]) {
                
                [arr addObject:model];
            }
        }
    }else {
        
        for (StrategyCollectionCellModel *model in arrModel) {
            
            if ([model.areaID intValue] == [placeID intValue]) {
                
                [arr addObject:model];
            }
        }
    }
    
    return arr;
}

@end
