//
//  allocationTableCell.m
//  Automate Firm
//
//  Created by leonine on 18/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "allocationTableCell.h"
#import "calenderEachCell.h"

@implementation allocationTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.shiftAray=[[NSMutableArray alloc]initWithObjects:@"dayicon_1_blue.png",@"dayicon_1_orange.png",@"dayicon_1_Green.png",@"dayicon_1_blue.png",@"dayicon_1_Green.png",@"dayicon_1_orange.png",@"dayicon_1_blue.png",@"dayicon_1_orange.png",@"dayicon_1_Green.png",@"dayicon_1_blue.png",@"dayicon_1_Green.png",@"dayicon_1_orange.png",@"dayicon_1_blue.png",@"dayicon_1_orange.png",@"dayicon_1_Green.png",@"dayicon_1_blue.png",@"dayicon_1_Green.png",@"dayicon_1_orange.png",@"dayicon_1_blue.png",@"dayicon_1_orange.png",@"dayicon_1_Green.png",@"dayicon_1_blue.png",@"dayicon_1_Green.png",@"dayicon_1_orange.png",@"dayicon_1_blue.png",@"dayicon_1_orange.png",@"dayicon_1_Green.png",@"dayicon_1_blue.png",@"dayicon_1_Green.png",@"dayicon_1_orange.png",@"dayicon_1_blue.png",@"dayicon_1_orange.png", nil];
    [self.cellCollection registerNib:[UINib nibWithNibName:@"calenderEachCell" bundle:nil]
              forCellWithReuseIdentifier:@"eachCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  self.shiftAray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    calenderEachCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"eachCell" forIndexPath:indexPath];
    cell.eachCellImage.image=[UIImage imageNamed:self.shiftAray[indexPath.row]];
    if (indexPath.row==6) {
        
    }
    return cell;
}
@end
