//
//  SerachListingEmployeeView.m
//  Automate Firm
//
//  Created by leonine on 11/18/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "SerachListingEmployeeView.h"

@implementation SerachListingEmployeeView

- (void)awakeFromNib {
    self.imageView.layer.cornerRadius = 25;
    self.imageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
