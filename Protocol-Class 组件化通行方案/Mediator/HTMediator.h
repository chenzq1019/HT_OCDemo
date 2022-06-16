//
//  HTMediator.h
//  Protocol-Class 组件化通行方案
//
//  Created by 陈竹青 on 2022/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTMediator : NSObject


+(void)registerProcol:(Protocol *) protocol forclass:(Class) cls;

+ (Class) classForProtocol:(Protocol *)protocol;

@end

NS_ASSUME_NONNULL_END
