//
//  deductionsViewClass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 09/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "deductionsViewClass.h"
#import "deductionsTileViewClass.h"
#import "deductionsTileClass.h"
#import "settingsViewController.h"
#import "payrollSettingsViewsClass.h"

@implementation deductionsViewClass

-(void)awakeFromNib
{
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:(@"deductionsAction")]isEqualToString:@"update"]) {
      //  [self.myconnection :[[NSUserDefaults standardUserDefaults]objectForKey:@"earningRuleID"]];
        self.plusButton.hidden=false;
        [self.myconnection deductionRuleDetails:[[NSUserDefaults standardUserDefaults]objectForKey:@"deductionRuleID"] offficeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    }

    self.deductionstypearray=[[NSMutableArray alloc]initWithObjects:@"Flat Amount",@"Fixed Amount",@"Amount Per Hour", @"Percentage of Base", nil];
    self.descriptionMessageArray=[[NSMutableArray alloc] initWithObjects:@"Manually determine on pay-slip, any amount at the time of salary or wage payment.",@"Determine a fixed amount that cannot be overridden on the payment slip.",@"Determined by multiplying hours you specify by a particular amount.",@"Determined as a percentage of employee’s base salary or wages.", nil];
    
    self.mytableview.hidden=TRUE;
    app.deductionTileIdDict= [[NSMutableDictionary alloc] init];
    
    app.deductionTypeString=@"Flat Amount";
    app.deductionRowId=1;
    self.cancelflag=@"0";
    app.deductionDescription=@"Manually determine on pay-slip, any amount at the time of salary or wage payment.";
    app.deductionName=@"";
    app.deductionAbbrevtion=@"";
    app.deductionRuleId=@"0";
    accordion = [[deductionsTileClass alloc] initWithFrame:CGRectMake(10, 120, 625, 450)];
    [self addSubview:accordion];
    
    [self addSubview:self.mytableview];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"dropAction"];
    
}


-(IBAction)cancel:(id)sender
{
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"deductionsAction"]isEqualToString:@"create"])
    {
        [self alertAction:@"You did not save the rule. Continue to delete the rule"];
        
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
        [self removeFromSuperview];
    }
    
}
-(IBAction)done:(id)sender
{
    self.deductionnameText.text=app.deductionName;
    self.abbrvationText.text=app.deductionAbbrevtion;

    NSMutableDictionary *firstDetails=[[NSMutableDictionary alloc]initWithObjectsAndKeys:app.deductionName,@"d_name",app.deductionAbbrevtion,@"abbreviation",[NSString stringWithFormat:@"%d",app.deductionRowId],@"d_type",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"o_id",app.deductionDescription,@"description",app.deductionRuleId,@"deduction_id", nil];
    
    if ((self.deductionnameText.text.length>0)&&(self.abbrvationText.text.length>0)&&(app.deductionTileIdDict.count>0)) {
     
        [self.myconnection finalDoneFunctionForDeduction:firstDetails];
 
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

-(void)willRemoveSubview:(UIView *)subview
{
    NSMutableArray *selectedDeignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
    NSLog(@"%@",self.subviews);
    for (deductionsTileViewClass *myView in accordion.scrollView.subviews) {
        if ([myView isKindOfClass:[deductionsTileViewClass class]]) {
            
            [myView collectionViewReload:selectedDeignationArray];
            
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.deductionstypearray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.font=[UIFont systemFontOfSize:12.0];
    cell.textLabel.text=[self.deductionstypearray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.deductionTypeText.text=[self.deductionstypearray objectAtIndex:indexPath.row];
    self.descriptionlabel.text=[self.descriptionMessageArray objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
            app.deductionDescription=@"Manually determine on pay-slip, any amount at the time of salary or wage payment.";
            break;
        case 1:
            app.deductionDescription=@"Determine a fixed amount that cannot be overridden on the payment slip.";
            break;
        case 2:
            app.deductionDescription=@"Determined by multiplying hours you specify by a particular amount.";
            break;
        case 3:
            app.deductionDescription=@"Determined as a percentage of employee’s base salary or wages.";
            break;
            
        default:
            break;
    }
    app.deductionTypeString=self.deductionTypeText.text;
    app.deductionRowId=indexPath.row+1;
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",indexPath.row+1]  forKey:@"dropAction"];
    
    self.mytableview.hidden=TRUE;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.deductionnameText) {
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
    else if (textField==self.abbrvationText)
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
    
    if (textField==self.deductionTypeText) {
        if (!([app.deductionRuleId isEqualToString:@"0"])) {
            [self showalerviewcontroller:@"All Rule Condition Should Have Only One Type..Are You Sure Want to Reset The Tile Condition"];
        }
        else{
            self.mytableview.hidden=FALSE;
        }
        [self.deductionTypeText resignFirstResponder];
        return NO;
    }
    else
    {
        return YES;
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    if (textField==self.deductionnameText) {
        
        app.deductionName=self.deductionnameText.text;
    }
    
    if (textField==self.abbrvationText)
    {
        app.deductionAbbrevtion=self.abbrvationText.text;
    }
    
    
    
}

-(void)disableDropDown
{
    self.deductionTypeText.userInteractionEnabled=NO;
}
-(void)enableDropDown
{
    self.deductionTypeText.userInteractionEnabled=YES;
}

//.......Response........
-(void)conditionDetailsResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.deductionnameText.text=[[[responseData objectForKey:@"deduction_details"]objectAtIndex:0] objectForKey:@"d_name"];
        self.abbrvationText.text=[[[responseData objectForKey:@"deduction_details"]objectAtIndex:0] objectForKey:@"abbreviation"];
        self.deductionTypeText.text=[[[responseData objectForKey:@"deduction_details"]objectAtIndex:0] objectForKey:@"d_type"];
        self.descriptionlabel.text=[[[responseData objectForKey:@"deduction_details"]objectAtIndex:0] objectForKey:@"description"];
        app.deductionName=[[[responseData objectForKey:@"deduction_details"]objectAtIndex:0] objectForKey:@"d_name"];
        app.deductionAbbrevtion=[[[responseData objectForKey:@"deduction_details"]objectAtIndex:0] objectForKey:@"abbreviation"];
        app.deductionDescription=[[[responseData objectForKey:@"deduction_details"]objectAtIndex:0] objectForKey:@"description"];
        app.deductionRuleId=[[[responseData objectForKey:@"deduction_details"]objectAtIndex:0] objectForKey:@"d_id"];
        app.deductionRowId=[[[[responseData objectForKey:@"deduction_details"]objectAtIndex:0] objectForKey:@"d_type"]intValue];
               switch (app.deductionRowId) {
            case 1:
                self.deductionTypeText.text=[self.deductionstypearray objectAtIndex:0];
                break;
            case 2:
                self.deductionTypeText.text=[self.deductionstypearray objectAtIndex:1];
                break;
                
            case 3:
                self.deductionTypeText.text=[self.deductionstypearray objectAtIndex:2];
                break;
                
            case 4:
                self.deductionTypeText.text=[self.deductionstypearray objectAtIndex:3];
                break;
             
            default:
                break;
        }

       
        for (int i=0; i<[[responseData objectForKey:@"deduction_condition_details" ]count]; i++) {
            [app.deductionTileIdDict setObject:[[[responseData objectForKey:@"deduction_condition_details"]objectAtIndex:i] objectForKey:@"id"] forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[deductionsTileClass class]]) {
                deductionsTileClass *myobj = (deductionsTileClass *)view;
                [myobj CreationoftileforUpdation:[[responseData objectForKey:@"deduction_condition_details" ]count]];
            }
        }
        
    });
    
    
}
-(IBAction)addNewTile:(id)sender
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[deductionsTileClass class]]) {
            deductionsTileClass *myobj = (deductionsTileClass *)view;
            if ([app.deductionTileIdDict count]==app.addnewCount) {
                
                [myobj addNewTileForUpdation :app.deductionTileIdDict.count];
            }
            else{
                UIAlertController *alert= [UIAlertController
                                           alertControllerWithTitle:@"Warning..."
                                           message:[NSString stringWithFormat:@"Cannot make an empty condition"]
                                           preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                               
                                                               
                                                               
                                                           }];
              
                [alert addAction:ok];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
                });

            }
        }
    }
}
-(void)alertAction:(NSString *)alertMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning..."
                               message:[NSString stringWithFormat:@"%@",alertMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
      
                                                   [self.myconnection deleteDeductionRule:app.deductionRuleId idFlag:@"1"];
                                                   
                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
                                                   [self removeFromSuperview];
                                               }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                                 
                                 
                                 
                                 
                                 
                             }];
    [alert addAction:cancel];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}
-(void)showalerviewcontroller:(NSString *)alertMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning..."
                               message:[NSString stringWithFormat:@"%@",alertMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //  [app hudStop];
                                                   for (int i=0; i<[app.deductionTileIdDict count]; i++) {
                                                       [self.myconnection deleteDeductionRule:[app.deductionTileIdDict objectForKey:[NSString stringWithFormat:@"%d",i]] idFlag:@"2"];
                                                   }
                                                   
                                                   
                                                   
                                                   
                                               }];
    
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
}

//......Final Done Response
-(void)viewalldedctionResponse:(id)responseDta
{
    if ([responseDta count]>0) {
        
        
        payrollSettingsViewsClass *ob1 = (payrollSettingsViewsClass *)self.superview.superview;
        
        [ob1 viewalldedctionResponse:responseDta];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
            
        });
        
        
    }
    else
    {
        
        [self showalerviewcontroller:@"Connection Failed"];
    }
    
    

}







//..Delete All conditions
-(void)deleteAllTileResponse:(id)response flag:(NSString *)delFlag
{
    
    
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[deductionsTileClass class]]) {
          deductionsTileClass   *myobj = (deductionsTileClass *)view;
            
            [myobj deleteAllTileResponse:response flag:@"2"];
        }
    }
    
    
    //  [ob1];
    dispatch_async(dispatch_get_main_queue(), ^{
        // [self removeFromSuperview];
        
    });
    
    
    
}

@end
