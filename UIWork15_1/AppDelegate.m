//
//  AppDelegate.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/11.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "transformViewController.h"
//#import "SecondViewController.h"
#import "ThreeViewController.h"
#import "FourthViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UINavigationController *firstVC = [[UINavigationController alloc]initWithRootViewController:[[FirstViewController alloc]init]];
    
//    UINavigationController *secondVC = [[UINavigationController alloc]initWithRootViewController:[[SecondViewController alloc]init]];
    
    UINavigationController *transformVC = [[UINavigationController alloc]initWithRootViewController:[[transformViewController alloc]init]];
    
    
    UINavigationController *threeVC = [[UINavigationController alloc]initWithRootViewController:[[ThreeViewController alloc]init]];
    
    UINavigationController *fourthVC = [[UINavigationController alloc]initWithRootViewController:[[FourthViewController alloc]init]];
    
    UITabBarController *mainTabBar = [[UITabBarController alloc]init];
    mainTabBar.viewControllers = @[firstVC,transformVC,threeVC,fourthVC];
    
    self.window.rootViewController = mainTabBar;
    
    
    
    
    // 设置tabBarItem的标题和图片
    firstVC.tabBarItem.title = @"活动";
    firstVC.tabBarItem.image = [UIImage imageNamed:@"activity"];
    
    transformVC.tabBarItem.title = @"电影";
    transformVC.tabBarItem.image = [UIImage imageNamed:@"movie"];
    
    threeVC.tabBarItem.title = @"影院";
    threeVC.tabBarItem.image = [UIImage imageNamed:@"cinema"];
    
    fourthVC.tabBarItem.title = @"我的";
    fourthVC.tabBarItem.image = [UIImage imageNamed:@"user"];
    
    
    
    
    
    
    
    
    
    
    
    
    
    return YES;
}

@end
