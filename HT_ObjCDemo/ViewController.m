//
//  ViewController.m
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2020/12/28.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "SendMsgViewController.h"
#import "HT_LoginProtocolVC.h"
#import "HT_CollectionViewController.h"

@interface ViewController ()< UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * mTableView;
@property (nonatomic, strong) NSMutableArray * mdataArray;
@end

@implementation ViewController
- (IBAction)click:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试模块";
    [self loadData];
    [self.view addSubview:self.mTableView];
    [self.mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (void)loadData{
    _mdataArray = [@[@"发送短信",@"富文本可点击",@"UICollectionView分组背景颜色"] mutableCopy];
}


#pragma mark - <delegate and datasource>
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mdataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.mdataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            SendMsgViewController * sendVC = [[SendMsgViewController alloc] init];
            [self.navigationController pushViewController:sendVC animated:YES];
            
        }break;
        case 1:{
            HT_LoginProtocolVC * vc = [[HT_LoginProtocolVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            HT_CollectionViewController * vc = [[HT_CollectionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - <getter>
- (UITableView *)mTableView{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mTableView.delegate= self;
        _mTableView.dataSource = self;
        [_mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mycell"];
        
    }
    return _mTableView;
}
- (NSMutableArray *)mdataArray{
    if (!_mdataArray) {
        _mdataArray = [NSMutableArray new];
    }
    return _mdataArray;
}
@end
