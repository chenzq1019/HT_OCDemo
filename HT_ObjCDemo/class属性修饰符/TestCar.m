//
//  TestCar.m
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2021/12/28.
//

#import "TestCar.h"

static NSString * _desc = nil;

@implementation TestCar


+ (NSString *)desc{
    if (!_desc) {
        _desc = [[NSString alloc] init];
    }
    return _desc;
}

+ (void)setDesc:(NSString *)desc{
    _desc = desc;
}
@end
