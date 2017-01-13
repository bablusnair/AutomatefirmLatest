//
//  idcardtablecellclass.m
//  bablusdemokpproject
//
//  Created by leonine on 24/06/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "idcardtablecellclass.h"

@implementation idcardtablecellclass

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
        self.collectionView = [[NSBundle mainBundle] loadNibNamed:@"insideviewidcards" owner:self options:nil][0];
        self.collectionView.frame = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height);
        // self.collectionView.frame = self.bounds;
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (void)setCollectionData:(NSArray *)collectionData {
    
    [self.collectionView setCollectionData:collectionData];
}


@end
