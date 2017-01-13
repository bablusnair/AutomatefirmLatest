//
//  custumclasscell.m
//  bablusdemokpproject
//
//  Created by Emvigo on 28/01/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "custumclasscell.h"

@implementation custumclasscell
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((textField==self.degree)|| (textField==self.institution)) {
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
    
    else
    {
        return  YES;
    }
}
@end
