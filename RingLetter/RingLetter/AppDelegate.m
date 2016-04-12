//
//  AppDelegate.m
//  RingLetter
//
//  Created by fangjs on 16/4/8.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<EMChatManagerDelegate>

@end

#define appkey @"wjy123#huanxinceshi1"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //registerSDKWithAppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    //    [[EaseMob sharedInstance] registerSDKWithAppKey:@"vgios#xmg1chat" apnsCertName:nil];
    // 1.初始化SDK，并隐藏环信SDK的日志输入
    [[EaseMob sharedInstance] registerSDKWithAppKey:appkey apnsCertName:nil otherConfig:@{kSDKConfigEnableConsoleLogger:@(NO)}];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    // 2.监听自动登录的状态
    // 设置chatManager代理
    // 写个nil 默认代理会在主线程调用
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    // 3.如果登录过，直接来到主界面
    if ([[EaseMob sharedInstance].chatManager isAutoLoginEnabled]) {
        self.window.rootViewController = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
    }

    return YES;
}

#pragma mark - 自动登录的回调
-(void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error {
    if (!error) {
        NSLog(@"登录成功 %@",loginInfo);
    }
    else {
        NSLog(@"登录失败 %@",error);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)dealloc {
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

@end
