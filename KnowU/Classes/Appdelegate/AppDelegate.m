//
//  AppDelegate.m
//  KnowU
//
//  Created by young He on 2018/4/17.
//  Copyright © 2018年 Hy. All rights reserved.
//

#import "AppDelegate.h"
#import "UIImage+Extension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    CETabBarController *tabBar = [[CETabBarController alloc]init];
    self.window.rootViewController = tabBar;
    self.tabBarVC = tabBar;
    //----  导航栏处理  -----//
    [self configNavBar];
    [self.window makeKeyAndVisible];
    return YES;
}

//全局导航栏处理
-(void)configNavBar
{
    [[UITabBar appearance] setBarTintColor:[Utils colorConvertFromString:@"#f6f6f6"]];
    [[UITabBar appearance] setShadowImage:[UIImage createImageWithColor:UIColorRGB(233, 233, 233)]];
    UINavigationBar *navBar = [UINavigationBar appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [navBar setTitleTextAttributes:attrs];
    
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = KCOLOR(@"#333333");
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17.0];
    [barItem setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:itemAttrs forState:UIControlStateHighlighted];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    
    //设置系统默认返回按钮颜色
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setShadowImage:[UIImage createImageWithColor:UIColorRGB(233, 233, 233)]];
    [[UITabBar appearance] setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
    
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor whiteColor]];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:KCOLOR(@"#333333")];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:KCOLOR(@"#333333")];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleDefault];
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:NO];
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
//        WKWebView.appearance.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        WKWebView.appearance.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        WKWebView.appearance.scrollView.scrollIndicatorInsets = WKWebView.appearance.scrollView.contentInset;
        
    } else {
        // Fallback on earlier versions
    }
}

- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    [self.window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.window.rootViewController = nil;
    typedef void (^Animation)(void);
    UIWindow* window = self.window;
    rootViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    [UIView transitionWithView:window
                      duration:0.8f
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:animation
                    completion:^(BOOL finished) {
                        if(finished)
                        {
                            g_App.tabBarVC = nil;
                            g_App.tabBarVC =  (CETabBarController*)rootViewController;
                        }
                    }];
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
