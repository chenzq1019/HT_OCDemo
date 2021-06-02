//
//  MyContainerView.h
//  分页控制器二
//
//  Created by 陈竹青 on 2020/10/29.
//  Copyright © 2020 陈竹青. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MYTableView : UITableView

@property (nonatomic, strong) NSArray *allowGestureEventPassViews;

@end



@protocol MFNestTableViewDelegate <NSObject>

@required

// 当内容可以滚动时会调用
- (void)nestTableViewContentCanScroll:(MYTableView *)nestTableView;

// 当容器可以滚动时会调用
- (void)nestTableViewContainerCanScroll:(MYTableView *)nestTableView;

// 当容器正在滚动时调用，参数scrollView就是充当容器的tableView
- (void)nestTableViewDidScroll:(UIScrollView *)scrollView;

@end

@interface MyContainerView : UIView

@property (nonatomic, strong) MYTableView * firstTableView;
@property (nonatomic, weak) id<MFNestTableViewDelegate> delegate;
@property (nonatomic,assign) BOOL canScroll;
@end

NS_ASSUME_NONNULL_END
