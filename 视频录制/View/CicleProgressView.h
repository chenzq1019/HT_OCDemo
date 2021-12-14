//
//  CicleProgressView.h
//  视频录制
//
//  Created by 陈竹青 on 2021/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol CicleProgressViewProtocol <NSObject>
@optional
- (void)didClickTakePhoto;

- (void)beginRecordVideo;

- (void)endRecordVideo;

@end


@interface CicleProgressView : UIView
@property (nonatomic, weak) id<CicleProgressViewProtocol> delegate;
@end

NS_ASSUME_NONNULL_END
