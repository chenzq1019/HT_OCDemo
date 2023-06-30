//
//  TestVCViewController.m
//  自定义转场
//
//  Created by 陈竹青 on 2022/12/5.
//

#import "TestVCViewController.h"
#import "US_PresentAnimaiton.h"
#import "US_InteractiveTransition.h"
@interface TestVCViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) US_PresentAnimaiton * animation;
@end

@implementation TestVCViewController

- (instancetype)init{
    self  = [super init];
    if(self){
        _animation = [[US_PresentAnimaiton alloc] initWithAnimationType:AniamtionSheetType targetViewSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height*0.7)];
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate=_animation;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor= UIColor.whiteColor;
    [ _animation.interactive  transitionToViewController:self];
}



@end
