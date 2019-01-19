//
//  EasyInputDetailConfig.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/03.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputConfigAdd.h"

@interface EasyInputDetailConfig : UITableViewController <InputConfigAddDelegate>
{
    
    NSUserDefaults *ud;
    NSMutableArray *list;
    NSMutableArray *kariList;
    NSString *keyTitle;
    
    // ツールバーのボタン
    UIBarButtonItem *def;
    UIBarButtonItem *add;
    UIBarButtonItem *gap;
    
    // アラート
    UIAlertView *alert;
    
    // option condition 制御用変数
    int controll;
    
}

- (id)initWithRow:(NSString *)key title:(NSString *)title;

@end
