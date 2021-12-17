//
//  HTAlertViewManager.h
//  NSOperationDemo
//
//  Created by 陈竹青 on 2021/9/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HTAlertPriorityLower,
    HTAlertPriorityNormol,
    HTAlertPriorityMiddle,
    HTAlertPriorityHigh,
    HTAlertPriorityVeryHigh,
} HTAlertPriority;


NS_ASSUME_NONNULL_BEGIN
typedef void(^CustomAlertViewManagerFinish)(void);
@interface HTAlertViewManager : NSObject
@property (nonatomic, strong) _Nullable CustomAlertViewManagerFinish  finishBlock;
@property (nonatomic, copy) NSString * targetVCName;
+ (instancetype)sharedManager;

//添加view
+ (void)addCustomAlertView:(UIView *)alertView;

//添加view
+ (void)addCustomAlertView:(UIView *)alertView priority:(HTAlertPriority) priority;

//添加view
+ (void)addCustomAlertView:(UIView *)alertView priority:(HTAlertPriority) priority identify:(NSString *)identify;

//触发队列的弹框显示
+ (void)showAlertView;

//暂停队列中的弹框显示
+ (void)suspendShowAlert;


@end

NS_ASSUME_NONNULL_END
