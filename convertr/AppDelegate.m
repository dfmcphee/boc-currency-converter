//
//  AppDelegate.m
//  convertr
//
//  Created by Dominic McPhee on 2012-11-02.
//  Copyright (c) 2012 2pages. All rights reserved.
//

#import "AppDelegate.h"
#import "ConverterViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

@implementation AppDelegate

@synthesize rates;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        UIStoryboard *storyBoard;
        
        CGSize result = [[UIScreen mainScreen] bounds].size;
        CGFloat scale = [UIScreen mainScreen].scale;
        result = CGSizeMake(result.width * scale, result.height * scale);
        
        if(result.height == 1136){
            storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone_5" bundle:nil];
            UIViewController *initViewController = [storyBoard instantiateInitialViewController];
            [self.window setRootViewController:initViewController];
        }
    }
    
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
    ConverterViewController* mainController = (ConverterViewController*)  self.window.rootViewController;
    
    // allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"exchng.ca"];
    
    // set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        [mainController loadRates];
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        [mainController showAlert];
    };
    
    // start the notifier which will cause the reachability object to retain itself!
    [reach startNotifier];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
