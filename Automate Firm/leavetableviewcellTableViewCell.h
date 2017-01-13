//
//  leavetableviewcellTableViewCell.h
//  bablusdemokpproject
//
//  Created by leonine on 8/21/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface leavetableviewcellTableViewCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UIButton *checkButton;
@property(nonatomic,retain)IBOutlet UIImageView *backImage;
@property(nonatomic,retain)IBOutlet UILabel *nameLabel;
@property(nonatomic,retain)NSString *cellID;
@end
