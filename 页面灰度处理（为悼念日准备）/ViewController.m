//
//  ViewController.m
//  页面灰度处理（为悼念日准备）
//
//  Created by 陈竹青 on 2021/12/13.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 40)];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(220, 100, 100, 40)];
    title.textColor = [UIColor blackColor];
    title.text = @"我的颜色是黑色";
    [self.view addSubview:title];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, 100, 100)];
    imageView.image = [UIImage imageNamed:@"background_update_top"];
    [self.view addSubview:imageView];
}


@end
