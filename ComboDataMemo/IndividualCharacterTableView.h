//
//  IndividualCharacterTableView.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/30.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "ComboView.h"
#import "modalTableView.h"
#import "SortView.h"

@interface IndividualCharacterTableView : UITableViewController <SortViewDelegate>
{

    // Game テーブルを取得する
    FMDatabase *inviCharadb;
    // テーブルから取得したキャラクター一覧を格納する配列
    NSArray *comboId;
    NSArray *combo;
    NSArray *damage;
    NSArray *center;
    NSArray *gage;
    NSArray *memo;
    // called を保持する変数
    NSString *gameCalled;
    
    
    NSString *select;

}

- (id)initWithTable:(NSString *)title select:(NSString *)called;
- (void)reloadData;

@end
