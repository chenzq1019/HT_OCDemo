//
//  HT_LoginProtocolVC.m
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2021/9/10.
//

#import "HT_LoginProtocolVC.h"
#import <Masonry/Masonry.h>

@interface HT_LoginProtocolVC ()<UITextViewDelegate>

@end

@implementation HT_LoginProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    
    UITextView * protocolView = [[UITextView alloc] init];
    protocolView.delegate = self;
    protocolView.scrollEnabled = NO;//设置为不可滑动，就能使用自适应高度了。
    protocolView.font = [UIFont systemFontOfSize:15];
    protocolView.textColor = [UIColor blackColor];
    NSString * protocolStr = @"同意《邮乐用户协议》、《隐私权政策》、《中国邮政会员服务协议》、《积分授权及账户绑定条款》及其相关的条款和条件";
    NSMutableAttributedString * attribute = [[NSMutableAttributedString alloc] initWithString:protocolStr];
    
    [attribute addAttribute:NSLinkAttributeName value:@"uleProtocol://" range:[protocolStr rangeOfString:@"《邮乐用户协议》"]];
    [attribute addAttribute:NSLinkAttributeName value:@"YSProtocol://" range:[protocolStr rangeOfString:@"《隐私权政策》"]];
    [attribute addAttribute:NSLinkAttributeName value:@"ZGYZProtocol://" range:[protocolStr rangeOfString:@"《中国邮政会员服务协议》"]];
    [attribute addAttribute:NSLinkAttributeName value:@"JFSQProtocol://" range:[protocolStr rangeOfString:@"《积分授权及账户绑定条款》"]];
    
    protocolView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor]};
    protocolView.attributedText = attribute;
    
    [self.view addSubview:protocolView];
    [protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.top.equalTo(self.view).offset(100);

    }];
    
}

#pragma mark - <delegate>
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    
    NSString * scheme = URL.scheme;
    if ([scheme isEqualToString:@"uleProtocol"]) {
        NSLog(@"uleProtocol");
        return false;
    }
    if ([scheme isEqualToString:@"YSProtocol"]) {
        NSLog(@"YSProtocol");
        return false;
    }
    if ([scheme isEqualToString:@"ZGYZProtocol"]) {
        NSLog(@"ZGYZProtocol");
        return false;
    }
    if ([scheme isEqualToString:@"JFSQProtocol"]) {
        NSLog(@"JFSQProtocol");
        return false;
    }
    return  true;
}

@end
