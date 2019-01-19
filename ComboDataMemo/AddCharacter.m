//
//  AddCharacter.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/30.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "AddCharacter.h"

@implementation AddCharacter
@synthesize charaImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"キャラ追加";
    
    // テキストフィールド以外の部分をタップしたらキーボードが閉じるようにアクションを設定する
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    
    //背景を設定する
    UIImage *backgroundImage = [UIImage imageNamed:@"back.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    // レイアウトを決定する
    
    // キャラクター名を入力するテキストフィールドを追加
    charaNameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 180, 300, 60)];
    charaNameField.placeholder = @"キャラ名を入力してください";
    charaNameField.font = [UIFont systemFontOfSize:21];
    charaNameField.layer.borderColor = [UIColor grayColor].CGColor;
    charaNameField.layer.borderWidth = 1.0f;
    charaNameField.layer.cornerRadius = 7.5f;
    
    [self.view addSubview:charaNameField];
    
    // キーボードの改行ボタンをキーボードをしまうボタンに設定する
    // [デリゲートの設定]
    charaNameField.delegate = self;
    // [「改行（Return）」キーの設定]
    charaNameField.returnKeyType = UIReturnKeyDone;
    
    // 実際にキャラを追加するボタンを追加
    addButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 250, 300, 50)];
    addButton.layer.borderColor = [UIColor blackColor].CGColor;
    [addButton setTitle:@"キャラを追加" forState:UIControlStateNormal];
    addButton.layer.borderWidth = 1.0f;
    addButton.layer.cornerRadius = 1.0f;
    [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    // ボタンが押された時の処理を決定する
    [addButton addTarget:self action:@selector(onAddButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addButton];
    
    // キャラ画像を格納する UIImageView を作成
    // ここから UIImage を設定する
    // 初期設定：デフォルト画像を使用
    UIImage *charaImageBefore = [UIImage imageNamed:@"chara.png"];
    // リサイズ処理
    
    CGFloat width = 100;
    CGFloat height = 100;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [charaImageBefore drawInRect:CGRectMake(0, 0, width, height)];
    charaImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageView = [[UIImageView alloc] initWithImage:charaImage];
    // 初期設定
    imageView.frame = CGRectMake(110, 10, 100, 100);
    [imageView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:imageView];
    
    // キャラ編集ボタン
    charaButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 120, 100, 30)];
    charaButton.layer.borderColor = [UIColor blackColor].CGColor;
    [charaButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [charaButton setTitle:@"キャラ画像変更" forState:UIControlStateNormal];
    charaButton.layer.borderWidth = 1.0f;
    charaButton.layer.cornerRadius = 7.5f;
    // ボタンが押された時の処理を決定する
    [charaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [charaButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [charaButton addTarget:self action:@selector(charaSelect) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:charaButton];
    
    // ツールバーにボタンを設置
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"about.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(info)];
    self.toolbarItems = @[item];

    
}

// modalview を表示する
- (void) info
{
    
    modalTableView *modalView = [[modalTableView alloc] init];
    UINavigationController *modalNavi = [[UINavigationController alloc] initWithRootViewController:modalView];
    [self presentViewController:modalNavi animated:YES completion:nil];
    
    
}

- (void) charaSelect {
    
    // タップされたらまず始めにライブラリから画像を選択させる
    charaPicker = [[UIImagePickerController alloc] init];
    charaPicker.delegate = self;
    // ライブラリを選択させる
    charaPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:charaPicker animated:YES];
    
}

// ImagePicker で画像が選択された時に呼ばれるメソッド
-(void)imagePickerController:(UIImagePickerController*)picker
       didFinishPickingImage:(UIImage*)image editingInfo:(NSDictionary*)editingInfo{
    
    [self dismissModalViewControllerAnimated:YES];  // モーダルビューを閉じる
    
    // 選択した image を charaimage に代入する
    UIImage *imageBefore = image;
    CGFloat w = imageBefore.size.width;
    CGFloat h = imageBefore.size.height;
    
    // 大きい方に比率をあわせる
    if (w > h) {
        CGFloat a = 100 / w;
        // リサイズ処理
        CGSize sz = CGSizeMake(imageBefore.size.width*a,
                               imageBefore.size.height*a);
        UIGraphicsBeginImageContext(sz);
        [imageBefore drawInRect:CGRectMake(0, 0, sz.width, sz.height)];
        
        charaImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        imageView.image = charaImage;
        imageView.frame = CGRectMake(((320 - sz.width) / 2), 10, sz.width, sz.height);
        
    }
    else {
        CGFloat a = 100 / h;
        // リサイズ処理
        CGSize sz = CGSizeMake(imageBefore.size.width*a,
                               imageBefore.size.height*a);
        UIGraphicsBeginImageContextWithOptions(sz, NO, 0.0);
        [imageBefore drawInRect:CGRectMake(0, 0, sz.width, sz.height)];
        charaImage = UIGraphicsGetImageFromCurrentImageContext();
        imageView.image = charaImage;
        imageView.frame = CGRectMake(110, 10, 100, 100);
        imageView.frame = CGRectMake(((320 - sz.width) / 2), 10, sz.width, sz.height);
    }


    
}

- (id)initAddView:(NSString *)called {
    
    gameCalled = called;
    
    return self;
    
}

// 追加ボタンが押された時の処理をする
// 具体的な処理
// ゲーム別テーブルにキャラのデータを挿入
// 新しいゲーム名 + キャラ ID のテーブルを作成（そこにコンボは格納していく）
- (void)onAddButton {
    
    
    // テキストフィールドが空白じゃなければ
    if ([charaNameField.text length] != 0) {
        
        
        // 画像を縦 60 にあわせる
        // 選択した image を charaimage に代入する
        UIImage *imageBefore = charaImage;
        CGFloat w = imageBefore.size.width;
        CGFloat h = imageBefore.size.height;
        
        // 大きい方に比率をあわせる
        if (w > h) {
            CGFloat a = 60 / w;
            // リサイズ処理
            CGSize sz = CGSizeMake(imageBefore.size.width*a,
                                   imageBefore.size.height*a);
            
            UIGraphicsBeginImageContext(sz);
            [imageBefore drawInRect:CGRectMake(0, 0, sz.width, sz.height)];
            charaImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            
        }
        else {
            CGFloat a = 60 / h;
            // リサイズ処理
            CGSize sz = CGSizeMake(imageBefore.size.width*a,
                                   imageBefore.size.height*a);
            UIGraphicsBeginImageContextWithOptions(sz, NO, 0.0);
            [imageBefore drawInRect:CGRectMake(0, 0, sz.width, sz.height)];
            charaImage = UIGraphicsGetImageFromCurrentImageContext();

        }
        
        
        NSLog(@"サイズ = %f", charaImage.size.width);
        
        // 画像をバイナリデータ化する
        NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(charaImage, 0.8)];
        NSString *imageDataString = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
        
        //NSLog(@"%@", imageData);
    
    // ゲーム別テーブルにキャラクターの要素を追加する
    // ここから Combo.db のパスの指定
    NSArray  *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir   = [paths objectAtIndex:0];
    NSString *db_path  = [dir stringByAppendingPathComponent:@"ComboData.db"];
    
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
    adddb = [FMDatabase databaseWithPath:db_path];
    
    // キャラ ID 用に乱数を作成する　1 ~ 1000 の間
        
    srand((unsigned int)time(NULL));
    int random = rand() % 1000 + 1;
    NSLog(@"random = %d", random);
    // ここから抽出
    NSString *select = [NSString stringWithFormat:@"INSERT INTO %@ (id, name, image) VALUES (?, ?, ?);", gameCalled];
    NSString *charaName = charaNameField.text;
        // 新規テーブル作成用の命令列
        NSString *newTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@%d (id INTEGER PRIMARY KEY, combo TEXT, damage INTEGER, gage INTEGER, center INTEGER, memo TEXT);", gameCalled, random];
    
    [adddb open];
    [adddb executeUpdate:select, [NSNumber numberWithInt:random], charaName, imageData];
        [adddb executeUpdate:newTable];
    [adddb close];
        
        
        
        // 一つ前の画面のテーブルビューを更新する
        NSArray *allcontrollers = [self.navigationController viewControllers];
        NSInteger target = [allcontrollers count] - 2;
        IndividualGameTableView *parent = [allcontrollers objectAtIndex:target];
        [parent reloadData];

    
    // 最後にキャラ一覧画面に戻る
    [self.navigationController popViewControllerAnimated:YES];
    
    }
        
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // キーボードを隠す
    [charaNameField resignFirstResponder];
    return YES;
}

-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [charaNameField resignFirstResponder];
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.singleTap) {
        
        // キーボード表示中のみ有効
        if (charaNameField.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

@end
