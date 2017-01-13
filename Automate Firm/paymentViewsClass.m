//
//  paymentViewClass.m
//  bablusdemokpproject
//
//  Created by leonine on 9/12/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "paymentViewsClass.h"

@implementation paymentViewsClass

-(void)awakeFromNib
{
    NSString *myString=[[NSUserDefaults standardUserDefaults]objectForKey:@"paymentValue"];
    NSArray *paymentArray=[myString componentsSeparatedByString:@"###"];
    if (!([[paymentArray objectAtIndex:0]isEqualToString:@""])) {
        
        NSArray *splitArray1=[[paymentArray objectAtIndex:0]componentsSeparatedByString:@" "];
        self.paymentText3.text=[splitArray1 objectAtIndex:0];
    }
    if (!([[paymentArray objectAtIndex:1]isEqualToString:@""])) {
        NSArray *splitArray2=[[paymentArray objectAtIndex:1]componentsSeparatedByString:@" "];
        self.paymentText5.text=[splitArray2 objectAtIndex:0];
    }
    
    if (!([[paymentArray objectAtIndex:2]isEqualToString:@""])) {
        NSArray *splitArray3=[[paymentArray objectAtIndex:2]componentsSeparatedByString:@" "];
        self.paymentText7.text=[splitArray3 objectAtIndex:0];
    }
    
    NSArray *paymentArray2=[[[NSUserDefaults standardUserDefaults]objectForKey:@"paymentAdvanced"] componentsSeparatedByString:@"###"];
    
    if (!(([[paymentArray2 objectAtIndex:0]isEqualToString:@""]) || ([[paymentArray2 objectAtIndex:0]isEqualToString:@"<null>"]))) {
        self.paymentText2.text=[paymentArray2 objectAtIndex:0];
        self.paymentText2.backgroundColor=[UIColor clearColor];
        self.paymentText2.userInteractionEnabled=YES;
    }
    if (!(([[paymentArray2 objectAtIndex:1]isEqualToString:@""]) || ([[paymentArray2 objectAtIndex:1]isEqualToString:@"<null>"]))) {
        self.paymentText4.text=[paymentArray2 objectAtIndex:1];
        self.paymentText4.backgroundColor=[UIColor clearColor];
        self.paymentText4.userInteractionEnabled=YES;
    }
    if (!(([[paymentArray2 objectAtIndex:2]isEqualToString:@""]) || ([[paymentArray2 objectAtIndex:2]isEqualToString:@"<null>"]))) {
        self.paymentText6.text=[paymentArray2 objectAtIndex:2];
        self.paymentText6.backgroundColor=[UIColor clearColor];
        self.paymentText6.userInteractionEnabled=YES;
    }
    if (!(([[paymentArray2 objectAtIndex:3]isEqualToString:@""]) || ([[paymentArray2 objectAtIndex:3]isEqualToString:@"<null>"]))) {
        self.paymentText1.text=[paymentArray2 objectAtIndex:3];
    }
    
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ((textField==self.paymentText3) || (textField==self.paymentText5) || (textField==self.paymentText7)) {
        return  NO;
    }
    else
    {
        return  YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string

{
    if ((textField==self.paymentText2)||(textField==self.paymentText3)) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=2) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
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
        
    }
    else if ((textField==self.paymentText4)||(textField==self.paymentText5)) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=2) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
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
    }
    else if (textField==self.paymentText1)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=1) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
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
        
    }
    
    else
    {
        return YES;
    }
    return false;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.paymentText1) {
        [[NSUserDefaults standardUserDefaults]setObject:self.paymentText1.text forKey:@"expYear"];
        self.paymentText2.backgroundColor=[UIColor clearColor];
        self.paymentText2.userInteractionEnabled=YES;
    }
    
    else if (textField==self.paymentText2) {
        [[NSUserDefaults standardUserDefaults]setObject:self.paymentText2.text forKey:@"fullyPaidleaves"];
        self.paymentText4.backgroundColor=[UIColor clearColor];
        self.paymentText4.userInteractionEnabled=YES;
    }
    else if (textField==self.paymentText4) {
        [[NSUserDefaults standardUserDefaults]setObject:self.paymentText4.text forKey:@"halfPaidleaves"];
        self.paymentText6.backgroundColor=[UIColor clearColor];
        self.paymentText6.userInteractionEnabled=YES;
    }
    else if (textField==self.paymentText6) {
        int value=[self.paymentText2.text intValue] + [self.paymentText4.text intValue];
        if ([self.paymentText6.text intValue]>= value) {
            self.paymentText6.textColor=[UIColor blackColor];
        }
        else
        {
            self.paymentText6.textColor=[UIColor redColor];
        }
        [[NSUserDefaults standardUserDefaults]setObject:self.paymentText6.text forKey:@"totalLeaves"];

    }
    else if(textField==self.paymentText7)
    {
        int value=[self.paymentText3.text intValue] + [self.paymentText5.text intValue];
        if ([self.paymentText7.text intValue]>= value) {
            self.paymentText7.textColor=[UIColor blackColor];
        }
        else
        {
            self.paymentText7.textColor=[UIColor redColor];
        }

    }
    return  YES;
}

@end
