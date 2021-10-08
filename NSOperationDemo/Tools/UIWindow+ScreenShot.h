//
//  UIWindow+ScreenShot.h
//  UleApp
//
//  Created by chenzhuqing on 16/9/29.
//  Copyright © 2016年 ule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (ScreenShot)

- (UIImage *)screenshot;

- (UIImage *)screenshotWithRect:(CGRect)rect;
@end
