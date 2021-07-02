//
//  ViewController.m
//  深复制与浅复制
//
//  Created by 陈竹青 on 2021/6/9.
//

#import "ViewController.h"

@interface ViewController ()
//定义成copy属性，可以避免被x
@property (nonatomic, copy) NSString * myStr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableString * str = [NSMutableString stringWithFormat:@"这是一个字符串"];
    NSLog(@"%p",str);
    self.myStr = [str mutableCopy];
    NSLog(@"%@-%p",self.myStr,self.myStr);
    [str appendString:@"修改了"];
    NSLog(@"%@",self.myStr);
    
    NSMutableString *string = [NSMutableString stringWithFormat:@"name"];
    NSLog(@"原始string的地址:%p",string);
    
    NSMutableString *copyString = [string copy];
    NSLog(@"拷贝string的地址:%p",copyString);
    
    NSString *string1 = [NSString stringWithFormat:@"name"];
    NSLog(@"原始string1的地址:%p",string1);
    
    NSString *copyString1 = [string1 copy];
    NSLog(@"拷贝string1的地址:%p",copyString1);
    
    NSString *mutCopyString1 = [string1 mutableCopy];
    NSLog(@"拷贝string1的地址:%p",mutCopyString1);
    
    NSArray * array = @[@"1",@"2",@"3",@"4"];
    NSArray * copyArray = [array copy];
    NSArray * mutlCopyArray = [array mutableCopy];
    NSLog(@"原始数组的地址：%p",array);
    NSLog(@"拷贝数组的地址：%p",copyArray);
    NSLog(@"拷贝数组的地址：%p",mutlCopyArray);
    
    NSMutableArray * multArray = [[NSMutableArray alloc] initWithArray:array];
    NSArray * multCopyArray = [multArray copy];
    NSMutableArray * mutabelCopyArray = [multArray mutableCopy];
    
    NSLog(@"原始数组的地址：%p",multArray);
    NSLog(@"拷贝数组的地址：%p",multCopyArray);
    NSLog(@"拷贝数组的地址：%p",mutabelCopyArray);
    
    NSMutableString * mutableStr = [[NSMutableString alloc] initWithString:@"这是原始字符串"];
    self.myStr= mutableStr;
    NSLog(@"%@",self.myStr);
    [mutableStr appendString:@"+新修改字符"];
    NSLog(@"%@",self.myStr);
    
}


@end
