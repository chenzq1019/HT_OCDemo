//
//  HTVideoPreView.h
//  视频录制
//
//  Created by 陈竹青 on 2021/12/8.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface HTVideoPreView : UIView

@property (nonatomic, strong) AVCaptureSession * captureSessionsion;


- (CGPoint)captureDevicePointForPoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
