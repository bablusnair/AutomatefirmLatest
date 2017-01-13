//
//  roundupsettingsviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 20/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "roundupsettingsviewclass.h"
#import "attendancesettingsviewclass.h"
@implementation roundupsettingsviewclass
@synthesize x,y,z,p,timeArray,flag,flag1,flagValue;
-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    [self.myconnection roundUpViewAll:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];//Service for individual round up view
    
    appObj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    x=y=z=p=0;
    self.flag=self.flag1=0;
    self.flagValue=self.checkinFlag=self.checkoutFlag=0;
    
    self.checkinRounding=@"";
    self.checkoutRounding=@"";
    self.breakStart=@"";
    self.breakEnd=@"";
    
    self.timeArray=[[NSMutableArray alloc] initWithObjects:@"05",@"10",@"15", nil];
    self.minuteTableView.hidden=true;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.timeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=[self.timeArray objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:13];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flagValue==1) {
        if ([self.checkButton2.currentImage isEqual:[UIImage imageNamed:@"check_box_tick.png"]]) {
            if (self.checkoutRoundingDropText.text.length > 0) {
                self.checkoutFlag=1;
            }
            else
            {
                self.checkoutFlag=0;
            }
        }
        else
        {
            self.checkoutFlag=1;
        }
        if (self.checkoutFlag==1) {
            
            self.doneButton.enabled=YES;
        }
        else
        {
            self.doneButton.enabled=NO;
        }
        self.checkinRoundingDropText.text=[self.timeArray objectAtIndex:indexPath.row];
    }
    else
    {
        if ([self.checkButton1.currentImage isEqual:[UIImage imageNamed:@"check_box_tick.png"]]) {
            if (self.checkinRoundingDropText.text.length > 0) {
                self.checkinFlag=1;
            }
            else
            {
                self.checkinFlag=0;
            }
        }
        else
        {
            self.checkinFlag=1;
        }
        if (self.checkinFlag==1) {
            self.doneButton.enabled=YES;
        }
        else
        {
            self.doneButton.enabled=NO;
        }
         self.checkoutRoundingDropText.text=[self.timeArray objectAtIndex:indexPath.row];
        
    }
    self.minuteTableView.hidden=true;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.checkinRoundingText) {
        if (x%2==0) {
            self.flag=1;
            self.checkinRounding=@"1";
            [self.checkButton1 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.checkinRoundingDropText.backgroundColor=[UIColor clearColor];
            self.x++;
            self.doneButton.enabled=NO;
        }
        else
        {
            self.flag=0;
            self.checkinRounding=@"0";
            self.checkinRoundingDropText.text=@"";
            [self.checkButton1 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.checkinRoundingDropText.backgroundColor=[UIColor lightGrayColor];
            self.x++;
            self.doneButton.enabled=YES;
            self.minuteTableView.hidden=TRUE;
        }

        return  NO;
    }
    if (textField==self.checkoutRoundingText) {
        if (y%2==0) {
            self.flag1=1;
            self.checkoutRounding=@"1";
            [self.checkButton2 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.checkoutRoundingDropText.backgroundColor=[UIColor clearColor];
            self.y++;
            self.doneButton.enabled=NO;
        }
        else
        {
            self.flag1=0;
            self.checkoutRounding=@"0";
            self.checkoutRoundingDropText.text=@"";
            [self.checkButton2 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.checkoutRoundingDropText.backgroundColor=[UIColor lightGrayColor];
            self.y++;
            self.doneButton.enabled=YES;
            self.minuteTableView.hidden=TRUE;
        }

        return  NO;
    }
    if (textField==self.breakStartText) {
        if (z%2==0) {
            self.breakStart=@"1";
            [self.checkButton3 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.z++;
        }
        else
        {
            self.breakStart=@"0";
            [self.checkButton3 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.z++;
        }

        return  NO;
    }
    if (textField==self.breakEndText) {
        if (p%2==0) {
            self.breakEnd=@"1";
            [self.checkButton4 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.p++;
        }
        else
        {
            self.breakEnd=@"0";
            [self.checkButton4 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.p++;
        }
        return  NO;
    }
    if (textField==self.checkinRoundingDropText) {
        if (self.flag==1) {
            self.flagValue=1;
            self.minuteTableView.frame=CGRectMake(455, 231, self.minuteTableView.frame.size.width, self.minuteTableView.frame.size.height);
            self.minuteTableView.hidden=false;
        }
        return  NO;
    }
    if (textField==self.checkoutRoundingDropText) {
        if (self.flag1==1) {
            self.flagValue=2;
            self.minuteTableView.frame=CGRectMake(463, 291, self.minuteTableView.frame.size.width, self.minuteTableView.frame.size.height);
            self.minuteTableView.hidden=false;
        }
        return  NO;
    }
    else
        return  YES;
}
-(IBAction)checkButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        if (x%2==0) {
            self.flag=1;
            self.checkinRounding=@"1";
            [self.checkButton1 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.checkinRoundingDropText.backgroundColor=[UIColor clearColor];
            self.x++;
            self.doneButton.enabled=NO;
        }
        else
        {
            self.flag=0;
            self.checkinRounding=@"0";
            self.checkinRoundingDropText.text=@"";
            [self.checkButton1 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.checkinRoundingDropText.backgroundColor=[UIColor lightGrayColor];
            self.x++;
            self.doneButton.enabled=YES;
            self.minuteTableView.hidden=TRUE;
        }
    }
    if (button.tag==2) {
        if (y%2==0) {
            self.flag1=1;
            self.checkoutRounding=@"1";
            [self.checkButton2 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.checkoutRoundingDropText.backgroundColor=[UIColor clearColor];
            self.y++;
            self.doneButton.enabled=NO;
        }
        else
        {
            self.flag1=0;
            self.checkoutRounding=@"0";
            self.checkoutRoundingDropText.text=@"";
            [self.checkButton2 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.checkoutRoundingDropText.backgroundColor=[UIColor lightGrayColor];
            self.y++;
            self.doneButton.enabled=YES;
            self.minuteTableView.hidden=TRUE;
        }

    }
    if (button.tag==3) {
        if (z%2==0) {
            self.breakStart=@"1";
            [self.checkButton3 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.z++;
        }
        else
        {
            self.breakStart=@"0";
            [self.checkButton3 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.z++;
        }

    }
    if (button.tag==4) {
        if (p%2==0) {
            self.breakEnd=@"1";
            [self.checkButton4 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.p++;
        }
        else
        {
            self.breakEnd=@"0";
            [self.checkButton4 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.p++;
        }

    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.roundupNameText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=49) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz"];
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
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView==self.descriptionTextView) {
        if ([text isEqualToString:@""]) {
            return YES;
        }
        if (textView.text.length<=150) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@" 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
            unichar c = [text characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
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
        return YES;
    }

}
-(IBAction)donebuttonaction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"close" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"roundupAction"];
    
    
    [self.myconnection roundUpUpdate:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]:self.roundupNameText.text :self.descriptionTextView.text :self.checkinRounding :self.checkinRoundingDropText.text :self.checkoutRounding :self.checkoutRoundingDropText.text :self.breakStart :self.breakEnd ];
    dispatch_async(dispatch_get_main_queue(), ^{
        [appObj hudStart:self];
    });
    
    //[self removeFromSuperview];
}
-(IBAction)cancelButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"close" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}


//<-------------------------------------------Response Part--------------------------------------------->

-(void)initiallyRoundupRuleViewResponse:(NSMutableArray *)roundupRulesArray
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"roundupAction"]isEqualToString:@"update"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableDictionary *roundUpDict=[roundupRulesArray objectAtIndex:0];
            self.roundupNameText.text=[roundUpDict objectForKey:@"round_up_name"];
            self.descriptionTextView.text=[roundUpDict objectForKey:@"round_up_description"];
            
            self.checkinRounding=[roundUpDict objectForKey:@"round_up_checkbox1"];
            if([[roundUpDict objectForKey:@"round_up_checkbox1"]isEqualToString:@"1"])
            {
                self.flag=1;
                x=1;
                [self.checkButton1 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
                self.checkinRoundingDropText.text=[roundUpDict objectForKey:@"round_up_time1"];
                self.checkinRoundingDropText.backgroundColor=[UIColor clearColor];
            }
            else
            {
                self.flag=0;
                x=0;
                [self.checkButton1 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
                self.checkinRoundingDropText.backgroundColor=[UIColor lightGrayColor];
            }
            
            self.checkoutRounding=[roundUpDict objectForKey:@"round_up_checkbox2"];
            if ([[roundUpDict objectForKey:@"round_up_checkbox2"]isEqualToString:@"1"])
            {
                self.flag1=1;
                y=1;
                [self.checkButton2 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
                self.checkoutRoundingDropText.text=[roundUpDict objectForKey:@"round_up_time2"];
                self.checkoutRoundingDropText.backgroundColor=[UIColor clearColor];
            }
            else
            {
                self.flag1=0;
                y=0;
                [self.checkButton2 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
                self.checkoutRoundingDropText.backgroundColor=[UIColor lightGrayColor];
            }
            
            self.breakStart=[roundUpDict objectForKey:@"round_up_checkbox3"];
            if ([[roundUpDict objectForKey:@"round_up_checkbox3"]isEqualToString:@"1"]) {
                z=1;
                [self.checkButton3 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            }
            else
            {
                z=0;
                [self.checkButton3 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            }
            
            self.breakEnd=[roundUpDict objectForKey:@"round_up_checkbox4"];
            if ([[roundUpDict objectForKey:@"round_up_checkbox4"]isEqualToString:@"1"]) {
                p=1;
                [self.checkButton4 setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            }
            else
            {
                p=0;
                [self.checkButton4 setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            }
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            attendancesettingsviewclass *ob = (attendancesettingsviewclass *)self.superview.superview;
        
            [ob initiallyRoundupRuleViewResponse:roundupRulesArray];
        
            [self removeFromSuperview];
        });
    }
    
    
}

@end
