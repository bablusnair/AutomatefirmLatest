//
//  calenderCollectionShiftCell.m
//  Automate Firm
//
//  Created by leonine on 18/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "calenderCollectionShiftCell.h"
#import "calenderEachCell.h"

@implementation calenderCollectionShiftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.shiftAray=[[NSMutableArray alloc]initWithObjects:@"dayicon_1_blue.png",@"dayicon_1_orange.png",@"dayicon_1_Green.png",@"dayicon_1_blue.png",@"dayicon_1_Green.png",@"dayicon_1_orange.png",@"dayicon_1_blue.png",@"dayicon_1_orange.png",@"dayicon_1_Green.png",@"dayicon_1_blue.png",@"dayicon_1_Green.png",@"dayicon_1_orange.png",@"dayicon_1_blue.png",@"dayicon_1_orange.png",@"dayicon_1_Green.png",@"dayicon_1_blue.png",@"dayicon_1_Green.png",@"dayicon_1_orange.png",@"dayicon_1_blue.png",@"dayicon_1_orange.png",@"dayicon_1_Green.png",@"dayicon_1_blue.png",@"dayicon_1_Green.png",@"dayicon_1_orange.png",@"dayicon_1_blue.png",@"dayicon_1_orange.png",@"dayicon_1_Green.png",@"dayicon_1_blue.png",@"dayicon_1_Green.png",@"dayicon_1_orange.png",@"dayicon_1_blue.png",@"dayicon_1_orange.png",@"dayicon_1_Green.png",@"dayicon_1_blue.png",@"dayicon_1_Green.png",@"dayicon_1_orange.png", nil];
    [self.eachCellCollection registerNib:[UINib nibWithNibName:@"calenderEachCell" bundle:nil]
              forCellWithReuseIdentifier:@"eachCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  self.shiftAray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    calenderEachCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"eachCell" forIndexPath:indexPath];
    cell.eachCellImage.image=[UIImage imageNamed:self.shiftAray[indexPath.row]];
    return cell;
}
@end
