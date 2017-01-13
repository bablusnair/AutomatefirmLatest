//
//  createnewbankviewclass.m
//  Automate Firm
//
//  Created by leonine on 20/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "createnewbankviewclass.h"
#import "settingsViewController.h"
#import "AppDelegate.h"
#import "generalsettingsmainclass.h"
@implementation createnewbankviewclass

-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"bankAction"] isEqualToString:@"update"]) {
        [self.myconnection individualBankView:[[NSUserDefaults standardUserDefaults]objectForKey:@"bankID"]];
        [self.app hudStart:self];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    

}
-(IBAction)cancel:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)doneButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    
    
    //To resign All textField's keyboard
    [self.bankNameText resignFirstResponder];
    [self.AbbrvText resignFirstResponder];
    [self.branchText resignFirstResponder];
    [self.descriptionText resignFirstResponder];
    [self.holderNameText resignFirstResponder];
    [self.accountNumberText resignFirstResponder];
    [self.bicText resignFirstResponder];
    [self.ibanText resignFirstResponder];
    [self.addressText resignFirstResponder];
    
    
    //Removing all spaces from beginning
    self.bankNameText.text=[self.bankNameText.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    self.AbbrvText.text=[self.AbbrvText.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
    self.branchText.text=[self.branchText.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    self.holderNameText.text=[self.holderNameText.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    self.accountNumberText.text=[self.accountNumberText.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    //Checking mandatory fields
    if ((self.bankNameText.text.length >0) && (self.AbbrvText.text.length >0) && (self.branchText.text.length >0) &&(self.holderNameText.text.length > 0) && (self.ibanText.text.length > 0)) {
        
        NSDate *myDate=[NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy hh:mm:ss"];
        NSString *prettyVersion = [dateFormat stringFromDate:myDate];
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"bankAction"] isEqualToString:@"update"]) {
            
            [self.myconnection updateBank:[[NSUserDefaults standardUserDefaults]objectForKey:@"bankID"]: self.bankNameText.text :self.AbbrvText.text :self.branchText.text :self.descriptionText.text :self.holderNameText.text :self.accountNumberText.text :self.ibanText.text :self.bicText.text :self.addressText.text :self.createdDate :prettyVersion :@"C"];
        }
        else
        {
            [self.myconnection createNewBank:self.bankNameText.text :self.AbbrvText.text :self.branchText.text :self.descriptionText.text :self.holderNameText.text :self.accountNumberText.text :self.ibanText.text :self.bicText.text :self.addressText.text :prettyVersion :prettyVersion :@"C"];
        }
        
        [self.app hudStart:self];
    }
    else
    {
        [self showalerviewcontroller:@"Warning" :@"Mandatory Fields are Required"];

    }
}

//Got Response when creating a new bank
-(void)allBankViewResponse:(NSMutableArray *)bankList
{
    if ([bankList count]>0) {
        
        generalsettingsmainclass *ob = (generalsettingsmainclass *)self.superview.superview;
        [ob allBankViewResponse:bankList];
        [self removeFromSuperview];
    }
    else
    {
        [self.app hudStop];
        [self showalerviewcontroller:@"Error" :@"Server Timed Out"];
    }
}

//Got Response when individual bank is selected
-(void)updateruleviewresponse:(NSMutableDictionary *)updateruleDict
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.bankNameText.text=[updateruleDict objectForKey:@"bank_name"];
        self.AbbrvText.text=[updateruleDict objectForKey:@"bank_abbrv"];
        self.branchText.text=[updateruleDict objectForKey:@"bank_branch"];
        self.descriptionText.text=[updateruleDict objectForKey:@"bank_description"];
        self.holderNameText.text=[updateruleDict objectForKey:@"bank_holder_name"];
        self.accountNumberText.text=[updateruleDict objectForKey:@"bank_account_number"];
        self.ibanText.text=[updateruleDict objectForKey:@"bank_iban"];
        self.bicText.text=[updateruleDict objectForKey:@"bank_bic"];
        self.addressText.text=[updateruleDict objectForKey:@"bank_address"];
        self.createdDate=[updateruleDict objectForKey:@"bank_created_date"];
        
        [self.app hudStop];
    });
}

//Common function to show the alert message
-(void)showalerviewcontroller:(NSString *)alertType : (NSString *)alertMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:[NSString stringWithFormat:@"%@",alertType]
                               message:[NSString stringWithFormat:@"%@",alertMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
    
}
//Got reponse when trying to create a bank details with same account number
-(void)showalerviewcontroller:(NSString *)errorMessage
{
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [app hudStop];
    [self showalerviewcontroller:@"Warning" :errorMessage];
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.AbbrvText) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
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
    else if (textField==self.bankNameText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=39) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz 0123456789!@#$%^&*()-_=+,.<>/?';:"];
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
    else if (textField==self.branchText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=24) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
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
    else if ((textField==self.descriptionText) || (textField==self.addressText))
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=89) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.-!@#$%^&*()-_=+.,<> "];
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
    else if (textField==self.holderNameText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=39) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz. "];
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
    else if(textField==self.accountNumberText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=24) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
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
        else if ((textField==self.ibanText) || (textField=self.bicText))
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=24) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
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

- (void) keyboardDidShow:(NSNotification *)notification
{
    
    
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.frame;
    aRect.size.height -= kbRect.size.height;
    
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
        
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
        
    }
    
}



- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
