//
//  HTFakeNavigationBar.m
//  自定义导航栏
//
//  Created by 陈竹青 on 2021/10/11.
//

#import "HTFakeNavigationBar.h"
#import "UIViewController+NaviExtension.h"

@implementation HTFakeNavigationBar

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.fakeBacekgoundEffectView];
    [self addSubview:self.fakeBackgroundImageView];
    [self addSubview:self.fakeShadowImageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.fakeBacekgoundEffectView.frame = self.bounds;
    self.fakeBackgroundImageView.frame = self.bounds;
    self.fakeShadowImageView.frame = CGRectMake(0, self.bounds.size.height -0.5, self.bounds.size.width, 0.5);
}

- (void)ht_updateFameBarBackgroundFor:(UIViewController *) viewController{
    self.fakeBacekgoundEffectView.subviews.lastObject.backgroundColor = viewController.ht_backgoundColor;
    self.fakeBacekgoundEffectView.backgroundColor = viewController.ht_backgoundColor;;
    self.fakeBackgroundImageView.image = viewController.ht_backgoundImage;
    if (viewController.ht_backgoundImage != nil) {
        for (UIView * subView in self.fakeBacekgoundEffectView.subviews) {
            subView.alpha = 0.0;
        }
    }else{
        for (UIView * subView in self.fakeBacekgoundEffectView.subviews) {
            subView.alpha = viewController.ht_barAlpha;
        }
    }
    self.fakeShadowImageView.alpha = viewController.ht_barAlpha;
    self.fakeBackgroundImageView.alpha = viewController.ht_barAlpha;
}


- (void)ht_updateFakeBarShadowFor:(UIViewController *)viewController{
    [self.fakeShadowImageView setHidden:viewController.ht_shadowHidden];
    self.fakeShadowImageView.backgroundColor = viewController.ht_shadowColor;
}


#pragma mark - <getter>

- (UIImageView *)fakeBackgroundImageView{
    if (!_fakeBackgroundImageView) {
        _fakeBackgroundImageView = [UIImageView new];
        _fakeBackgroundImageView.contentScaleFactor =1;
        _fakeBackgroundImageView.contentMode = UIViewContentModeScaleToFill;
        _fakeBackgroundImageView.backgroundColor = UIColor.clearColor;
    }
    return _fakeBackgroundImageView;
}

- (UIVisualEffectView *)fakeBacekgoundEffectView{
    if (!_fakeBacekgoundEffectView) {
        _fakeBacekgoundEffectView = [UIVisualEffectView new];
    }
    return _fakeBacekgoundEffectView;
}

- (UIImageView *)fakeShadowImageView{
    if (!_fakeShadowImageView) {
        _fakeShadowImageView = [UIImageView new];
        _fakeShadowImageView.contentScaleFactor = 1;
    }
    return _fakeShadowImageView;
}

@end
