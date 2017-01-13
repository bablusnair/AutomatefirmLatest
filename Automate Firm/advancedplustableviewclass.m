//
//  advancedplustableviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 6/25/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "advancedplustableviewclass.h"

@implementation advancedplustableviewclass

- (void)awakeFromNib {
    // Initialization code
    self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
