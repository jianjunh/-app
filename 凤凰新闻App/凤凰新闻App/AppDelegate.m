//
//  AppDelegate.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/15.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsViewController.h"
#import "AudioViewController.h"
#import "MyselfViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NewsViewController *news = [[NewsViewController alloc]init];
    UINavigationController *newsNavi = [[UINavigationController alloc]initWithRootViewController:news];
    newsNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"新闻" image:[UIImage imageNamed:@"新闻.png"] tag:1000];
    
    
    
    AudioViewController *audio = [[AudioViewController alloc]init];
    UINavigationController *audioNavi = [[UINavigationController alloc]initWithRootViewController:audio];
    audioNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"视听" image:[UIImage imageNamed:@"视听.png"] tag:1002];
    
    
    MyselfViewController *myself = [[MyselfViewController alloc]init];
    UINavigationController *myselfNavi = [[UINavigationController alloc]initWithRootViewController:myself];
    myselfNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"我.png"] tag:1003];
    
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    tabBarController.viewControllers = @[newsNavi,audioNavi,myselfNavi];
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
   
    [UMSocialData setAppKey:@"56d80bbb67e58ededb001b7c"];
    
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx5b9f76d942b9408f" appSecret:@"2dd64eecfc9a38e6f7045528c6dbf4b4" url:@"http://www.umeng.com/social"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    }

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
