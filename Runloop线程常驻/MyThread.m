//
//  MyThread.m
//  Runloop线程常驻
//
//  Created by 陈竹青 on 2021/6/8.
//

#import "MyThread.h"

@interface YYThread : NSThread
@end
@implementation YYThread
- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end

@interface MyThread ()
@property(nonatomic, strong) NSThread *thread;
@property(nonatomic, assign, getter=isStopped) BOOL stopped;
@end
@implementation MyThread

- (instancetype)init{
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        self.thread = [[YYThread alloc] initWithBlock:^{
            NSLog(@"-------RunLoop start-------");
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            //注意判断weaself
            while (weakSelf && !weakSelf.isStopped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
            NSLog(@"-------RunLoop end-------");
        }];
    }
    return self;
}

- (void)run {
    if (self.thread == nil) return;
    [self.thread start];
}

- (void)stop {
    if (self.thread == nil) return;
    [self performSelector:@selector(__stopThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}

//执行block 在子线程中。
- (void)executeTask:(MyThreadBlock)task {
    if (self.thread == nil || task == nil) return;
    [self performSelector:@selector(__executeTask:) onThread:self.thread withObject:task waitUntilDone:NO];
}

#pragma mark - private method

- (void) __stopThread {
    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void) __executeTask:(MyThreadBlock)task {
    task();
}

- (void)dealloc {
    if (self.thread != nil){
        [self stop];
    }
    NSLog(@"%s", __func__);
}

@end
