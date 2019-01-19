//
//  IndividualGameTableView.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/30.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "AddCharacter.h"
#import "IndividualCharacterTableView.h"
#import "modalTableView.h"
#import "ImageSizeFixedCell.h"


@interface IndividualGameTableView : UITableViewController
{
    
    // Game テーブルを取得する
    FMDatabase *invidb;
    // テーブルから取得したキャラクター一覧を格納する配列
    NSArray *charaName;
    // キャラ別テーブルに移動する時に使用するキャラ ID を格納する配列
    // キャラ別テーブルは GameCalled + キャラ ID で作成される（ex. BBCP1, P4U23)
    NSArray *charaId;
    // called を格納する変数
    NSString *gameCalled;
    // キャライメージを格納する変数
    NSArray *charaImage;
    
}

- (id)initWithTable:(NSString *)title select:(NSString *)called;
- (void)reloadData;

@end
