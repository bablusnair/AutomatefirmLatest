//
//  taxfirstcellclass.h
//  aftaxtesting
//
//  Created by leonine on 24/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface taxfirstcellclass : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *numberlabel;
@property(nonatomic,retain)IBOutlet UILabel *zerolabel;
@property(nonatomic,retain)IBOutlet UITextField *amounttext;
@property(nonatomic,retain)IBOutlet UITextField *taxtextfield;
@property(nonatomic,retain)IBOutlet UIView *taxview;
@property(nonatomic,retain)IBOutlet UILabel *mandatorystar;

@property(nonatomic,retain)IBOutlet UIView *amountbgView;
@end
