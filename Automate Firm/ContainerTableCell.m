//
//  ContainerTableCell.m
//  sometesting
//
//  Created by Emvigo on 21/01/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "ContainerTableCell.h"

@implementation ContainerTableCell
@synthesize collectionView;
- (void)awakeFromNib {
    // Initialization code
   //self.collectionView=[[ContainerCellView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.collectionView = [[NSBundle mainBundle] loadNibNamed:@"myview" owner:self options:nil][0];
  self.collectionView.frame = CGRectMake(5, 15, self.bounds.size.width, self.bounds.size.height);
   // self.collectionView.frame = self.bounds;
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}
- (void)setCollectionData:(NSArray *)collectionData {
    [self.collectionView setCollectionData:collectionData];
}

@end
