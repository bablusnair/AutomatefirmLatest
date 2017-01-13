//
//  teamAllocationScreenClass.m
//  Automate Firm
//
//  Created by leonine on 18/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "teamAllocationScreenClass.h"
#import "calenderCollectionShiftCell.h"

@implementation teamAllocationScreenClass

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [self.calenderCollection registerNib:[UINib nibWithNibName:@"calenderCollectionShiftCell" bundle:nil]
          forCellWithReuseIdentifier:@"calenderCell"];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    calenderCollectionShiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"calenderCell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.daysLabel.text=@"Days(1-6)";
            break;
        case 1:
            cell.daysLabel.text=@"Days(7-13)";
            break;
        case 2:
            cell.daysLabel.text=@"Days(14-20)";
            break;
        case 3:
            cell.daysLabel.text=@"Days(21-27)";
            break;
        default:
            break;
    }
    return cell;
}
@end
