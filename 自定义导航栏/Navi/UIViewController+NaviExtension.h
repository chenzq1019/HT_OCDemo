//
//  UIViewController+NaviExtension.h
//  自定义导航栏
//
//  Created by 陈竹青 on 2021/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NaviExtension)
@property (nonatomic, assign) UIBarStyle ht_barStyle;
@property (nonatomic, strong) UIColor * ht_tintColor;
@property (nonatomic, strong) UIColor * ht_titleColor;
@property (nonatomic, strong) UIFont * ht_titleFont;
@property (nonatomic, strong) UIColor * ht_backgoundColor;
@property (nonatomic, strong) UIImage * ht_backgoundImage;
@property (nonatomic, assign) CGFloat ht_barAlpha;
@property (nonatomic, assign) BOOL ht_shadowHidden;
@property (nonatomic, strong) UIColor * ht_shadowColor;
@property (nonatomic, assign) BOOL ht_enablePopGesture;


- (void)ht_setNeedNavigationBarUpdate;

- (void)ht_setNeedsNavigationBarTintUpdate;

- (void)ht_setNeedsNavigationBarBackgroundUpdate;


- (void)ht_setNeedsNavigationBarShadowUpdate;
@end

NS_ASSUME_NONNULL_END
