//
//  HT_StacViewVC.m
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2021/12/30.
//

#import "HT_StacViewVC.h"

@interface HT_StacViewVC ()
@property (nonatomic, strong) UIStackView * stackView;
@end

@implementation HT_StacViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _stackView = [[UIStackView alloc] init];
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.spacing = 10;
    _stackView.distribution = UIStackViewDistributionFillEqually;
    _stackView.alignment = UIStackViewAlignmentFill;
    _stackView.frame = CGRectMake(0, 100, self.view.frame.size.width,110);
    [self.view addSubview:_stackView];
    for (int i=0; i<6; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        [btn setTitle:[NSString stringWithFormat:@"%@",@(i)] forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.redColor;
        [_stackView addArrangedSubview:btn];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
