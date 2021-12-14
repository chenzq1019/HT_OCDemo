//
//  HTVCTools.m
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2021/12/10.
//

#import "HTVCTools.h"

@implementation HTVCTools

+ (UIViewController *)findNextViewControllerByResponder:(UIResponder *)responder{
    UIResponder *next = responder;
    do {
        if (![next isKindOfClass:UIViewController.class]) {
            continue;
        }
        UIViewController *vc = (UIViewController *)next;
        if ([vc isKindOfClass:UINavigationController.class]) {
            return [self findNextViewControllerByResponder:[(UINavigationController *)vc topViewController]];
        } else if ([vc isKindOfClass:UITabBarController.class]) {
            return [self findNextViewControllerByResponder:[(UITabBarController *)vc selectedViewController]];
        }
        
        UIViewController *parentVC = vc.parentViewController;
        if (!parentVC) {
            break;
        }
        if ([parentVC isKindOfClass:UINavigationController.class] ||
            [parentVC isKindOfClass:UITabBarController.class] ||
            [parentVC isKindOfClass:UIPageViewController.class] ||
            [parentVC isKindOfClass:UISplitViewController.class]) {
            break;
        }
    } while ((next = next.nextResponder));
    return [next isKindOfClass:UIViewController.class] ? (UIViewController *)next : nil;
}
@end
