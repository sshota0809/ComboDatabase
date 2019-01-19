//
//  title.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/06.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "title.h"

@implementation title


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    titleBack = [UIImage imageNamed:@"bigtitle3.png"];
    CGSize resizedSize = CGSizeMake(320, 568);
    UIGraphicsBeginImageContextWithOptions(resizedSize, NO, 0.0);
    [titleBack drawInRect:CGRectMake(0, 0, resizedSize.width, resizedSize.height)];
    titleBack = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    titleIconBefore = [UIImage imageNamed:@"titleicon.png"];
    titleIconAfter = [UIImage imageNamed:@"titleicon2.png"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:titleBack];
    
    titleButton = [[UIButton alloc]
                    initWithFrame:CGRectMake(95, 250, 130, 130)];  // ボタンのサイズを指定する
    [titleButton setBackgroundImage:titleIconBefore forState:UIControlStateNormal];  // 画像をセットする
    [titleButton setBackgroundImage:titleIconAfter forState:UIControlStateHighlighted];
    // ボタンが押された時にhogeメソッドを呼び出す
    [titleButton addTarget:self
            action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:titleButton];
    
    
    ////////////////// ここからアニメーション //////////////////////
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.9];
	[UIView setAnimationDelegate:self];
	titleButton.center = CGPointMake(160, 440);
	[UIView commitAnimations];

    ////////////////// ここまでアニメーション //////////////////////
    
}

- (void)go
{

    mainTableView *indiView = [[mainTableView alloc] init];
    if (indiView) {
        [self.navigationController pushViewController:indiView animated:YES];
    }
    
}


@end
