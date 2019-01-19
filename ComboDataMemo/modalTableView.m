//
//  modalTableView.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/01.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "modalTableView.h"

@implementation modalTableView

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 画面のタイトルの設定
    self.title = @"info";
    
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
	if (!self.navigationItem.rightBarButtonItem) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"閉じる" style:UIBarButtonItemStyleBordered target:self action:@selector(close)];
        [self.navigationItem setRightBarButtonItem:doneButton animated:YES];
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
    return 2; // セクションは2個とします
}

// セクションのタイトルを指定
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0:
            return @"設定";
            break;
        case 1: // 2個目のセクションの場合
            return @"情報";
            break;
    }
    return nil; //ビルド警告回避用
}

// それぞれのセルの行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return 2; // 1個目のセクションのセルは2個とします
    }
    return 3; // 2個目のセクションのセルは1個とします
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
    if (indexPath.section == 0) {
    if (indexPath.row == 0) {
        cell.textLabel.text = @"楽々入力";
    }
    else {
        cell.textLabel.text = @"テーマカラー";
    }
    }
    else {
    if (indexPath.row == 0) {
        cell.textLabel.text = @"アプリの使い方";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"アプリについて";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
        
    else {
        cell.textLabel.text = @"リリースノート";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
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
    
    if (indexPath.section == 0) {
    return UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return UITableViewCellAccessoryNone;
    
}

/**
 * セルが選択されたとき
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // もし 0 が選択されたなら楽々入力の設定の表示
    // もし 1 が選択されたならアプリの使い方を表示
    if (indexPath.section == 0) {
    if (indexPath.row == 0) {
        
        easyInputConfig *inputConfig = [[easyInputConfig alloc] init];
        if (inputConfig) {
            [self.navigationController pushViewController:inputConfig animated:YES];
        }
        
    }
        
        else if (indexPath.row == 1) {
            
            ThemaColor *inputConfig = [[ThemaColor alloc] init];
            if (inputConfig) {
                [self.navigationController pushViewController:inputConfig animated:YES];
            }
            
        }

}
else {
    if (indexPath.row == 0) {
        /*
        HowToUse *howView = [[HowToUse alloc] init];
        if (howView) {
            [self.navigationController pushViewController:howView animated:YES];
        }
         */
        
        EAIntroPage *page1 = [EAIntroPage page];
        page1.title = @"ゲーム一覧画面";
        page1.desc = @"トップの画面です。コンボをメモしたいゲームを選択してください。";
        page1.bgImage = [UIImage imageNamed:@"introback2.png"];
        page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro1.png"]];
        
        EAIntroPage *page2 = [EAIntroPage page];
        page2.title = @"キャラクター一覧画面";
        page2.desc = @"選択したゲームのキャラクターの一覧画面です。キャラクターは自分で追加・削除が行えます。追加する場合は画面右上の＋ボタンをタップ・削除する時は削除したいキャラの行を左にスワイプしてください。コンボを追加したいキャラクターを選択してください。";
        page2.titlePositionY = 220;
        page2.descPositionY = 200;
        page2.bgImage = [UIImage imageNamed:@"introback2.png"];
        page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro2.png"]];
        
        EAIntroPage *page3 = [EAIntroPage page];
        page3.title = @"キャラクター追加画面";
        page3.desc = @"キャラクターを新規に追加する画面です。キャラクターの画像はiPhone本体に保存された画像から自分の好きな画像を設定することができます。好きなキャラクター名を入力したら下部の追加ボタンを押してください。";
        page3.titlePositionY = 220;
        page3.descPositionY = 200;
        page3.bgImage = [UIImage imageNamed:@"introback2.png"];
        page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro3.png"]];
        
        EAIntroPage *page4 = [EAIntroPage page];
        page4.title = @"コンボ一覧画面";
        page4.desc = @"キャラクターのコンボ一覧画面です。絞り込み表示も可能です。また、画面中央コンボ・画面端コンボを簡単に判別することができます。コンボもキャラクター画面と同じ手順で追加・削除ができます。コンボの閲覧・編集を行う場合はそのコンボを選択してください。新しくコンボを追加する場合は右上の＋ボタンを押してください。";
        page4.titlePositionY = 220;
        page4.descPositionY = 200;
        page4.bgImage = [UIImage imageNamed:@"introback2.png"];
        page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro4.png"]];
        
        EAIntroPage *page5 = [EAIntroPage page];
        page5.title = @"コンボ画面";
        page5.desc = @"コンボ画面です。コンボルート・ダメージ・ゲージ回収・画面中央/端・コンボメモが閲覧することができます。また、それらの欄をタップすることで編集することができます。また、右下のツイートボタンを押すことによってコンボをツイートすることができます。";
        page5.bgImage = [UIImage imageNamed:@"introback2.png"];
        page5.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro5.png"]];

        EAIntroPage *page6 = [EAIntroPage page];
        page6.title = @"楽々入力";
        page6.desc = @"コンボ画面の「楽々入力を使用」をONにすると使用することができます。コンボルートの入力が簡単に行うことができます。また、取り消しを押すことで一つ前の状態にもどることができます。";
        page6.bgImage = [UIImage imageNamed:@"introback2.png"];
        page6.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro6.png"]];
        
        EAIntroPage *page7 = [EAIntroPage page];
        page7.title = @"設定：楽々入力";
        page7.desc = @"さきほどの楽々入力のそれぞれの列の項目は自分で追加・削除・並び替えができるようになっています。自分のプレイしているゲームに合わせた設定・使いやすい設定に変更することができます。";
        page7.bgImage = [UIImage imageNamed:@"introback2.png"];
        page7.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro7.png"]];

        EAIntroPage *page8 = [EAIntroPage page];
        page8.title = @"設定：テーマカラー";
        page8.desc = @"アプリ上部のバーの背景色・文字色を自分で変更できます。自分の好みのカラーにカスタマイズしてみてください。";
        page8.bgImage = [UIImage imageNamed:@"introback2.png"];
        page8.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro8.png"]];
        
        
        EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.navigationController.view.bounds andPages:@[page1, page2, page3, page4, page5, page6, page7, page8]];
        [intro setDelegate:self];
        
        [intro showInView:self.navigationController.view animateDuration:1.0];
        
        
        
        // cellを選択したハイライトを解除する
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
        
        
    }
    else if (indexPath.row == 1) { // もし 1 が選択されたならアプリ情報を表示
        AppInfo *appView = [[AppInfo alloc] init];
        if (appView) {
            [self.navigationController pushViewController:appView animated:YES];
        }
    }
    else {
        releaseNote *reView = [[releaseNote alloc] init];
        if (reView) {
            [self.navigationController pushViewController:reView animated:YES];
        }
    }
}

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
