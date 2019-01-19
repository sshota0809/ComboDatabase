//
//  ThemaColor.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/04.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "ThemaColor.h"

@implementation ThemaColor

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 画面のタイトルの設定
    self.title = @"テーマカラー";
    
    // 背景設定
    UIImage *backImage = [UIImage imageNamed:@"back3.png"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    [self.tableView setBackgroundView:backImageView];
    
    
}

// グループにする
- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
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
            return @"カラーの設定";
            break;
    }
    return nil; //ビルド警告回避用
}

// それぞれのセルの行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return 2; // 1個目のセクションのセルは4個とします
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
        cell.textLabel.text = @"バーの背景色";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"バーの文字色";
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
        
        ThemeColorConfig *inputConfig = [[ThemeColorConfig alloc] initWithColor:@"bar" title:@"バーの背景色"];
        if (inputConfig) {
            [self.navigationController pushViewController:inputConfig animated:YES];
        }
        
        
    }
    else if (indexPath.row == 1) {
        
        ThemeColorConfig *inputConfig = [[ThemeColorConfig alloc] initWithColor:@"tex" title:@"バーの文字色"];
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
