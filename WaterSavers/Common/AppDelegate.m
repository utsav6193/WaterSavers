//
//  AppDelegate.m
//  Water Savers
//
//  Created by Utsav Parikh on 10/3/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import "AppDelegate.h"
#import "Constant.h"
#import "HomeViewController.h"
#import "MenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [NSThread sleepForTimeInterval:1];
    appDel.dictUser = [[NSMutableDictionary alloc] init];
    self.dictResults = [[NSMutableDictionary alloc] init];
    appDel.arrayTips = [[NSMutableArray alloc] init];
    HomeViewController *controller = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:controller];

    // Appearance
    [[UINavigationBar appearance] setBarTintColor:NAVIBARCOLOR];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setTranslucent:NO];

    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:RGB(255, 255, 255),NSForegroundColorAttributeName,
      [UIFont fontWithName:kProximaNovaBold size:30], NSFontAttributeName, nil]];
    
    //MMDrawer initialization
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeParallax];
    MenuViewController *leftSideDrawerViewController = [[MenuViewController alloc] init];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:self.navigationController leftDrawerViewController:leftSideDrawerViewController rightDrawerViewController:nil];
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumRightDrawerWidth:275.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drawerController setDrawerVisualStateBlock: ^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
                 drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController, drawerSide, percentVisible);
        }
    }];
    
    self.window.rootViewController = self.drawerController;
    [self.window makeKeyAndVisible];
    return YES;

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

@end
