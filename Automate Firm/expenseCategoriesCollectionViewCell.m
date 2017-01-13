//
//  expenseCategoriesCollectionViewCell.m
//  Automate Firm
//
//  Created by leonine on 11/24/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "expenseCategoriesCollectionViewCell.h"
#import "expenseReimbursementSettingsViewClass.h"
#import "settingsViewController.h"

@implementation expenseCategoriesCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if (textField==self.expenseText) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length < 13) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
            return YES;
        }
        return  NO;
    }
    else
    {
        return YES;
    }
    return false;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    expenseReimbursementSettingsViewClass *myview=(expenseReimbursementSettingsViewClass *)[self.superview.superview superview ];
    if ((myview.expenseNameText.text.length > 0) && (myview.abbrvText.text.length > 0)) {
        return  YES;
    }
    else
    {
        [myview showalerviewcontroller:@"Must Enter Expense Name and Abbreviation to Continue"];
        return  NO;
    }
    
}

@end
