//
//  UINavigationController+HTExtention.h
//  自定义导航栏
//
//  Created by 陈竹青 on 2021/10/11.
//

#import <UIKit/UIKit.h>
#import "HTFakeNavigationBar.h"
NS_ASSUME_NONNULL_BEGIN



@interface HTNavigationController : UINavigationController
- (void)ht_updateNavigationBarFor:(UIViewController *)viewController;
- (void)ht_updateNavigationBarTintFor:(UIViewController *)viewController ignorTintColor:(BOOL) ignoreTintColor;
- (void)ht_updateNavigationBarBackgroundFor:(UIViewController *)viewController;
- (void)ht_updateNavigationBarShadowFor:(UIViewController *)viewController;
@end

@interface UINavigationController (HTExtention)

//- (void)ht_updateNavigationBarFor:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
