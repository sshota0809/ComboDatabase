//
//  IndividualGameTableView.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/30.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "IndividualGameTableView.h"

@implementation IndividualGameTableView

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}


// 初期化処理はここで行う
- (id)initWithTable:(NSString *)title select:(NSString *)called
{
    
    gameCalled = called;
    
    self.title = gameCalled;
    
    // 背景設定
    UIImage *backImage = [UIImage imageNamed:@"back3.png"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    [self.tableView setBackgroundView:backImageView];
    
    // ツールバーにボタンを設置
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"about.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(info)];
    self.toolbarItems = @[item];
    
    // ゲーム別のキャラ一覧を表示する table を tableView に表示する
    // テーブル名: GameCalled.db (ex.BBCP.db, P4U2.db)
    // フィールド
    // id INTEGER
    // name TEXT
    
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
    charaName = [[NSArray alloc] init];
    charaId = [[NSArray alloc] init];
    charaImage = [[NSArray alloc] init];
    
    // maindb に取得したテーブルの内容を格納
    invidb = [FMDatabase databaseWithPath:db_path];
    
    // ここから抽出
    NSString *select = [NSString stringWithFormat:@"SELECT id, name, image FROM %@;", called];
    
    // ここから取得したテーブルから必要なデータを検索して result に格納する
    [invidb open];
    
    FMResultSet *result = [invidb executeQuery:select];
    
    
    // ここから取得したデータからゲームタイトルを配列に格納する
    while([result next]) {
        NSString *charaName2 = [result stringForColumn:@"name"];
        NSString *charaId2 = [result stringForColumn:@"id"];
        NSData *charaImage2 = [result dataForColumn:@"image"];
        
        // 配列の最後に新しく要素を挿入していく
        charaName = [charaName arrayByAddingObject:charaName2];
        charaId = [charaId arrayByAddingObject:charaId2];
        charaImage = [charaImage arrayByAddingObject:charaImage2];
        
    }
    
    [invidb close];
    
    // キャラを追加するボタンを設置する
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                              target:self
                                              action:@selector(addCharacter)];
    
    
    return self;
    
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
    return [charaName count];
}

/**
 * 指定されたインデックスパスのセルを作成する
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    ImageSizeFixedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // セルが作成されていないか?
    if (!cell) { // yes
        // セルを作成
        cell = [[ImageSizeFixedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // セルの背景を透明にする
    [cell setBackgroundColor:[UIColor clearColor]];
    // セルにテキストを設定
    cell.textLabel.text = [charaName objectAtIndex:indexPath.row];
    // セルに画像設定
    UIImage *cellImage = [[UIImage alloc] initWithData:[charaImage objectAtIndex:indexPath.row]];
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
    NSString *table = [NSString stringWithFormat:@"%@%@", gameCalled, [charaId objectAtIndex:indexPath.row]];
    IndividualCharacterTableView *indiCharaView = [[IndividualCharacterTableView alloc] initWithTable:[charaName objectAtIndex:indexPath.row] select:table];
    if (indiCharaView) {
        [self.navigationController pushViewController:indiCharaView animated:YES];
    }
    
}

// キャラクター追加処理
- (void)addCharacter
{
    
    
    // called を参照して、ゲーム別のテーブルに遷移する処理を行う。
    AddCharacter *addChara = [[AddCharacter alloc] initAddView:gameCalled];
    if (addChara) {
        [self.navigationController pushViewController:addChara animated:YES];
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
    charaName = [[NSArray alloc] init];
    charaId = [[NSArray alloc] init];
    charaImage = [[NSArray alloc] init];
    
    // maindb に取得したテーブルの内容を格納
    invidb = [FMDatabase databaseWithPath:db_path];
    
    // ここから抽出
    NSString *select = [NSString stringWithFormat:@"SELECT id, name, image FROM %@;", gameCalled];
    
    // ここから取得したテーブルから必要なデータを検索して result に格納する
    [invidb open];
    
    FMResultSet *result = [invidb executeQuery:select];
    
    // ここから取得したデータからゲームタイトルを配列に格納する
    while([result next]) {
        NSString *charaName2 = [result stringForColumn:@"name"];
        NSString *charaId2 = [result stringForColumn:@"id"];
        NSData *charaImage2 = [result dataForColumn:@"image"];
        // 配列の最後に新しく要素を挿入していく
        charaName = [charaName arrayByAddingObject:charaName2];
        charaId = [charaId arrayByAddingObject:charaId2];
        charaImage = [charaImage arrayByAddingObject:charaImage2];
    }
    
    [invidb close];
    
    [self.tableView reloadData];
}

// セルをスワイプすると削除ボタンが表示されるようにする
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
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
        invidb = [FMDatabase databaseWithPath:db_path];
        
        // ここから抽出
        NSString *select = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id = ?", gameCalled];
        NSString *table = [NSString stringWithFormat:@"DROP TABLE %@%@", gameCalled, [charaId objectAtIndex:indexPath.row]];
        
        // ここから取得したテーブルから必要なデータを検索して result に格納する
        [invidb open];
        
        [invidb executeUpdate:select, [NSNumber numberWithInt:[[charaId objectAtIndex:indexPath.row] intValue]]];
        [invidb executeUpdate:table];
        [invidb close];
        
        [self reloadData];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

@end
