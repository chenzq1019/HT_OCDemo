//
//  CustemView.m
//  绘图
//
//  Created by 陈竹青 on 2021/2/26.
//

#import "CustemView.h"

@implementation CustemView

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
//    UIBezierPath * path=[UIBezierPath bezierPathWithRect:CGRectMake(20, 210, 50, 50)];
//    CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
//    //这里跟CGPath一样需要添加
//    CGContextAddPath(ctx, path.CGPath);
//    [[UIColor redColor] setFill];
//    //绘制填充和绘制边框
//    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context,  0,100);
    CGContextAddLineToPoint(context,300,100);
    CGContextStrokePath(context);
}

@end
