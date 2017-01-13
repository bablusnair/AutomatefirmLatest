//
//  cellForShifttableView.m
//  Automate Firm
//
//  Created by leonine on 04/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "cellForShifttableView.h"
#import "CellForShiftScrollingCell.h"

@implementation cellForShifttableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.scrollCollection registerNib:[UINib nibWithNibName:@"CellForShiftScrollingCell" bundle:nil]
               forCellWithReuseIdentifier:@"scrollCell"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    
//    return 31;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    CellForShiftScrollingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"scrollCell" forIndexPath:indexPath];
////    if (indexPath.row%2==0) {
////        cell.shiftImage.image=[UIImage imageNamed:@"strip_greenbar.png"];
////    }
////    else{
////        cell.shiftImage.image=[UIImage imageNamed:@"strip_redbar.png"];
////        
////    }
////    cell.cellTableview.dataSource=self;
////    cell.cellTableview.delegate=self;
//    return cell;
//}

@end
