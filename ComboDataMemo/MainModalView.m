//
//  MainModalView.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/01.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "MainModalView.h"

@implementation MainModalView

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // window の初期化
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // UINavigationBar を作成
    // このアプリは基本的に UINavigationBar の上に DB から取得したデータを表示させた UITableView を表示して動作させる
    modalTable = [[modalTableView alloc] init];
    modalNavi = [[UINavigationController alloc] initWithRootViewController:modalTable];
    
    // mainNavi (NavigationController のビューをウィンドウを貼付ける)
    [self.window addSubview:modalNavi.view];
    [self.window makeKeyAndVisible];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
