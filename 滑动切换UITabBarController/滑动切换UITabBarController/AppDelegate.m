//
//  AppDelegate.m
//  滑动切换UITabBarController
//
//  Created by FunctionMaker on 16/4/27.
//  Copyright © 2016年 FunctionMaker. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initWindowAndRootViewController];
    
    [_window makeKeyAndVisible];
    
    return YES;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    
    [tabBarController.view.layer addAnimation:transition forKey:nil];
    
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

- (void)initWindowAndRootViewController {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.viewControllers = @[firstVC, secondVC, thirdVC];
    _tabBarController.delegate = self;
    
    [_window setRootViewController:_tabBarController];
    
}

@end
