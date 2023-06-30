//
//  US_PresentAnimaiton.h
//
//  Created by chenzhuqing on 2019/1/24.
//  Copyright © 2019年 Baoqin Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "US_InteractiveTransition.h"
typedef enum : NSUInteger {
    AniamtionSheetType,
    Aniamtion3DTransform,
    AniamtionAlertType,
} USAniamtionType;

NS_ASSUME_NONNULL_BEGIN
typedef void(^PresentAnimationBlock)(void);
@interface US_PresentAnimaiton : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>
@property (nonatomic,assign) CGFloat animatTime;
@property (nonatomic,strong) PresentAnimationBlock clicBlock;
@property (nonatomic, strong) US_InteractiveTransition * interactive;
- (instancetype)initWithAnimationType:(USAniamtionType)animationType targetViewSize:(CGSize) size;

@end

NS_ASSUME_NONNULL_END
