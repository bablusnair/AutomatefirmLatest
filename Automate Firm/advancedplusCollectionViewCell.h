//
//  advancedplusCollectionViewCell.h
//  bablusdemokpproject
//
//  Created by leonine on 6/25/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface advancedplusCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *signature;
@property (strong, nonatomic) IBOutlet UILabel *designation;
@property (strong, nonatomic) IBOutlet UIImageView *signImg;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *empName;
@property (strong, nonatomic) IBOutlet UILabel *stageLabel;
@property (strong, nonatomic) IBOutlet UIButton *stampicon;
@property (strong, nonatomic) IBOutlet UIButton *stampicon1;
@end
