//
//  SendMsgViewController.m
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2021/9/10.
//

#import "SendMsgViewController.h"
#import <MessageUI/MFMessageComposeViewController.h>
@interface SendMsgViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation SendMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    UIButton * sender = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 40)];
    sender.backgroundColor= UIColor.redColor;
    [sender addTarget:self action:@selector(sendeMsg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender];
    
}

- (void)sendeMsg:(id)sender{
    if ([MFMessageComposeViewController canSendText]) {
            //  判断一下是否支持发送短信，比如模拟器
        NSString * str = @"18016333297;10086";
        NSArray * array = [str componentsSeparatedByString:@";"];
            MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
            messageVC.recipients = array; //需要发送的手机号数组
            messageVC.body = @"发送的内容";
            messageVC.messageComposeDelegate = self; //指定代理
        [self presentViewController:messageVC animated:YES completion:^{
//            [messageVC dismissViewControllerAnimated:YES completion:nil];
        }];
        } else {
//            [SVProgressHUD showErrorWithStatus:@"设备不支持短信功能"];
            NSLog(@"不支持");
        }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
