//
//  TestModel.m
//  谓词Demo
//
//  Created by 陈竹青 on 2021/4/12.
//

#import "TestModel.h"

@implementation DataModel


@end

@implementation TestModel
- (instancetype)init{
    self  = [super init];
    if (self) {
        self.data  = [[DataModel alloc] init];
    }
    return self;
}
@end
