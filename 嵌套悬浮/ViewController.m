//
//  ViewController.m
//  嵌套悬浮
//
//  Created by 陈竹青 on 2021/5/31.
//

#import "ViewController.h"
#import "MyContainerView.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MFNestTableViewDelegate>
@property (nonatomic, strong) MyContainerView * containerView;
@property (nonatomic, strong) UIScrollView * pageView;
@property (nonatomic, assign) BOOL canContentScroll;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UICollectionView * mCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:self.containerView];
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 210)];
    headView.backgroundColor=UIColor.redColor;
    [headView addSubview:self.imageView];
    [self.containerView.firstTableView setTableHeaderView:headView];
    
    [self.containerView.firstTableView setTableFooterView:self.pageView];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width -10)/2;
    
    layout.itemSize = CGSizeMake(width, 100);
    layout.minimumLineSpacing=10;
    layout.minimumInteritemSpacing = 10;
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.pageView.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    self.mCollectionView = collectionView;
    [self.pageView addSubview:collectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 40;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.blueColor;
    return  cell;
}

// 3个tableView，scrollView，webView滑动时都会响应这个方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"=====List");
    if (!_canContentScroll) {
        // 这里通过固定contentOffset，来实现不滚动
        scrollView.contentOffset = CGPointZero;
    } else if (scrollView.contentOffset.y <= 0) {
        _canContentScroll = NO;
        // 通知容器可以开始滚动
        _containerView.canScroll = YES;
    }
    scrollView.showsVerticalScrollIndicator = _canContentScroll;
}

// 当内容可以滚动时会调用
- (void)nestTableViewContentCanScroll:(MYTableView *)nestTableView{
    self.canContentScroll = YES;
}

// 当容器可以滚动时会调用
- (void)nestTableViewContainerCanScroll:(MYTableView *)nestTableView{
    self.mCollectionView.contentInset = UIEdgeInsetsZero;
    

    
//    CGFloat y = offsetY + self.mHeadView.height;
//    [self. scaleBHeadView:y];
//    CGFloat alpha;
//    if (y <= 0) {
//        alpha = 0;
//    } else {
//        alpha = y /100;
//    }
}

// 当容器正在滚动时调用，参数scrollView就是充当容器的tableView
- (void)nestTableViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY =scrollView.contentOffset.y;
    NSLog(@"==y==%@",@(offsetY));
    CGFloat y =  offsetY + 100;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 100;
    if (offsetY < 0) {
        CGFloat factor = ((ABS(offsetY)+height)*width)/height;
        CGRect frame = CGRectMake(-(factor-width)/2, offsetY, factor, height+ABS(offsetY));
        self.imageView.frame = frame;
    } else {
        CGRect frame = self.imageView.frame;
        frame.origin.y = 0;
        self.imageView.frame = frame;
    }
//    self.imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, alpa, alpa);
}

#pragma mark - <getter and setter>
- (MyContainerView *)containerView{
    if (!_containerView) {
        _containerView = [[MyContainerView alloc] initWithFrame:self.view.frame];
        _containerView.delegate=self;
    }
    return _containerView;
}

- (UIScrollView *)pageView{
    if (!_pageView) {
        _pageView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-80)];
    }
    return _pageView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        _imageView.image = [UIImage imageNamed:@"bg_s"];
        _imageView.layer.anchorPoint = CGPointMake(0.5, 1);
    }
    return _imageView;
}
@end
