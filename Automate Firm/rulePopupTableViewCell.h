//
//  rulePopupTableViewCell.h
//  Automate Firm
//
//  Created by leonine on 7/18/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rulePopupTableViewCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UIImageView *backImage;
@property(nonatomic,retain)IBOutlet UILabel *abbrvLabel;
@property(nonatomic,retain)IBOutlet UILabel *shiftTypeLabel;
@property(nonatomic,retain)IBOutlet UILabel *descriptionLabel;

@property(nonatomic,retain)IBOutlet UIButton *radioButton;

@property(nonatomic,retain)NSString *cellID;
@end
