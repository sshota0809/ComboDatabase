//
//  EasyInputDetailConfig.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/03.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "EasyInputDetailConfig.h"

@implementation EasyInputDetailConfig

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // ツールバーを表示する
    
    ud = [NSUserDefaults standardUserDefaults];
    
    double barr = [ud doubleForKey:@"barr"];
    double barg = [ud doubleForKey:@"barg"];
    double barb = [ud doubleForKey:@"barb"];
    double texr = [ud doubleForKey:@"texr"];
    double texg = [ud doubleForKey:@"texg"];
    double texb = [ud doubleForKey:@"texb"];
    
    // ツールバーを表示する
    [self.navigationController setToolbarHidden:NO animated:NO];
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.toolbar.barTintColor = [UIColor colorWithRed:barr green:barg blue:barb alpha:0.6];
    self.navigationController.toolbar.tintColor = [UIColor colorWithRed:texr green:texg blue:texb alpha:1.0];
    
    
    // 背景設定
    UIImage *backImage = [UIImage imageNamed:@"back3.png"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    [self.tableView setBackgroundView:backImageView];
    
    // ツールバーにボタンを設置
    
    // 初期化ボタン
    def = [[UIBarButtonItem alloc] initWithTitle:@"デフォルトに戻す"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(comeDef)];
    
    // コマンドaddボタン
    add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    
    // 余白用
    gap = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    self.toolbarItems = @[def, gap, gap, gap, gap, gap, add];
    
    
}

- (id)initWithRow:(NSString *)key title:(NSString *)title
{
    
    // 画面のタイトルの設定
    self.title = title;
    
    keyTitle = key;
    
    // もし option condition の場合は - を残したいので変数を使用してコントロールする
    if ([keyTitle isEqualToString:@"option"] || [keyTitle isEqualToString:@"condition"]) {
        controll = 1;
    }
    else {
        controll = 1;
    }
    
    ud = [NSUserDefaults standardUserDefaults];
    
    // テーブルのセルとなるその列のリストを呼ぶ
    // mutablecopy しないとなぜかバグるので絶対にそうする
    kariList = [ud objectForKey:key];
    list = [kariList mutableCopy];
    
    // テーブルの編集モードボタンを設置する
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    return self;
}

// デフォルトにコマンドを戻す
- (void) comeDef
{
    
    // １行で書くタイプ（複数ボタンタイプ）
    alert =
    [[UIAlertView alloc] initWithTitle:@"確認" message:@"デフォルトのコマンドに戻してよろしいですか？"
                              delegate:self cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
    [alert show];

    
}

// アラートのボタンが押された時に呼ばれるデリゲート例文
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
            //１番目のボタンが押されたときの処理を記述する
    }
    else {
            //２番目のボタンが押されたときの処理を記述する
        // optionかどうかなどで決める
        
        if ([keyTitle isEqualToString:@"option"]) {
            list = [NSArray arrayWithObjects:@"-", @"dl", @"dc", @"jc", @"hjc", nil];
            
        }
        else if ([keyTitle isEqualToString:@"condition"]) {
            list = [NSArray arrayWithObjects:@"-", @"J", nil];
        }
        else if ([keyTitle isEqualToString:@"liver"]) {
            list = [NSArray arrayWithObjects:@"-", @"2", @"3", @"4", @"5", @"6", @"8", @"236", @"214", @"623", @"421", @"41236", @"63214", @"632146", @"2141236", @"4タメ6", @"2タメ8", @"1回転", nil];
        }
        else if ([keyTitle isEqualToString:@"button"]) {
            list = [NSArray arrayWithObjects:@"-", @"A", @"B", @"C", @"D", @"P", @"K", @"S", @"HS", @"弱P", @"中P", @"強P", @"弱K", @"中K", @"強K", nil];
        }
        
        list = [list mutableCopy];

        [ud setObject:list forKey:keyTitle];
        
        [self reloadData];
        
    }
    
}

// コマンドを追加するボタン
- (void) add
{
    
    InputConfigAdd *modalView = [[InputConfigAdd alloc] init];
    modalView.delegate = self;
    UINavigationController *modalNavi = [[UINavigationController alloc] initWithRootViewController:modalView];
    [self presentViewController:modalNavi animated:YES completion:nil];
    
}

// コマンドを追加する
- (void) addInput:(NSString *)addCommand
{
    NSLog(@"hooooo");
                NSLog(@"count = %d", [list count]);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([list count] - controll) inSection:0];
                NSLog(@"list 1 = %@", [list objectAtIndex:0]);
    NSArray *indexPaths = [NSArray arrayWithObjects:indexPath,nil];
                NSLog(@"gyaaaaaaaa");
    [list addObject:[NSString stringWithFormat:@"%@", addCommand]];
                NSLog(@"gyaaaaaaaa");
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            NSLog(@"gyaaaaaaaa");
    // NSUserDefaults の更新
    [ud setObject:list forKey:keyTitle];
            NSLog(@"gyaaaaaaaa");
}


/**
 * テーブルのセルの数を返す
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count] - controll;
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // セルの背景を透明にする
    [cell setBackgroundColor:[UIColor clearColor]];
    
    // セルにテキストを設定
    cell.textLabel.text = [list objectAtIndex:(indexPath.row + controll)];
    
    return cell;
}

// セルの高さを指定する
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

/**
 * セルが選択されたとき
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

// セルの削除を可能にするメソッド
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"a");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            NSLog(@"b");
        NSLog(@"%ld", (long)indexPath.row);
        NSLog(@"%@", [list objectAtIndex:indexPath.row]);
        [list removeObjectAtIndex:(indexPath.row + controll)]; // 削除ボタンが押された行のデータを配列から削除します。
            NSLog(@"c");
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"d");
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // ここは空のままでOKです。
            NSLog(@"e");
    }
    
    // NSUserDefaults の更新
    [ud setObject:list forKey:keyTitle];
    
}

// セルの移動を許可する
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// セルの移動
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if(fromIndexPath.section == toIndexPath.section) { // 移動元と移動先は同じセクションです。
        if(list && (toIndexPath.row) < ([list count] - controll)) {
            NSString *item = [list objectAtIndex:(fromIndexPath.row + controll)]; // 移動対象を保持します。
            [list removeObject:item]; // 配列から一度消します。
            [list insertObject:item atIndex:(toIndexPath.row + controll)]; // 保持しておいた対象を挿入します。
        }
    }
    
    // NSUserDefaults の更新
    [ud setObject:list forKey:keyTitle];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    if (editing) { // 現在編集モードです。

        def.enabled = NO;
        add.enabled = NO;
        
        
    } else { // 現在通常モードです。
        [self.navigationItem setLeftBarButtonItem:nil animated:YES]; // 追加ボタンを非表示にします。
        
        def.enabled = YES;
        add.enabled = YES;
        
    }
}

- (void)reloadData {
    
    [self.tableView reloadData];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
            [self.navigationController setToolbarHidden:YES animated:NO];
    }
    [super viewWillDisappear:animated];
}


@end
