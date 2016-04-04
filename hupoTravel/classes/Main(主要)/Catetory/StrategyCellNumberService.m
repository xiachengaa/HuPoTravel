//
//  StrategyCellNumberService.m
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "StrategyCellNumberService.h"
#import "StrategyCollectionCellModel.h"

@implementation StrategyCellNumberService

//+(NSMutableArray *)numberServiceWithMutaArray:(NSMutableArray *)mutaArray Flag:(NSInteger)flag
//{
//    
//    if (flag == 0) {
//        
//        //国外
//        NSInteger i,j,k = 0;
//        for (StrategyCollectionCellModel *model in mutaArray) {
//    
//            NSString *str = model.areaID;
//            if ([str isEqualToString:@"11"]) {
//                
//                i++;
//            }
//            if ([str isEqualToString:@"12"]) {
//                
//                j++;
//            }
//            if ([str isEqualToString:@"13"]) {
//                
//                k++;
//            }
//        }
//        
//        NSNumber *num1 = [NSNumber numberWithInteger:i];
//        NSNumber *num2 = [NSNumber numberWithInteger:j];
//        NSNumber *num3 = [NSNumber numberWithInteger:k];
//        NSMutableArray *array = [NSMutableArray arrayWithObjects:num1,num2,num3, nil];
//        return array;
//        
//    } else {
//        
//        //国内
//        NSInteger i,j = 0;
//        for (StrategyCollectionCellModel *model in mutaArray) {
//            
//            NSString *str = model.areaID;
//            if ([str isEqualToString:@"21"]) {
//                
//                i++;
//            }
//            if ([str isEqualToString:@"22"]) {
//                
//                j++;
//            }
//        }
//        
//        NSNumber *num1 = [NSNumber numberWithInteger:i];
//        NSNumber *num2 = [NSNumber numberWithInteger:j];
//        NSMutableArray *array = [NSMutableArray arrayWithObjects:num1,num2, nil];
//        return array;
//        
//    }
//}

+ (NSInteger)numberServiceWithMutaArray:(NSMutableArray *)mutaArray Area:(NSInteger )number
{
    NSInteger i = 0;
    for (StrategyCollectionCellModel *model in mutaArray) {
        
//        NSString *str = model.areaID;
        
        if ([model.areaID integerValue]== number) {
            
            i++;
            
//            NSLog(@"----%ld", i);
        }
    }
    
    return i;
}

//注：在类方法中，应该定义一个实例对象去调用实例方法————类方法中，self为类对象
//- (NSMutableArray *)sortOrderWithMutaArray:(NSMutableArray *)arr Index:(NSInteger )index
//{
//    
//}

+ (NSMutableArray *)brownServiceWithMutaArray:(NSMutableArray *)mutaArray StrategyCollectionCellModel:(StrategyCollectionCellModel *)model
{
    
    NSMutableArray *arr = mutaArray;
//    StrategyCollectionCellModel *cellModel;
    
    for (StrategyCollectionCellModel *modelIn in arr) {
        
        int modelInInt = [modelIn.placeID intValue];
        int modelInt = [model.placeID intValue];
        
        if (modelInInt == modelInt) {
            
            //浏览了重复的国家(国外页面)或城市(国内页面)
            [arr removeObject:modelIn];
            [arr insertObject:model atIndex:0];
            
            
            //以下排序方法有问题
//            NSInteger index = [arr indexOfObject:modelIn];
//            for (NSInteger i = index; i > 0; i--) {
//                
//                arr[i] = arr[i - 1];
//                
//                NSLog(@"arr[%ld] = %@", i, arr[i]);
//            }
//            arr[0] = modelIn;
//            NSLog(@"arr[0] = %@", arr[0]);
            
//            break;
            return arr;
        }//else {
            
            //浏览了新的国家或城市
            //return NULL;
        //}
    }
    
    //浏览了新的国家或城市
    [arr removeLastObject];
    [arr insertObject:model atIndex:0];
    
//    for (NSInteger i = arr.count; i > 0; i--) {
//        
//        arr[i] = arr[i - 1];
//    }
//    arr[0] = model;
    
//    NSLog(@"arr.count----%ld", arr.count);
    
    return arr;
}



@end
