//
//  HTAlerViewOperation.h
//  NSOperationDemo
//
//  Created by 陈竹青 on 2021/9/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HTAlerViewOperation : NSOperation

@property (nonatomic, strong) UIView * view;
@property (nonatomic, readwrite, getter=isExecuting) BOOL executing;
@property (nonatomic, readwrite, getter=isFinished) BOOL finished;
@property (nonatomic, copy) NSString * identifyID;

- (instancetype)initWithView:(UIView *)alertView queuePriority:(NSOperationQueuePriority)priority;
@end

NS_ASSUME_NONNULL_END
