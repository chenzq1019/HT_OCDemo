//
//  HTFakeNavigationBar.h
//  自定义导航栏
//
//  Created by 陈竹青 on 2021/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTFakeNavigationBar : UIView
@property (nonatomic, strong) UIImageView * fakeBackgroundImageView;
@property (nonatomic, strong) UIImageView * fakeShadowImageView;
@property (nonatomic, strong) UIVisualEffectView * fakeBacekgoundEffectView;


- (void)ht_updateFameBarBackgroundFor:(UIViewController *) viewController;
- (void)ht_updateFakeBarShadowFor:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
