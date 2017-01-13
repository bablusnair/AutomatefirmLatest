//
//  employeeSelectionCellCollectionViewCell.h
//  Automate Firm
//
//  Created by leonine on 10/22/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface employeeSelectionCellCollectionViewCell : UICollectionViewCell
@property(nonatomic,retain)IBOutlet UILabel *empNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *empIDLabel;
@property(nonatomic,retain)IBOutlet UIButton *selectionButton;
@property(nonatomic,retain)IBOutlet UIImageView *empIcon;
@property(nonatomic,retain)NSString *cellID;
@end
