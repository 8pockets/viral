//
//  NecoTableViewCell.m
//  viralmedia
//
//  Created by 8pockets on 2014/08/22.
//  Copyright (c) 2014年 YamauchiShingo. All rights reserved.
//

#import "NecoTableViewCell.h"

@implementation NecoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
