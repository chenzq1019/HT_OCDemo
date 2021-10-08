//
//  ViewController.m
//  NSOperationDemo
//
//  Created by 陈竹青 on 2021/9/29.
//

#import "ViewController.h"
#import "CustemOperation.h"
#import "HTAlerView.h"
#import "HTAlertViewManager.h"
#import "SubViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) NSOperationQueue * kvoqueue;
@end

@implementation ViewController
- (void)addNewAlertView{
    HTAlerView * alertView = [[HTAlerView alloc] initWithFrame:CGRectMake(0, 0, 250, 300)];
    alertView.backgroundColor = UIColor.yellowColor;
    [HTAlertViewManager addCustomAlertView:alertView];
}

- (void)showNewAlertView{
    [HTAlertViewManager showAlertView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
    [btn setTitle:@"增加AlertView" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.redColor;
    [btn addTarget:self action:@selector(addNewAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton * btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 250, 200, 40)];
    [btn1 setTitle:@"显示AlertView" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.blueColor;
    [btn1 addTarget:self action:@selector(showNewAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    // Do any additional setup after loading the view.
//    [self testInvocationOperation];
    
//    [self testBlockOperation];
    
//    [self testCustemOperation];
    
//    [self testInvocationOperationAndOperationQueue];
    
//    [self testBlockOperationAndOperationQueue];
    
//    [self testCustemOperationAndOperationQueue];
    
//    [self testDependencyOperationQueue];
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
//    [self.view addSubview:self.imageView];
//
//    [self testDownloadImage];
    
//    [self testKVOForNSOperationQueue];
    
//    [[HTAlertViewManager sharedManager] suspendShowAlert];
    [self testAlertGroupManager];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        HTAlerView * alertView4 = [[HTAlerView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        alertView4.backgroundColor = [UIColor cyanColor];
        alertView4.clickBLock = ^{
            SubViewController * subVC = [[SubViewController alloc] init];
            [self.navigationController pushViewController:subVC animated:YES];
            [HTAlertViewManager suspendShowAlert];
        };
        [HTAlertViewManager addCustomAlertView:alertView4 priority:HTAlertPriorityVeryHigh identify:@""];
    });
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [HTAlertViewManager showAlertView];
}

//NSINvocationOperation

- (void)testInvocationOperation{
    //1、创建操作，封装任务
    
    NSInvocationOperation * op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation1) object:nil];
    NSInvocationOperation * op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation2) object:nil];
    NSInvocationOperation * op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation3) object:nil];
    
    //启动，执行操作
    
    [op1 start];
    [op2 start];
    [op3 start];
    
    //我们发现直接启动，打印结果，都是在主线程中，并没有重新开启子线程。
}

- (void)operation1{
    NSLog(@"1--%@",[NSThread currentThread]);
}

- (void)operation2{
    NSLog(@"2--%@",[NSThread currentThread]);
}

- (void)operation3{
    NSLog(@"3--%@",[NSThread currentThread]);
}

- (void)testBlockOperation{
    NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1--%@",[NSThread currentThread]);
    }];
    NSBlockOperation * op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2--%@",[NSThread currentThread]);
    }];
    NSBlockOperation * op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3--%@",[NSThread currentThread]);
    }];
    
    [op1 addExecutionBlock:^{
        NSLog(@"4--%@",[NSThread currentThread]);
    }];
    
    [op2 addExecutionBlock:^{
        NSLog(@"5--%@",[NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"6--%@",[NSThread currentThread]);
    }];
    
    [op1 start];
    [op2 start];
    [op3 start];
}


- (void)testCustemOperation{
    CustemOperation * op1 = [[CustemOperation alloc] init];
    CustemOperation * op2 = [[CustemOperation alloc] init];
    [op1 start];
    [op2 start];
}

//NSInvocationOperation 和 NSOperationQueue组合使用
- (void)testInvocationOperationAndOperationQueue{
    //1、创建操作，封装任务
    NSInvocationOperation * op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation1) object:nil];
    NSInvocationOperation * op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation2) object:nil];
    NSInvocationOperation * op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation3) object:nil];
    
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    //通过打印我们发现都是子线程执行的
}

- (void)testBlockOperationAndOperationQueue{
    NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1--%@",[NSThread currentThread]);
    }];
    NSBlockOperation * op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2--%@",[NSThread currentThread]);
    }];
    NSBlockOperation * op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3--%@",[NSThread currentThread]);
    }];
    
    [op1 addExecutionBlock:^{
        NSLog(@"4--%@",[NSThread currentThread]);
    }];
    
    [op2 addExecutionBlock:^{
        NSLog(@"5--%@",[NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"6--%@",[NSThread currentThread]);
    }];
    
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

- (void)testCustemOperationAndOperationQueue{
    CustemOperation * op1 = [[CustemOperation alloc] init];
    CustemOperation * op2 = [[CustemOperation alloc] init];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op1];
    [queue addOperation:op2];
}

- (void)testDependencyOperationQueue{
    NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1--%@",[NSThread currentThread]);
    }];
    NSBlockOperation * op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2--%@",[NSThread currentThread]);
    }];
    NSBlockOperation * op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3--%@",[NSThread currentThread]);
    }];
    
    //监听op3是否执行完成
    op3.completionBlock = ^{
        NSLog(@"3已经执行完成了。");
    };
    //添加依赖
    
    [op1 addDependency:op3];
    [op2 addDependency:op3];
    
    
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
    
}

- (void)testDownloadImage{
    
    __block UIImage * image1;
    __block UIImage * image2;
    
    //1创建队列
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    //2、封装操作
    NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL * url = [NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwx2.sinaimg.cn%2Flarge%2F001xWdDjly4guw2qlwacsj60u00gtjuh02.jpg&refer=http%3A%2F%2Fwx2.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635498693&t=fa411f5a25b3c13d1d5d629d00bbf6b8"];
        NSData * data  = [NSData dataWithContentsOfURL:url];
        image1 = [UIImage imageWithData:data];
    }];
    
    NSBlockOperation * op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL * url = [NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Finews.gtimg.com%2Fnewsapp_bt%2F0%2F14017322609%2F641&refer=http%3A%2F%2Finews.gtimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635498693&t=c721cc2e025d5daa3df6794fd5e5c602"];
        NSData * data  = [NSData dataWithContentsOfURL:url];
        image2 = [UIImage imageWithData:data];
    }];
    
    //合并图片
    NSBlockOperation * op3 = [NSBlockOperation blockOperationWithBlock:^{
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        [image1 drawInRect:CGRectMake(0, 0, 200, 100)];
        [image2 drawInRect:CGRectMake(0, 100, 200, 100)];
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //回到主线程绘制
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
            NSLog(@"刷新");
        }];
    }];
    
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
}

//利用kvo监听来实现，监听队列所有操作都完成了的操作
- (void) testKVOForNSOperationQueue{
    NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1--%@",[NSThread currentThread]);
    }];
    NSBlockOperation * op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2--%@",[NSThread currentThread]);
    }];
    NSBlockOperation * op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3--%@",[NSThread currentThread]);
    }];
    self.kvoqueue = [[NSOperationQueue alloc] init];
    [self.kvoqueue addObserver:self forKeyPath:@"operationCount" options:0 context:nil];
    [self.kvoqueue addOperation:op1];
    [self.kvoqueue addOperation:op2];
    [self.kvoqueue addOperation:op3];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.kvoqueue && [keyPath isEqualToString:@"operationCount"]) {
        if (0==self.kvoqueue.operations.count) {
            NSLog(@"所有操作都结束了");
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)testAlertGroupManager{
    HTAlerView * alertView = [[HTAlerView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
    alertView.backgroundColor = [UIColor yellowColor];
    [HTAlertViewManager addCustomAlertView:alertView];
    
    
    HTAlerView * alertView1 = [[HTAlerView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    alertView1.backgroundColor = [UIColor greenColor];
    [HTAlertViewManager addCustomAlertView:alertView1];
    
    HTAlerView * alertView2 = [[HTAlerView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    alertView2.backgroundColor = [UIColor blueColor];
    alertView2.clickBLock = ^{
        SubViewController * subVC = [[SubViewController alloc] init];
        [self.navigationController pushViewController:subVC animated:YES];
        [HTAlertViewManager suspendShowAlert];
    };
    [HTAlertViewManager addCustomAlertView:alertView2 priority:HTAlertPriorityHigh];
    
    
    HTAlerView * alertView3 = [[HTAlerView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    alertView3.backgroundColor = [UIColor systemPinkColor];
    alertView3.clickBLock = ^{
        SubViewController * subVC = [[SubViewController alloc] init];
        [self.navigationController pushViewController:subVC animated:YES];
        [HTAlertViewManager suspendShowAlert];
    };
    [HTAlertViewManager addCustomAlertView:alertView3 priority:HTAlertPriorityVeryHigh identify:@"versionUpdate"];
    
    HTAlerView * alertView4 = [[HTAlerView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    alertView4.backgroundColor = [UIColor purpleColor];
    alertView4.clickBLock = ^{
        SubViewController * subVC = [[SubViewController alloc] init];
        [self.navigationController pushViewController:subVC animated:YES];
        [HTAlertViewManager suspendShowAlert];
    };
    [HTAlertViewManager addCustomAlertView:alertView4 priority:HTAlertPriorityVeryHigh identify:@"versionUpdate"];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [[HTAlertViewManager sharedManager]  showApplicationAlertView];
//}
@end
