//
//  MyThread.h
//  Runloop线程常驻
//
//  Created by 陈竹青 on 2021/6/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyThreadBlock)(void);

@interface MyThread : NSObject


- (void)run;
- (void)stop;
- (void)executeTask:(MyThreadBlock)task;
@end

NS_ASSUME_NONNULL_END
