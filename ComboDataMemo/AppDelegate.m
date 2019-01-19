//
//  AppDelegate.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/30.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    

    
    // ステータスバーの文字色を変更する
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    MySHKConfiguration *configurator = [[MySHKConfiguration alloc] init];
    [SHKConfiguration sharedInstanceWithConfigurator:configurator];
    
    
    // NSUserdefaults の生成
    ud = [NSUserDefaults standardUserDefaults];
    
    // UserDefaults のキー
    // 楽々入力
    // 1列目 option
    // 2列目 condition
    // 3列目 liver
    // 4列目 button
    
    NSMutableArray *check = [ud objectForKey:@"option"];
    
    // もし初期値がとれない場合は初回起動なので初期値を設定する。
    if (check) {
        // すでにデータがあるならそれでOK
    }
    else {
        // データがセットされてないなら初期値となるデータをセットする。
        row1 = [NSArray arrayWithObjects:@"-", @"dl", @"dc", @"jc", @"hjc", nil];
        row2 = [NSArray arrayWithObjects:@"-", @"J", nil];
        row3 = [NSArray arrayWithObjects:@"-", @"2", @"3", @"4", @"5", @"6", @"8", @"236", @"214", @"623", @"421", @"41236", @"63214", @"632146", @"2141236", @"4タメ6", @"2タメ8", @"1回転", nil];
        row4 = [NSArray arrayWithObjects:@"-", @"A", @"B", @"C", @"D", @"P", @"K", @"S", @"HS", @"弱P", @"中P", @"強P", @"弱K", @"中K", @"強K", nil];
        
        
        // テーマカラーの色も同じく
        barR = 0.2;
        barG = 0.5;
        barB = 0.8;
        texR = 1.0;
        texG = 1.0;
        texB = 1.0;
        
        // これをデフォルト値として保存
        [ud setObject:row1 forKey:@"option"];
        [ud setObject:row2 forKey:@"condition"];
        [ud setObject:row3 forKey:@"liver"];
        [ud setObject:row4 forKey:@"button"];
        
        [ud setDouble:barR forKey:@"barr"];
        [ud setDouble:barG forKey:@"barg"];
        [ud setDouble:barB forKey:@"barb"];
        [ud setDouble:texR forKey:@"texr"];
        [ud setDouble:texG forKey:@"texg"];
        [ud setDouble:texB forKey:@"texb"];
    }
            sortNum = 0;
            [ud setInteger:sortNum forKey:@"sort"];
    
    
    /*
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[ViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
*/
    
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // UINavigationBar を作成
    // このアプリは基本的に UINavigationBar の上に DB から取得したデータを表示させた UITableView を表示して動作させる
    mainTable = [[title alloc] init];
    mainNavi = [[UINavigationController alloc] initWithRootViewController:mainTable];
    
    // mainNavi (NavigationController のビューをウィンドウを貼付ける)
    [self.window addSubview:mainNavi.view];
    
    [self.window makeKeyAndVisible];
    
    
    // Override point for customization after application launch.
    
    
    // スプラッシュ画面を2秒は表示する
    sleep(1);
    
    
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

@end
