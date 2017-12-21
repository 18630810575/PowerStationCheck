//
//  AppDelegate.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "ListViewController.h"
#import "ScanViewController.h"
#import "GettingViewController.h"

#import "TabBar.h"

static const int kTabButtonBaseTag = 400;


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UINavigationController *nav = [[UINavigationController alloc]init];
    HomeViewController *homeVC = [[HomeViewController alloc]initWithTitle:@"待办任务" AndNeedBack:NO];
    [nav addChildViewController:homeVC];
    self.window.rootViewController = nav;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabButtonClickToShowControllerWithTag:) name:TabBarNotificationChangeViewController object:nil];
    return YES;
}

-(void)tabButtonClickToShowControllerWithTag:(NSNotification *)noti{
    UIView *view = [noti object];
    int tag = (int)view.tag;
    if (tag == kTabButtonBaseTag) {
        //待办任务
        UINavigationController *nav = [[UINavigationController alloc]init];
        HomeViewController *homeVC = [[HomeViewController alloc]initWithTitle:@"待办任务" AndNeedBack:NO];
        [nav addChildViewController:homeVC];
        self.window.rootViewController = nav;
    }else if (tag == kTabButtonBaseTag+1){
        //待领任务
        UINavigationController *nav = [[UINavigationController alloc]init];
        GettingViewController *gettingVC = [[GettingViewController alloc]initWithTitle:@"待领任务" AndNeedBack:NO];
        [nav addChildViewController:gettingVC];
        self.window.rootViewController = nav;
    }else if (tag == kTabButtonBaseTag+2){
        //扫一扫
        UINavigationController *nav = [[UINavigationController alloc]init];
        ScanViewController *scanVC = [[ScanViewController alloc]initWithTitle:@"扫一扫" AndNeedBack:YES];
        [self.window.rootViewController presentViewController:scanVC animated:(BOOL)YES completion:^{
            
        }];
    }
    else if (tag == kTabButtonBaseTag+3){
        //任务列表
        UINavigationController *nav = [[UINavigationController alloc]init];
        ListViewController *listVC = [[ListViewController alloc]initWithTitle:@"任务列表" AndNeedBack:NO];
        [nav addChildViewController:listVC];
        self.window.rootViewController = nav;
    }
    else if (tag == kTabButtonBaseTag+4){
        //我的
        UINavigationController *nav = [[UINavigationController alloc]init];
        MineViewController *mineVC = [[MineViewController alloc]initWithTitle:@"我的" AndNeedBack:NO];
        [nav addChildViewController:mineVC];
        self.window.rootViewController = nav;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
