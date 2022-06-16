//
//  ViewController.m
//  Protocol-Class 组件化通行方案
//
//  Created by 陈竹青 on 2022/6/16.
//

#import "ViewController.h"
#import "ModuleA/ModuleAProtocol.h"
#import "ModuleB/ModuleBProtocol.h"
#import "Mediator/HTMediator.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Class ModuleA = [HTMediator classForProtocol:@protocol(ModuleAProtocol)];
    Class ModuleB = [HTMediator classForProtocol:@protocol(ModuleBProtocol)];
    
    id<ModuleAProtocol> moduleA = [[ModuleA alloc] init];
    id<ModuleBProtocol> moduleB = [[ModuleB alloc] init];
    
    [moduleA testModuleAFunc];
    [moduleB runModuleB:@"陈竹青"];
}


@end
