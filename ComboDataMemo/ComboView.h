//
//  ComboView.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/31.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "IndividualCharacterTableView.h"
#import "modalTableView.h"
#import "ShareKit.h"
#import "SHKTwitter.h"

@interface ComboView : UIViewController <UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    
    // ScrollView にのせるView
    UIScrollView *scrView;
    UIView *comView;
    
    // FMDatabase 用変数
    FMDatabase *combodb;
    
    // コンボ、ダメージ、ゲージ回収、中央か端かを格納する変数
    NSString *comboId;
    NSString *called;
    NSString *combo;
    NSString *damage;
    NSString *gage;
    NSInteger *center;
    NSString *buttonTitle;
    NSString *insCenter;
    NSString *memo;
    
    // それぞれの機能を説明する文字列
    UILabel *comboTextLabel;
    UILabel *boolPickerLabel;
    UILabel *damageLabel;
    UILabel *gageLabel;
    UILabel *centerLabel;
    UILabel *memoLabel;
    
    // コンボを表示するテキスト、ダメージを表示するテキスト、ゲージ回収を表示するテキスト、中央か端かを格納するラジオボックス
    UITextView *comboTextField;
    UITextField *comboDamageField;
    UITextField *comboGageField;
    UITextView *memoField;
    UISwitch *centerSwitch;
    
    // picker で入力するか否かを設定するボタン
    UISwitch *usePicker;
    BOOL usePick;
    
    // 簡易コマンド入力をするためのpicker
    UIPickerView *commandPicker;
    // picker の上に表示するview とボタン
    UIView *pickerMenuview;
    UIButton *addCommandButton;
    
    // 編集を終了にするボタン
    UIButton *finButton;
    
    // 一つ前に戻るボタン
    UIButton *undoButton;
    
    // 一つ前の ComboTextField の文字列を保存する変数
    NSString *undoText;
    
    // 楽々入力用に使用する NSUserDefaults
    NSUserDefaults *ud;
    
    // 楽々入力制御用変数
    int pickerCount;
}

@property(nonatomic, strong) UITapGestureRecognizer *singleTap;

- (id)initWithScrollView:(NSString *)aCombo comboId:(NSString *)aId comboDamage:(NSString *)aDamage comboGage:(NSString *)aGage comboCenter:(NSString *)aCenter comboMemo:(NSString *)aMemo buttonTitle:(NSString *)aTitle called:(NSString *)aCalled;

@end
