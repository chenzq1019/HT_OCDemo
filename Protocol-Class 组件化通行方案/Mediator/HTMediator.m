//
//  HTMediator.m
//  Protocol-Class 组件化通行方案
//
//  Created by 陈竹青 on 2022/6/16.
//

#import "HTMediator.h"

@interface HTMediator ()
@property (nonatomic, strong) NSMutableDictionary * mediatorCache;

@end

@implementation HTMediator
+ (instancetype) shareInstance{
    static HTMediator * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTMediator alloc] init];
        instance.mediatorCache = [NSMutableDictionary new];
    });
    return instance;
}

+(void)registerProcol:(Protocol *) protocol forclass:(Class) cls{
    if (protocol && cls) {
        [[HTMediator shareInstance].mediatorCache setObject:cls forKey:NSStringFromProtocol(protocol)];
    }
}

+ (Class) classForProtocol:(Protocol *)protocol{
    return [[HTMediator shareInstance].mediatorCache objectForKey:NSStringFromProtocol(protocol)];
}
@end
