//
//  BNRAppDelegate.m
//  HomePwner
//
//  Created by John Gallagher on 1/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "BNRItemsViewController.h"
#import "BNRItemStore.h"

@implementation BNRAppDelegate

-(UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    // Create new NC
    UIViewController *vc = [[UINavigationController alloc] init];
    
    // the last object in the path array is the restoration id for this view controller
    vc.restorationIdentifier = [identifierComponents lastObject];
    
    // If there is only 1 id, then this is the root vc
    if ([identifierComponents count] == 1) {
        self.window.rootViewController = vc;
    }
    
    return vc;
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // If state restoration did not occur, set up the view controller hierarchy
    if (!self.window.rootViewController) {
            // Create a BNRItemsViewController
        BNRItemsViewController *itemsViewController = [[BNRItemsViewController alloc] init];
        
            // Create an instance of a UINavigationController
            // its stack contains only itemsViewController
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];
        
            // Give the navi a restoration
        navController.restorationIdentifier = NSStringFromClass([navController class]);
        
            // Place navigation controller's view in the window hierarchy
        self.window.rootViewController = navController;
    }

    //self.window.backgroundColor = [UIColor whiteColor];
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
    BOOL success = [[BNRItemStore sharedStore] saveChanges];
    if (success) {
        NSLog(@"Saved all of the BNRItems");
    } else {
        NSLog(@"Could not save any of the BNRItems");
    }
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

-(BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return YES;
}

-(BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return YES;
}

@end
