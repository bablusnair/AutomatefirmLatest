//
//  otherSurchargesTableViewCell.h
//  Automate Firm
//
//  Created by leonine on 12/4/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface otherSurchargesTableViewCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UITextField *nameText;
@property(nonatomic,retain)IBOutlet UITextField *taxText;
@property(nonatomic,retain)IBOutlet UITextField *amountText;

@property(nonatomic,retain)IBOutlet UIView *taxbgview;
@property(nonatomic,retain)IBOutlet UIView *amountbgview;

@property(nonatomic,retain)IBOutlet UILabel *mandatorystar1;
@property(nonatomic,retain)IBOutlet UILabel *mandatorystar2;

@property(nonatomic,retain)IBOutlet UIView *namefieldbgView;
@end
