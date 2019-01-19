//
//  SortView.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/04.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "SortView.h"

@implementation SortView

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 画面のタイトルの設定
    self.title = @"絞り込み";
    
    ud = [NSUserDefaults standardUserDefaults];
    
    double barr = [ud doubleForKey:@"barr"];
    double barg = [ud doubleForKey:@"barg"];
    double barb = [ud doubleForKey:@"barb"];
    double texr = [ud doubleForKey:@"texr"];
    double texg = [ud doubleForKey:@"texg"];
    double texb = [ud doubleForKey:@"texb"];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:barr green:barg blue:barb alpha:0.6];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:texr green:texg blue:texb alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:texr green:texg blue:texb alpha:1.0]};
    
    
    
    // 背景設定
    UIImage *backImage = [UIImage imageNamed:@"back3.png"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    [self.tableView setBackgroundView:backImageView];
    
    // 右上に閉じるボタン
	if (!self.navigationItem.leftBarButtonItem) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"閉じる" style:UIBarButtonItemStyleBordered target:self action:@selector(close)];
        [self.navigationItem setLeftBarButtonItem:doneButton animated:YES];
    }
    
}

// グループにする
- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

// modal を閉じるボタン
- (void) close
{
    
    // modal を閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// セクション数を指定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // セクションは2個とします
}

// セクションのタイトルを指定
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0:
            return @"絞り込みルール";
            break;
    }
    return nil; //ビルド警告回避用
}

// それぞれのセルの行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return 3; // 1個目のセクションのセルは2個とします
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
        cell.textLabel.text = @"すべて";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"中央コンボ";
    }
    else {
        cell.textLabel.text = @"端コンボ";
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int sortNum = [ud integerForKey:@"sort"];
    if (sortNum == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    
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
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:indexPath.row forKey:@"sort"];

    
    // delegate によって前のメソッドを呼ぶ
    if ([delegate respondsToSelector:@selector(relo)]) {
        NSLog(@"aaaaaa");

        [delegate relo];
    }
    
    
    // 最後にキャラ一覧画面に戻る
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
