//
//  SectondViewController.m
//  Runloop线程常驻
//
//  Created by 陈竹青 on 2021/6/8.
//

#import "SectondViewController.h"
#import "MyThread.h"
@interface SectondViewController ()
@property (nonatomic, strong) MyThread * testThread;
@end

@implementation SectondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.yellowColor;
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 40)];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor= UIColor.redColor;
    [self.view addSubview:btn];
    
    self.testThread = [[MyThread alloc] init];
    [self.testThread run];
    
}

- (void)click:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.testThread executeTask:^{
        NSLog(@"在子线程中执行任务");
    }];
}

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}
@end
