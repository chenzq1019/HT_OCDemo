//
//  ModuleAServer.m
//  Protocol-Class 组件化通行方案
//
//  Created by 陈竹青 on 2022/6/16.
//

#import "ModuleAServer.h"
#import "HTMediator.h"


@implementation ModuleAServer

+ (void)load {
    [HTMediator registerProcol:@protocol(ModuleAProtocol) forclass:[ModuleAServer class]];
}


- (void)testModuleAFunc{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"===================");
}

@end
