//
//  ViewController.m
//  自定义导航栏
//
//  Created by 陈竹青 on 2021/10/11.
//

#import "ViewController.h"
#import "UIViewController+NaviExtension.h"
#import "TwoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    self.ht_backgoundColor = UIColor.redColor;
    self.ht_titleColor =  UIColor.blueColor;
    self.view.backgroundColor = UIColor.orangeColor;
    
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightClick:(id)sender{
    TwoViewController * twoVC = [[TwoViewController alloc] init];
    [self.navigationController pushViewController:twoVC animated:YES];
}

@end
