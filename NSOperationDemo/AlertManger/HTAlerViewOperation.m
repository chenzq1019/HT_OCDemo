//
//  HTAlerViewOperation.m
//  NSOperationDemo
//
//  Created by 陈竹青 on 2021/9/29.
//

#import "HTAlerViewOperation.h"
#import "UIView+ShowAnimation.h"
@implementation HTAlerViewOperation
@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)initWithView:(UIView *)alertView queuePriority:(NSOperationQueuePriority)priority{
    self = [super init];
    if (self) {
        _view = alertView;
        self.queuePriority = priority;
    }
    return self;
}

- (void)start {
    self.executing = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view showViewWithAnimation:AniamtionAlert];
        
    });
    __weak typeof(self) weakself = self;
    self.view.mCompleteBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself done];
        });
    };
}

- (void)done{
    self.finished = YES;
    self.executing = NO;
}

#pragma mark - setter -- getter
- (void)setExecuting:(BOOL)executing {
    //调用KVO通知
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    //调用KVO通知
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isExecuting {
    return _executing;
}

- (void)setFinished:(BOOL)finished {
    if (_finished != finished) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = finished;
        [self didChangeValueForKey:@"isFinished"];
    }
}

- (BOOL)isFinished {
    return _finished;
}

// 返回NO 标识为串行Operation
- (BOOL)isAsynchronous {
    return NO;
}


@end
