//
//  SortView.h
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/04.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SortViewDelegate

- (void) relo;

@end

@interface SortView : UITableViewController
{
    
    NSUserDefaults *ud;
    
}

@property (nonatomic, retain) id delegate;

@end
