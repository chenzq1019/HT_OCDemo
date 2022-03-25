//
//  TwoViewController.m
//  自定义导航栏
//
//  Created by 陈竹青 on 2021/10/12.
//

#import "TwoViewController.h"
#import "UIViewController+NaviExtension.h"
#import "SearchResultViewController.h"
#import "UINavigationController+HTExtention.h"

@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UITableView * mTableView;
@property (nonatomic, strong) UIView * mTopView;
@property (nonatomic, strong) UISearchController * mSearchController;
@property (nonatomic, assign) CGFloat mContentOffsetY;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"页面二";
    self.view.backgroundColor = UIColor.whiteColor;
    self.ht_backgoundColor = UIColor.orangeColor;
    self.ht_backgoundImage = [UIImage imageNamed:@"image0"];
  
    [self.view addSubview:self.mTableView];
//    [self.mTableView addSubview:self.mSearchBar];
//    self.mTableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
//    self.navigationItem.searchController = self.mSearchController;
    self.mTableView.tableHeaderView = self.mSearchController.searchBar;
}


#pragma mark - <dataSource and Delegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ ---- 行",@(indexPath.row)];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.mContentOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.isDragging) {
        if (scrollView.contentOffset.y - self.mContentOffsetY > 5.0) {
            NSLog(@"向上滑动=====");
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }else if(self.mContentOffsetY - scrollView.contentOffset.y > 5.0){
            NSLog(@"想下滑动*****");
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"begin search");
//    self.mTableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
}


#pragma mark - <getter>
- (UITableView *)mTableView{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
        _mTableView.delegate= self;
        _mTableView.dataSource = self;
    }
    return _mTableView;
}
//
//- (UISearchBar *)mSearchBar{
//    if (!_mSearchBar) {
//        _mSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, -45, CGRectGetWidth(self.view.frame), 45)];
//        _mSearchBar.delegate = self;
//    }
//    return _mSearchBar;
//}

- (UISearchController *)mSearchController{
    if (!_mSearchController) {
        SearchResultViewController * resultVC = [SearchResultViewController new];
        _mSearchController = [[UISearchController alloc] init];
        [_mSearchController.view addSubview:resultVC.view];
        _mSearchController.searchResultsUpdater = resultVC;
        _mSearchController.searchBar.delegate = resultVC;
        _mSearchController.delegate = resultVC;
        _mSearchController.searchBar.placeholder = @"搜索";
        _mSearchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        [_mSearchController.searchBar sizeToFit];
        
        // 3.设置搜索框文字的偏移
        _mSearchController.searchBar.searchTextPositionAdjustment = UIOffsetMake(3, 0);
        
        // 4.设置搜索框图标的偏移
//        CGFloat offsetX = (self.view.bounds.size.width - 200 - 32) / 2;
//        [_mSearchController.searchBar setPositionAdjustment:UIOffsetMake(offsetX, 0) forSearchBarIcon:UISearchBarIconSearch];

    }
    
    
    return _mSearchController;
}
@end
