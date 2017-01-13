//
//  ConditionTableViewCell.h
//  Automate Firm
//
//  Created by leonine on 7/22/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionTableViewCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *abbrvLabel;
@property(nonatomic,retain)IBOutlet UIButton *radioButton;
@property(nonatomic,retain)NSString *cellID;
@property(nonatomic,retain)IBOutlet UIImageView *backImage;
@end
