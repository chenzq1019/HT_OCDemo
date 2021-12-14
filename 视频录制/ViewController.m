//
//  ViewController.m
//  视频录制
//
//  Created by 陈竹青 on 2021/12/6.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreMedia/CMMetadata.h>
#import <Photos/Photos.h>
#import "HTCameraView.h"
#import "CCMotionManager.h"
#import "CCMovieManager.h"
#import "CCCameraManager.h"
#import "UIView+CCHUD.h"
#import "CicleProgressView.h"
#import "HTPreviewController.h"
@interface ViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate,AVCapturePhotoCaptureDelegate,HTCameraViewDelegate>{
    //会话
    AVCaptureSession   * _session;
    //输入
    AVCaptureDeviceInput * _deviceInput;
    
    //输出
    AVCaptureConnection  *  _videoConnection;
    AVCaptureConnection  *  _audioConnection;
    AVCaptureVideoDataOutput * _videoOutput;
    AVCapturePhotoOutput * _imageOutput;
    AVCaptureStillImageOutput * _oldImageOutput;
    
}

@property (nonatomic, strong) HTCameraView * cameraView;
@property(nonatomic, strong) CCMotionManager *motionManager;    // 陀螺仪管理
@property (nonatomic, strong) CCMovieManager * movieManager;  //
@property(nonatomic, strong) CCCameraManager *cameraManager;    // 相机管理

@property (nonatomic, assign) BOOL  recording;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _movieManager = [[CCMovieManager alloc] init];
    _cameraManager = [[CCCameraManager alloc] init];
    self.cameraView = [[HTCameraView alloc] initWithFrame:self.view.bounds];
    self.cameraView.delegate = self;
    [self.view addSubview:self.cameraView];
    
    NSError * error;
    [self setupSession:&error];
    if (!error) {
        [self.cameraView.previewView setCaptureSessionsion:_session];
        [self startCaptureSession];
    }else{
        
    }
}
#pragma mark - <相关配置>
//创建会话
- (void)setupSession:(NSError **)error{
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetHigh;
    
    [self setupSessionInputs:error];
    [self setupSessionOutputs:error];
}

//配置输入
- (void)setupSessionInputs:(NSError **)error{
    //视频输入
    AVCaptureDevice * videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput * videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:error];
    if (videoInput) {
        if ([_session canAddInput:videoInput]) {
            [_session addInput:videoInput];
        }
    }
    _deviceInput = videoInput;
    //音频输入
    AVCaptureDevice * audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput * audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:error];
    if (audioInput) {
        if ([_session canAddInput:audioInput]) {
            [_session addInput:audioInput];
        }
    }
}

//配置输出
- (void)setupSessionOutputs:(NSError **)error{
    dispatch_queue_t captureQueue = dispatch_queue_create("com.cc.captureQueue", DISPATCH_QUEUE_SERIAL);
    
    //视频输出
    AVCaptureVideoDataOutput * videoOut = [[AVCaptureVideoDataOutput alloc] init];
    [videoOut setAlwaysDiscardsLateVideoFrames:YES];
    [videoOut setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey: [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]}];
    [videoOut setSampleBufferDelegate:self queue:captureQueue];
    
    if ([_session canAddOutput:videoOut]) {
        [_session addOutput:videoOut];
    }
    _videoOutput = videoOut;
    _videoConnection = [videoOut connectionWithMediaType:AVMediaTypeVideo];
    
    //音频输出
    AVCaptureAudioDataOutput * audioOut = [[AVCaptureAudioDataOutput alloc] init];
    [audioOut setSampleBufferDelegate:self queue:captureQueue];
    if ([_session canAddOutput:audioOut]) {
        [_session addOutput:audioOut];
    }
    _audioConnection = [audioOut connectionWithMediaType:AVMediaTypeAudio];
    
    //静态图片输出
    if (@available(iOS 10.0, *)) {
        AVCapturePhotoOutput * imageOutPut = [[AVCapturePhotoOutput alloc] init];
        if ([_session canAddOutput:imageOutPut]) {
            [_session addOutput:imageOutPut];
        }
        _imageOutput = imageOutPut;
    }else{
        AVCaptureStillImageOutput * imageOutput = [[AVCaptureStillImageOutput alloc] init];
        imageOutput.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
        if ([_session canAddOutput:imageOutput]) {
            [_session addOutput:imageOutput];
        }
        _oldImageOutput = imageOutput;
    }

}

#pragma mark - -会话控制
// 开启捕捉
- (void)startCaptureSession{
    if (!_session.isRunning){
        [_session startRunning];
    }
}

// 停止捕捉
- (void)stopCaptureSession{
    if (_session.isRunning){
        [_session stopRunning];
    }
}


#pragma mark - <output Delegate>
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    if (_recording) {
        NSLog(@"recording=====");
        [_movieManager writeData:connection video:_videoConnection audio:_audioConnection buffer:sampleBuffer];
    }
}
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error API_AVAILABLE(ios(11.0)){
    if (photo) {
        CGImageRef cgImage = [photo CGImageRepresentation];
        UIImage * image = [UIImage imageWithCGImage:cgImage];
        if (_deviceInput.device.position == AVCaptureDevicePositionFront) {
            UIImageOrientation imgOrientation = UIImageOrientationLeftMirrored;
            image = [[UIImage alloc] initWithCGImage:cgImage scale:1.0f orientation:imgOrientation];
        }else{
            UIImageOrientation imageOrientation = UIImageOrientationRight;
            image = [[UIImage alloc] initWithCGImage:cgImage scale:1.0f orientation:imageOrientation];
        }
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        HTPreviewController * previewVC = [[HTPreviewController alloc] init];
        previewVC.photoImage = image;
        previewVC.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:previewVC animated:NO completion:nil];
    }
}
#pragma mark - <CameraView Delegate>
// 拍照
- (void)takePhotoAction:(HTCameraView *)cameraView{
    AVCaptureConnection *connection = [_imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (connection.isVideoOrientationSupported) {
        connection.videoOrientation = [self currentVideoOrientation];
    }
    
    if (@available(iOS 10.0, *)) {
        AVCapturePhotoSettings * settings = [AVCapturePhotoSettings photoSettings];
        [_imageOutput capturePhotoWithSettings:settings delegate:self];
    }else{
        [_oldImageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
            if (error) {
                [self.view showError:error];
                return;
            }
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [[UIImage alloc]initWithData:imageData];
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

        }];
    }

}

/// 开始录制视频
-(void)startRecordVideoAction:(HTCameraView *)cameraView{
    NSLog(@"开始录制视频");
    _recording = YES;
    self.movieManager.currentDevice = _deviceInput.device;
    self.movieManager.currentOrientation = [self currentVideoOrientation];
    [self.movieManager start:^(NSError * _Nonnull error) {
        if (error) [self.view showError:error];
    }];
}


/// 停止录制视频
-(void)stopRecordVideoAction:(HTCameraView *)cameraView{
    NSLog(@"停止录制");
    _recording = NO;
    [self.movieManager stop:^(NSURL * _Nonnull url, NSError * _Nonnull error) {
        if (error) {
            [self.view showError:error];
        } else {
            [self.view showAlertView:@"是否保存到相册" ok:^(UIAlertAction *act) {
                [self saveMovieToCameraRoll: url];
            } cancel:nil];
        }
    }];
}


// 保存视频
- (void)saveMovieToCameraRoll:(NSURL *)url{
    [self.view showLoadHUD:@"保存中..."];
    if (@available(iOS 10.0,*)) {
        [PHPhotoLibrary requestAuthorization:^( PHAuthorizationStatus status ) {
            if (status != PHAuthorizationStatusAuthorized) return;
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetCreationRequest *videoRequest = [PHAssetCreationRequest creationRequestForAsset];
                [videoRequest addResourceWithType:PHAssetResourceTypeVideo fileURL:url options:nil];
            } completionHandler:^( BOOL success, NSError * _Nullable error ) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.view hideHUD];
                });
                success?:[self.view showError:error];
            }];
        }];
    } else {
        ALAssetsLibrary *lab = [[ALAssetsLibrary alloc]init];
        [lab writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.view hideHUD];
            });
            !error?:[self.view showError:error];
        }];
    }
}
//聚焦
- (void)focusAction:(HTCameraView *)cameraView point:(CGPoint)point handle:(void (^)(NSError * _Nonnull))handle{
    NSError * error = [self.cameraManager focus:_deviceInput.device point:point];
    handle(error);
}
- (void)swicthCameraAction:(HTCameraView *)cameraView handle:(void (^)(NSError * _Nonnull))handle{
    NSError *error;
    AVCaptureDevice *videoDevice = [self inactiveCamera];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if (videoInput) {
        // 动画效果
        CATransition *animation = [CATransition animation];
        animation.type = @"oglFlip";
        animation.subtype = kCATransitionFromLeft;
        animation.duration = 0.5;
        [self.cameraView.previewView.layer addAnimation:animation forKey:@"flip"];

        // 当前闪光灯状态
        AVCaptureFlashMode mode = [_cameraManager flashMode:[self activeCamera]];

        // 转换摄像头
        _deviceInput = [_cameraManager switchCamera:_session old:_deviceInput new:videoInput];

        // 重新设置视频输出链接
        _videoConnection = [_videoOutput connectionWithMediaType:AVMediaTypeVideo];

        // 如果后置转前置，系统会自动关闭手电筒(如果之前打开的，需要更新UI)
        if (videoDevice.position == AVCaptureDevicePositionFront) {
//            [self.cameraView changeTorch:NO];
        }

        // 前后摄像头的闪光灯不是同步的，所以在转换摄像头后需要重新设置闪光灯
        [_cameraManager changeFlash:[self activeCamera] mode:mode];
    }
    handle(error);
}
#pragma mark - -其它方法
// 当前设备取向
- (AVCaptureVideoOrientation)currentVideoOrientation{
    AVCaptureVideoOrientation orientation;
    switch (self.motionManager.deviceOrientation) {
        case UIDeviceOrientationPortrait:
            orientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeLeft:
            orientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            orientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        default:
            orientation = AVCaptureVideoOrientationPortrait;
            break;
    }
    return orientation;
}

- (AVCaptureDevice *)inactiveCamera{
    AVCaptureDevice *device = nil;
    if ([[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1) {
        if ([self activeCamera].position == AVCaptureDevicePositionBack) {
            device = [self cameraWithPosition:AVCaptureDevicePositionFront];
        } else {
            device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }
    }
    return device;
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *)activeCamera{
    return _deviceInput.device;
}


@end
