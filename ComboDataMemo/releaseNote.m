//
//  releaseNote.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/10.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "releaseNote.h"

@implementation releaseNote

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"リリースノート";
    
    scr = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scr.bounces = NO;
    // スクロールビューにのせるビュー
    // このビューにパーツをのせて最後にスクロールビューに追加する
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    textView = [[infoTextView alloc] initWithFrame:rect];
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:12];
    textView.text = @"version 1.0.0\n\nコンボデータベースリリース！\n・本アプリはiPhone5・iOS7以降の機種を対象として作成しています。";
    
    
    [scr addSubview:textView];
    [self.view addSubview:scr];

    
}

@end
