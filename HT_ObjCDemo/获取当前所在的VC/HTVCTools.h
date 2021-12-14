//
//  HTVCTools.h
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2021/12/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HTVCTools : NSObject


+ (UIViewController *)findNextViewControllerByResponder:(UIResponder *)responder;
@end

NS_ASSUME_NONNULL_END
