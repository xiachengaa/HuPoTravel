//
//  HeaderCollectionViewStrategy.m
//  琥珀旅行
//
//  Created by 卢育彪 on 16/2/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HeaderCollectionViewStrategy.h"
#import "StrategyHeaderModel.h"

#define kWidthLine 0.2

@interface HeaderCollectionViewStrategy ()
{
    CGFloat _startXLeft;
    CGFloat _startXRight;
    CGFloat _y;
    UILabel *_label;
}

@end

@implementation HeaderCollectionViewStrategy

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        /*图形创建的先后顺序：
         init方法中，创建label(frame为zero)——>setHeaderModel方法中，配置label属性(根据字体大小重置frame)——>根据label的frame绘制线条
         */
        
        //中间字体
        [self _createText];
        
//        //左右线条
//        [self _createLine];
    }
    
    return self;
}

- (void)_createText
{
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
//    _label.text = @"最近浏览";
//    _label.text = _headerModel.headerTitle;
    _label.font = [UIFont systemFontOfSize:11];
//    _label.textColor = [UIColor whiteColor];
//    [_label sizeToFit];
////    _label.center = self.center;//这样做会出问题，达不到预期效果
//    CGFloat width = CGRectGetWidth(_label.frame);
//    CGFloat height = CGRectGetHeight(_label.frame);
//    CGFloat x = (self.frame.size.width - width) / 2;
//    CGFloat y = (self.frame.size.height - height) / 2;
//    CGRect frame = CGRectMake(x, y, width, height);
//    _label.frame = frame;
    [self addSubview:_label];
}

- (void)_createLine
{
    _y = CGRectGetMidY(_label.frame);
    
    //左线条
    _startXLeft = _label.left - kminimumInteritemSpacing;
    
    //右线条
    _startXRight = _label.right + kminimumInteritemSpacing;
    
    //调用drawRect方法开始绘制
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    /*
     1.获取图形上下文context；
     2.创建路径path：
       2.1确定起点；
       2.2添加终点；
       2.3添加path至context；
     3.属性配置：
       3.1线条颜色；
       3.2线条宽度；
     4.绘图；
     5.释放path；
     */
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //左线条
    CGMutablePathRef pathLeft = CGPathCreateMutable();
    CGPathMoveToPoint(pathLeft, NULL, _startXLeft, _y);
    CGPathAddLineToPoint(pathLeft, NULL, _endXLeft, _y);
    CGContextAddPath(context, pathLeft);
    
    //右线条
    CGMutablePathRef pathRight = CGPathCreateMutable();
    CGPathMoveToPoint(pathRight, NULL, _startXRight, _y);
    CGPathAddLineToPoint(pathRight, NULL, _endXRight, _y);
    CGContextAddPath(context, pathRight);
    
    [[UIColor lightGrayColor] setStroke];
    CGContextSetLineWidth(context, kWidthLine);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    CGPathRelease(pathLeft);
    CGPathRelease(pathRight);
}

- (void)setHeaderModel:(StrategyHeaderModel *)headerModel
{
    if (_headerModel != headerModel) {
        
        _headerModel = headerModel;
        
        //        //中间字体
        //        [self _createText];
        //
        //        //左右线条
        //        [self _createLine];
        
        [self _configLabel];
        
        //左右线条
        [self _createLine];
    }
}

- (void)_configLabel
{
    _label.text = _headerModel.headerTitle;
    [_label sizeToFit];
    //    _label.center = self.center;//这样做会出问题，达不到预期效果
    CGFloat width = CGRectGetWidth(_label.frame);
    CGFloat height = CGRectGetHeight(_label.frame);
    CGFloat x = (self.frame.size.width - width) / 2;
    CGFloat y = (self.frame.size.height - height) / 2;
    CGRect frame = CGRectMake(x, y, width, height);
    _label.frame = frame;
}

@end
