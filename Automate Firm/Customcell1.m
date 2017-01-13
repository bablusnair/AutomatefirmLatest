//
//  Customcell1.m
//  bablusdemokpproject
//
//  Created by leonine on 8/19/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "Customcell1.h"

@implementation Customcell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.descriptiontext) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=14) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz"];
            unichar u = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:u])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            return  NO;
        }
    }
    else if(textField==self.experiencetext)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=1) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            unichar u = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:u])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            return  NO;
        }

    }
    else
    {
        return  YES;
    }
}
@end
