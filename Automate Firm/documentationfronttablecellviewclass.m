//
//  documentationfronttablecellviewclass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 17/08/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "documentationfronttablecellviewclass.h"

@implementation documentationfronttablecellviewclass

- (void)awakeFromNib {
    [super awakeFromNib];
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
       self.collectionView = [[NSBundle mainBundle] loadNibNamed:@"docuview" owner:self options:nil][0];
        self.collectionView.frame = CGRectMake(0, 0, 820,149);
        // self.collectionView.frame = self.bounds;
        
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (void)setCollectionData:(NSArray *)collectionData {
    
    [self.collectionView setCollectionData:collectionData];
    
}



@end
