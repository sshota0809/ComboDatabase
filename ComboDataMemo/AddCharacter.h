//
//  AddCharacter.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/30.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "IndividualGameTableView.h"
#import "CharaImageView.h"
#import "modalTableView.h"

@interface AddCharacter : UIViewController <UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    // どのようなキャラ名に設定するかを設定
    UITextField *charaNameField;
    // キャラ画像を表示するようの UIImageView
    UIImageView *imageView;
    // 追加するボタン
    UIButton *addButton;
    // 画像変更用ボタン
    UIButton *charaButton;
    // called を格納する変数
    NSString *gameCalled;
    // DB格納用
    FMDatabase *adddb;
    
    // キャラ画像選択用の imagePicker
    UIImagePickerController *charaPicker;
    
    
}

@property(nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, retain) UIImage *charaImage;

- (id)initAddView:(NSString *)called;

@end
