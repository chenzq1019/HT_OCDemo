//
//  ViewController.m
//  Runloop线程常驻
//
//  Created by 陈竹青 on 2021/6/8.
//

#import "ViewController.h"
#import "MyThread.h"
#import "SectondViewController.h"
@interface ViewController ()
@property (nonatomic, strong) MyThread * testThread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.testThread = [[MyThread alloc]initWithBlock:^{
//        
//    }];
//    [self.testThread run];
//    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 40)];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor= UIColor.redColor;
    [self.view addSubview:btn];
}

- (void)click:(id)sender{
    SectondViewController * vc = [[SectondViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
