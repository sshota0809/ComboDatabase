//
//  ThemeColorConfig.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/04.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infoTextView.h"

@interface ThemeColorConfig : UITableViewController
{
    
    // カラーを保管している配列を呼び出す
    NSUserDefaults *ud;
    
    // 現在のカラーを呼び出すためのキー
    NSString *colorKey;
    
    // RGB 用のスライダー
    UISlider *r;
    UISlider *g;
    UISlider *b;
    
    // 色を保存する変数
    double rc;
    double gc;
    double bc;
}

- (id)initWithColor:(NSString *)key title:(NSString *)titleName;

@end
