//
//  documentationFrontCellClass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/20/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface documentationFrontCellClass : UITableViewCell
@property(nonatomic,retain)IBOutlet UIImageView *myImag;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIImageView *statusImage;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UIButton *priorityButton;
@end
