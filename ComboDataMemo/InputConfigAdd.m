//
//  InputConfigAdd.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/04.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "InputConfigAdd.h"

@implementation InputConfigAdd

@synthesize delegate;
@synthesize singleTap;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
    
    
    // 画面のタイトルの設定
    self.title = @"コマンド追加";
    
    
    // テキストフィールド以外の部分をタップしたらキーボードが閉じるようにアクションを設定する
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    
    // 背景設定
    //背景を設定する
    UIImage *backgroundImage = [UIImage imageNamed:@"back.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    // コマンドを入力するテキストフィールド
    commandTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 60)];
    commandTextField.placeholder = @"コマンドを入力してください";
    commandTextField.font = [UIFont systemFontOfSize:21];
    commandTextField.layer.borderColor = [UIColor grayColor].CGColor;
    commandTextField.layer.borderWidth = 1.0f;
    commandTextField.layer.cornerRadius = 7.5f;
    
    [self.view addSubview:commandTextField];
    
    // 追加ボタン
    addButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 270, 300, 50)];
    addButton.layer.borderColor = [UIColor blackColor].CGColor;
    [addButton setTitle:@"コマンド追加" forState:UIControlStateNormal];
    addButton.layer.borderWidth = 1.0f;
    addButton.layer.cornerRadius = 1.0f;
    [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    // キーボードの改行ボタンをキーボードをしまうボタンに設定する
    // [デリゲートの設定]
    commandTextField.delegate = self;
    // [「改行（Return）」キーの設定]
    commandTextField.returnKeyType = UIReturnKeyDone;
    // ボタンが押された時の処理を決定する
    [addButton addTarget:self action:@selector(onAddButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    // キャンセルボタン
	if (!self.navigationItem.leftBarButtonItem) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"キャンセル" style:UIBarButtonItemStyleBordered target:self action:@selector(close)];
        [self.navigationItem setLeftBarButtonItem:doneButton animated:YES];
    }


    
    
}


// modal を閉じるボタン
- (void) close
{
    
    // modal を閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)onAddButton {
    
    
    // テキストフィールドが空白じゃなければ
    if ([commandTextField.text length] != 0) {
        
        NSLog(@"aaaaaa");
        NSString *text = commandTextField.text;
        
        // delegate によって前のメソッドを呼ぶ
        if ([delegate respondsToSelector:@selector(addInput:)]) {
                    NSLog(@"aaaaaa");
            [delegate addInput:text];
        }
        
        
        // 最後にキャラ一覧画面に戻る
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // キーボードを隠す
    [commandTextField resignFirstResponder];
    return YES;
}

-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [commandTextField resignFirstResponder];
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.singleTap) {
        
        // キーボード表示中のみ有効
        if (commandTextField.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}


@end
