//
//  UIViewController+NaviExtension.m
//  自定义导航栏
//
//  Created by 陈竹青 on 2021/10/11.
//

#import "UIViewController+NaviExtension.h"
#import "UINavigationController+HTExtention.h"
#import <objc/runtime.h>

static NSString * barStyle = @"htNavigationBarStyle";
static NSString * tintColor =  @"htNavigationBarTintColor";
static NSString * titleColor = @"htNavigationBarTitleColor";
static NSString * titleFont = @"htNavigationBarTitleFont";
static NSString * backgroundColor =  @"htNavigationBarBackgroundColor";
static NSString * backgroundImage = @"htNaviagtionBarBackgrounImage";
static NSString * alpha = @"htNavigationAlpha";
static NSString * shadowHidden = @"htNavigationShowHidden";
static NSString * shadowColor = @"htNavigationShadowColor";
static NSString * enabelGestPop = @"htNavigationEnableGestPop";

@implementation UIViewController (NaviExtension)


- (void)setHt_barStyle:(UIBarStyle) ht_barStyle{
    objc_setAssociatedObject(self, &barStyle, @(ht_barStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self ht_setNeedsNavigationBarTintUpdate];
}
- (UIBarStyle )ht_barStyle{
    NSNumber * number =  objc_getAssociatedObject(self, &barStyle);
    UIBarStyle style = [number integerValue];
    if (number == nil) {
        style = UINavigationBar.appearance.barStyle;
    }
    return style;
}

- (void)setHt_tintColor:(UIColor *)ht_tintColor{
    objc_setAssociatedObject(self, &tintColor, ht_tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self ht_setNeedsNavigationBarTintUpdate];
}

- (UIColor *)ht_tintColor{
    UIColor * color = objc_getAssociatedObject(self, &tintColor);
    if (color == nil) {
        color = [UINavigationBar appearance].tintColor;
    }
    if (color == nil) {
        color = [UIColor blackColor];
    }
    return color;
}

- (void)setHt_titleColor:(UIColor *)ht_titleColor{
    objc_setAssociatedObject(self, &titleColor, ht_titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self ht_setNeedsNavigationBarTintUpdate];
}

- (UIColor *)ht_titleColor{
    UIColor * color = objc_getAssociatedObject(self, &titleColor);
    if (color == nil) {
        color = [UINavigationBar appearance].titleTextAttributes[NSForegroundColorAttributeName];
    }
    if (color == nil) {
        color = [UIColor blackColor];
    }
    return color;
}

- (void)setHt_titleFont:(UIFont *)ht_titleFont{
    objc_setAssociatedObject(self, &titleFont, ht_titleFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self ht_setNeedsNavigationBarTintUpdate];
}

- (UIFont *)ht_titleFont{
    UIFont * font = objc_getAssociatedObject(self, &titleFont);
    if (font == nil) {
        font = [UINavigationBar appearance].titleTextAttributes[NSFontAttributeName];
    }
    if (font == nil) {
        font = [UIFont boldSystemFontOfSize:17];
    }
    return font;
}

- (void)setHt_backgoundColor:(UIColor *)ht_backgoundColor{
    objc_setAssociatedObject(self, &backgroundColor, ht_backgoundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self ht_setNeedsNavigationBarBackgroundUpdate];
}

- (UIColor *)ht_backgoundColor{
    UIColor * color = objc_getAssociatedObject(self, &backgroundColor);
    if (color == nil) {
        color = [UINavigationBar appearance].barTintColor;
    }
    return color;
}

- (void)setHt_backgoundImage:(UIImage *)ht_backgoundImage{
    objc_setAssociatedObject(self, &backgroundImage, ht_backgoundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self ht_setNeedsNavigationBarBackgroundUpdate];
}

- (UIImage *)ht_backgoundImage{
    UIImage * image = objc_getAssociatedObject(self, &backgroundImage);
    if (image ==nil) {
        image = [[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsDefault];
    }
    return image;
}

- (void)setHt_barAlpha:(CGFloat)ht_barAlpha{
    objc_setAssociatedObject(self, &alpha, @(ht_barAlpha), OBJC_ASSOCIATION_ASSIGN);
    [self ht_setNeedsNavigationBarBackgroundUpdate];
}

- (CGFloat)ht_barAlpha{
    NSNumber * number = objc_getAssociatedObject(self, &alpha);
    if (number != nil) {
        return [number floatValue];
    }
    return 1.0;
}

- (void)setHt_shadowHidden:(BOOL)ht_shadowHidden{
    objc_setAssociatedObject(self, &shadowHidden, @(ht_shadowHidden), OBJC_ASSOCIATION_ASSIGN);
    [self ht_setNeedsNavigationBarShadowUpdate];
}
- (BOOL)ht_shadowHidden{
    NSNumber * number = objc_getAssociatedObject(self, &shadowHidden);
    if (number) {
        return  [number boolValue];
    }
    return NO;
}

- (void)setHt_shadowColor:(UIColor *)ht_shadowColor{
    objc_setAssociatedObject(self, &shadowColor, ht_shadowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self ht_setNeedsNavigationBarShadowUpdate];
}

- (UIColor *)ht_shadowColor{
    UIColor * color = objc_getAssociatedObject(self, &shadowColor);
    if (color != nil) {
        color = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return color;
}

- (void)setHt_enablePopGesture:(BOOL)ht_enablePopGesture{
    objc_setAssociatedObject(self, &enabelGestPop, @(ht_enablePopGesture), OBJC_ASSOCIATION_ASSIGN);

}

- (BOOL)ht_enablePopGesture{
    NSNumber * eablePopGest = objc_getAssociatedObject(self, &enabelGestPop);
    if (eablePopGest) {
        return  [eablePopGest boolValue];
    }
    return YES;
}

#pragma mark - <func>
- (void)ht_setNeedNavigationBarUpdate{
    if ([self.navigationController isKindOfClass:[HTNavigationController class]]) {
        HTNavigationController * navController = (HTNavigationController *)self.navigationController;
        [navController ht_updateNavigationBarFor:self];
    }
}

- (void)ht_setNeedsNavigationBarTintUpdate{
    if ([self.navigationController isKindOfClass:[HTNavigationController class]]) {
        HTNavigationController * navController = (HTNavigationController *)self.navigationController;
        [navController ht_updateNavigationBarTintFor:self ignorTintColor:NO];
    }
}

- (void)ht_setNeedsNavigationBarBackgroundUpdate{
    if ([self.navigationController isKindOfClass:[HTNavigationController class]]) {
        HTNavigationController * navController = (HTNavigationController *)self.navigationController;
        [navController ht_updateNavigationBarBackgroundFor:self];
    }
}


- (void)ht_setNeedsNavigationBarShadowUpdate{
    if ([self.navigationController isKindOfClass:[HTNavigationController class]]) {
        HTNavigationController * navController = (HTNavigationController *)self.navigationController;
        [navController ht_updateNavigationBarShadowFor:self];
    }
}

@end
