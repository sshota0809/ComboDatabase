//
//  easyInputConfig.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/03.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "easyInputConfig.h"

@implementation easyInputConfig

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 画面のタイトルの設定
    self.title = @"楽々入力";
    
    // 背景設定
    UIImage *backImage = [UIImage imageNamed:@"back3.png"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    [self.tableView setBackgroundView:backImageView];

    
}

// グループにする
- (id)init
{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    infoTextView *tv = [[infoTextView alloc] initWithFrame:CGRectMake(5, 250, 310, 200)];
    
    tv.text = @"楽々入力で選択できる項目を編集できます。追加、削除、並び替えの操作が可能です。また、デフォルトに戻すこともできます。";
    // opaque属性にNOを設定する事で、背景透過を許可する。
    // ここの設定を忘れると、背景色をいくら頑張っても透明になりません。
    tv.opaque = NO;
    tv.editable = NO;
    
    // backgroundColorにalpha=0.0fの背景色を設定することで、
    // 背景色が透明になります。
    tv.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    
    [self.tableView addSubview:tv];
    
    return self;
}


// セクション数を指定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // セクションは2個とします
}

// セクションのタイトルを指定
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0:
            return @"項目";
            break;
    }
    return nil; //ビルド警告回避用
}

// それぞれのセルの行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return 4; // 1個目のセクションのセルは4個とします
    }
    return 2; // 2個目のセクションのセルは1個とします
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
    // [cell setBackgroundColor:[UIColor clearColor]];
    
    // セルにテキストを設定
    if (indexPath.row == 0) {
        cell.textLabel.text = @"1列目: オプション";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"2列目: キャラ状態";
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"3列目 レバー入力";
    }
    else {
        cell.textLabel.text = @"4列目 ボタン入力";
    }
    
    return cell;
}

// セルの高さを指定する
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
    
    // もし 0 が選択されたなら楽々入力の設定の表示
    // もし 1 が選択されたならアプリの使い方を表示
    
    if (indexPath.row == 0) {
        
        EasyInputDetailConfig *inputConfig = [[EasyInputDetailConfig alloc] initWithRow:@"option" title:@"オプション"];
        if (inputConfig) {
            [self.navigationController pushViewController:inputConfig animated:YES];
        }
        
        
    }
    else if (indexPath.row == 1) {
        
        EasyInputDetailConfig *inputConfig = [[EasyInputDetailConfig alloc] initWithRow:@"condition" title:@"キャラ状態"];
        if (inputConfig) {
            [self.navigationController pushViewController:inputConfig animated:YES];
        }
        
        }
        
    else if (indexPath.row == 2) {
        
        EasyInputDetailConfig *inputConfig = [[EasyInputDetailConfig alloc] initWithRow:@"liver" title:@"レバー入力"];
        if (inputConfig) {
            [self.navigationController pushViewController:inputConfig animated:YES];
        }

        }
        
        else {
            
            EasyInputDetailConfig *inputConfig = [[EasyInputDetailConfig alloc] initWithRow:@"button" title:@"コマンド入力"];
            if (inputConfig) {
                [self.navigationController pushViewController:inputConfig animated:YES];
            
        }
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
