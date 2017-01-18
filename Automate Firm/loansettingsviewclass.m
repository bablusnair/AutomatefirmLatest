//
//  loansettingsviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 19/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "loansettingsviewclass.h"
#import "loanConditionsMainViewClass.h"
#import "settingsViewController.h"
#import "loanTileClass.h"
@implementation loansettingsviewclass

- (void)awakeFromNib
{
    
    self.myconnection=[[connectionclass alloc] init];
    self.myconnection.mydelegate=self;
    
    accordion = [[loanTileClass alloc] initWithFrame:CGRectMake(21, 148, 603, 425)];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"loan" forKey:@"accordianAction"];
    [self addSubview:accordion];

    self.descriptiontext.text=@"";
    
     [[NSUserDefaults standardUserDefaults] setObject:self.descriptiontext.text forKey:@"description"];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"loanAction"]isEqualToString:@"update"]) {
        
        self.plusButton.hidden=false;
        
        [self.myconnection updationofloanIndividualrules:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] loanruleid:[[NSUserDefaults standardUserDefaults]objectForKey:@"Loan_ruleId"]];
    }
    else
    {
        
        self.plusButton.hidden=true;
        
    }
    
}

-(IBAction)donebuttonaction:(id)sender
{
    
     AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (self.loantype.text.length>0 && self.abbrevation.text.length>0 && ![myappde.loan_idstring isEqualToString:@"0"]) {
        
        
        
        [self.myconnection lastdonebuttonforcreateloanservice:self.loantype.text abbrevation:self.abbrevation.text description:self.descriptiontext.text loanruleid:myappde.loan_idstring];
        
      
    }
    else
    {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Mandatory"
                                   message:[NSString stringWithFormat:@"Mandatory Fields are Required"]
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       //Do Some action here
                                                   }];
        [alert addAction:ok];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"%@",[self.superview.superview.superview.superview nextResponder]);
            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });

        
    }
  
}


-(IBAction)cancelButtonAction:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
  
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Loan_ruleId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loantype"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"abbrevation"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"officeDetails"];
    
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
   // myappde.loan_idstring=@"0";
    
    myappde.includedesignationflag=0;
    
    myappde.myselectedTag=0;
    
    myappde.designation_tile=@"";
    
    [myappde.loantileid_array removeAllObjects];
    
    [myappde.appde_locgroupdictionary removeAllObjects];
    
    [myappde.appde_localdict removeAllObjects];
    
    [myappde.loanupdate_dictionary removeAllObjects];
    
        
        NSLog(@"%@",myappde.loan_idstring);
    
    if (![myappde.loan_idstring isEqualToString:@"0"]) {
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"loanAction"]isEqualToString:@"create"]) {
            
            [self.myconnection deletethemainloanRules:myappde.loan_idstring];
            myappde.loan_idstring=@"0";
            
        }
        else
        {
             myappde.loan_idstring=@"0";
             [self removeFromSuperview];
        }
       
    }
    else
    {
         myappde.loan_idstring=@"0";
         [self removeFromSuperview];
        
    }
         
  });
    
}

-(void)willRemoveSubview:(UIView *)subview
{
    NSMutableArray *selectedDeignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
   // NSLog(@"%@",self.subviews);
    for (loanConditionsMainViewClass *myView in accordion.scrollView.subviews) {
        if ([myView isKindOfClass:[loanConditionsMainViewClass class]]) {
            
            [myView collectionViewReload:selectedDeignationArray];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  
    
    if (textField==self.loantype) {
        
        [[NSUserDefaults standardUserDefaults] setObject:self.loantype.text forKey:@"loantype"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    else if (textField==self.abbrevation)
    {
        [[NSUserDefaults standardUserDefaults] setObject:self.abbrevation.text forKey:@"abbrevation"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    else{
        
        [[NSUserDefaults standardUserDefaults] setObject:self.descriptiontext.text forKey:@"description"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.loantype) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=44) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz 0123456789"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
                return NO;
        }
        else
            return  NO;
    }
    else if (textField==self.abbrevation)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
                return NO;
        }
        else
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
            else
                return NO;
        }
        else
            return  NO;
    }
    else
    {
        return YES;
    }
}

-(void)donesavedGotresponse:(NSString *)responsestring
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loantype"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"abbrevation"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Loan_ruleId"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"officeDetails"];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    
        
        AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        myappde.loan_idstring=@"0";
        
        myappde.includedesignationflag=0;
        
        myappde.myselectedTag=0;
        
        myappde.designation_tile=@"";
        
        [myappde.loantileid_array removeAllObjects];
       
        [myappde.appde_locgroupdictionary removeAllObjects];
      
        [myappde.appde_localdict removeAllObjects];
        
        [myappde.loanupdate_dictionary removeAllObjects];
        [self removeFromSuperview];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"viewallloanservice" object:Nil];
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

-(void)updationofloanResponse:(NSMutableDictionary *)updatedloanresponse
{
  
    if (updatedloanresponse.count>0) {
        
        
        AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        [myappde.loanupdate_dictionary addEntriesFromDictionary:updatedloanresponse];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            loanTileClass *myobj = (loanTileClass *)[self.subviews lastObject];
            [myobj CreationoftileforUpdation:[[updatedloanresponse objectForKey:@"loan_condition_details"]count]];
            
            NSMutableArray *myarray = [updatedloanresponse objectForKey:@"loan_details"];
            
            if (myarray.count>0) {
                
                NSMutableDictionary *dict = [myarray objectAtIndex:0];
                
                self.loantype.text=[dict objectForKey:@"loan_type"];
                self.abbrevation.text=[dict objectForKey:@"abbreviation"];
                
                [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"loan_type"] forKey:@"loantype"];
                
                [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"abbreviation"]forKey:@"abbrevation"];
                
                

                NSString *str = [dict objectForKey:@"description"];
                if (str.length>0) {
                    
                    self.descriptiontext.text=[dict objectForKey:@"description"];
                }
                else
                {
                    self.descriptiontext.text=@"";
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:self.descriptiontext.text forKey:@"description"];
                
                myappde.loan_idstring=[dict objectForKey:@"loan_id"];
                
            }

        });
        
        
        NSMutableArray *fortileidarray = [updatedloanresponse objectForKey:@"loan_condition_details"];

        for (int i=0; i<fortileidarray.count; i++) {
            
            NSMutableDictionary *mydict= [fortileidarray objectAtIndex:i];
            [myappde.loantileid_array addObject:[mydict objectForKey:@"id"]];
            
        }
        

    }
    

}

-(IBAction)plusNewTile:(id)sender
{
   
   AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (myappde.loantileid_array.count==myappde.headercount) {
        
        loanTileClass *myobj = (loanTileClass *)[self.subviews lastObject];
        
        if (myappde.loantileid_array.count>0) {
            
            [myobj addNewTileForUpdation:myappde.loantileid_array.count];
        }
        else
        {
            
            [myobj addNewTileForUpdation:0];
            
        }
        
    }
  
    
}


-(void)deleteloanrules:(NSString *)deletedresponse
{
   
    dispatch_async(dispatch_get_main_queue(), ^{
    
    if ([deletedresponse isEqualToString:@"1"]) {
        
         [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"viewallloanservice" object:Nil];
        
    }
        
   });
  
}

-(void)disableddonebutton
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
      self.donebutton.enabled=FALSE;
      self.plusButton.enabled=FALSE;
    });

    
}


-(void)enableddonebutton
{
    dispatch_async(dispatch_get_main_queue(), ^{
    
    self.donebutton.enabled=TRUE;
    self.plusButton.enabled=TRUE;
        
    });
}

@end
