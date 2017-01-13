//
//  holidayTableViewCell.m
//  Automate Firm
//
//  Created by leonine on 2/4/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "holidayTableViewCell.h"

@implementation holidayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.deptButton.backgroundColor=[UIColor lightGrayColor];
        self.catButton.backgroundColor=[UIColor lightGrayColor];
    }
    // Configure the view for the selected state
}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    return  NO;
//}
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//}
@end
