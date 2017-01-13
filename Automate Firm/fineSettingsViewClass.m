
//
//  fineSettingsViewClass.m
//  Automate Firm
//
//  Created by leonine on 1/19/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "fineSettingsViewClass.h"
#import "borrowingSettingsViewClass.h"
#import "settingsViewController.h"
@implementation fineSettingsViewClass

-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    self.maximumwarningArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"FineSettingAction"]isEqualToString:@"update"])
    {
        
      
        [self.myconnection individualFineruleDisplay:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] ruled:[[NSUserDefaults standardUserDefaults]objectForKey:@"fine_Id"]];
        
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

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.fineAmountText) {
        float amount=[self.fineAmountText.text floatValue];
        if (!(amount == 0)) {
            NSString *value=[NSString stringWithFormat:@"%.1f",amount];
            self.fineAmountText.text=value;
        }
        return  YES;
    }
    else
    {
        return  YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.fineNameTest)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=44) {
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
    else if (textField==self.fineAmountText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
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
    else if(textField==self.maxInstallmentText)
    {
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
        return  NO;
    }
    else if (textField==self.descriptiontext)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=89) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz 0123456789"];
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
-(IBAction)cancelAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)doneAction:(id)sender
{
  
    if ((self.fineNameTest.text.length&&self.fineNameTest.text.length&&self.maxInstallmentText.text.length&&self.maxInstallmentText.text.length)>0) {
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"FineSettingAction"]isEqualToString:@"update"])
        {
            [self.myconnection updateFineSettings:self.fineNameTest.text fineAmount:self.fineAmountText.text maxWarning:self.maxWarningText.text maxInstalment:self.maxInstallmentText.text description:self.descriptiontext.text officeid:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] ruleId:[[NSUserDefaults standardUserDefaults]objectForKey:@"fine_Id"]];
            
        }
        else{
            [self.myconnection CreaateNewFineSettings:self.fineNameTest.text fineAmount:self.fineAmountText.text maxWarning:self.maxWarningText.text maxInstalment:self.maxInstallmentText.text description:self.descriptiontext.text officeid:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        }

    }
    else{
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@" Warning..."
                                   message:[NSString stringWithFormat:@"Mandatory fields Required"]
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
   // [self removeFromSuperview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.maximumwarningArray .count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[[UITableViewCell alloc] init];
    cell.textLabel.font=[UIFont systemFontOfSize:12.0];
    cell.textLabel.text=[self.maximumwarningArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.maxwarningTableView) {
        self.maxWarningText.text=[self.maximumwarningArray objectAtIndex:indexPath.row];
        self.maxwarningTableView.hidden=TRUE;
    }
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    if (textField==self.maxWarningText) {
        self.maxwarningTableView.hidden=FALSE;
        return  NO;
        
    }
    self.maxwarningTableView.hidden=TRUE;
    return  YES;
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
-(void)viewAllFineResponse:(id)responseList
{
    if ([responseList count]>0) {
        
        
        borrowingSettingsViewClass *ob1 = (borrowingSettingsViewClass *)self.superview.superview;
        
        [ob1 viewAllFineResponse:responseList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
            
        });
        
        
    }
    else
    {
        
        [self showalerviewcontroller:@"Connection Failed"];
    }
    
    
}
-(void)individualDisplayResponse:(id)responseData
{ dispatch_async(dispatch_get_main_queue(), ^{


     self.fineNameTest.text=[[responseData objectAtIndex:0]objectForKey:@"violation_name"];
     self.fineAmountText.text=[[responseData objectAtIndex:0]objectForKey:@"fine_amount"];
     self.maxWarningText.text=[[responseData objectAtIndex:0]objectForKey:@"max_warnings"];
     self.maxInstallmentText.text=[[responseData objectAtIndex:0]objectForKey:@"max_installments"];
     self.descriptiontext.text=[[responseData objectAtIndex:0]objectForKey:@"description"];
    });
    
    
}
-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Error"
                               message:[NSString stringWithFormat:@"%@",errorMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                 //  [app hudStop];
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}




@end
