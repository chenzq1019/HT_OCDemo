//
//  US_InteractiveTransition.h
//  自定义转场
//
//  Created by 陈竹青 on 2022/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface US_InteractiveTransition : UIPercentDrivenInteractiveTransition


- (void)transitionToViewController:(UIViewController *)toViewController;
@property(nonatomic, strong) UIViewController *presentedViewController;
@property(nonatomic, assign) BOOL shouldComplete; //是否拖拽了一半以上
@end

NS_ASSUME_NONNULL_END
