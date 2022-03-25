//
//  HTToolManager.m
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2021/12/28.
//

#import "HTToolManager.h"

@implementation HTToolManager

+ (instancetype)instance {
    static HTToolManager * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[HTToolManager alloc] init];
    });
    return tool;
}

- (void)takeTestFunc{
    NSLog(@"%s",__func__);
}
@end
