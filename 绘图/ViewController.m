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
    [self.view addSubview:custemView];
}


@end
