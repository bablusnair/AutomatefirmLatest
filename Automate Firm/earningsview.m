//
//  earningsview.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 05/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "earningsview.h"
#import "earningstileviewclass.h"
#import "payrollSettingsViewsClass.h"
#import "earningsAccordianview.h"
#import "settingsViewController.h"
#import "earningsAccordianview.h"
@implementation earningsview

-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:(@"earningsAction")]isEqualToString:@"update"]) {
        self.plusButton.userInteractionEnabled=TRUE;
        self.plusButton.hidden=FALSE;
        [self.myconnection EarningRuleDetails:[[NSUserDefaults standardUserDefaults]objectForKey:@"earningRuleID"]];

    }
    self.cancelflag=@"0";

    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.tableRowId=1;
    app.earningName=@"";
    app.earningAbbrevtion=@"";
    app.earningRuleId=@"0";
    app.earningDesc=@"Manually determine on pay-slip, any amount at the time of salary or wage payment.";

  //  app.earningName=@"";

    app.earningsTileIdDict= [[NSMutableDictionary alloc] init];

    self.earningstypearray=[[NSMutableArray alloc] initWithObjects:@"Flat Amount",@"Fixed Amount",@"Hourly Rate",@"Amount Per Hour", @"Percentage of Base", nil];
    self.descriptionMessageArray=[[NSMutableArray alloc] initWithObjects:@"Manually determine on pay-slip, any amount at the time of salary or wage payment.",@"Determine a fixed amount that cannot be overridden on the payment slip.",@"Determined by multiplying hours worked by a specific amount pay rate (for earnings only).",@"Determined by multiplying hours you specify by a particular amount.",@"Determined as a percentage of employee’s base salary or wages.", nil];
    
    
    

    accordion = [[earningsAccordianview alloc] initWithFrame:CGRectMake(10, 120, 625, 450)];
    [self addSubview:accordion];
    
    self.mytableview.hidden=TRUE;
    [self addSubview:self.mytableview];
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"dropAction"];
    
}


-(IBAction)cancel:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"earningsAction"]isEqualToString:@"create"]) {
        [self showalerviewcontroller:@"You did not save the rule. Ok to delete the rule"];
        self.cancelflag=@"1";
    }
    else{
        [self removeFromSuperview];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    //
}

-(IBAction)done:(id)sender
{
    
    [self.earningNameText resignFirstResponder];
    [self.earningAbbrText resignFirstResponder];
   NSMutableDictionary *firstDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:app.earningName,@"earnings_name",app.earningAbbrevtion,@"earnings_abbrb",app.earningTypeString,@"earnings_type",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"office_id",app.earningRuleId,@"earnings_id",app.earningDesc,@"description", nil];
    
    if ((self.earningNameText.text.length>0)&&(self.earningAbbrText.text.length>0)&&(app.earningsTileIdDict.count>0)) {
        
        [self.myconnection finalDoneFunction:firstDetailsDict];
        
    }
    else{
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Warning..."
                                   message:[NSString stringWithFormat:@"Must Enter All Mandatory fields"]
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                   }];
        [alert addAction:ok];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    //[self removeFromSuperview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.earningstypearray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.font=[UIFont systemFontOfSize:12.0];
    cell.textLabel.text=[self.earningstypearray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    app.tableRowId=indexPath.row+1;
    self.earningstypetext.text=[self.earningstypearray objectAtIndex:indexPath.row];
    self.descriptionlabel.text=[self.descriptionMessageArray objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
            app.earningDesc=@"Manually determine on pay-slip, any amount at the time of salary or wage payment.";
            break;
        case 1:
            app.earningDesc=@"Determine a fixed amount that cannot be overridden on the payment slip.";
            break;
        case 2:
            app.earningDesc=@"Determined by multiplying hours worked by a specific amount pay rate (for earnings only).";

            break;
        case 3:
            app.earningDesc=@"Determined by multiplying hours you specify by a particular amount.";

            break;
        case 4:
            app.earningDesc=@"Determined as a percentage of employee’s base salary or wages.";

            break;
    
        default:
            break;
    }
    
    
    
    
    
    app.earningTypeString=[NSString stringWithFormat:@"%d",indexPath.row+1];
    app.tableRowId=indexPath.row+1;
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",indexPath.row+1]  forKey:@"dropAction"];
    self.mytableview.hidden=TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.earningNameText) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=29) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
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
            return  NO;
    }
    else if (textField==self.earningAbbrText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"];
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
            return  NO;
    }
    else
    {
        return YES;
    }
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.earningstypetext) {
        if (!([app.earningRuleId isEqualToString:@"0"])) {
            [self showalerviewcontroller:@"All Rule Condition Should Have Only One Type..Are You Sure Want to Reset The Tile Condition"];
        }
        else{
        self.mytableview.hidden=FALSE;
        }
            [self.earningstypetext resignFirstResponder];
        return NO;
    }
    else
    {
        return YES;
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    if (textField==self.earningNameText) {
        
        app.earningName=self.earningNameText.text;
    }
    
    if (textField==self.earningAbbrText)
    {
        app.earningAbbrevtion=self.earningAbbrText.text;
            }
    
    
    
}


- (IBAction)addNewTile:(id)sender {
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[earningsAccordianview class]]) {
            earningsAccordianview *myobj = (earningsAccordianview *)view;
            if ([app.earningsTileIdDict count]==app.addnewCount) {
                
                [myobj addNewTileForUpdation :app.earningsTileIdDict.count];
            }
            else
            {
                UIAlertController *alert= [UIAlertController
                                           alertControllerWithTitle:@"Warning..."
                                           message:[NSString stringWithFormat:@"Cannot make an empty condition"]
                                           preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                               //  [app hudStop];
                                                            //   [self.myconnection deleteEarningRule:app.earningRuleId typeOfDel:@"3"];
                                                               
                                                               
                                                               
                                                           }];
           // }];
           // [alert addAction:cancel];
            [alert addAction:ok];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
            });
            

               // [self showalerviewcontroller:@"Cannot make an empty condition"];
            }
        }
    }
}

-(void)disableDropDown
{
    self.earningstypetext.userInteractionEnabled=NO;
}
-(void)enableDropDown
{
    self.earningstypetext.userInteractionEnabled=YES;
}
-(void)willRemoveSubview:(UIView *)subview
{
    NSMutableArray *selectedDeignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
    NSLog(@"%@",self.subviews);
        for (earningstileviewclass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[earningstileviewclass class]]) {
    
                [myView collectionViewReload:selectedDeignationArray];
                
            }
     }
}


//..service response for earning rule view

-(void)serviceGotResponse : (id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.earningNameText.text=[[[responseData objectForKey:@"earnings_rule"]objectAtIndex:0] objectForKey:@"earnings_name"];
        self.earningAbbrText.text=[[[responseData objectForKey:@"earnings_rule"]objectAtIndex:0] objectForKey:@"earnings_abbrb"];
      NSString *typeStr=[[[responseData objectForKey:@"earnings_rule"]objectAtIndex:0] objectForKey:@"earnings_type"];
        app.earningRuleId=[[[responseData objectForKey:@"earnings_rule"]objectAtIndex:0] objectForKey:@"id"];
        app.earningName=[[[responseData objectForKey:@"earnings_rule"]objectAtIndex:0] objectForKey:@"earnings_name"];
        app.earningAbbrevtion=[[[responseData objectForKey:@"earnings_rule"]objectAtIndex:0] objectForKey:@"earnings_abbrb"];
        app.earningTypeString=[[[responseData objectForKey:@"earnings_rule"]objectAtIndex:0] objectForKey:@"earnings_type"];
        int value = [typeStr intValue];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",[[[[responseData objectForKey:@"earnings_rule"]objectAtIndex:0] objectForKey:@"earnings_type"] intValue]]  forKey:@"dropAction"];
        app.tableRowId=[[[[responseData objectForKey:@"earnings_rule"]objectAtIndex:0] objectForKey:@"earnings_type"] intValue];
        switch (value) {
            case 1:
                self.earningstypetext.text=[self.earningstypearray objectAtIndex:0];
                break;
            case 2:
                self.earningstypetext.text=[self.earningstypearray objectAtIndex:1];
                break;
                
            case 3:
                self.earningstypetext.text=[self.earningstypearray objectAtIndex:2];
                break;
                
            case 4:
                self.earningstypetext.text=[self.earningstypearray objectAtIndex:3];
                break;
                
            case 5:
                self.earningstypetext.text=[self.earningstypearray objectAtIndex:4];
                break;
                

                
            default:
                break;
        }
            
        for (int i=0; i<[[responseData objectForKey:@"earnings_rule_condtions" ]count]; i++) {
            [app.earningsTileIdDict setObject:[[[responseData objectForKey:@"earnings_rule_condtions"]objectAtIndex:i] objectForKey:@"id"] forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[earningsAccordianview class]]) {
                earningsAccordianview *myobj = (earningsAccordianview *)view;
                [myobj CreationoftileforUpdation:[[responseData objectForKey:@"earnings_rule_condtions" ]count]];
            }
        }
        
        //earningsAccordianview *myobj = (earningsAccordianview *)[self.subviews lastObject];
        

      
        
        
    });
}

//......MainDone Response

-(void)allearningsResponse : (id)responseData
{
    if ([responseData count]>0) {
        
        
    payrollSettingsViewsClass *ob1 = (payrollSettingsViewsClass *)self.superview.superview;
        
        [ob1 allearningsResponse:responseData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
            
        });
        
        
    }
    else
    {
        
        [self showalerviewcontroller:@"Connection Failed"];
    }

    
}

-(void)showalerviewcontroller:(NSString *)alertMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning..."
                               message:[NSString stringWithFormat:@"%@",[[alertMessage componentsSeparatedByString:@"###" ] objectAtIndex:0]]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //  [app hudStop];
                                                   if ([alertMessage containsString:@"###"]) {
                                                       self.cancelflag=@"2";
                                                   }
                                                   if ([self.cancelflag isEqualToString:@"1"]) {
                                                       [self.myconnection deleteEarningRule:app.earningRuleId typeOfDel:@"1"];
                                                       [self removeFromSuperview];
  
                                                   }
                                                   if ([self.cancelflag isEqualToString:@"0"]) 
                                                   {
                                                       [self.myconnection deleteEarningRule:app.earningRuleId typeOfDel:@"3"];
  
                                                   }
                                                
                                                   
                                                   
                                               }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                                 self.cancelflag=@"0";
                                 //self.mytableview.hidden=FALSE;

                                 
                                 
                             }];
    [alert addAction:cancel];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
}

//..Delete All conditions
-(void)deleteAllTileResponse:(id)response flag:(NSString *)delFlag
{
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[earningsAccordianview class]]) {
                earningsAccordianview *myobj = (earningsAccordianview *)view;
                [myobj deleteAllTileResponse:response flag:@"2"];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
    });
}

@end
