//
//  IndividualCharacterTableView.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/30.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "IndividualCharacterTableView.h"

@implementation IndividualCharacterTableView

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

// 初期化処理はここで行う
- (id)initWithTable:(NSString *)title select:(NSString *)called
{
    
    gameCalled = called;
    self.title = title;
    
    // 背景設定
    UIImage *backImage = [UIImage imageNamed:@"back3.png"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    [self.tableView setBackgroundView:backImageView];

    // ツールバーにボタンを設置
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"about.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(info)];
    
    // ツイートボタン
    UIBarButtonItem *sorte = [[UIBarButtonItem alloc] initWithTitle:@"絞り込み"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(sort)];
    // 余白用
    UIBarButtonItem *gap = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    self.toolbarItems = @[item, gap, gap, gap, gap, gap, sorte];
    
    //キャラ別のコンボを表示する table を tableView に表示する
    // フィールド
    // id INTEGER
    // combo TEXT
    // damage INTEGER
    // center INTEGER
    // gage INTEGER
    
    // データベースを検索してフィールドの全要素を取得する作業を行う
    
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
    comboId = [[NSArray alloc] init];
    combo = [[NSArray alloc] init];
    damage = [[NSArray alloc] init];
    center = [[NSArray alloc] init];
    gage = [[NSArray alloc] init];
    memo = [[NSArray alloc] init];
    
    
    // maindb に取得したテーブルの内容を格納
    inviCharadb = [FMDatabase databaseWithPath:db_path];
    
    // ここから抽出
    NSString *select = [NSString stringWithFormat:@"SELECT id, combo, damage, center, gage, memo FROM %@;", called];
    
    // ここから取得したテーブルから必要なデータを検索して result に格納する
    [inviCharadb open];
    
    FMResultSet *result = [inviCharadb executeQuery:select];
    
    // ここから取得したデータからゲームタイトルを配列に格納する
    while([result next]) {
        NSString *comboId2 = [result stringForColumn:@"id"];
        NSString *combo2 = [result stringForColumn:@"combo"];
        NSString *damage2 = [result stringForColumn:@"damage"];
        NSString *center2 = [result stringForColumn:@"center"];
        NSString *gage2 = [result stringForColumn:@"gage"];
        NSString *memo2 = [result stringForColumn:@"memo"];
        // 配列の最後に新しく要素を挿入していく
        comboId = [comboId arrayByAddingObject:comboId2];
        combo = [combo arrayByAddingObject:combo2];
        damage = [damage arrayByAddingObject:damage2];
        center = [center arrayByAddingObject:center2];
        gage = [gage arrayByAddingObject:gage2];
        memo = [memo arrayByAddingObject:memo2];
    }
    
    [inviCharadb close];
    
    // コンボを追加するボタンを設置する
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                              target:self
                                              action:@selector(addCombo)];
    
    return self;
    
}

// sort 画面に遷移
- (void) sort
{
    
    SortView *modalView = [[SortView alloc] init];
    modalView.delegate = self;
    UINavigationController *modalNavi = [[UINavigationController alloc] initWithRootViewController:modalView];
    [self presentViewController:modalNavi animated:YES completion:nil];
    
}

// delegate 用変数
- (void) relo
{
    [self reloadData];
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
    return [combo count];
}

// セルの横に矢印を表示する
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellAccessoryDisclosureIndicator;
    
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
    // セルにテキストを設定
    cell.textLabel.text = [combo objectAtIndex:indexPath.row];
    // セルにサブテキストを設定
    NSString *damageText = [damage objectAtIndex:indexPath.row];
    NSString *detail = [NSString stringWithFormat:@"ダメージ: %@", damageText];
    cell.detailTextLabel.text = detail;
    
    // セルに画像設定
    // もし center が 0 なら中央 1 なら端
    if ([[center objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
    UIImage *cellImage = [UIImage imageNamed:@"center.jpg"];
    cell.imageView.image = cellImage;
    }
    else {
        UIImage *cellImage = [UIImage imageNamed:@"hashi.jpg"];
        cell.imageView.image = cellImage;
    }
    
    
    return cell;
}

/**
 * セルが選択されたとき
 */

// !!!!!!!!!!!!!!!!!!!! まだ未実装（後で実装）"!!!!!!!!!!!!!!!!!!!!!!! //
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // called を参照して、ゲーム別のテーブルに遷移する処理を行う。
    NSString *aId = [comboId objectAtIndex:indexPath.row];
    NSString *aCombo = [combo objectAtIndex:indexPath.row];
    NSString *aDamage = [damage objectAtIndex:indexPath.row];
    NSString *aGage = [gage objectAtIndex:indexPath.row];
    NSString *aCenter = [center objectAtIndex:indexPath.row];
    NSString *aMemo = [memo objectAtIndex:indexPath.row];
    ComboView *comboView = [[ComboView alloc] initWithScrollView:aCombo comboId:aId comboDamage:aDamage comboGage:aGage comboCenter:aCenter comboMemo:aMemo buttonTitle:@"編集完了" called:gameCalled];
    if (comboView) {
        [self.navigationController pushViewController:comboView animated:YES];
    }
    
}

// コンボ新規追加する用
- (void)addCombo
{
    ComboView *comboView = [[ComboView alloc] initWithScrollView:nil comboId:nil comboDamage:nil comboGage:nil comboCenter:@"1" comboMemo:nil buttonTitle:@"新規登録" called:gameCalled];
    if (comboView) {
        [self.navigationController pushViewController:comboView animated:YES];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadData {
    
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
    comboId = [[NSArray alloc] init];
    combo = [[NSArray alloc] init];
    damage = [[NSArray alloc] init];
    center = [[NSArray alloc] init];
    gage = [[NSArray alloc] init];
    memo = [[NSArray alloc] init];
    
    
    // maindb に取得したテーブルの内容を格納
    inviCharadb = [FMDatabase databaseWithPath:db_path];
    
    // ここから抽出
    // もし 0 ならすべて
    // 1 なら中央こん
    // 2 なら端こんのみ
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int sortNum = [ud integerForKey:@"sort"];
    if (sortNum == 0) {
    
    select = [NSString stringWithFormat:@"SELECT id, combo, damage, center, gage, memo FROM %@;", gameCalled];
  
    }
    else if (sortNum == 1) {
    select = [NSString stringWithFormat:@"SELECT id, combo, damage, center, gage, memo FROM %@ WHERE center = '0';", gameCalled];
    }
    else if (sortNum == 2) {
        select = [NSString stringWithFormat:@"SELECT id, combo, damage, center, gage, memo FROM %@ WHERE center = '1';", gameCalled];
    }
    
    // ここから取得したテーブルから必要なデータを検索して result に格納する
    [inviCharadb open];
    
    FMResultSet *result = [inviCharadb executeQuery:select];
    
    // ここから取得したデータからゲームタイトルを配列に格納する
    while([result next]) {
        NSString *comboId2 = [result stringForColumn:@"id"];
        NSString *combo2 = [result stringForColumn:@"combo"];
        NSString *damage2 = [result stringForColumn:@"damage"];
        NSString *center2 = [result stringForColumn:@"center"];
        NSString *gage2 = [result stringForColumn:@"gage"];
        NSString *memo2 = [result stringForColumn:@"memo"];
        
        // 配列の最後に新しく要素を挿入していく
        comboId = [comboId arrayByAddingObject:comboId2];
        combo = [combo arrayByAddingObject:combo2];
        damage = [damage arrayByAddingObject:damage2];
        center = [center arrayByAddingObject:center2];
        gage = [gage arrayByAddingObject:gage2];
        memo = [memo arrayByAddingObject:memo2];
    }
    
    [inviCharadb close];

    
    [self.tableView reloadData];
}

// セルをスワイプすると削除ボタンが表示されるようにする
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 最初にデータベースを呼び出す
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
        
        // maindb に取得したテーブルの内容を格納
        inviCharadb = [FMDatabase databaseWithPath:db_path];
        // ここから取得したテーブルから必要なデータを検索削除、追加
        [inviCharadb open];
        
        // 削除
            NSString *delete = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id = ?", gameCalled];
            [inviCharadb executeUpdate:delete, [NSNumber numberWithInt:[[comboId objectAtIndex:indexPath.row] intValue]]];
            
        [self reloadData];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}


@end
