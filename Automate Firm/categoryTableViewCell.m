//
//  categoryTableViewCell.m
//  Automate Firm
//
//  Created by leonine on 1/14/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "categoryTableViewCell.h"

@implementation categoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.categoryText) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=27) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        //        return NO;
    }
    return NO;
}



@end
