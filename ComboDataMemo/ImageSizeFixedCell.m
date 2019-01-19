//
//  ImageSizeFixedCell.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/04.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "ImageSizeFixedCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ImageSizeFixedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGRect frame = CGRectMake(90, 0, 200, size.height);
    self.textLabel.frame =  frame;
    self.textLabel.contentMode = UIViewContentModeScaleAspectFit;
}

@end
