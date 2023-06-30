//
//  UIColor+GrayColor.m
//
//
//

#import "UIImageView+GrayImageview.h"
#import "UIImage+GrayImage.h"
#import "SDImageCoderHelper.h"
#import "SDAnimatedImageView.h"
#import "SDAnimatedImage.h"
//#import "UleGrayManager.h"
@implementation UIImageView (GrayImageview)

+ (void)load {
    
    [self swizzleMethod:[self class] orig:@selector(setImage:) swizzled:@selector(swizzled_setImage:)];
    
    [self swizzleMethod:[self class] orig:@selector(initWithCoder:) swizzled:@selector(swizzled_initWithCoder:)];
}

+ (void)swizzleMethod:(Class)class orig:(SEL)originalSelector swizzled:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (nullable instancetype)swizzled_initWithCoder:(NSCoder *)coder {
   UIImageView *tmpImgageView = [self swizzled_initWithCoder:coder];
    [self fjf_convertToGrayImageWithImage:tmpImgageView.image];
    return tmpImgageView;
}


- (void)swizzled_setImage:(UIImage *)image {
    //系统键盘处理（如果不过滤，这系统键盘字母背景是黑色）
    if ([self.superview isKindOfClass:NSClassFromString(@"UIKBSplitImageView")]) {
        [self swizzled_setImage:image];
        return;
    }
//    if([UleGrayManager shareInstance].needGrayStyle){
        if([image isKindOfClass:[SDAnimatedImage class]]){
            SDAnimatedImage * animatedImage = (SDAnimatedImage *)image;
            NSData * data = animatedImage.animatedImageData;
            //将GIF图片转换成对应的图片源
            CGImageSourceRef gifSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
            //获取其中图片源个数，即由多少帧图片组成
            size_t frameCout = CGImageSourceGetCount(gifSource);
            if(frameCout>0){
                //定义数组存储拆分出来的图片
                NSMutableArray <SDImageFrame *> * frames = [[NSMutableArray alloc] init];
                for (size_t i=0; i<frameCout; i++) {
                    //从GIF图片中取出源图片
                    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
                    //将图片源转换成UIimageView能使用的图片源
                    UIImage* imageName = [UIImage imageWithCGImage:imageRef];
                    imageName = [imageName grayImage];
                    NSTimeInterval duration = [self gifImageDeleyTime:gifSource index:i];
                    SDImageFrame *thumbFrame = [SDImageFrame frameWithImage:imageName duration:duration];
                    //将图片加入数组中
                    [frames addObject:thumbFrame];
                    CGImageRelease(imageRef);
                }
                UIImage *greyAnimatedImage = [SDImageCoderHelper animatedImageWithFrames:frames];
                [self swizzled_setImage:greyAnimatedImage];
            }else{
                [self fjf_convertToGrayImageWithImage:image];
            }
        }else{
            [self fjf_convertToGrayImageWithImage:image];
        }
//    }else{
//        [self swizzled_setImage:image];
//    }

}


// 转换为灰度图标
- (void)fjf_convertToGrayImageWithImage:(UIImage *)image {
    NSArray<SDImageFrame *> *animatedImageFrameArray = [SDImageCoderHelper framesFromAnimatedImage:image];
    if (animatedImageFrameArray.count > 1) {
        NSMutableArray<SDImageFrame *> *tmpThumbImageFrameMarray = [NSMutableArray array];
        [animatedImageFrameArray enumerateObjectsUsingBlock:^(SDImageFrame * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImage *targetImage = [obj.image grayImage];
            SDImageFrame *thumbFrame = [SDImageFrame frameWithImage:targetImage duration:obj.duration];
            [tmpThumbImageFrameMarray addObject:thumbFrame];
        }];
        UIImage *greyAnimatedImage = [SDImageCoderHelper animatedImageWithFrames:tmpThumbImageFrameMarray];
        [self swizzled_setImage:greyAnimatedImage];
    } else if([image isKindOfClass:NSClassFromString(@"_UIResizableImage")]){
        [self swizzled_setImage:image];
    } else {
        UIImage *im = [image grayImage];
        [self swizzled_setImage:im];
    }
}

- (NSMutableArray *)praseGIFDataToImageArray:(NSData *)data{
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    CGFloat animationTime = 0.f;
    if (src) {
        size_t l = CGImageSourceGetCount(src);
        frames = [NSMutableArray arrayWithCapacity:l];
        for (size_t i = 0; i < l; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            if (img) {
                [frames addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    return frames;
}
//获取gif图片的总时长
- (NSTimeInterval)durationForGifData:(NSData *)data{
    
    //将GIF图片转换成对应的图片源
    CGImageSourceRef gifSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    //获取其中图片源个数，即由多少帧图片组成
    size_t frameCout = CGImageSourceGetCount(gifSource);

    //定义数组存储拆分出来的图片
    NSMutableArray* frames = [[NSMutableArray alloc] init];
    NSTimeInterval totalDuration = 0;
    for (size_t i=0; i<frameCout; i++) {

        //从GIF图片中取出源图片
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);

        //将图片源转换成UIimageView能使用的图片源
        UIImage* imageName = [UIImage imageWithCGImage:imageRef];

        //将图片加入数组中
        [frames addObject:imageName];
        NSTimeInterval duration = [self gifImageDeleyTime:gifSource index:i];
        totalDuration += duration;
        CGImageRelease(imageRef);
    }
    
    //获取循环次数
    NSInteger loopCount;//循环次数
    CFDictionaryRef properties = CGImageSourceCopyProperties(gifSource, NULL);
    if (properties) {
        CFDictionaryRef gif = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gif) {
            CFTypeRef loop = CFDictionaryGetValue(gif, kCGImagePropertyGIFLoopCount);
            if (loop) {
                //如果loop == NULL，表示不循环播放，当loopCount  == 0时，表示无限循环；
                CFNumberGetValue(loop, kCFNumberNSIntegerType, &loopCount);
            };
        }
    }
    CFRelease(gifSource);
    return totalDuration;
}
//获取GIF图片每帧的时长
- (NSTimeInterval)gifImageDeleyTime:(CGImageSourceRef)imageSource index:(NSInteger)index {
    NSTimeInterval duration = 0;
    CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, index, NULL);
    if (imageProperties) {
        CFDictionaryRef gifProperties;
        BOOL result = CFDictionaryGetValueIfPresent(imageProperties, kCGImagePropertyGIFDictionary, (const void **)&gifProperties);
        if (result) {
            const void *durationValue;
            if (CFDictionaryGetValueIfPresent(gifProperties, kCGImagePropertyGIFUnclampedDelayTime, &durationValue)) {
                duration = [(__bridge NSNumber *)durationValue doubleValue];
                if (duration <= 0) {
                    if (CFDictionaryGetValueIfPresent(gifProperties, kCGImagePropertyGIFDelayTime, &durationValue)) {
                        duration = [(__bridge NSNumber *)durationValue doubleValue];
                    }
                }
            }
        }
    }
    
    return duration;
}
@end
