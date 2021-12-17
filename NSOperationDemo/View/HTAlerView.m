//
//  HTAlerView.m
//  NSOperationDemo
//
//  Created by 陈竹青 on 2021/9/29.
//

#import "HTAlerView.h"
#import "UIView+ShowAnimation.h"
#import "UIViewController+UleExtension.h"
@interface HTAlerView ()
@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) UILabel * titleLable;
@end

@implementation HTAlerView


- (instancetype)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.btn];
        [self addSubview:self.titleLable];
    }
    return self;
}

- (void)clickAt:(id)sender{
    if (self.clickBLock) {
        self.clickBLock();
    }
    [self hiddenView];
    NSLog(@"%@", [UIViewController currentViewController]);
}

- (void)setSortNum:(NSInteger)sortNum{
    self.titleLable.text = [NSString stringWithFormat:@"%@",@(sortNum)];
}

#pragma mark - <getter>

- (UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
        _btn.backgroundColor = [UIColor redColor];
        [_btn addTarget:self action:@selector(clickAt:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _btn;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        _titleLable.textColor = [UIColor blackColor];
    }
    return  _titleLable;
}
@end
