//
//  coinsCollectionViewCell.m
//  Automate Firm
//
//  Created by leonine on 1/15/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "coinsCollectionViewCell.h"

@implementation coinsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.coinsText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=7) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
            unichar u = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:u])
            {
                return YES;
            }
            else{
                return NO;
            }
            return YES;
        }
        
    }
    else
    {
        return YES;
    }
    return false;
}
@end
