//
//  TestInstanceVC.m
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2021/12/28.
//

#import "TestInstanceVC.h"

#import "HTToolManager.h"

@interface TestInstanceVC ()

@end

@implementation TestInstanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    [HTToolManager.instance takeTestFunc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
