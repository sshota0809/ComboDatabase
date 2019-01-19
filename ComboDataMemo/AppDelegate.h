//
//  AppDelegate.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/30.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SHKConfiguration.h"
#import "MySHKConfiguration.h"
#import "mainTableView.h"
#import "title.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    UINavigationController *mainNavi;
    title *mainTable;
    NSUserDefaults *ud;
    
    // 楽々入力用の配列
    NSMutableArray *row1;
    NSMutableArray *row2;
    NSMutableArray *row3;
    NSMutableArray *row4;
    
    double barR;
    double barG;
    double barB;
    double texR;
    double texG;
    double texB;
    
    int sortNum;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;


@end
