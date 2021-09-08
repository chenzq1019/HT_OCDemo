//
//  ViewController.m
//  电影院选座
//
//  Created by 陈竹青 on 2021/7/2.
//
// Demo 引用GitHub：https://github.com/ZFbaby 的实现代码，只记录实现过程，不应用商业
#import "ViewController.h"
#import "ZFSeatViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 110, 100, 40)];
    [self.view addSubview:btn];
    [btn setTitle:@"点击跳转" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAction:(id)sender{
    ZFSeatViewController *seatsVC = [[ZFSeatViewController alloc]init];
    
    [self.navigationController pushViewController:seatsVC animated:YES];
    
}


@end
