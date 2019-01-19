//
//  mainTableView.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/30.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "mainTableView.h"
#import "FMDatabase.h"

@implementation mainTableView

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    // 画面のタイトルの設定
    self.title = @"ゲーム一覧";
    
    ud = [NSUserDefaults standardUserDefaults];
    
    double barr = [ud doubleForKey:@"barr"];
    double barg = [ud doubleForKey:@"barg"];
    double barb = [ud doubleForKey:@"barb"];
    double texr = [ud doubleForKey:@"texr"];
    double texg = [ud doubleForKey:@"texg"];
    double texb = [ud doubleForKey:@"texb"];
    
    
    gameLogo = [NSArray arrayWithObjects:@"bbcp.png", @"p4u2.png", @"nopackage.png", @"nopackage.png", @"uni.png", @"usf4", @"umvc3.png", @"nopackage.png", nil];
    
    
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:barr green:barg blue:barb alpha:0.6];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:texr green:texg blue:texb alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:texr green:texg blue:texb alpha:1.0]};
    
    // ツールバーを表示する
    [self.navigationController setToolbarHidden:NO animated:YES];
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.toolbar.barTintColor = [UIColor colorWithRed:barr green:barg blue:barb alpha:0.6];
    self.navigationController.toolbar.tintColor = [UIColor colorWithRed:texr green:texg blue:texb alpha:1.0];
    
    // ツールバーにボタンを設置
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"about.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(info)];
    self.toolbarItems = @[item];
    



    //[[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1.0]];
    
    // まずはじめに一番メインとなるタイトルを選択する table を tableView に表示する
    // DB名: ComboData.db
    // 使用テーブル名: Game
    // フィールド
    // id INTEGER
    // title TEXT
    
    // データベースを検索してフィールドの全要素を取得する作業を行う
    
    // 背景設定
    UIImage *backImage = [UIImage imageNamed:@"back3.png"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    [self.tableView setBackgroundView:backImageView];
    
    // ここから Combo.db のパスの指定
    NSArray  *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir   = [paths objectAtIndex:0];
    NSString *db_path  = [dir stringByAppendingPathComponent:@"ComboData.db"];
    NSLog(@"db path = %@", db_path);

    // .db が Document 以下にない場合はコピー(初回起動時のみとか)
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL result_flag = [fm fileExistsAtPath:db_path];
    if(!result_flag){
        //dbが存在してなかったらここが呼ばれて、作成したDBをコピー
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ComboData.db"];
        
        BOOL copy_result_flag = [fm copyItemAtPath:defaultDBPath toPath:db_path error:&error];
        
        if(!copy_result_flag){
            //失敗したらここ
        }
    }
    
    // gameTiles / gameCalled の初期化
    gameTitles = [[NSArray alloc] init];
    gameCalled = [[NSArray alloc] init];
    
    // maindb に取得したテーブルの内容を格納
    maindb = [FMDatabase databaseWithPath:db_path];
    
    // ここから抽出
    NSString *select = @"SELECT id, title, called FROM Game;";
    
    // ここから取得したテーブルから必要なデータを検索して result に格納する
    [maindb open];
    
    FMResultSet *result = [maindb executeQuery:select];
    
    // ここから取得したデータからゲームタイトルを配列に格納する
    while([result next]) {
        NSString *gameName = [result stringForColumn:@"title"];
        NSString *gameCalledName = [result stringForColumn:@"called"];
        // 配列の最後に新しく要素を挿入していく
        gameTitles = [gameTitles arrayByAddingObject:gameName];
        gameCalled = [gameCalled arrayByAddingObject:gameCalledName];
    }
    
    [maindb close];
    
    NSLog(@"%@", self.navigationController.navigationBar.barTintColor);
}

// modalview を表示する
- (void) info
{
    
    modalTableView *modalView = [[modalTableView alloc] init];
    UINavigationController *modalNavi = [[UINavigationController alloc] initWithRootViewController:modalView];
    [self presentViewController:modalNavi animated:YES completion:nil];

    
    
}

/**
 * テーブルのセルの数を返す
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [gameTitles count];
}

/**
 * 指定されたインデックスパスのセルを作成する
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // セルが作成されていないか?
    if (!cell) { // yes
        // セルを作成
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // セルの背景を透明にする
    [cell setBackgroundColor:[UIColor clearColor]];
    
    // セルの文字サイズ
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    
    // セルにテキストを設定
    cell.textLabel.text = [gameTitles objectAtIndex:indexPath.row];
    
    // セルにサブテキストを追加　これは if 文で分岐を行う
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = @"アークシステムワークス";
    }
    else if (indexPath.row == 1) {
        cell.detailTextLabel.text = @"アークシステムワークス";
    }
    else if (indexPath.row == 2) {
        cell.detailTextLabel.text = @"アークシステムワークス";
    }
    else if (indexPath.row == 3) {
        cell.detailTextLabel.text = @"SEGA";
    }
    else if (indexPath.row == 4) {
        cell.detailTextLabel.text = @"フランスパン";
    }
    else if (indexPath.row == 5) {
        cell.detailTextLabel.text = @"カプコン";
    }
    else if (indexPath.row == 6) {
        cell.detailTextLabel.text = @"カプコン";
    }
    else if (indexPath.row == 7) {
        cell.detailTextLabel.text = @"-";
    }
    
    
    // セルに画像設定
    // セルに画像設定
    NSLog(@"hogehoge = %@", [gameLogo objectAtIndex:indexPath.row]);
    UIImage *cellImage = [UIImage imageNamed:[gameLogo objectAtIndex:indexPath.row]];
    cell.imageView.image = cellImage;

    return cell;
}

// セルの高さを指定する
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

// セルの横に矢印を表示する
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellAccessoryDisclosureIndicator;
    
}

/**
 * セルが選択されたとき
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // called を参照して、ゲーム別のテーブルに遷移する処理を行う。
    IndividualGameTableView *indiView = [[IndividualGameTableView alloc] initWithTable:[gameTitles objectAtIndex:indexPath.row] select:[gameCalled objectAtIndex:indexPath.row]];
    if (indiView) {
        [self.navigationController pushViewController:indiView animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (![self.navigationController.viewControllers containsObject:self]) {
        //戻るを押された
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
