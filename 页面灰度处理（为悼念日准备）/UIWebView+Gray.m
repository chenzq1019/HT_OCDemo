//
//  UIWebView+Gray.m
//
//

#import "UIWebView+Gray.h"

@implementation UIWebView (Gray)

+ (void)load {
    
    [self swizzleMethod:[self class] orig:NSSelectorFromString(@"webView:resource:didFinishLoadingFromDataSource:")
             swizzled:@selector(swizzled_webView:resource:didFinishLoadingFromDataSource:)];
}

+ (void)swizzleMethod:(Class)class orig:(SEL)originalSelector swizzled:(SEL)swizzledSelector {
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


-(void)swizzled_webView:(id)arg1 resource:(id)arg2 didFinishLoadingFromDataSource:(id)arg3 {
    [self grayWebaction:arg1];
    [self swizzled_webView:arg1 resource:arg2 didFinishLoadingFromDataSource:arg3];
}

-(void)grayWebaction:(UIWebView *)web {
    NSString *params = @"var filter = '-webkit-filter:grayscale(100%);-moz-filter:grayscale(100%); -ms-filter:grayscale(100%); -o-filter:grayscale(100%) filter:grayscale(100%);';document.getElementsByTagName('html')[0].style.filter = 'grayscale(100%)';";
    [web stringByEvaluatingJavaScriptFromString:params];
}

@end
