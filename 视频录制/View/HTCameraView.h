//
//  HTCameraView.h
//  视频录制
//
//  Created by 陈竹青 on 2021/12/8.
//

#import <UIKit/UIKit.h>
#import "HTVideoPreView.h"
NS_ASSUME_NONNULL_BEGIN
@class HTCameraView;
@protocol HTCameraViewDelegate <NSObject>
@optional;
/// 闪光灯
-(void)flashLightAction:(HTCameraView *)cameraView handle:(void(^)(NSError *error))handle;
/// 补光
-(void)torchLightAction:(HTCameraView *)cameraView handle:(void(^)(NSError *error))handle;
/// 转换摄像头
-(void)swicthCameraAction:(HTCameraView *)cameraView handle:(void(^)(NSError *error))handle;
/// 自动聚焦曝光
-(void)autoFocusAndExposureAction:(HTCameraView *)cameraView handle:(void(^)(NSError *error))handle;
/// 聚焦
-(void)focusAction:(HTCameraView *)cameraView point:(CGPoint)point handle:(void(^)(NSError *error))handle;
/// 曝光
-(void)exposAction:(HTCameraView *)cameraView point:(CGPoint)point handle:(void(^)(NSError *error))handle;
/// 缩放
-(void)zoomAction:(HTCameraView *)cameraView factor:(CGFloat)factor;

/// 取消
-(void)cancelAction:(HTCameraView *)cameraView;
/// 拍照
-(void)takePhotoAction:(HTCameraView *)cameraView;
/// 停止录制视频
-(void)stopRecordVideoAction:(HTCameraView *)cameraView;
/// 开始录制视频
-(void)startRecordVideoAction:(HTCameraView *)cameraView;
/// 改变拍摄类型 1：拍照 2：视频
-(void)didChangeTypeAction:(HTCameraView *)cameraView type:(NSInteger)type;

@end

@interface HTCameraView : UIView

@property (nonatomic, strong, readonly) HTVideoPreView * previewView;
@property (nonatomic, assign, readonly) NSInteger type;
@property (nonatomic, weak) id<HTCameraViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
