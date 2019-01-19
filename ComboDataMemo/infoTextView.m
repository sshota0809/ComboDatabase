//
//  infoTextView.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/04.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "infoTextView.h"

@implementation infoTextView

- (BOOL)canBecomeFirstResponder {
    
    // 編集・コピー等の動作を不可とする
    return NO;
}

@end
