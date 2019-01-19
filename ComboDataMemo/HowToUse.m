//
//  HowToUse.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/01.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "HowToUse.h"

@implementation HowToUse

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"アプリの使い方";
    
    // メインとなるビュー
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    backView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:backView];
    
}

@end
