//
//  HTToolManager.h
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2021/12/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTToolManager : NSObject

@property (nonatomic,class,readonly) HTToolManager * instance;


- (void)takeTestFunc;
@end

NS_ASSUME_NONNULL_END
