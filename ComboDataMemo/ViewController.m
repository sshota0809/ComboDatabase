//
//  ViewController.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/30.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize window;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    /*
    // window の初期化
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // UINavigationBar を作成
    // このアプリは基本的に UINavigationBar の上に DB から取得したデータを表示させた UITableView を表示して動作させる
    mainTable = [[mainTableView alloc] init];
    mainNavi = [[UINavigationController alloc] initWithRootViewController:mainTable];
    
    // mainNavi (NavigationController のビューをウィンドウを貼付ける)
    [self.window addSubview:mainNavi.view];
    
    [self.window makeKeyAndVisible];
     
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    */



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
