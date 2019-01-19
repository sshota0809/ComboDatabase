//
//  modalTableView.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/01.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HowToUse.h"
#import "AppInfo.h"
#import "easyInputConfig.h"
#import "ThemaColor.h"
#import "EAIntroView.h"
#import "releaseNote.h"

@interface modalTableView : UITableViewController <EAIntroDelegate>
{
    

    // テーブルから取得したゲームタイトルを格納する配列
    NSArray *cellTitle;
    
    NSUserDefaults *ud;
    
}

- (id)init;

@end
