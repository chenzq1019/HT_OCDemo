//
//  HTVideoPreView.m
//  视频录制
//
//  Created by 陈竹青 on 2021/12/8.
//

#import "HTVideoPreView.h"

@implementation HTVideoPreView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [(AVCaptureVideoPreviewLayer *)self.layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    }
    return self;
}

- (CGPoint)captureDevicePointForPoint:(CGPoint)point{
    AVCaptureVideoPreviewLayer * layer =  (AVCaptureVideoPreviewLayer *)self.layer;
    return [layer captureDevicePointOfInterestForPoint:point];
}

//重定义layer
+ (Class) layerClass{
    return [AVCaptureVideoPreviewLayer class];
}

#pragma mark - <getter and setter>
- (AVCaptureSession *)captureSessionsion{
    return [(AVCaptureVideoPreviewLayer *)self.layer session];
}

- (void)setCaptureSessionsion:(AVCaptureSession *)captureSessionsion{
    [(AVCaptureVideoPreviewLayer *)self.layer setSession:captureSessionsion];
}

@end
