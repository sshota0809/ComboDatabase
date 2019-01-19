//
//  mainTableView.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/30.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "IndividualGameTableView.h"
#import "MainModalView.h"
#import "modalTableView.h"
#import "title.h"


@interface mainTableView : UITableViewController
{
    
    // Game テーブルを取得する
    FMDatabase *maindb;
    // テーブルから取得したゲームタイトルを格納する配列
    NSArray *gameTitles;
    // ゲーム別テーブルに移動する時に使用するゲーム名略称を格納する配列
    // Game テーブルとして called (ex.BBCP, P4U2) という値を持っていてその名前のテーブルが次のゲーム別テーブルとなる
    NSArray *gameCalled;
    // テーブルビューに表示するゲームタイトル画像を保存する配列
    NSArray *gameLogo;
    
    // NSUserDefaults
    NSUserDefaults *ud;
    
}



@end
