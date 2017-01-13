//
//  officesetupcustomcell.m
//  Automate Firm
//
//  Created by leonine on 05/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "officesetupcustomcell.h"

@implementation officesetupcustomcell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected==true) {
        self.backgroundColor=[UIColor lightTextColor];
    }
}

@end
