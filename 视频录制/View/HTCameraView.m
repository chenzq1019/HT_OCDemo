//
//  HTCameraView.m
//  视频录制
//
//  Created by 陈竹青 on 2021/12/8.
//

#import "HTCameraView.h"
#import "CicleProgressView.h"

@interface HTCameraView ()<CicleProgressViewProtocol>
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) HTVideoPreView * previewView;
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIView * bottomView;

@property (nonatomic, strong) UIView * focusView;
@property (nonatomic, strong) UIView * exposureView;

@property (nonatomic, strong) UISlider * slider;
@property (nonatomic, strong) UIButton * torchBtn;
@property (nonatomic, strong) UIButton * flashBtn;
@property (nonatomic, strong) UIButton * photoBtn;

@property (nonatomic, strong) CicleProgressView * pressBtn;
@end

@implementation HTCameraView

- (instancetype) initWithFrame:(CGRect)frame{
    self =  [super initWithFrame:frame];
    if (self) {
        _type = 1;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.previewView];
    
    [self.previewView addSubview:self.focusView];
    
    UIButton * swichCamer = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 60, 40)];
    [swichCamer setTitle:@"旋转" forState:UIControlStateNormal];
    [swichCamer setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [swichCamer addTarget:self action:@selector(swichCamerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.previewView addSubview:swichCamer];
    
    
    
    CicleProgressView * videoBtn = [[CicleProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)]; 
    videoBtn.center = CGPointMake(self.previewView.center.x, self.bottomView.center.y -50);
    self.pressBtn = videoBtn;
    videoBtn.delegate= self;
    [self.previewView addSubview:videoBtn];
    
    UILabel * noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(videoBtn.frame)-100, CGRectGetWidth(self.frame), 40)];
    noteLabel.textColor = UIColor.whiteColor;
    noteLabel.text = @"轻触拍照，长按录制视频";
    noteLabel.textAlignment = NSTextAlignmentCenter;
    noteLabel.font = [UIFont systemFontOfSize:15];
    [self.previewView addSubview:noteLabel];
    
    
    UITapGestureRecognizer * tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.previewView addGestureRecognizer:tapAction];
    UITapGestureRecognizer * doubleTapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTapAction.numberOfTapsRequired = 2;
    [self.previewView addGestureRecognizer:doubleTapAction];
    [tapAction requireGestureRecognizerToFail:doubleTapAction];
}


#pragma mark -<delegate>
- (void) didClickTakePhoto{
    if ([_delegate respondsToSelector:@selector(takePhotoAction:)]) {
        [_delegate takePhotoAction:self];
    }
}

- (void)beginRecordVideo{
    if ([_delegate respondsToSelector:@selector(startRecordVideoAction:)]) {
        [_delegate startRecordVideoAction:self];
    }
}

- (void)endRecordVideo{
    if ([_delegate respondsToSelector:@selector(stopRecordVideoAction:)]) {
        [_delegate stopRecordVideoAction:self];
    }
}


#pragma mark - <tap>
- (void)tapAction:(UIGestureRecognizer *)recognizer{
    NSLog(@"tapAction");
    if ([self.delegate respondsToSelector:@selector(focusAction:point:handle:)]) {
        CGPoint point = [recognizer locationInView:self.previewView];
        [self runFocusAnimation:self.focusView positon:point];
        [self.delegate focusAction:self point:[self.previewView captureDevicePointForPoint:point] handle:^(NSError * _Nonnull error) {
            
        }];
    }
}

- (void)doubleTapAction:(UIGestureRecognizer *)recognizer{
    
}

- (void)pinchAction:(UIGestureRecognizer *)recognizer{
    
}

- (void)swichCamerAction:(id)sender{
    if ([self.delegate respondsToSelector:@selector(swicthCameraAction:handle:)]) {
        [self.delegate swicthCameraAction:self handle:^(NSError * _Nonnull error) {
                    
        }];
    }
}
#pragma mark - <private methods>

- (void)runFocusAnimation:(UIView *)view positon:(CGPoint)point{
    view.center = point;
    view.hidden = NO;
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    } completion:^(BOOL finished) {
        double delayInsecondes = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInsecondes * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            view.hidden = YES;
            view.transform = CGAffineTransformIdentity;
        });
    }];
}

#pragma mark - <btn action>
- (void)takePicture:(id)sender{
    if (self.type == 1) {
        if ([_delegate respondsToSelector:@selector(takePhotoAction:)]) {
            [_delegate takePhotoAction:self];
        }
    } else {
//        if (btn.selected == YES) {
//            // 结束
//            btn.selected = NO;
//            [_photoBtn setTitle:@"开始" forState:UIControlStateNormal];
//            if ([_delegate respondsToSelector:@selector(stopRecordVideoAction:)]) {
//                [_delegate stopRecordVideoAction:self];
//            }
//        } else {
//            // 开始
//            btn.selected = YES;
//            [_photoBtn setTitle:@"结束" forState:UIControlStateNormal];
//            if ([_delegate respondsToSelector:@selector(startRecordVideoAction:)]) {
//                [_delegate startRecordVideoAction:self];
//            }
//        }
    }
}

- (void)cancel:(id)sender{
    
}

- (void)changeType:(id)sender{
    
}
#pragma mark - <getter and setter>
- (HTVideoPreView *)previewView{
    if (!_previewView) {
        _previewView = [[HTVideoPreView alloc] initWithFrame:self.frame];
        
    }
    return _previewView;
}

-(UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
        _topView.backgroundColor = [UIColor blackColor];
    }
    return _topView;
}

-(UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-100, self.frame.size.width, 100)];
        _bottomView.backgroundColor = [UIColor blackColor];
    }
    return _bottomView;
}

-(UIView *)focusView{
    if (_focusView == nil) {
        _focusView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150, 150.0f)];
        _focusView.backgroundColor = [UIColor clearColor];
        _focusView.layer.borderColor = [UIColor blueColor].CGColor;
        _focusView.layer.borderWidth = 5.0f;
        _focusView.hidden = YES;
    }
    return _focusView;
}

-(UIView *)exposureView{
    if (_exposureView == nil) {
        _exposureView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150, 150.0f)];
        _exposureView.backgroundColor = [UIColor clearColor];
        _exposureView.layer.borderColor = [UIColor purpleColor].CGColor;
        _exposureView.layer.borderWidth = 5.0f;
        _exposureView.hidden = YES;
    }
    return _exposureView;
}

-(UISlider *)slider{
    if (_slider == nil) {
        _slider = [[UISlider alloc] init];
        _slider.minimumValue = 0;
        _slider.maximumValue = 1;
        _slider.maximumTrackTintColor = [UIColor whiteColor];
        _slider.minimumTrackTintColor = [UIColor whiteColor];
        _slider.alpha = 0.0;
    }
    return _slider;
}

@end
