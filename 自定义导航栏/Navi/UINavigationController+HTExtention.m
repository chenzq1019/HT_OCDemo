//
//  UINavigationController+HTExtention.m
//  自定义导航栏
//
//  Created by 陈竹青 on 2021/10/11.
//

#import "UINavigationController+HTExtention.h"
#import "UIViewController+NaviExtension.h"
#import "HTFakeNavigationBar.h"
@interface HTNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) HTFakeNavigationBar * fakeBar;
@property (nonatomic, strong) HTFakeNavigationBar * fromFakeBar;
@property (nonatomic, strong) HTFakeNavigationBar * toFakeBar;

@property (nonatomic, weak) UIViewController * popingVC;
@property (nonatomic, assign) NSKeyValueObservingOptions fakeFromObserve;
@end

@implementation HTNavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
    [self.interactivePopGestureRecognizer addTarget:self action:@selector(handleinteractivePopGesture:)];
    [self setupNavigationBar];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    if (self.transitionCoordinator) {
        UIViewController * fromVC = [self.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        if (fromVC == self.popingVC) {
            [self ht_updateNavigationBarFor:fromVC];
        }
    }else{
        UIViewController * topViewController = self.topViewController;
        if (topViewController) {
            [self ht_updateNavigationBarFor:topViewController];
        }
    }
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self layoutFakeSubviews];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated{
    self.popingVC = self.topViewController;
    UIViewController * viewController = [super popViewControllerAnimated:animated];
    if (viewController) {
        [self ht_updateNavigationBarTintFor:viewController ignorTintColor:YES];
    }
    return viewController;
}

- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    self.popingVC = self.topViewController;
    NSArray * vcArray = [super popToRootViewControllerAnimated:animated];
    if (self.topViewController) {
        [self ht_updateNavigationBarTintFor:self.topViewController ignorTintColor:YES];
    }
    return  vcArray;
}

- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.popingVC = self.topViewController;
    NSArray * vcArray = [super popToViewController:viewController animated:animated];
    if (self.topViewController) {
        [self ht_updateNavigationBarTintFor:self.topViewController ignorTintColor:YES];
    }
    return  vcArray;
}

- (void)setupNavigationBar{
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    [self setupFakeSubviews];
}

- (void)setupFakeSubviews{
    UIView * fakesuperView = [self fakeSuperView];
    if (fakesuperView && self.fakeBar.superview == nil) {
        [fakesuperView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        [fakesuperView insertSubview:self.fakeBar atIndex:0];
    }
}
- (void)layoutFakeSubviews{
    UIView * fakesuperView = [self fakeSuperView];
    if (fakesuperView) {
        self.fakeBar.frame = fakesuperView.bounds;
        [self.fakeBar setNeedsLayout];
    }
}
- (UIView *)fakeSuperView{
    return self.navigationBar.subviews.firstObject;
}

- (void)handleinteractivePopGesture:(UIGestureRecognizer *)recognizer{
    if (self.transitionCoordinator) {
        UIViewController * fromVC = [self.transitionCoordinator viewControllerForKey:UITransitionContextFromViewKey];
        UIViewController * toVC = [self.transitionCoordinator viewControllerForKey:UITransitionContextToViewKey];
        
        if (recognizer.state == UIGestureRecognizerStateChanged) {
            self.navigationBar.tintColor = [self averageFromColor:fromVC.ht_tintColor toColor:toVC.ht_tintColor percent:self.transitionCoordinator.percentComplete];
        }
    }
}

- (NSArray *)getRGBByColor:(UIColor *)originColor{
    CGFloat r=0,g=0,b=0,a=0;
    [originColor getRed:&r green:&g blue:&b alpha:&a];
    return @[@(r),@(g),@(b),@(a)];
}

- (UIColor *) averageFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat) percent{
    NSArray * fromColors = [self getRGBByColor:fromColor];
    NSArray * toColors = [self getRGBByColor:toColor];
    CGFloat fromRed = [fromColors[0] floatValue];
    CGFloat fromGreen = [fromColors[1] floatValue];
    CGFloat fromBlue = [fromColors[2] floatValue];
    CGFloat fromAlpha = [fromColors[3] floatValue];
    CGFloat toRed = [toColors[0] floatValue];
    CGFloat toGreen = [toColors[1] floatValue];
    CGFloat toBlue = [toColors[2] floatValue];
    CGFloat toAlpha = [toColors[3] floatValue];
    CGFloat red = fromRed + (toRed - fromRed) * percent;
    CGFloat green = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat blue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat alpha = fromAlpha+ (toAlpha - fromAlpha)* percent;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}

- (void)showViewControlller:(UIViewController *)viewController coordinator:(id<UIViewControllerTransitionCoordinator>) coordinotr{
    UIViewController * fromVC = [coordinotr viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [coordinotr viewControllerForKey:UITransitionContextToViewControllerKey];
    if (fromVC && toVC) {
        [coordinotr animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            [self ht_updateNavigationBarTintFor:viewController ignorTintColor:context.isInteractive];
            if (viewController == toVC) {
                [self showTempFakeBarFromVC:fromVC toVC:toVC];
            }else{
                [self ht_updateNavigationBarBackgroundFor:viewController];
                [self ht_updateNavigationBarShadowFor:viewController];
            }
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            if (context.isCancelled) {
                [self ht_updateNavigationBarFor:fromVC];
            }else{
                [self ht_updateNavigationBarFor:viewController];
            }
            if (viewController == toVC) {
                [self cleanTempFakeBar];
            }
        }];
    }
}

- (void)showTempFakeBarFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC{
    [UIView setAnimationsEnabled:NO];
    self.fakeBar.alpha = 0.0;
    [fromVC.view addSubview:self.fromFakeBar];
    self.fromFakeBar.frame = [self fakerBarFrameFor:fromVC];
    [self.fromFakeBar setNeedsLayout];
    [self.fromFakeBar ht_updateFameBarBackgroundFor:fromVC];
    [self.fromFakeBar ht_updateFakeBarShadowFor:fromVC];
    
    [toVC.view addSubview:self.toFakeBar];
    self.toFakeBar.frame = [self fakerBarFrameFor:toVC];
    [self.toFakeBar setNeedsLayout];
    [self.toFakeBar ht_updateFameBarBackgroundFor:toVC];
    [self.toFakeBar ht_updateFakeBarShadowFor:toVC];
    
    [UIView setAnimationsEnabled:YES];
}


- (void)cleanTempFakeBar{
    [self.fromFakeBar removeFromSuperview];
    [self.toFakeBar removeFromSuperview];
    self.fakeBar.alpha = 1.0;
}

- (CGRect) fakerBarFrameFor:(UIViewController *) viewController{
    UIView * fakeSuperView= [self fakeSuperView];
    if (fakeSuperView) {
        CGRect rect = [self.navigationBar convertRect:fakeSuperView.frame toView:viewController.view];
        rect.origin.x = viewController.view.frame.origin.x;
        return rect;
    }else{
        return  self.navigationBar.frame;
    }
}

- (void) resetButtonLabelsInView:(UIView *)view{
    NSString * viewClassName = [[[view classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
    if ([viewClassName isEqualToString:@"UIButtonLabel"]) {
        view.alpha = 1;
    }else{
        if (view.subviews.count > 0) {
            for (UIView * subView in view.subviews) {
                [self resetButtonLabelsInView:subView];
            }
        }
    }
}
#pragma mark - <obser>

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]) {
        [self layoutFakeSubviews];
    }
}

#pragma mark - <delegate>
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.transitionCoordinator) {
        [self showViewControlller:viewController coordinator:self.transitionCoordinator];
    }else{
        if (!animated && self.viewControllers.count>1) {
            UIViewController * lastButOnVC = self.viewControllers[self.viewControllers.count -2];
            [self showTempFakeBarFromVC:lastButOnVC toVC:viewController];
            return;
        }
        [self ht_updateNavigationBarFor:viewController];
    }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (!animated) {
        [self ht_updateNavigationBarFor:viewController];
        [self cleanTempFakeBar];
    }
    self.popingVC = nil;
}

#pragma mark - <>
- (void)ht_updateNavigationBarFor:(UIViewController *)viewController{
    [self setupFakeSubviews];
    [self ht_updateNavigationBarTintFor:viewController ignorTintColor:false];
    [self ht_updateNavigationBarShadowFor:viewController];
    [self ht_updateNavigationBarBackgroundFor:viewController];
}

- (void)ht_updateNavigationBarTintFor:(UIViewController *)viewController ignorTintColor:(BOOL) ignoreTintColor{
    if (viewController != self.topViewController) {
        return;
    }
    [UIView setAnimationsEnabled:NO];
    self.navigationBar.barStyle = viewController.ht_barStyle;
    NSDictionary * attributs = @{NSForegroundColorAttributeName:viewController.ht_titleColor,NSFontAttributeName:viewController.ht_titleFont};
    self.navigationBar.titleTextAttributes = attributs;
    if (!ignoreTintColor) {
        self.navigationBar.tintColor = viewController.ht_tintColor;
    }
    [UIView setAnimationsEnabled:YES];
}

- (void)ht_updateNavigationBarBackgroundFor:(UIViewController *)viewController{
    if (viewController != self.topViewController) {
        return;
    }
    [self.fakeBar ht_updateFameBarBackgroundFor:viewController];
}

- (void)ht_updateNavigationBarShadowFor:(UIViewController *)viewController{
    if (viewController != self.topViewController) {
        return;
    }
    [self.fakeBar ht_updateFakeBarShadowFor:viewController];
}

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.viewControllers.count <= 1) {
        return  false;
    }
    if (self.topViewController) {
        return self.topViewController.ht_enablePopGesture;
    }
    return true;
}

#pragma mark - <getter>

- (HTFakeNavigationBar *) fakeBar {
    if (!_fakeBar) {
        _fakeBar = [HTFakeNavigationBar new];
    }
    return _fakeBar;
}

- (HTFakeNavigationBar *)fromFakeBar {
    if (!_fromFakeBar) {
        _fromFakeBar = [HTFakeNavigationBar new];
    }
    return _fromFakeBar;
}

- (HTFakeNavigationBar *)toFakeBar{
    if (!_toFakeBar) {
        _toFakeBar = [HTFakeNavigationBar new];
    }
    return _toFakeBar;
}


@end

@implementation UINavigationController (HTExtention)



//
//- (void)ht_updateNavigationBarFor:(UIViewController *)viewController{
//
//}


@end
