//
//  ViewController.m
//  谓词Demo
//
//  Created by 陈竹青 on 2021/4/12.
//

#import "ViewController.h"
#import "TestModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    
    TestModel * model01 = [[TestModel alloc] init];
    model01.groupId = @"A1";
    model01.groupName = @"01";
    model01.data.name = @"czq";
    
    [dataArray addObject:model01];
    
    TestModel * model02 = [[TestModel alloc] init];
    model02.groupId = @"A2";
    model02.groupName = @"02";
    model01.data.name = @"dww";
    
    [dataArray addObject:model02];
    
    TestModel * model03 = [[TestModel alloc] init];
    model03.groupId = @"A3";
    model03.groupName = @"03";
    [dataArray addObject:model03];
    
    TestModel * model04 = [[TestModel alloc] init];
    model04.groupId = @"A4";
    model04.groupName = @"04";
    [dataArray addObject:model04];
    TestModel * model10 = [[TestModel alloc] init];
    model10.groupId = @"";
    model10.groupName = @"A5";
    [dataArray addObject:model10];

    TestModel * model11 = [[TestModel alloc] init];
    model11.groupId = @"A6";
    model11.groupName = @"01";
    [dataArray addObject:model11];
    
    NSPredicate *tempDPredicate = [NSPredicate predicateWithFormat:@"groupId IN %@", @[@"A1",@"A2",@""]];
    NSArray * findresult =[dataArray  filteredArrayUsingPredicate:tempDPredicate];
    
    NSLog(@"%@\n%@",findresult,[findresult.lastObject valueForKey:@"groupName"]);
    
    //判断数值相等
    NSInteger number = 121;
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF < 123"];
    if ([predicate evaluateWithObject:@(number)]) {
        NSLog(@"数值是%@",@(number));
    }
    
    NSArray * array = @[@1,@3,@10,@12,@6,@7,@20];
    NSArray * array2 = @[@3,@10,@14,@6,@15];
    NSPredicate * predicateNum = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",array2];
    NSArray * filterArray = [array filteredArrayUsingPredicate:predicateNum];
    NSLog(@"%@",filterArray);
    NSPredicate * predicateBetween = [NSPredicate predicateWithFormat:@"SELF BETWEEN {10,20}"];
    NSArray * betweenArray = [array filteredArrayUsingPredicate:predicateBetween];
    NSLog(@"%@",betweenArray);
    
}


@end
