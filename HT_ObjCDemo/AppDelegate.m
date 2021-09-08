//
//  AppDelegate.m
//  HT_ObjCDemo
//
//  Created by 陈竹青 on 2020/12/28.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //iOS10 推送
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
//                NSLog(@"注册通知成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//                        NSLog(@"%@", settings);
                    }];
                });
            } else {
                //点击不允许
                NSLog(@"注册通知失败");
            }
        }];
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }

    /**
     iOS9及之前 点击通知进入应用(程序关闭时)
     为达到由跳转事件的通知栏启动应用时不加载引导页广告,不区分iOS10,相当于解析通知信息数据两次,不影响效果
     */
    // 远程推送
    NSDictionary *remoteNotification = (NSDictionary *)[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//    [[UlePushHelper shared] handleRemoteNotification:remoteNotification];
    
    // 本地推送
    UILocalNotification *localNoti = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if(localNoti!=nil)
    {
        NSDictionary *dic=localNoti.userInfo;
//        [[UlePushHelper shared] handleRemoteNotification:dic];
    }
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

#pragma mark - 推送相关
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
    if (![deviceToken isKindOfClass:[NSData class]]) return;
    NSString *pushToken=@"";
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0) {
        const unsigned *tokenBytes = [deviceToken bytes];
        pushToken = [NSString stringWithFormat:@"%08x %08x %08x %08x %08x %08x %08x %08x",
                     ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                     ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                     ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    }
    else{
        pushToken = [NSString stringWithFormat:@"%@", deviceToken];
        if (pushToken != nil && pushToken.length> 3) {
            pushToken = [pushToken substringFromIndex:1];
            pushToken = [pushToken substringToIndex:pushToken.length -1];
        }
    }
    NSLog(@"deviceToken= %@", pushToken);
}

@end
