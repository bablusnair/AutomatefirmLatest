//
//  advancedplustableviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 6/25/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface advancedplustableviewclass : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UIImageView *backImage;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UITextField *dateLabel;
@property (strong, nonatomic) IBOutlet UITextField *kwdLabel;
@property(nonatomic,retain)AppDelegate *app;

@end
