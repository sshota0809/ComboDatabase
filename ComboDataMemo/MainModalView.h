//
//  MainModalView.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/01.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "modalTableView.h"

@interface MainModalView : UIViewController
{
    
    UINavigationController *modalNavi;
    modalTableView *modalTable;
    
}

@property (nonatomic, retain) UIWindow *window;

@end
