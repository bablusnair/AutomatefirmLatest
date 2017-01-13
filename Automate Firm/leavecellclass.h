//
//  leavecellclass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/10/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface leavecellclass : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *leaveLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *startLabel;
@property (strong, nonatomic) IBOutlet UILabel *endLabel;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *rejoiningLabel;
@property (strong, nonatomic) IBOutlet UILabel *reasonLabel;
@property (strong, nonatomic) IBOutlet UIImageView *backImg;
@property(nonatomic,retain)IBOutlet UIButton *uploadBtn;
@end
