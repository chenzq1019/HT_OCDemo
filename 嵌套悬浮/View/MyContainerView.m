//
//  MyContainerView.m
//  分页控制器二
//
//  Created by 陈竹青 on 2020/10/29.
//  Copyright © 2020 陈竹青. All rights reserved.
//

#import "MyContainerView.h"

@implementation MYTableView
#pragma mark - UIGestureRecognizerDelegate
// 返回YES表示可以继续传递触摸事件，这样两个嵌套的scrollView才能同时滚动
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end


@interface MyContainerView ()<UITableViewDelegate>

@end

@implementation MyContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    self =  [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    [self addSubview:self.firstTableView];
    self.canScroll=YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"offsetY=%@",@(scrollView.contentOffset.y));
    CGFloat contentOffset = 130;//[self heightForContainerCanScroll];
    if (!_canScroll) {
        // 这里通过固定contentOffset的值，来实现不滚动
        scrollView.contentOffset = CGPointMake(0, contentOffset);
    } else if (scrollView.contentOffset.y >= contentOffset) {
        scrollView.contentOffset = CGPointMake(0, contentOffset);
        self.canScroll = NO;
        // 通知delegate内容开始可以滚动
        if (self.delegate && [self.delegate respondsToSelector:@selector(nestTableViewContentCanScroll:)]) {
            [self.delegate nestTableViewContentCanScroll:self.firstTableView];
        }
    }
    scrollView.showsVerticalScrollIndicator = _canScroll;
    if (self.delegate && [self.delegate respondsToSelector:@selector(nestTableViewDidScroll:)]) {
        [self.delegate nestTableViewDidScroll:_firstTableView];
    }
}

#pragma mark - <getter>
- (MYTableView *)firstTableView{
    if (!_firstTableView) {
        _firstTableView  = [[MYTableView alloc] initWithFrame:self.bounds];
        _firstTableView.delegate=self;
        _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _firstTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _firstTableView;
}
@end
