//
//  UIWindow+ScreenShot.m
//  UleApp
//
//  Created by chenzhuqing on 16/9/29.
//  Copyright © 2016年 ule. All rights reserved.
//

#import "UIWindow+ScreenShot.h"


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@implementation UIWindow (ScreenShot)

- (UIImage *)screenshot
{
    return [self screenshotWithRect:self.bounds];
}

- (UIImage *)screenshotWithRect:(CGRect)rect
{
    // Source (Under MIT License): https://github.com/shinydevelopment/SDScreenshotCapture/blob/master/SDScreenshotCapture/SDScreenshotCapture.m#L35
    
    BOOL ignoreOrientation = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0");
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    CGSize imageSize = CGSizeZero;
    CGFloat width = rect.size.width, height = rect.size.height;
    CGFloat x = rect.origin.x, y = rect.origin.y;
    
    //    imageSize = CGSizeMake(width, height);
    //    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    if (UIInterfaceOrientationIsPortrait(orientation) || ignoreOrientation)
    {
        //imageSize = [UIScreen mainScreen].bounds.size;
        imageSize = CGSizeMake(width, height);
        x = rect.origin.x, y = rect.origin.y;
    }
    else
    {
        //imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
        imageSize = CGSizeMake(height, width);
        x = rect.origin.y, y = rect.origin.x;
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.center.x, self.center.y);
    CGContextConcatCTM(context, self.transform);
    CGContextTranslateCTM(context, -self.bounds.size.width * self.layer.anchorPoint.x, -self.bounds.size.height * self.layer.anchorPoint.y);
    
    // Correct for the screen orientation
    if(!ignoreOrientation)
    {
        if(orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, (CGFloat)M_PI_2);
            CGContextTranslateCTM(context, 0, -self.bounds.size.height);
            CGContextTranslateCTM(context, -x, y);
        }
        else if(orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, (CGFloat)-M_PI_2);
            CGContextTranslateCTM(context, -self.bounds.size.width, 0);
            CGContextTranslateCTM(context, x, -y);
        }
        else if(orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            CGContextRotateCTM(context, (CGFloat)M_PI);
            CGContextTranslateCTM(context, -self.bounds.size.height, -self.bounds.size.width);
            CGContextTranslateCTM(context, x, y);
        }
        else
        {
            CGContextTranslateCTM(context, -x, -y);
        }
    }
    else
    {
        CGContextTranslateCTM(context, -x, -y);
    }
    
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    else
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
