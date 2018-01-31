//
//  AppDelegate.m
//  RYApp
//
//  Created by 连杰 on 2018/1/27.
//  Copyright © 2018年 连杰. All rights reserved.
//

#import "AppDelegate.h"
#import "RYVController.h"
#import <RongIMKit/RongIMKit.h>
#import "RCDCustomerServiceViewController.h"
#define SERVICE_ID @"KEFU151703811665720"

@interface AppDelegate ()<RCIMUserInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
    [self rytest];
   
    return YES;
}
-(void)rytest{
    [[RCIM sharedRCIM] initWithAppKey: @"8luwapkv8r8gl"];
    [[RCIM sharedRCIM] connectWithToken:@"WbnJadLIkaE/0zSiTkWDoupddE9sbIgS0dX6Si8MVuJRJXlV+zQSlQKu3gBqiKGo8rVmMLl6oSOPP76gl3fkRg==" success:^(NSString *userId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            
            RCDCustomerServiceViewController *rcdV = [[RCDCustomerServiceViewController alloc]init];
            rcdV.conversationType = ConversationType_CUSTOMERSERVICE;
            
            rcdV.targetId = SERVICE_ID;
            rcdV.title = @"客服";
            
//            RYVController *VC = [[RYVController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rcdV];
            self.window.rootViewController = nav;
             [self.window makeKeyAndVisible];
        });
        NSLog(@"登陆成功---登录用户ID:%@",userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆失败---错误码:%ld",status);
    } tokenIncorrect:^{
        NSLog(@"token错误");
    }];

}

-(void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    if ([userId isEqualToString:@"RYApp2"]) {
        RCUserInfo *userinfo = [[RCUserInfo alloc]init];
        userinfo.userId = userId;
        userinfo.name = @"RYApp2";
        userinfo.portraitUri = @"";
        
        return completion(userinfo);
    }
    
    return completion(nil);
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
