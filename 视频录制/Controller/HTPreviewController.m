//
//  HTPreviewController.m
//  视频录制
//
//  Created by 陈竹青 on 2021/12/9.
//

#import "HTPreviewController.h"

@interface HTPreviewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIButton * saveBtn;

@end

@implementation HTPreviewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.scrollView];
//    [self.view addSubview:self.imageView];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.imageView.image.size;
    
    _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(self.view.frame) -100, 70, 40)];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
}

- (void)doubleTapAction:(UIGestureRecognizer *)tap{
    NSLog(@"=====");
    
    if (_scrollView.zoomScale > _scrollView.minimumZoomScale) {
        _scrollView.contentInset = UIEdgeInsetsZero;
        [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:YES];
    } else {
        CGPoint touchPoint = [tap locationInView:self.imageView];
        CGFloat newZoomScale = _scrollView.maximumZoomScale;
        CGFloat xsize = self.view.frame.size.width / newZoomScale;
        CGFloat ysize = self.view.frame.size.height / newZoomScale;
        [_scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
    
//    CGFloat width = CGRectGetWidth(self.view.frame);
//    CGFloat height = CGRectGetHeight(self.view.frame);
//    [self.scrollView zoomToRect:CGRectMake(-(width/2.0), -(height/2.0), 2*width, 2*height) animated:YES];
}

#pragma mark - <>

- (void)setPhotoImage:(UIImage *)photoImage{
    self.imageView.image = photoImage;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGSize boundsSize = scrollView.bounds.size;
        CGRect frameToCenter = self.imageView.frame;

        // center horizontally
        if (frameToCenter.size.width < boundsSize.width)
        {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
        } else {
            frameToCenter.origin.x = 0;
        }

        // center vertically
        if (frameToCenter.size.height < boundsSize.height)
        {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
        } else {
            frameToCenter.origin.y = 0;
        }

        self.imageView.frame = frameToCenter;
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)saveClick:(id)sender{
    if (self.imageView.image) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - <getter and setter>

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.minimumZoomScale=1;
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.delegate= self;
        
    }
    return _scrollView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _imageView;
}
@end
