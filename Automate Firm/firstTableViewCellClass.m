//
//  firstTableViewCellClass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/6/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "firstTableViewCellClass.h"

@implementation firstTableViewCellClass

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.Description) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=39) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@" 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+|=?/.,<>"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
        {
            return  NO;
        }
        
    }
    else if (textField==self.remarkText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=99) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+=|{}[]:,.<>?/ 0123456789"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
        {
            return  NO;
        }

    }
    else if ((textField==self.limitText)||(textField==self.rqstAmount)||(textField==self.approvedAmount))
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=8) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
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
        return YES;
    }
}
@end
