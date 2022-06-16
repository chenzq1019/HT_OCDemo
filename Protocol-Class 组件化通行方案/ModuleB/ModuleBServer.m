//
//  ModuleBServer.m
//  Protocol-Class 组件化通行方案
//
//  Created by 陈竹青 on 2022/6/16.
//

#import "ModuleBServer.h"
#import "HTMediator.h"

@implementation ModuleBServer

+ (void)load {
    [HTMediator registerProcol:@protocol(ModuleBProtocol) forclass:[ModuleBServer class]];
}


- (void)runModuleB:(NSString *)parmas{
    NSLog(@"ModuleB run with %@",parmas);
}
@end
