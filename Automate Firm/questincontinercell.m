//
//  questincontinercell.m
//  bablusdemokpproject
//
//  Created by leonine on 18/03/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "questincontinercell.h"

@implementation questincontinercell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.collectionView = [[NSBundle mainBundle] loadNibNamed:@"myquesioncollionview" owner:self options:nil][0];
        self.collectionView.frame = CGRectMake(5, 15, self.bounds.size.width, self.bounds.size.height);
        // self.collectionView.frame = self.bounds;
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}


@end
