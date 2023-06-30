//
//  US_InteractiveTransition.m
//  自定义转场
//
//  Created by 陈竹青 on 2022/12/5.
//

#import "US_InteractiveTransition.h"




@implementation US_InteractiveTransition

- (void)transitionToViewController:(UIViewController *)toViewController{
    self.presentedViewController = toViewController;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [toViewController.view addGestureRecognizer:panGesture];
    
}

- (void)panAction:(UIPanGestureRecognizer *)gesture {
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            
            [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            
            break;
        case UIGestureRecognizerStateChanged: {
            
            //监听当前滑动的距离
            CGPoint transitionPoint = [gesture translationInView:self.presentedViewController.view];
            NSLog(@"transitionPoint %@", NSStringFromCGPoint(transitionPoint));
            
            CGFloat ratio = transitionPoint.y/[UIScreen mainScreen].bounds.size.height;
            NSLog(@"ratio: %f", ratio);
            
//            if (ratio >= 0.5) {
//                self.shouldComplete = YES;
//            } else {
//                self.shouldComplete = NO;
//            }
            self.shouldComplete=YES;
            [self updateInteractiveTransition:ratio];

        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.shouldComplete=NO;
            if (self.shouldComplete) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        }
            break;
        default:
            break;
    }
}

@end
