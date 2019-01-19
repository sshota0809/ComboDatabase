//
//  ComboView.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/31.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "ComboView.h"



@implementation ComboView

- (id)initWithScrollView:(NSString *)aCombo comboId:(NSString *)aId comboDamage:(NSString *)aDamage comboGage:(NSString *)aGage comboCenter:(NSString *)aCenter comboMemo:(NSString *)aMemo buttonTitle:(NSString *)aTitle called:(NSString *)aCalled;
{
    
    
    // pickerview 用変数の初期化
    pickerCount = 0;
    
    // コンボ
    self.title = @"コンボ";
    
    // NSUserDefaults の初期化
    ud = [NSUserDefaults standardUserDefaults];
    
    // キーボード用のジェスチャーの設定
    // テキストフィールド以外の部分をタップしたらキーボードが閉じるようにアクションを設定する
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    
    //背景を設定する
    UIImage *backgroundImage = [UIImage imageNamed:@"back.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    // UISCrollView を設定
    scrView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrView.bounces = NO;
    // スクロールビューにのせるビュー
    // このビューにパーツをのせて最後にスクロールビューに追加する
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, 568);
    comView = [[UIView alloc] initWithFrame:rect];
    
    NSLog(@"teste = %f", self.view.bounds.size.width);
    
    // 使用する変数を代入
    called = aCalled;
    comboId = aId;
    combo = aCombo;
    damage = aDamage;
    gage = aGage;
    insCenter = aCenter;
    center = [aCenter integerValue];
    buttonTitle = aTitle;
    memo = aMemo;
    
    // それぞれのパーツを配置する
    
    // まずはコンボを表示するテキストビュー
    comboTextField = [[UITextView alloc] initWithFrame:CGRectMake(2, 25, 316, 70)];
    comboTextField.text = combo;
    comboTextField.font = [UIFont systemFontOfSize:15];
    // タグ
    comboTextField.tag = 1;
    comboTextField.delegate = self;
    [comView addSubview:comboTextField];
    
    // コンボダメージを表示するテキストフィールド
    comboDamageField = [[UITextField alloc] initWithFrame:CGRectMake(2, 160, 100, 30)];
    comboDamageField.text = damage;
    comboDamageField.backgroundColor = [UIColor whiteColor];
    // キーボードは数字のみのに固定
    comboDamageField.keyboardType = UIKeyboardTypeNumberPad;
    [comView addSubview:comboDamageField];
    
    // ゲージ回収を表示するテキストフィールド
    comboGageField = [[UITextField alloc] initWithFrame:CGRectMake(158, 160, 100, 30)];
    comboGageField.text = gage;
    comboGageField.backgroundColor = [UIColor whiteColor];
    // キーボードは数字のみのに固定
    comboGageField.keyboardType = UIKeyboardTypeNumberPad;
    [comView addSubview:comboGageField];
    
    // コンボのメモを表示するテキストフィールド
    memoField = [[UITextView alloc] initWithFrame:CGRectMake(38, 230, 280, 50)];
    memoField.text = memo;
    memoField.font = [UIFont systemFontOfSize:11];
    // タグ
    memoField.tag = 2;
    memoField.delegate = self;
    [comView addSubview:memoField];
    
    // 中央か端かを表示するスイッチ
    centerSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(150, 195, 60, 60)];
    // もし 0 なら中央 1 なら端だと判定する
    if ([insCenter isEqualToString:@"0"]) {
        centerSwitch.on = NO;
    }
    else {
        centerSwitch.on = YES;
    }
    // 値が変更されたら center の値を変更するメソッドを呼び出す
    [centerSwitch addTarget:self action:@selector(switchSlide:) forControlEvents:UIControlEventValueChanged];
    [comView addSubview:centerSwitch];
    
    // 編集を完了するボタン
    finButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 370, 280, 60)];
    finButton.layer.borderColor = [UIColor blackColor].CGColor;
    // [finButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:100 alpha:0.4]];
    finButton.layer.borderWidth = 1.0f;
    finButton.layer.cornerRadius = 1.0f;
    [finButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [finButton setTitle:buttonTitle forState:UIControlStateNormal];
    [finButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [finButton addTarget:self action:@selector(addCombo) forControlEvents:UIControlEventTouchUpInside];
    [comView addSubview:finButton];
    
    // picker を使用するか否かのボタン
    usePicker = [[UISwitch alloc] initWithFrame:CGRectMake(150, 100, 60, 60)];
    
    usePicker.on = NO;
    [usePicker addTarget:self action:@selector(boolPicker:) forControlEvents:UIControlEventValueChanged];
    [comView addSubview:usePicker];
    
    
    
    // ここからラベル系を指定
    
    // コンボルート
    comboTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 70, 30)];
    comboTextLabel.text = @"コンボ";
    [comView addSubview:comboTextLabel];
    
    // ピッカーを使うかどうか
    boolPickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 100, 200, 30)];
    boolPickerLabel.text = @"楽々入力を使用:";
    [comView addSubview:boolPickerLabel];
    
    // ダメージ
    damageLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 130, 70, 30)];
    damageLabel.text = @"ダメージ";
    [comView addSubview:damageLabel];
    
    // ゲージ回収
    gageLabel = [[UILabel alloc] initWithFrame:CGRectMake(158, 130, 100, 30)];
    gageLabel.text = @"ゲージ回収";
    [comView addSubview:gageLabel];
    
    // 中央かどうか
    centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 195, 150, 30)];
    centerLabel.text = @"端限定コンボ:";
    [comView addSubview:centerLabel];
    
    // コンボメモ
    memoLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 230, 150, 30)];
    memoLabel.text = @"メモ";
    [comView addSubview:memoLabel];
    
    
    
    // ツールバーにボタンを設置
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"about.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(info)];
    
    // ツイートボタン
    UIBarButtonItem *twe = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"twiBird.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(tweet)];
    
    // 余白用
    UIBarButtonItem *gap = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    self.toolbarItems = @[item, gap, gap, gap, gap, gap, twe];
    
    
    
    
    
    // 最後にパーツをのせてるビューをスクロールビューにのせて終わる
    // UIScrollViewのコンテンツサイズを画像のサイズに合わせる
    scrView.contentSize = comView.bounds.size;
    [scrView addSubview:comView];
    [self.view addSubview:scrView];
    
    return self;
}

// modalview を表示する
- (void) info
{
    
    modalTableView *modalView = [[modalTableView alloc] init];
    UINavigationController *modalNavi = [[UINavigationController alloc] initWithRootViewController:modalView];
    [self presentViewController:modalNavi animated:YES completion:nil];
    
    
}

// tweet 画面を表示する
- (void) tweet
{
    
    
    // コンボをつぶやく
    // ex. 5A>5B>5C
    //     ダメージ: 500
    
    NSString *tweetText = [NSString stringWithFormat:@"%@\nダメージ: %@", comboTextField.text, comboDamageField.text];
    SHKItem *item = [SHKItem text:tweetText];
    [SHKTwitter shareItem:item];
    
    
}


- (void)boolPicker:(id)sender
{
    UISwitch *sw = sender;
    if (sw.on) {
        usePick = true;
    }
    else {
        usePick = false;
    }
    
}

- (void)undoCommand
{
    
    comboTextField.text = undoText;
    
}

- (void)switchSlide:(id)sender
{
    UISwitch *sw = sender;
    if (sw.on) {
        insCenter = @"1";
        center = 1;
    }
    else {
        insCenter = @"0";
        center = 0;
    }
    
}

- (void)addCombo
{
    
    // テキストフィールドの値を変更して代入する
    combo = comboTextField.text;
    damage = comboDamageField.text;
    gage = comboGageField.text;
    memo = memoField.text;
    
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
    combodb = [FMDatabase databaseWithPath:db_path];
    // ここから取得したテーブルから必要なデータを検索削除、追加
    [combodb open];
    
    int *boolNew = [comboId intValue];
    
    NSLog(@"%d", center);

    // もし id が 0 に設定されてるならばそれは新規追加なので ID を乱数生成して追加処理をする
    if (boolNew == 0) {
        
        // 乱数を作成してその乱数を id としてコンボを登録する
        // キャラ ID 用に乱数を作成する　1 ~ 1000 の間
        srand((unsigned int)time(NULL));
        int random = rand() % 1000 + 1;
        NSLog(@"random = %d", random);
        // 新規レコード
        NSString *insert = [NSString stringWithFormat:@"INSERT INTO %@ (id, combo, damage, gage, center, memo) VALUES (?, ?, ?, ?, ?, ?);", called];
        
        [combodb executeUpdate:insert, [NSNumber numberWithInt:random], combo, [NSNumber numberWithInt:[damage intValue]], [NSNumber numberWithInt:[gage intValue]], [NSNumber numberWithInt:[insCenter intValue]], memo];
        
    }
    // その他はその id のレコードを一回削除して新規レコードを追加する
    else {
        // 削除
        NSLog(@"fffffff%@", called);
        NSString *delete = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id = ?", called];
        [combodb executeUpdate:delete, [NSNumber numberWithInt:[comboId intValue]]];
        
        // 追加
        NSString *insert = [NSString stringWithFormat:@"INSERT INTO %@ (id, combo, damage, gage, center, memo) VALUES (?, ?, ?, ?, ?, ?);", called];
        [combodb executeUpdate:insert, [NSNumber numberWithInt:[comboId intValue]], combo, [NSNumber numberWithInt:[damage intValue]], [NSNumber numberWithInt:[gage intValue]], [NSNumber numberWithInt:[insCenter intValue]], memo];
        
    }
    
    // 一つ前の画面のテーブルビューを更新する
    NSArray *allcontrollers = [self.navigationController viewControllers];
    NSInteger target = [allcontrollers count] - 2;
    IndividualCharacterTableView *parent = [allcontrollers objectAtIndex:target];
    [parent reloadData];
    // 最後にキャラ一覧画面に戻る
    [self.navigationController popViewControllerAnimated:YES];
    
}

////// ここからキーボードしまう処理 //////
-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    
    if (comboTextField.isFirstResponder) {
        [comboTextField resignFirstResponder];
    }
    else if (comboDamageField.isFirstResponder) {
        [comboDamageField resignFirstResponder];
    }
    else if (comboGageField.isFirstResponder) {
        [comboGageField resignFirstResponder];
    }
    else if (memoField.isFirstResponder) {
        [memoField resignFirstResponder];
    }
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.singleTap) {
        // キーボード表示中のみ有効
        if (comboDamageField.isFirstResponder || comboTextField.isFirstResponder || comboGageField.isFirstResponder || memoField.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}
////// ここからキーボードしまう処理 //////










///////////　ここからピッカーに関する処理、メソッド ///////////
/**
 * ピッカーに表示する列数を返す
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

// 列(component)に対する、行(row)の数を返す
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    // picker 用配列
    NSMutableArray *option = [ud stringArrayForKey:@"option"];
    NSMutableArray *condition = [ud stringArrayForKey:@"condition"];
    NSMutableArray *liver = [ud stringArrayForKey:@"liver"];
    NSMutableArray *button = [ud stringArrayForKey:@"button"];

    switch (component) {
        case 0: // -, dl, jc, hjc
            return [option count];;
        case 1:
            return [condition count];;
        case 2: // 2,3,4,5,6,8
            return [liver count];;
        case 3: // A, B, C, D
            return [button count];;
    }
    return 0;
}

/**
 * 行のサイズを変更
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0: // 1列目
            return 50.0;
            break;
            
        case 1: // 2列目
            return 50.0;
            break;
            
        case 2: // 3列目
            return 100.0;
            break;
        
        case 3:
            return 100.0;
            break;
            
        default:
            return 0;
            break;
    }
}

/**
 * ピッカーに表示する値を返す
 */
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // picker 用配列
    NSArray *option = [ud stringArrayForKey:@"option"];
    NSArray *condition = [ud stringArrayForKey:@"condition"];
    NSArray *liver = [ud stringArrayForKey:@"liver"];
    NSArray *button = [ud stringArrayForKey:@"button"];

    switch (component) {
        case 0: // 1列目
            
            return [option objectAtIndex:row];
            break;
        
        case 1:
            return [condition objectAtIndex:row];
            break;
            
        case 2: // 2列目
            return [liver objectAtIndex:row];
            break;
            
        case 3: // 3列目
            return [button objectAtIndex:row];
            break;
            
        default:
            return 0;
            break;
    }
}

- (void)showPicker {
    
    
    if (pickerCount == 0) {
        pickerCount = 1;
        
    // ピッカーを作成
    commandPicker = [[UIPickerView alloc] init];
    commandPicker.center = CGPointMake(640, 400);
    commandPicker.backgroundColor = [UIColor whiteColor];
    commandPicker.delegate = self;
    commandPicker.dataSource = self;
    commandPicker.showsSelectionIndicator = YES;
    [comView addSubview:commandPicker];
    
    // ピッカーのメニューをのせる view を作成
    pickerMenuview = [[UIView alloc] initWithFrame:CGRectMake(640, 270, 320, 40)];
    pickerMenuview.backgroundColor = [UIColor colorWithRed:0.2 green:0.5 blue:0.8 alpha:0.8];
    
    // ピッカーのメニューにのせるボタン
    addCommandButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 5, 70, 30)];
    addCommandButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [addCommandButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addCommandButton.layer.borderWidth = 1.0f;
    addCommandButton.layer.cornerRadius = 7.5f;
    [addCommandButton setTitle:@"追加" forState:UIControlStateNormal];
    [addCommandButton setTitleColor:[UIColor colorWithRed:0.7 green:0.7 blue:1.0 alpha:0.8] forState:UIControlStateHighlighted];
    [addCommandButton addTarget:self action:@selector(addCommand) forControlEvents:UIControlEventTouchUpInside];
    [pickerMenuview addSubview:addCommandButton];
    
    // ピッカーのメニューにのせるボタン
    undoButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
    undoButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [undoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    undoButton.layer.borderWidth = 1.0f;
    undoButton.layer.cornerRadius = 7.5f;
    [undoButton setTitle:@"取り消し" forState:UIControlStateNormal];
    [undoButton setTitleColor:[UIColor colorWithRed:0.7 green:0.7 blue:1.0 alpha:0.8] forState:UIControlStateHighlighted];
    [undoButton addTarget:self action:@selector(undoCommand) forControlEvents:UIControlEventTouchUpInside];
    [pickerMenuview addSubview:undoButton];
    [comView addSubview:pickerMenuview];

    
    // 最初にツールバーをしまう
    [self.navigationController setToolbarHidden:YES animated:YES];
    
	// ピッカーが下横から出るアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	commandPicker.center = CGPointMake(160, 400);
    pickerMenuview.center = CGPointMake(160, 275);
	[UIView commitAnimations];
	
	// 右上にdoneボタン
	if (!self.navigationItem.rightBarButtonItem) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"閉じる" style:UIBarButtonItemStyleBordered target:self action:@selector(done:)];
        [self.navigationItem setRightBarButtonItem:doneButton animated:YES];
    }
        
        comboDamageField.enabled = NO;
        comboGageField.enabled = NO;
        memoField.editable = NO;
        
    }
    
    
}


- (void)hidePicker {
    
	// ピッカーが下に隠れるアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	commandPicker.center = CGPointMake(640, 400);
    pickerMenuview.center = CGPointMake(640, 275);
	[UIView commitAnimations];
    
	// doneボタンを消す
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
    
    // ツールバー再登場
    [self.navigationController setToolbarHidden:NO animated:YES];

    
}


- (void)done:(id)sender {
    
    pickerCount = 0;
 
	// ピッカーしまう
	[self hidePicker];
	
	// doneボタン消す
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    
    comboDamageField.enabled = YES;
    comboGageField.enabled = YES;
    memoField.editable = YES;
}

- (void)addCommand
{
    
    undoText = comboTextField.text;
    
    // picker 用配列
    NSMutableArray *option = [ud stringArrayForKey:@"option"];
    NSMutableArray *condition = [ud stringArrayForKey:@"condition"];
    NSMutableArray *liver = [ud stringArrayForKey:@"liver"];
    NSMutableArray *button = [ud stringArrayForKey:@"button"];
    
    // 現在選択されてるコマンドをUITextViewに表示する
    // text が 0 の場合は > は表示しない
    NSString *optionText = [option objectAtIndex:[commandPicker selectedRowInComponent:0]];
    NSString *conditionText = [condition objectAtIndex:[commandPicker selectedRowInComponent:1]];
    NSString *liverText = [liver objectAtIndex:[commandPicker selectedRowInComponent:2]];
    NSString *buttonText = [button objectAtIndex:[commandPicker selectedRowInComponent:3]];
    
    if ([optionText isEqualToString:@"-"]) {
        optionText = @"";
    }
    if ([conditionText isEqualToString:@"-"]) {
        conditionText = @"";
    }
    if ([liverText isEqualToString:@"-"]) {
        liverText = @"";
    }
    if ([buttonText isEqualToString:@"-"]) {
        buttonText = @"";
    }
    
    if ([comboTextField.text length] == 0) {
        
        NSString *command = [NSString stringWithFormat:@"%@%@%@%@", optionText, conditionText, liverText, buttonText];
        
        comboTextField.text = [NSString stringWithFormat:@"%@%@", comboTextField.text, command];
        
    }
    
    else {
        
        NSString *command = [NSString stringWithFormat:@">%@%@%@%@", optionText, conditionText, liverText, buttonText];
        
        comboTextField.text = [NSString stringWithFormat:@"%@%@", comboTextField.text, command];
        
    }


}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    // もし usePick が true なら picker を使用する
    
    if (textView.tag == 1) {
    if (usePick) {
        
        undoText = comboTextField.text;
	// ピッカー表示開始
	[self showPicker];
    
    return NO;
    }
    }
    else {
        return YES;
    }
    
    return YES;
    
}
///////////　ここまでピッカーに関する処理、メソッド ///////////

@end
