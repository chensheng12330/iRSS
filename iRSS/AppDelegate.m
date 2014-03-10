//
//  AppDelegate.m
//  iRSS
//
//  Created by sherwin on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "AppDelegate.h"

#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMNavigationController.h"
#import "MMDrawerVisualStateManager.h"

#import "HotRSSViewController.h"
#import "SettingViewController.h"
#import "RSSListViewController.h"

#import <QuartzCore/QuartzCore.h>


@interface AppDelegate ()
@property (nonatomic,strong) MMDrawerController * drawerController;

@end


@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    //test

    UIViewController * leftSideDrawerViewController = [[HotRSSViewController alloc] init];
    UIViewController * rightSideDrawerViewController= [[SettingViewController alloc] init];
    
    UIViewController * centerViewController = [[RSSListViewController alloc] init];
    
    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:centerViewController];
    
    if(1){//OSVersionIsAtLeastiOS7()
        UINavigationController * rightSideNavController = [[MMNavigationController alloc] initWithRootViewController:rightSideDrawerViewController];
        rightSideNavController.navigationBar.barStyle  = UIBarStyleBlackOpaque;
        
        UINavigationController * leftSideNavController = [[MMNavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
		leftSideNavController.navigationBar.barStyle  = UIBarStyleBlackOpaque;
        
        self.drawerController = [[MMDrawerController alloc]
                                 initWithCenterViewController:navigationController
                                 leftDrawerViewController:leftSideNavController
                                 rightDrawerViewController:rightSideNavController];
        [self.drawerController setShowsShadow:NO];
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        if (DEVICE_IS_IOS7) {
            [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
            [rightSideNavController setRestorationIdentifier:@"MMExampleRightNavigationControllerRestorationKey"];
            [leftSideNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
            
            [self.drawerController setRestorationIdentifier:@"MMDrawer"];
        }
        
#endif
        
    }
    else{
        self.drawerController = [[MMDrawerController alloc]
                                 initWithCenterViewController:navigationController
                                 leftDrawerViewController:leftSideDrawerViewController
                                 rightDrawerViewController:rightSideDrawerViewController];
    }
    
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setMaximumLeftDrawerWidth:320];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    COM.mmDrawerControl = self.drawerController;
    COM.mmDrawerControl.enablePan = YES;
    COM.viewController = (RSSListViewController*)centerViewController;
    
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (DEVICE_IS_IPHONE4 && !DEVICE_IS_IOS7) {
        navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        //self.nav.navigationBar.translucent = YES;
        navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    }
    
    if(OSVersionIsAtLeastiOS7()){
        UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                              green:173.0/255.0
                                               blue:234.0/255.0
                                              alpha:1.0];
        [self.window setTintColor:tintColor];
    }
    
    
    [self.window setRootViewController:self.drawerController];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Restoration Application
- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder{
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder{
    return YES;
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    NSString * key = [identifierComponents lastObject];
    if([key isEqualToString:@"MMDrawer"]){
        return self.window.rootViewController;
    }
    else if ([key isEqualToString:@"MMExampleCenterNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).centerViewController;
    }
    else if ([key isEqualToString:@"MMExampleRightNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).rightDrawerViewController;
    }
    else if ([key isEqualToString:@"MMExampleLeftNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
    }
    else if ([key isEqualToString:@"MMExampleLeftSideDrawerController"]){
        UIViewController * leftVC = ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
        if([leftVC isKindOfClass:[UINavigationController class]]){
            return [(UINavigationController*)leftVC topViewController];
        }
        else {
            return leftVC;
        }
        
    }
    else if ([key isEqualToString:@"MMExampleRightSideDrawerController"]){
        UIViewController * rightVC = ((MMDrawerController *)self.window.rootViewController).rightDrawerViewController;
        if([rightVC isKindOfClass:[UINavigationController class]]){
            return [(UINavigationController*)rightVC topViewController];
        }
        else {
            return rightVC;
        }
    }
    return nil;
}
@end
