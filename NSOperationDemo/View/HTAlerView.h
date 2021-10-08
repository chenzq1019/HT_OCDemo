//
//  HTAlerView.h
//  NSOperationDemo
//
//  Created by 陈竹青 on 2021/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HTAlerViewClickBlock)(void);

@interface HTAlerView : UIView
@property(nonatomic, strong) HTAlerViewClickBlock clickBLock;
@end

NS_ASSUME_NONNULL_END
