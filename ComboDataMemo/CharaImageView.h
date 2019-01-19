//
//  CharaImageView.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/01.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharaImageView : UIImageView <UIGestureRecognizerDelegate>


// 取得している image を保存する
@property (nonatomic, retain) UIImage *charaImage;

@end
