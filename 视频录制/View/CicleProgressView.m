//
//  CicleProgressView.m
//  视频录制
//
//  Created by 陈竹青 on 2021/12/8.
//

#define kWidth 8

#import "CicleProgressView.h"

@interface CicleProgressView ()<CAAnimationDelegate>
@property (nonatomic, strong) CAShapeLayer * shaperLayer;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) CABasicAnimation * animation;
@property (nonatomic, strong) CAShapeLayer * cicleLayer;
@end

@implementation CicleProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.9];
        self.layer.cornerRadius = frame.size.width/2.0;
        self.clipsToBounds= YES;
        _cicleLayer = [CAShapeLayer layer];
        _cicleLayer.fillColor = [UIColor whiteColor].CGColor;
        _cicleLayer.frame = CGRectMake(0, 0, frame.size.width-kWidth*2, frame.size.height-kWidth*2);
        CGFloat radius =  (frame.size.width-kWidth*2)/2.0;
        UIBezierPath * path1 = [UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
        _cicleLayer.path = path1.CGPath;
        [self.layer addSublayer:_cicleLayer];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressAction:)];
        [self addGestureRecognizer:longPress];
        
        
    }
    return self;
}

- (void)tapAction:(UIGestureRecognizer *)recognizer{
    NSLog(@"单击");
    CAKeyframeAnimation * keyFrameAniamation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyFrameAniamation.duration = 0.3;
    keyFrameAniamation.values = @[@1,@0.8,@1];
    [self.cicleLayer addAnimation:keyFrameAniamation forKey:@"scale"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickTakePhoto)]) {
        [self.delegate didClickTakePhoto];
    }
    
}

- (void)longpressAction:(UILongPressGestureRecognizer *)recognizer{
    switch (recognizer.state) {

        case UIGestureRecognizerStateBegan:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self scaleAniamal];
                self.shaperLayer = [CAShapeLayer layer];
                self.shaperLayer.frame = self.bounds;
                self.shaperLayer.fillColor = UIColor.clearColor.CGColor;
                self.shaperLayer.strokeColor = UIColor.greenColor.CGColor;
                self.shaperLayer.lineWidth = kWidth;
                        CGFloat width = self.frame.size.width;
                        CGPoint center = CGPointMake(width/2, width/2);
                UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:(width/2 - kWidth/2) startAngle:-M_PI_2 endAngle:3*M_PI/2 clockwise:YES];
                self.shaperLayer.path = path.CGPath;
                CABasicAnimation * animation  = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                animation.duration = 15;
                animation.fromValue = @0;
                animation.toValue= @1;
                animation.removedOnCompletion= YES;
                animation.delegate = self;
                [self.layer addSublayer:self.shaperLayer];
                [self.shaperLayer addAnimation:animation forKey:@"strokeEnd"];
                if (self.delegate && [self.delegate respondsToSelector:@selector(beginRecordVideo)]) {
                    [self.delegate beginRecordVideo];
                }
            });

          
        }
            break;
        case UIGestureRecognizerStateEnded:{
            [self.shaperLayer removeAnimationForKey:@"strokeEnd"];
            [self.shaperLayer removeFromSuperlayer];
            self.shaperLayer = nil;
            CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            animation.duration = 0.3;
            animation.fromValue = @0.7;
            animation.toValue = @1;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [self.cicleLayer addAnimation:animation forKey:@"scale"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(endRecordVideo)]) {
                [self.delegate endRecordVideo];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        default:
            break;
    }
}

- (void)scaleAniamal{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.3;
    animation.fromValue = @1;
    animation.toValue = @0.7;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.cicleLayer addAnimation:animation forKey:@"scale"];
}


@end
