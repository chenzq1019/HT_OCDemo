//
//  HTAlertViewManager.m
//  NSOperationDemo
//
//  Created by 陈竹青 on 2021/9/29.
//

#import "HTAlertViewManager.h"
#import "HTAlerViewOperation.h"
#import "UIView+ShowAnimation.h"
@interface HTAlertViewManager ()
@property (nonatomic, strong) NSOperationQueue * alertQueue;//弹框队列
@end

@implementation HTAlertViewManager

+ (instancetype)sharedManager{
    static HTAlertViewManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HTAlertViewManager alloc] init];
    });
    return manager;
}

- (void)dealloc{
    [_alertQueue removeObserver:self forKeyPath:@"operationCount" context:nil];
}
//添加view
+ (void)addCustomAlertView:(UIView *)alertView{
    [HTAlertViewManager addCustomAlertView:alertView priority:HTAlertPriorityNormol];
}

//添加view
+ (void)addCustomAlertView:(UIView *)alertView priority:(HTAlertPriority) priority{
    [HTAlertViewManager addCustomAlertView:alertView priority:priority identify:@""];
}
//添加view
+ (void)addCustomAlertView:(UIView *)alertView priority:(HTAlertPriority) priority identify:(NSString *)identify{
    NSOperationQueuePriority operationPriority;
    switch (priority) {
        case HTAlertPriorityLower:
            operationPriority = NSOperationQueuePriorityVeryLow;break;
        case HTAlertPriorityNormol:
            operationPriority = NSOperationQueuePriorityLow;break;
        case HTAlertPriorityMiddle:
            operationPriority = NSOperationQueuePriorityNormal;break;
        case HTAlertPriorityHigh:
            operationPriority = NSOperationQueuePriorityHigh;break;
        case HTAlertPriorityVeryHigh:
            operationPriority = NSOperationQueuePriorityVeryHigh;break;
        default:
            operationPriority = NSOperationQueuePriorityNormal;
            break;
    }
    HTAlerViewOperation * operation = [[HTAlerViewOperation alloc] initWithView:alertView queuePriority:operationPriority];
    operation.identifyID = identify;
    //找出当前显示的AlertView
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"isExecuting == %@",@YES];
    NSArray * findResult = [[HTAlertViewManager sharedManager].alertQueue.operations filteredArrayUsingPredicate:predicate];
    if (findResult&&findResult.count>0) {
        HTAlerViewOperation * excutingOperation = findResult.firstObject;
        //如果当前的优先级小于需要添加的，则将当前的视图关闭，并重新添加到队列中
        if (excutingOperation.queuePriority < operation.queuePriority) {
            [excutingOperation.view hiddenView];
            HTAlerViewOperation * newOperation = [[HTAlerViewOperation alloc] initWithView:excutingOperation.view queuePriority:excutingOperation.queuePriority];
            newOperation.identifyID = excutingOperation.identifyID;
            [[HTAlertViewManager sharedManager].alertQueue addOperation:newOperation];
        }
    }
    //找出identify相同的，则不需要添加到队列中
    if (identify.length>0) {
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"identifyID == %@",identify];
        NSArray * result = [[HTAlertViewManager sharedManager].alertQueue.operations filteredArrayUsingPredicate:predicate];
        if (result&& result.count>0) {
            return;
        }
    }
    [[HTAlertViewManager sharedManager].alertQueue addOperation:operation];
}
//中断弹框显示
+ (void)suspendShowAlert{
    [[HTAlertViewManager sharedManager].alertQueue setSuspended:YES];
}

//触发弹框显示
+ (void)showAlertView{
    //如果队列中有任务，就直接继续执行。
    if ([HTAlertViewManager sharedManager].alertQueue.operationCount >0) {
        [[HTAlertViewManager sharedManager].alertQueue  setSuspended:NO];
    }
}

#pragma mark - <kvo>

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.alertQueue && [keyPath isEqualToString:@"operationCount"]) {
        if (0==self.alertQueue.operations.count) {
            NSLog(@"所有操作都结束了");
            if (self.finishBlock) {
                self.finishBlock();
            }
            [self.alertQueue setSuspended:YES];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - <getter>
- (NSOperationQueue *)alertQueue{
    if (!_alertQueue) {
        _alertQueue = [[NSOperationQueue alloc] init];
        _alertQueue.maxConcurrentOperationCount = 1;
        [_alertQueue addObserver:self forKeyPath:@"operationCount" options:0 context:nil];
        [_alertQueue setSuspended:YES];
    }
    return _alertQueue;
}
@end
