//
//  HT_CollectionViewController.m
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2021/11/16.
//

#import "HT_CollectionViewController.h"
#import <Masonry/Masonry.h>
#import "JHCollectionViewFlowLayout.h"
#import "JHCollectionReusableView.h"
@interface HT_CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,JHCollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * mCollectionView;
@end

@implementation HT_CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mCollectionView];
    
    [self.mCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.redColor;
    return cell;
}

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section{
    if (section ==0) {
        return UIColor.blueColor;
    }
    if (section ==1) {
        return UIColor.greenColor;
    }
    if (section ==2) {
        return UIColor.orangeColor;
    }
    return UIColor.whiteColor;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString: @"UICollectionElementKindSectionHeader"]) {
        JHCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = UIColor.blueColor;
        return  header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}

#pragma mark - <getter>

- (UICollectionView *)mCollectionView{
    if (!_mCollectionView) {
        JHCollectionViewFlowLayout * layout = [[JHCollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing =10;
        layout.minimumInteritemSpacing = 10;
        CGFloat width =( [UIScreen mainScreen].bounds.size.width - 30)/2.0;
        layout.itemSize = CGSizeMake(width, 100);
        layout.sectionInset =UIEdgeInsetsMake(10, 10, 10, 10);
        _mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _mCollectionView.dataSource= self;
        _mCollectionView.delegate = self;
        [_mCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
        [_mCollectionView registerClass:[JHCollectionReusableView class] forSupplementaryViewOfKind: @"UICollectionElementKindSectionHeader" withReuseIdentifier:@"header"];
        _mCollectionView.backgroundColor = UIColor.whiteColor;
    }
    return _mCollectionView;
}

@end
