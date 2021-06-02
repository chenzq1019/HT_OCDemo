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
    model01.groupId = @"12212";
    model01.groupName = @"01";
    model01.data.name = @"czq";
    
    [dataArray addObject:model01];
    
    TestModel * model02 = [[TestModel alloc] init];
    model02.groupId = @"12212";
    model02.groupName = @"02";
    model01.data.name = @"dww";
    
    [dataArray addObject:model02];
    
    TestModel * model03 = [[TestModel alloc] init];
    model03.groupId = @"12212";
    model03.groupName = @"03";
    [dataArray addObject:model03];
    
    TestModel * model04 = [[TestModel alloc] init];
    model04.groupId = @"12212";
    model04.groupName = @"04";
    [dataArray addObject:model04];
//    TestModel * model10 = [[TestModel alloc] init];
//    model10.groupId = @"31231";
//    model10.groupName = @"01";
//    [dataArray addObject:model10];
//
//    TestModel * model11 = [[TestModel alloc] init];
//    model11.groupId = @"31231";
//    model11.groupName = @"01";
//    [dataArray addObject:model11];
    
    NSPredicate *tempDPredicate = [NSPredicate predicateWithFormat:@"groupId == %@", @"12212"];
    NSArray * findresult =[dataArray  filteredArrayUsingPredicate:tempDPredicate];
    
    NSLog(@"%@\n%@",findresult,[findresult.lastObject valueForKey:@"groupName"]);
    
}


@end
