//
//  leavetableviewcellTableViewCell.m
//  bablusdemokpproject
//
//  Created by leonine on 8/21/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "leavetableviewcellTableViewCell.h"

@implementation leavetableviewcellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
       // self.backView.backgroundColor=[UIColor lightGrayColor];
    }
    else
    {
       // self.backView.backgroundColor=[UIColor colorWithRed:34.0/255.0 green:55.0/255.0 blue:73.0/255.0 alpha:1.0];
    }
    // Configure the view for the selected state
}

@end
