//
//  TestOneVC.m
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2021/12/10.
//

#import "TestOneVC.h"
#import "HTVCTools.h"


@interface TestOneVC ()

@end

@implementation TestOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 40)];
    btn.backgroundColor= [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)sender{
    NSLog(@"click");
    UIViewController * currentVC = [HTVCTools findNextViewControllerByResponder:sender.nextResponder];
    
    NSLog(@"%@",currentVC);
}


@end
