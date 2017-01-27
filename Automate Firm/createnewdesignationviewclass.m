//
//  createnewdesignationviewclass.m
//  Automate Firm
//
//  Created by leonine on 18/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "createnewdesignationviewclass.h"
#import "jobdescriptioncellclass.h"
#import "settingsViewController.h"
#import "generalsettingsmainclass.h"
#import "AppDelegate.h"

@implementation createnewdesignationviewclass


-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc] init]; //Allocating location for connection object
    self.myconnection.mydelegate=self;
    
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"desigAction"]isEqualToString:@"update"]) {
        [self.myconnection individualDesignationView:[[NSUserDefaults standardUserDefaults]objectForKey:@"desigID"]];
        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        //Start Progress hud
        [app hudStart:self];
    }
    
    self.jobdescriptionarray=[[NSMutableArray alloc] init];
    self.jobtittlearray=[[NSMutableArray alloc] init];
    self.responsilityIDArray = [[NSMutableArray alloc]init];
    
    
    self.jobdescriptiontableview.delaysContentTouches=NO;
    
    self.desigID=@"0";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
     
                                               object:nil];
    self.addNewDescriptionButton.hidden=true;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.jobdescriptionarray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"simplecell";
    jobdescriptioncellclass  *cell = (jobdescriptioncellclass *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"jobdescriptioncellview" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.delegate=self;
    [lpgr setCancelsTouchesInView:NO];
    [cell addGestureRecognizer:lpgr];
    
    cell.jobtittle.text=[self.jobtittlearray objectAtIndex:indexPath.row];
    cell.jobdescription.text=[self.jobdescriptionarray objectAtIndex:indexPath.row];
    cell.jobdescription.delegate=self;
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //Stop the progress hud
    [app hudStop];
    return cell;
    
}

-(void)handleLongPress : (UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state==UIGestureRecognizerStateBegan) {
        CGPoint p = [gestureRecognizer locationInView:self.jobdescriptiontableview];
        
        self.inPath = [self.jobdescriptiontableview indexPathForRowAtPoint:p];
        
        jobdescriptioncellclass  *cell=[self.jobdescriptiontableview cellForRowAtIndexPath:self.inPath];
        [cell.jobdescription becomeFirstResponder];
        
        CGPoint buttonPosition = [cell.jobdescription convertPoint:CGPointZero toView:self];
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,buttonPosition.y-100);
    }
    
    
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // save the text view that is being edited
    if(textView==self.jobdescriptiontextfield)
        self.activeTextView = textView;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    // release the selected text view as we don't need it anymore
    if (textView==self.jobdescriptiontextfield) {
        if (!(self.jobdescriptiontextfield.text.length > 0)) {
            self.addNewDescriptionButton.hidden=true;
        }
        else
        {
            if (![self.jobdescriptiontextfield.text isEqualToString:@"Job Description"]) {
                self.responsibilityText = self.jobdescriptiontextfield.text;
                self.responsibilityID = @"0";
            }
        }
        self.activeTextView = nil;
    }
    else if (textView==self.descriptiontextview)
    {
        
    }
    else
    {
        jobdescriptioncellclass *cell=[self.jobdescriptiontableview cellForRowAtIndexPath:self.inPath];
        [self.jobdescriptionarray replaceObjectAtIndex:self.inPath.row withObject:cell.jobdescription.text];
        [cell.jobdescription resignFirstResponder];
        self.scrollView.contentOffset = CGPointMake(0,0);
        [self.jobdescriptiontableview reloadData];
    }
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    if (textView==self.jobdescriptiontextfield) {
        self.addNewDescriptionButton.hidden=false;
    }

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
    
    if (!CGRectContainsPoint(aRect, self.activeTextView.frame.origin)) {
        
        [self.scrollView scrollRectToVisible:self.activeTextView.frame animated:YES];
        
    }
    
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


-(IBAction)cancel:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    
    [self removeFromSuperview];
}
//Adding new job descriptions
-(IBAction)addnewjobdescription:(id)sender
{
    self.addNewDescriptionButton.hidden=true;
    [self.jobdescriptiontextfield resignFirstResponder];
    if (self.jobdescriptiontextfield.text.length>0) {
        
        if (![self.jobdescriptiontextfield.text isEqualToString:@"Job Description"]) {
            
            [self.jobdescriptionarray addObject:self.responsibilityText];
            [self.responsilityIDArray addObject:self.responsibilityID];
            self.responsibilityID=@"";
            self.responsibilityText=@"";
            
            NSString *str=[NSString stringWithFormat:@"Job Description %lu",[self.jobtittlearray count]+1];
            [self.jobtittlearray addObject:str];
            
            [self.jobdescriptiontableview reloadData];
            self.jobdescriptiontextfield.text=@"";
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Delete?"
                                       message:@"Are you sure you want to delete?"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           
                                                           [self.myconnection deleteResponsibility:[self.responsilityIDArray objectAtIndex:indexPath.row]];
                                                           
                                                           [self.jobtittlearray removeObjectAtIndex:indexPath.row];
                                                           
                                                           [self.jobdescriptionarray removeObjectAtIndex:indexPath.row];
                                                           [self.responsilityIDArray removeObjectAtIndex:indexPath.row];
                                                           
                                                           for (int i=0; i<[self.jobtittlearray count]; i++) {
                                                               
                                                               NSString *str=[NSString stringWithFormat:@"Job Description %i",i+1];
                                                               [self.jobtittlearray replaceObjectAtIndex:i withObject:str];
                                                           }
                                                           
                                                           [self.jobdescriptiontableview reloadData];
                                                           
                                                       }];
            
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                               
                                                               [self.jobdescriptiontableview setEditing:false animated:YES];
                                                           }];
            [alert addAction:ok];
            [alert addAction:cancel];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
            });
        
   
    }

}

-(IBAction)doneButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    
    [self.designationTitle resignFirstResponder];
    [self.descriptiontextview resignFirstResponder];
    [self.jobdescriptiontextfield resignFirstResponder];
    
    if (self.responsibilityText.length > 0) {
        
        [self.jobdescriptionarray addObject:self.responsibilityText];
        [self.responsilityIDArray addObject:self.responsibilityID];
        NSString *str=[NSString stringWithFormat:@"Job Description %lu",[self.jobtittlearray count]+1];
        [self.jobtittlearray addObject:str];
        self.responsibilityText=self.jobdescriptiontextfield.text=@"";
        [self.jobdescriptiontableview reloadData];
        
    }
    
    
    NSMutableArray *responsibiltyArray = [[NSMutableArray alloc]init];
    for (int i=0; i<self.jobdescriptionarray.count; i++) {
        NSMutableDictionary * responsibiltyDict = [[NSMutableDictionary alloc]init];
        [responsibiltyDict setObject:[self.jobdescriptionarray objectAtIndex:i] forKey:@"job_responsibility"];
        [responsibiltyDict setObject:[self.responsilityIDArray objectAtIndex:i] forKey:@"id"];
        [responsibiltyDict setObject:self.desigID forKey:@"desig_id"];
        
        [responsibiltyArray addObject:responsibiltyDict];
    }
    
    self.designationTitle.text=[self.designationTitle.text stringByTrimmingCharactersInSet:
                                                          [NSCharacterSet whitespaceCharacterSet]];
    self.jobCodeText.text=[self.jobCodeText.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    
    if((self.designationTitle.text.length > 0) && (self.jobCodeText.text.length > 0))
    {
        NSMutableDictionary *designationDetailsDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"admin",@"desig_created_by",self.descriptiontextview.text,@"designation_description",self.designationTitle.text,@"designation_title",self.jobCodeText.text,@"job_code", nil];
       
        
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"desigAction"]isEqualToString:@"update"]) {
            
            [designationDetailsDict setObject:self.desigID forKey:@"designation_id"];
            NSMutableArray *designationDetailsArray = [[NSMutableArray alloc]initWithObjects:designationDetailsDict, nil];
            NSMutableDictionary *finalDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:designationDetailsArray,@"designation_details",responsibiltyArray,@"responsibilty_list", nil];
            
            [self.myconnection updateDesignation:finalDict];
        }
        else
        {
            NSMutableArray *designationDetailsArray = [[NSMutableArray alloc]initWithObjects:designationDetailsDict, nil];
            // [designationDetailsArray addObject:designationDetailsDict];
            NSMutableDictionary *finalDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:designationDetailsArray,@"designation_details",responsibiltyArray,@"responsibilty_list", nil];
            [self.myconnection createNewDesignations:finalDict];
        }
        
        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        [app hudStart:self];
    }
    else
    {
        [self showalerviewcontroller:@"Must Enter all the Mandatory Fields"];

    }
    
}


//---------------------------Service Response Part-----------------------------------

//Got response when save the data
-(void)designationsGotresponse:(NSMutableArray *)designationsarray
{
    dispatch_async(dispatch_get_main_queue(), ^{
   
        generalsettingsmainclass *ob = (generalsettingsmainclass *)self.superview.superview;
        [ob designationsGotresponse:designationsarray];
        [self removeFromSuperview];
    });
    
}
// Got response when individual designation view
-(void)updateruleviewresponse:(NSMutableDictionary *)updateruleDict
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *designationDict = [[updateruleDict objectForKey:@"designation_details"]objectAtIndex:0];
        
        self.desigID = [designationDict objectForKey:@"id"];
        self.designationTitle.text=[designationDict objectForKey:@"designation_title"];
        self.jobCodeText.text=[designationDict objectForKey:@"job_code"];
        self.descriptiontextview.text=[designationDict objectForKey:@"designation_description"];
        
        NSMutableArray *responsibilityArray = [updateruleDict objectForKey:@"responsibilty_list"];
        for (int i=0; i<responsibilityArray.count; i++) {
            NSMutableDictionary *responsibilityDict = [responsibilityArray objectAtIndex:i];
            [self.jobdescriptionarray addObject:[responsibilityDict objectForKey:@"job_responsibility"]];
            [self.responsilityIDArray addObject:[responsibilityDict objectForKey:@"id"]];
            [self.jobtittlearray addObject:[NSString stringWithFormat:@"Job Description %d",i+1]];
        }
        self.responsibilityText=@"";
        [self.jobdescriptiontableview reloadData];
        
//        NSString *str=[updateruleDict objectForKey:@"job_description_list"];
//        if (!([str isEqualToString:@""])) {
//            NSArray *jobDescrption=[str componentsSeparatedByString:@"###"];
//            [self.jobdescriptionarray addObjectsFromArray:jobDescrption];
//            for (int i=0; i<self.jobdescriptionarray.count; i++) {
//                [self.jobtittlearray addObject:[NSString stringWithFormat:@"Job Description %d",i+1]];
//            }
//            [self.jobdescriptiontableview reloadData];
//
//        }
//        else
//        {
//            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
//            [app hudStop];
//        }
    });
}


//Got response if no network connection is available
-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@""
                               message:[NSString stringWithFormat:@"%@",errorMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                                                   [app hudStop];
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.designationTitle)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=49) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar u = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:u])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
            return NO;
        
    }
    
    if (textField==self.jobCodeText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
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
        else
            return  NO;
        
    }
    else
    {
        return YES;
    }

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView==self.descriptiontextview) {
        if ([text isEqualToString:@""]) {
            return YES;
        }
        if (textView.text.length<=89) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz !@#$%^&*()_+=|?><,./;'[]"];
            unichar u = [text characterAtIndex:0];
            if ([myCharSet characterIsMember:u])
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
    else if (textView==self.jobdescriptiontextfield)
    {
        if ([text isEqualToString:@""]) {
            return YES;
        }
        if (textView.text.length<=249) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz !@#$%^&*()_+=|?><,./;'[]"];
            unichar u = [text characterAtIndex:0];
            if ([myCharSet characterIsMember:u])
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
        if ([text isEqualToString:@""]) {
            return YES;
        }
        if (textView.text.length<=249) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz !@#$%^&*()_+=|?><,./;'[]"];
            unichar u = [text characterAtIndex:0];
            if ([myCharSet characterIsMember:u])
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
}
@end
