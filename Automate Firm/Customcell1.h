//
//  Customcell1.h
//  bablusdemokpproject
//
//  Created by leonine on 8/19/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Customcell1 : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UILabel *ratinglabel;
@property (strong, nonatomic) IBOutlet UITextField *descriptiontext;
@property (strong, nonatomic) IBOutlet UITextField *experiencetext;

@end
