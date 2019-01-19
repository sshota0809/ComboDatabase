//
//  InputConfigAdd.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/04.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputConfigAddDelegate

- (void) addInput:(NSString *)addCommand;

@end

@interface InputConfigAdd : UIViewController <UIGestureRecognizerDelegate, UITextFieldDelegate>
{

    // コマンド入力用
    UITextField *commandTextField;
    // 追加するボタン
    UIButton *addButton;
    
    NSUserDefaults *ud;

    
}

@property(nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, retain) id delegate;

@end
