//
//  CharaImageView.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/01.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "CharaImageView.h"

@implementation CharaImageView

@synthesize charaImage;

- (id) init {
    
    // 初期設定
    self.userInteractionEnabled = YES;
    
    // ここでジェスチャーを呼び出す
    // タップされたら UIImagePicker を呼び出してその画像に差し替える処理を行う
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
    [self addGestureRecognizer:tap];

    
    // ここから UIImage を設定する
    // 初期設定：デフォルト画像を使用
    UIImage *charaImageBefore = [UIImage imageNamed:@"2749.png"];
    // リサイズ処理
    
    CGFloat width = 150;
    CGFloat height = 150;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [charaImageBefore drawInRect:CGRectMake(0, 0, width, height)];
    charaImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 最後に UIImageView に画像を貼付ける
    self.image = charaImage;
    
    return self;
    
}

@end
