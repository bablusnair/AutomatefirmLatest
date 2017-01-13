//
//  holidayTableViewCell.h
//  Automate Firm
//
//  Created by leonine on 2/4/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface holidayTableViewCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UILabel *fromDateLabel;
@property(nonatomic,retain)IBOutlet UILabel *toDateLabel;
@property(nonatomic,retain)IBOutlet UILabel *durationLabel;
@property(nonatomic,retain)IBOutlet UILabel *paymentLabel;
@property(nonatomic,retain)IBOutlet UILabel *officeLabel;
@property(nonatomic,retain)IBOutlet UILabel *departmentLabel;
@property(nonatomic,retain)IBOutlet UIButton *deptButton;
@property(nonatomic,retain)IBOutlet UILabel *categoryLabel;
@property(nonatomic,retain)IBOutlet UIButton *catButton;


@end
