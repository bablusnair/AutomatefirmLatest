//
//  calenderCollectionShiftCell.h
//  Automate Firm
//
//  Created by leonine on 18/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calenderCollectionShiftCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *eachCellCollection;
@property(nonatomic,retain)NSMutableArray *shiftAray;
@end
