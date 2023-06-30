//
//  ViewController.m
//  自定义转场
//
//  Created by 陈竹青 on 2022/12/5.
//

#import "ViewController.h"
#import "TestVCViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * presentBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 50)];
    presentBtn.backgroundColor = UIColor.redColor;
    [presentBtn addTarget:self action:@selector(presentClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentBtn];
}

- (void)presentClick:(id)sender{
    TestVCViewController * test = [[TestVCViewController alloc] init];
    [self.navigationController presentViewController:test animated:YES completion:nil];
}

@end
