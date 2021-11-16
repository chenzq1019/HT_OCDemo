//
//  ViewController.m
//  绘图
//
//  Created by 陈竹青 on 2021/2/26.
//

#import "ViewController.h"
#import "CustemView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustemView * custemView = [[CustemView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 400)];
    custemView.backgroundColor = UIColor.whiteColor;
//    [self.view addSubview:custemView];
    
    CAShapeLayer * shapelayer = [[CAShapeLayer alloc] init];
    shapelayer.frame= CGRectMake(100, 200, 200, 200);
    
    //A
    CGPoint A = CGPointMake(10, 10);
    //B
    CGPoint B = CGPointMake(10, 100);
    //C
    CGPoint C = CGPointMake(100, 100);
    //D
    CGPoint D = CGPointMake(100, 10);
    
    CGMutablePathRef path= CGPathCreateMutable();
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, A.x, 50);
    CGPathAddArcToPoint(path, &CGAffineTransformIdentity, B.x, B.y, C.x, C.y, 20);
    CGPathAddArcToPoint(path, &CGAffineTransformIdentity, C.x, C.y, D.x, D.y, 20);
    CGPathAddArcToPoint(path, &CGAffineTransformIdentity, D.x, D.y, A.x, A.y, 20);
    CGPathAddArcToPoint(path, &CGAffineTransformIdentity, A.x, A.y, B.x, B.y, 20);

    CGPathCloseSubpath(path);
    
    shapelayer.path = path;
    shapelayer.strokeColor = UIColor.redColor.CGColor;
    shapelayer.fillColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
    shapelayer.lineWidth = 1;
    CFRelease(path);
    [self.view.layer addSublayer:shapelayer];
    
}


@end
