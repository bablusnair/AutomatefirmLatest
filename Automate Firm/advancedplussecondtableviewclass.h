//
//  advancedplussecondtableviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 6/26/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface advancedplussecondtableviewclass : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UITextField *dateLabel;
@property (strong, nonatomic) IBOutlet UITextField *kwdLabel;
@property(nonatomic,retain)IBOutlet UIButton *editButton1;
@property(nonatomic,retain)IBOutlet UIButton *editButton2;
@property (strong, nonatomic) IBOutlet UIImageView *backImg;
@property (strong, nonatomic) IBOutlet UIImageView *checkBoxImg1;

@end
