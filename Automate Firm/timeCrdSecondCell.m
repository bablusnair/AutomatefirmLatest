//
//  timeCrdSecondCell.m
//  Automate Firm
//
//  Created by leonine on 08/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "timeCrdSecondCell.h"

@implementation timeCrdSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.timecardCollection2 registerNib:[UINib nibWithNibName:@"secondRowCollectionViewCell" bundle:nil]
               forCellWithReuseIdentifier:@"timecardSecCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
