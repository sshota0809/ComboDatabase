//
//  ComboPartPicker.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/08/31.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "ComboPartPicker.h"

@implementation ComboPartPicker

/**
 * ピッカーに表示する列数を返す
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// 列(component)に対する、行(row)の数を返す
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0: // dl, jc, hjc
            return 3;
        case 1: // 2,3,4,5,6,8
            return 6;
        case 2: // A, B, C, D
            return 4;
    }
    return 0;
}

/**
 * 行のサイズを変更
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0: // 1列目
            return 50.0;
            break;
            
        case 1: // 2列目
            return 150.0;
            break;
            
        case 2: // 3列目
            return 50.0;
            break;
            
        default:
            return 0;
            break;
    }
}

/**
 * ピッカーに表示する値を返す
 */
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSString *option[] = {@"dl", @"jc", @"hjc"};
    NSString *rever[] = {@"2", @"3", @"4", @"5", @"6", @"8"};
    NSString *button[] = {@"A", @"B", @"C", @"D"};
    switch (component) {
        case 0: // 1列目

            return option[row];
            break;
            
        case 1: // 2列目
            return rever[row];
            break;
            
        case 2: // 3列目
            return button[row];
            break;
            
        default:
            return 0;
            break;
    }
}


@end
