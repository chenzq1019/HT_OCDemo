//
//  ViewController.m
//  页面灰度处理（为悼念日准备）
//
//  Created by 陈竹青 on 2021/12/13.
//

#import "ViewController.h"
#import "SDAnimatedImageView.h"
#import <SDWebImage/SDWebImage.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 40)];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(220, 100, 100, 40)];
    title.textColor = [UIColor blackColor];
    title.text = @"我的颜色是黑色";
    [self.view addSubview:title];
    
//    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, 100, 100)];
//    imageView.image = [UIImage imageNamed:@"background_update_top"];
//    [self.view addSubview:imageView];
    
    //@"https://pic.ulecdn.com/pic/user_1655187885120/product/prd20221128/afcb4c83893a631e_p750x200.gif"
    
    SDAnimatedImageView * imageViewGif = [[SDAnimatedImageView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 200)];
    [imageViewGif sd_setImageWithURL:[NSURL URLWithString:@"https://pic.ulecdn.com/pic/user_1655187885120/product/prd20221018/4cd2dd4a9d93d557_p750x200.gif"] placeholderImage:nil];
    [self.view addSubview:imageViewGif];
    

}


@end
