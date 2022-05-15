//
//  AppDelegate.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/14.
//

#import "AppDelegate.h"
#import "CrashUncaughtExceptionHandle.h"
#import <KSCrash/KSCrash.h>
// Include to use the standard reporter.
#import <KSCrash/KSCrashInstallationStandard.h>
// Include to use Quincy or Hockey.
#import <KSCrash/KSCrashInstallationQuincyHockey.h>
// Include to use the email reporter.
#import <KSCrash/KSCrashInstallationEmail.h>
// Include to use Victory.
#import <KSCrash/KSCrashInstallationVictory.h>

@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [CrashUncaughtExceptionHandle start];
    

    bool result = [[KSCrash sharedInstance] initWithBasePath:@"/Users/shenzhoudiyikeng/Desktop/BaiduOCR真机/"];
    KSCrashInstallationStandard* installation = [KSCrashInstallationStandard sharedInstance];
  
    installation.url = [NSURL URLWithString:@"https://acc6-2409-8a00-241d-1720-69d6-70da-c089-db"];
    
//    KSCrashInstallationEmail* installation = [KSCrashInstallationEmail sharedInstance];
//    installation.recipients = @[@"806048441@qq.com"];
//    // Optional (Email): Send Apple-style reports instead of JSON
//    [installation setReportStyle:KSCrashEmailReportStyleApple useDefaultFilenameFormat:YES];
//    // Optional: Add an alert confirmation (recommended for email installation)
    
    [installation sendAllReportsWithCompletion:^(NSArray *filteredReports, BOOL completed, NSError *error)
    {
     // Stuff to do when report sending is complete
    }];
    [installation install];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
