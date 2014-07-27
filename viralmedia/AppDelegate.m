//
//  AppDelegate.m
//  viralmedia
//
//  Created by 8pockets on 2014/06/27.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //ナビゲーションtopbarカラー
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.99 green:0.67 blue:0.25 alpha:1.0]];
    //ナビゲーションテキストカラー
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    shadow.shadowOffset = CGSizeMake(0, 0.5);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"SinhalaSangamMN" size:17.0], NSFontAttributeName, nil]];
    //ステータスバーカラー
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //CoreData-MagicalRecordイニシャライズ
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"History.sqlite"];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"Favorite.sqlite"];
    
    //Appiraterライブラリ
    [Appirater setAppId:@"882438772"]; // アプリを追加したときに与えられる9桁の数字(Apple ID)
    // インストール後、再びメッセージを表示するまでの日数。(デフォルト:30日)
    [Appirater setDaysUntilPrompt: 30];
    
    // 再びメッセージを表示するまでの起動回数。(デフォルト:20回)
    [Appirater setUsesUntilPrompt: 20];
    
    // ユーザーがアプリ内で何か特別な操作をしたときに意図的にメッセージを表示するか否か。(デフォルト:-1)
    // 値 : -1=無効, 1=有効
    // 表示する場合は、任意の箇所に [Appirater userDidSignificantEvent:YES] を呼ぶ。
    [Appirater setSignificantEventsUntilPrompt: 1];
    
    // 「後で見る」を選択したときにメッセージを再び表示するまでの日数。(デフォルト:1日)
    [Appirater setTimeBeforeReminding: 1];
    
    // デバッグモードの有無。YESにすると起動の度に表示される。(デフォルト:NO)
    [Appirater setDebug: NO];

    [Appirater appLaunched:YES];
    
    return YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
    
    [Appirater appEnteredForeground:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //CoreData-MagicalRecord
    [MagicalRecord cleanUp];
}

@end
