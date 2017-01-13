//
//  paySettingsViewClass.m
//  Automate Firm
//
//  Created by leonine on 12/3/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "paySettingsViewClass.h"
#import "groupcollceioncellclass.h"
#import "settingsViewController.h"
#import "payrollSettingsViewsClass.h"
@implementation paySettingsViewClass
@synthesize radioFlag,timerFlag,x;
-(void)awakeFromNib
{
    [self.mycollectionview registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    self.grouparray=[[NSMutableArray alloc]init];
    self.monthPayArray=[[NSMutableArray alloc]initWithObjects:@"5th",@"10th",@"15th",@"20th",@"25th",@"Last Day", nil];
    self.checkBoxValueText.text=@"";
    self.updateString=@"0";
    radioFlag=1;
    timerFlag=0;
    x=0;
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesig"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"payAction"]isEqualToString:@"update"]) {
        [self.myconnection individualPayruleView:[[NSUserDefaults standardUserDefaults]objectForKey:@"ruleid"] officeid:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    }
    [self disableAllTimeText];
    //if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"payAction"] isEqualToString:@"Create"]) {
    
    [self settingDailyPay:self.currentStartsOnText.text];
    //}
    [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[UIDatePicker class]]]
     setBackgroundColor:[UIColor clearColor]];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];//Max Upto current Year
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [self.datePicker setMinimumDate:minDate];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.grouparray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"simplecell";
    groupcollceioncellclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.grouparray.count>0) {
        cell.grouplabel.text=[self.grouparray objectAtIndex:indexPath.row];
        
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.monthPayArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=[self.monthPayArray objectAtIndex: indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.checkBoxValueText.text=[self.monthPayArray objectAtIndex:indexPath.row];
    self.monthPayTC.hidden=true;
}
-(IBAction)includeDesignationButtonAction:(id)sender
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"grouppopupview" owner:self options:nil];
    [self addSubview:[nib objectAtIndex:0]];
}
-(void)willRemoveSubview:(UIView *)subview
{
    self.mycollectionview.hidden=FALSE;
    NSMutableArray *selectedGropupArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
    //NSMutableArray *selectedGroupIdArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedGroupsID"];
    [self.grouparray removeAllObjects];
    //[self.groupIDArray removeAllObjects];
    [self.grouparray addObjectsFromArray:selectedGropupArray];
   // [self.groupIDArray addObjectsFromArray:selectedGroupIdArray];
    [self.mycollectionview reloadData];
}


-(IBAction)removegroupfromcollectionview:(id)sender
{
    groupcollceioncellclass *clickedCell = (groupcollceioncellclass *)[[sender superview] superview];
    self.indexpath = [self.mycollectionview indexPathForCell:clickedCell];
    [self.grouparray removeObjectAtIndex:self.indexpath.row];
    [self.mycollectionview reloadData];
}

-(IBAction)radioButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        radioFlag=1;
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=true;
         [self disableAllTimeText];
        [self settingDailyPay:self.currentStartsOnText.text];
        
    }
    else if (button.tag==2)
    {
        radioFlag=2;
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=true;
         [self disableAllTimeText];
        [self settingBiWeeklyPay:self.currentStartsOnText.text];
    }
    else if (button.tag==3)
    {
        radioFlag=3;
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=false;
        self.checkBoxValueText.text=@"1st";

        [self disableAllTimeText];
        [self settingMonthlyPay:@"0"];
    }
    else if (button.tag==4)
    {
        radioFlag=4;
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=true;
         [self disableAllTimeText];
        [self settingWeeklyPay:self.currentStartsOnText.text];
    }
    else if (button.tag==5)
    {
        radioFlag=5;
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=true;
        [self disableAllTimeText];
        [self settingSemiMonthlyPay:@"0"];
    }
    else
    {
        radioFlag=6;
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=true;
         [self disableAllTimeText];
        [self settingCustomPay:self.currentStartsOnText.text :self.currentEndsOnText.text];
    }
}
-(IBAction)checkBoxAction:(id)sender
{
    [self checkAction]; // Calling the checkAction function
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.radioText1) {
        radioFlag=1;
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=true;
        [self disableAllTimeText];
        [self settingDailyPay:self.currentStartsOnText.text];
        
        return  NO;
    }
    else if (textField==self.radioText2)
    {
        radioFlag=2;
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=true;
        [self disableAllTimeText];
        [self settingBiWeeklyPay:self.currentStartsOnText.text];
        
        return  NO;
    }
    else if (textField==self.radioText3)
    {
        radioFlag=3;
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=false;
        [self disableAllTimeText];
        [self settingMonthlyPay:@"0"];
        
        return  NO;
    }
    else if (textField==self.radioText4)
    {
        radioFlag=4;
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=true;
        [self disableAllTimeText];
        [self settingWeeklyPay:self.currentStartsOnText.text];
        
        return  NO;
    }
    else if (textField==self.radioText5)
    {
        radioFlag=5;
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=true;
        [self disableAllTimeText];
        [self settingSemiMonthlyPay:@"0"];
        
        return  NO;
    }
    else if(textField==self.radioText6)
    {
        radioFlag=6;
        [self.radioButton6 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.monthlyCheckBoxView.hidden=true;
         [self disableAllTimeText];
        [self settingCustomPay:self.currentStartsOnText.text :self.currentEndsOnText.text];
        return  NO;
    }
    else if (textField==self.currentStartsOnText)
    {
        if (self.currentStartsOnText.text.length > 0) {
            [self disableAllTimeText];
            self.currentEndsOnText.text=@"";
            self.nextStartsOnText.text=@"";
            self.nextEndsOnText.text=@"";
        }
        if (radioFlag==3) {
            [self settingMonthlySemiMonthlyDate];
        }
        timerFlag=1;
        [self.datePicker setDate:[NSDate date]];
        self.datePickerView.hidden=FALSE;
        return  NO;
    }
    else if(textField==self.currentEndsOnText)
    {
        timerFlag=2;
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"d-MM-yyyy"];
        NSDate *currentDate =[formatter1 dateFromString:self.currentStartsOnText.text];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:0];//Max Upto current Year
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        [self.datePicker setMinimumDate:minDate];
        
        self.datePickerView.hidden=false;
        return  NO;
    }
    else if (textField==self.checkBoxText)
    {
        [self checkAction]; //Calling checkAction function
        return  NO;
    }
    else if (textField==self.checkBoxValueText)
    {
        self.monthPayTC.hidden=false;
        return  NO;
    }
    else
    {
        return  YES;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.payRuleNameText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=54) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
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
    else if (textField==self.abbrtext)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
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
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView==self.descriptionTextView)
    {
        if ([text isEqualToString:@""]) {
            return YES;
        }
        if (textView.text.length<=139) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [text characterAtIndex:0];
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
-(IBAction)doneAction:(id)sender
{
    NSString *selectstring=[[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"]componentsJoinedByString:@"###"];
    NSString *typeString;
    switch (radioFlag) {
        case 1:
            typeString=@"daily";
            self.timegapFlag=1;
            break;
        case 2:
            typeString=@"bi-weekly";
            self.timegapFlag=14;
            
            break;
        case 3:
            typeString=@"monthly";
            self.timegapFlag=1;

            
            break;
            
        case 4:
            typeString=@"weekly";
            self.timegapFlag=7;
            
            break;
        case 5:
            typeString=@"semi-month";
            self.timegapFlag=15;
            
            break;
        case 6:
            typeString=@"custom";
            //timeGap=@"14";
            
            break;
            
            
        default:
            
            
            break;
    }
    
    if ((self.payRuleNameText.text.length>0)&&(self.abbrtext.text.length>0)) {
        
        if ([self.updateString isEqualToString:@"0"]) {
            
            [self.myconnection createNewpayrule:self.payRuleNameText.text abbrevation:self.abbrtext.text dessc:self.descriptionTextView.text period_Type:typeString currentStartDate:self.currentStartsOnText.text officeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] selectedDesig:selectstring designationList:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] timegap:self.timegapFlag paymntDate:self.checkBoxValueText.text];
        }
        else{
            [self.myconnection updateNewpayrule:self.payRuleNameText.text abbrevation:self.abbrtext.text dessc:self.descriptionTextView.text officeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] payruleId:[[NSUserDefaults standardUserDefaults]objectForKey:@"payRuleId"] selectedDesig:selectstring designationList:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"]paymntDate:self.checkBoxValueText.text];
        }
    }
    else{
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Warning"
                                   message:@"Must Enter All mandatory Fields"
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

//    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
//    [self removeFromSuperview];
}
-(IBAction)cancelAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)doneTimerAction:(id)sender
{
    NSDate *myDate = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d-MM-yyyy"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    
    if (radioFlag==1) {
        self.currentStartsOnText.text=prettyVersion;
        [self settingDailyPay:self.currentStartsOnText.text];
        [self timeDifferenceCalculation:myDate];
    }
    else if(radioFlag==2)
    {
        self.currentStartsOnText.text=prettyVersion;
        [self settingBiWeeklyPay:self.currentStartsOnText.text];
        [self timeDifferenceCalculation:myDate];
    }
    else if (radioFlag==3)
    {
        self.currentStartsOnText.text=prettyVersion;
        [self settingMonthlyPay:prettyVersion];
        [self timeDifferenceCalculation:myDate];
    }
    else if (radioFlag==4)
    {
        self.currentStartsOnText.text=prettyVersion;
        [self settingWeeklyPay:self.currentStartsOnText.text];
        [self timeDifferenceCalculation:myDate];
    }
    else if (radioFlag==5)
    {
        self.currentStartsOnText.text=prettyVersion;
        [self settingSemiMonthlyPay:prettyVersion];
        [self timeDifferenceCalculation:myDate];
    }
    else if (radioFlag==6)
    {
        if (timerFlag==1) {
            self.currentStartsOnText.text=prettyVersion;
            self.currentEndsOnText.backgroundColor=[UIColor clearColor];
            self.currentEndsOnText.userInteractionEnabled=YES;
            [self timeDifferenceCalculation:myDate];
        }
        else
        {
            self.currentEndsOnText.text=prettyVersion;
            self.currentEndsOnText.textColor=[UIColor blackColor];
            [self settingCustomPay:self.currentStartsOnText.text :self.currentEndsOnText.text];
        }
    }
    self.datePickerView.hidden=true;
}

-(void)disableAllTimeText
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"payAction"] isEqualToString:@"create"]) {
        if (radioFlag==6) {
            self.currentStartsOnText.backgroundColor=[UIColor clearColor];
            self.currentStartsOnText.userInteractionEnabled=YES;
            self.currentStartsOnText.text=@"";
            self.currentEndsOnText.text=@"";
            self.nextStartsOnText.text=@"";
            self.nextStartsOnText.text=@"";
        }
        else
        {
        
            NSDate *today=[NSDate date];
            NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"d-MM-yyyy"];
            self.currentStartsOnText.text=[dateFormat stringFromDate:today];
        
            self.currentStartsOnText.backgroundColor=[UIColor clearColor];
            self.currentStartsOnText.userInteractionEnabled=YES;
        
            self.currentEndsOnText.text=@"";
        }
    }
    else
    {
        self.currentStartsOnText.backgroundColor=[UIColor lightGrayColor];
        self.currentStartsOnText.userInteractionEnabled=NO;
        NSDate *myDate = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"d-MM-yyyy"];
        NSString *prettyVersion = [dateFormat stringFromDate:myDate];
        self.currentStartsOnText.text=prettyVersion;
        
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];//Max Upto current Year
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [self.datePicker setMinimumDate:minDate];
    
    self.currentEndsOnText.backgroundColor=[UIColor lightGrayColor];
    self.currentEndsOnText.userInteractionEnabled=NO;
    self.nextStartsOnText.backgroundColor=[UIColor lightGrayColor];
    self.nextStartsOnText.userInteractionEnabled=NO;
    self.nextEndsOnText.backgroundColor=[UIColor lightGrayColor];
    self.nextEndsOnText.userInteractionEnabled=NO;
}

-(void)settingDailyPay:(NSString *)startsDate
{
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"d-MM-yyyy"];
    NSDate *now =[formatter1 dateFromString:startsDate];
    int daysToAdd = 1;
    NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    self.currentEndsOnText.text=startsDate;
    self.nextEndsOnText.text = self.nextStartsOnText.text = [formatter1 stringFromDate:newDate1];
    self.currentEndsOnText.textColor=[UIColor whiteColor];
    self.nextStartsOnText.textColor=[UIColor whiteColor];
    self.nextEndsOnText.textColor=[UIColor whiteColor];
    
}
-(void)settingBiWeeklyPay:(NSString *)startsDate
{
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"d-MM-yyyy"];
    NSDate *now =[formatter1 dateFromString:startsDate];
    int daysToAdd1 = 13;
    NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd1];
    self.currentEndsOnText.text = [formatter1 stringFromDate:newDate1];
    
    int dayToAdd2=1;
    
    NSDate *newDate2 = [newDate1 dateByAddingTimeInterval:60*60*24 * dayToAdd2];
    self.nextStartsOnText.text = [formatter1 stringFromDate:newDate2];
    
    int dayToAdd3=13;
    NSDate *newDate3 = [newDate2 dateByAddingTimeInterval:60*60*24 * dayToAdd3];
    self.nextEndsOnText.text = [formatter1 stringFromDate:newDate3];
    
    self.currentEndsOnText.textColor=[UIColor whiteColor];
    self.nextStartsOnText.textColor=[UIColor whiteColor];
    self.nextEndsOnText.textColor=[UIColor whiteColor];
    
    
}
-(void)settingWeeklyPay:(NSString *)startsDate
{
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"d-MM-yyyy"];
    NSDate *now =[formatter1 dateFromString:startsDate];
    int daysToAdd1 = 6;
    NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd1];
    self.currentEndsOnText.text = [formatter1 stringFromDate:newDate1];
    
    int dayToAdd2=1;
    
    NSDate *newDate2 = [newDate1 dateByAddingTimeInterval:60*60*24 * dayToAdd2];
    self.nextStartsOnText.text = [formatter1 stringFromDate:newDate2];
    
    int dayToAdd3=6;
    NSDate *newDate3 = [newDate2 dateByAddingTimeInterval:60*60*24 * dayToAdd3];
    self.nextEndsOnText.text = [formatter1 stringFromDate:newDate3];
    
    self.currentEndsOnText.textColor=[UIColor whiteColor];
    self.nextStartsOnText.textColor=[UIColor whiteColor];
    self.nextEndsOnText.textColor=[UIColor whiteColor];
}
-(void)settingMonthlyPay:(NSString *)startsDate
{
    if ([startsDate isEqualToString:@"0"]) {
        
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"d-MM-yyyy"];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *components = [gregorian components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:today];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        components.day = 1;
        
        NSDate *dayOneInCurrentMonth = [gregorian dateFromComponents:components];
        NSString *dateString1 = [dateFormat stringFromDate:dayOneInCurrentMonth];
        self.currentStartsOnText.text=dateString1;
        
        
        
        
        NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay
                                inUnit:NSCalendarUnitMonth
                               forDate:[NSDate date]];
        NSUInteger numberOfDaysInMonth = rng.length;
        
        NSDate *startDate=[dateFormat dateFromString:dateString1];
        NSDate *newDate1 = [startDate dateByAddingTimeInterval:60*60*24*(numberOfDaysInMonth - 1)];
        self.currentEndsOnText.text = [dateFormat stringFromDate:newDate1];
        
        
        components.day = 1;
        components.month=components.month+1;
        
        NSDate *date = [gregorian dateFromComponents:components];
        
        NSString *dateStringnext = [dateFormat stringFromDate:date];
        self.nextStartsOnText.text=dateStringnext;
        
        NSRange range = [cal rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:date];
        NSUInteger numberOfDaysInNextMonth = range.length;
        NSDate *endDate=[dateFormat dateFromString:dateStringnext];
        NSDate *nextDate = [endDate dateByAddingTimeInterval:60*60*24*(numberOfDaysInNextMonth - 1)];
        self.nextEndsOnText.text = [dateFormat stringFromDate:nextDate];
    }
    else
    {
        NSArray *dateArray=[startsDate componentsSeparatedByString:@"-"];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"d-MM-yyyy"];
        
        NSDate *startDate=[dateFormat dateFromString:startsDate];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *components = [gregorian components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:startDate];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        components.day = 1;
        
        NSDate *dayOneInCurrentMonth = [gregorian dateFromComponents:components];
        NSString *dateString1 = [dateFormat stringFromDate:dayOneInCurrentMonth];
        self.currentStartsOnText.text=dateString1;
        
        
        
        
        NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay
                                inUnit:NSCalendarUnitMonth
                               forDate:[dateFormat dateFromString:dateString1]];
        NSUInteger numberOfDaysInMonth = rng.length;
        
        
        NSString *endDate1=[NSString stringWithFormat:@"%d-%@-%@",numberOfDaysInMonth,[dateArray objectAtIndex:1],[dateArray objectAtIndex:2]];
        
        self.currentEndsOnText.text = endDate1;
        
        
        components.day = 1;
        components.month=components.month+1;
        
        NSDate *date = [gregorian dateFromComponents:components];
        
        NSString *dateStringnext = [dateFormat stringFromDate:date];
        self.nextStartsOnText.text=dateStringnext;
        
        NSRange range = [cal rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:date];
        NSUInteger numberOfDaysInNextMonth = range.length;
        NSDate *endDate=[dateFormat dateFromString:dateStringnext];
        NSDate *nextDate = [endDate dateByAddingTimeInterval:60*60*24*(numberOfDaysInNextMonth - 1)];
        self.nextEndsOnText.text = [dateFormat stringFromDate:nextDate];
        
        
        
        
        
    }
    
    
    self.currentEndsOnText.textColor=[UIColor whiteColor];
    self.nextStartsOnText.textColor=[UIColor whiteColor];
    self.nextEndsOnText.textColor=[UIColor whiteColor];
}
-(void)settingSemiMonthlyPay:(NSString *)startsDate
{
    if ([startsDate isEqualToString:@"0"]) {
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"d-MM-yyyy"];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *components = [gregorian components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:today];
        components.day = 1;
        
        NSDate *dayOneInCurrentMonth = [gregorian dateFromComponents:components];
        NSString *dateString1 = [dateFormat stringFromDate:dayOneInCurrentMonth];
        self.currentStartsOnText.text=dateString1;
        
        NSDate *now =[dateFormat dateFromString:dateString1];
        int daysToAdd1 = 14;
        NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd1];
        self.currentEndsOnText.text = [dateFormat stringFromDate:newDate1];
        
        int dayToAdd2=1;
        
        NSDate *newDate2 = [newDate1 dateByAddingTimeInterval:60*60*24 * dayToAdd2];
        self.nextStartsOnText.text = [dateFormat stringFromDate:newDate2];
        
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay
                                inUnit:NSCalendarUnitMonth
                               forDate:newDate2];
        NSUInteger numberOfDaysInMonth = rng.length;
        
        NSDate *startDate=[dateFormat dateFromString:dateString1];
        NSDate *newDate3 = [startDate dateByAddingTimeInterval:60*60*24*(numberOfDaysInMonth - 1)];
        self.nextEndsOnText.text = [dateFormat stringFromDate:newDate3];
    }
    else
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"d-MM-yyyy"];
        
        NSDate *today=[dateFormat dateFromString:startsDate];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *components = [gregorian components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:today];
        components.day = 1;
        
        NSDate *dayOneInCurrentMonth = [gregorian dateFromComponents:components];
        NSString *dateString1 = [dateFormat stringFromDate:dayOneInCurrentMonth];
        self.currentStartsOnText.text=dateString1;
        
        NSDate *now =[dateFormat dateFromString:dateString1];
        int daysToAdd1 = 14;
        NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd1];
        self.currentEndsOnText.text = [dateFormat stringFromDate:newDate1];
        
        int dayToAdd2=1;
        
        NSDate *newDate2 = [newDate1 dateByAddingTimeInterval:60*60*24 * dayToAdd2];
        self.nextStartsOnText.text = [dateFormat stringFromDate:newDate2];
        
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay
                                inUnit:NSCalendarUnitMonth
                               forDate:newDate2];
        NSUInteger numberOfDaysInMonth = rng.length;
        
        NSDate *startDate=[dateFormat dateFromString:dateString1];
        NSDate *newDate3 = [startDate dateByAddingTimeInterval:60*60*24*(numberOfDaysInMonth - 1)];
        self.nextEndsOnText.text = [dateFormat stringFromDate:newDate3];
    }
    
    self.currentEndsOnText.textColor=[UIColor whiteColor];
    self.nextStartsOnText.textColor=[UIColor whiteColor];
    self.nextEndsOnText.textColor=[UIColor whiteColor];
    
    
}

-(void)settingCustomPay:(NSString *)startsDate : (NSString *)endsDate
{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d-MM-yyyy"];
    
    NSDate *startDate = [dateFormat dateFromString:startsDate];
    NSDate *endDate = [dateFormat dateFromString:endsDate];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:NSCalendarWrapComponents];
    
    int difference=[components day];
    self.timegapFlag=difference;
    int dayToAdd2=1;
    
    NSDate *newDate2 = [endDate dateByAddingTimeInterval:60*60*24 * dayToAdd2];
    self.nextStartsOnText.text = [dateFormat stringFromDate:newDate2];
    
    
    NSDate *nextEndDate=[dateFormat dateFromString:self.nextStartsOnText.text];
    NSDate *newDate3 = [nextEndDate dateByAddingTimeInterval:60*60*24 * difference];
    self.nextEndsOnText.text = [dateFormat stringFromDate:newDate3];
    
    
   // self.currentEndsOnText.textColor=[UIColor whiteColor];
    self.nextStartsOnText.textColor=[UIColor whiteColor];
    self.nextEndsOnText.textColor=[UIColor whiteColor];
    
}

-(void)settingMonthlySemiMonthlyDate
{
//    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"d-MM-yyyy"];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDate *currentDate = [dateformatter dateFromString:self.currentStartsOnText.text];
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    [comps setDay:0];//Max Upto current Year
//    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//    
//    [self.datePicker setMaximumDate:minDate];
}
-(void)checkAction
{
    if (x%2==0) {
        [self.checkButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.mandatoryLabel.hidden=false;
        self.checkBoxValueText.backgroundColor=[UIColor clearColor];
        self.checkBoxValueText.userInteractionEnabled=YES;
        self.checkBoxValueText.text=@"";
        x++;
    }
    else
    {
        [self.checkButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.mandatoryLabel.hidden=true;
        self.monthPayTC.hidden=true;
        self.checkBoxValueText.backgroundColor=[UIColor lightGrayColor];
        self.checkBoxValueText.userInteractionEnabled=NO;
        self.checkBoxValueText.text=@"1st";
        x++;
    }
}

-(void)timeDifferenceCalculation:(NSDate *)datePickerDate // Funmction for calculating the differnce between current and datepicker selected date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d-MM-yyyy"];
    NSString *prettyVersion = [dateFormat stringFromDate:datePickerDate];
    
    
    NSTimeInterval secondsBetween = [datePickerDate timeIntervalSinceDate:[NSDate date]];
    
    int numberOfDays = secondsBetween / 86400;
    if(numberOfDays > 0)
    {
        [self alertAction];
    }
    else
    {
        NSString *currentDate=[dateFormat stringFromDate:[NSDate date]];
        NSArray *timeArray=[currentDate componentsSeparatedByString:@"-"];
        NSArray *timeArray1=[prettyVersion componentsSeparatedByString:@"-"];
        if ([[timeArray1 objectAtIndex:0]integerValue] > [[timeArray objectAtIndex:0] integerValue]) {
            [self alertAction];
        }
    }

}
-(void)alertAction //Function for showing alert functionality
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:[NSString stringWithFormat:@"Are you sure you want to set a date after today's date? These employees won't be paid from today until %@",self.currentStartsOnText.text]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                               }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                                 NSDate *myDate=[NSDate date];
                                 NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                                 [dateFormat setDateFormat:@"d-MM-yyyy"];
                                 NSString *prettyVersion = [dateFormat stringFromDate:myDate];
                                 
                                 if (radioFlag==1) {
                                     self.currentStartsOnText.text=prettyVersion;
                                     [self settingDailyPay:self.currentStartsOnText.text];
                                 }
                                 else if(radioFlag==2)
                                 {
                                     self.currentStartsOnText.text=prettyVersion;
                                     [self settingBiWeeklyPay:self.currentStartsOnText.text];
                                 }
                                 else if (radioFlag==3)
                                 {
                                     self.currentStartsOnText.text=prettyVersion;
                                     [self settingMonthlyPay:prettyVersion];
                                 }
                                 else if (radioFlag==4)
                                 {
                                     self.currentStartsOnText.text=prettyVersion;
                                     [self settingWeeklyPay:self.currentStartsOnText.text];
                                 }
                                 else if (radioFlag==5)
                                 {
                                     self.currentStartsOnText.text=prettyVersion;
                                     [self settingSemiMonthlyPay:prettyVersion];
                                 }
                                 else if (radioFlag==6)
                                 {
                                     if (timerFlag==1) {
                                         self.currentStartsOnText.text=prettyVersion;
                                         self.currentEndsOnText.backgroundColor=[UIColor clearColor];
                                         self.currentEndsOnText.userInteractionEnabled=YES;
                                     }
                                 }

                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });

}
-(void)viewAllPayResponse:(id)responseList
{
    if ([responseList count]>0) {
        
        
        paySettingsViewClass *ob1 = (paySettingsViewClass *)self.superview.superview;
        
        [ob1 viewAllPayResponse:responseList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
            
        });
        
        
    }
    else
    {
        
        [self showalerviewcontroller:@"Connection Failed"];
    }
    
    
}
-(void)viewIndividualPayResponse:(id)responseList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.updateString=@"1";
        [[NSUserDefaults standardUserDefaults]setObject:[[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"id"] forKey:@"payRuleId"];
        self.payRuleNameText.text=[[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"rule_name"];
        self.abbrtext.text=[[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"abr"];
        if ([[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"payment_date"]!=(id)[NSNull null])
        {
        self.checkBoxValueText.text=[[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"payment_date"];
        }
        if ([[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"description"]!=(id)[NSNull null])
        {
            self.descriptionTextView.text=[[[responseList objectForKey:@"payroll_details"]objectAtIndex:0]objectForKey:@"description"];
        }
        [self dateformatFuction:[[responseList objectForKey:@"payment_details"]objectForKey:@"current_pay_start"]];
        self.currentStartsOnText.text=self.fomatDateString;
        [self dateformatFuction:[[responseList objectForKey:@"payment_details"]objectForKey:@"current_pay_end"]];
        self.currentEndsOnText.text=self.fomatDateString;
        [self dateformatFuction:[[responseList objectForKey:@"payment_details"]objectForKey:@"next_pay_start"]];
        self.nextStartsOnText.text=self.fomatDateString;
        [self dateformatFuction:[[responseList objectForKey:@"payment_details"]objectForKey:@"next_pay_end"]];
        self.nextEndsOnText.text=self.fomatDateString;
        [self.grouparray removeAllObjects];
        for (int j=0; j<[[[responseList objectForKey:@"selected_designation"]objectForKey:@"office"]count]; j++) {
            NSMutableDictionary *localDict1=[[[responseList objectForKey:@"selected_designation"]objectForKey:@"office"] objectAtIndex:j];
            NSString *myString=[NSString stringWithFormat:@"%@:%@",[localDict1 objectForKey:@"office_name"],[localDict1 objectForKey:@"designation_title"]];
            [self.grouparray addObject:myString];
        }
        for (int j=0; j<[[[responseList objectForKey:@"selected_designation"]objectForKey:@"store"]count]; j++) {
            NSMutableDictionary *localDict1=[[[responseList objectForKey:@"selected_designation"]objectForKey:@"store"] objectAtIndex:j];
            NSString *myString=[NSString stringWithFormat:@"%@:%@",[localDict1 objectForKey:@"store_name"],[localDict1 objectForKey:@"designation_title"]];
            [self.grouparray addObject:myString];
        }
        [self.mycollectionview reloadData];
        if ([[[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"period_settings"] isEqualToString:@"daily"]) {
            [self resetButtonImageFunction:1];
        }
        
        if ([[[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"period_settings"] isEqualToString:@"bi-weekly"]) {
            [self resetButtonImageFunction:2];
        }
        if ([[[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"period_settings"] isEqualToString:@"monthly"]) {
            [self resetButtonImageFunction:3];
        }
        if ([[[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"period_settings"] isEqualToString:@"weekly"]) {
            [self resetButtonImageFunction:4];
        }
        if ([[[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"period_settings"] isEqualToString:@"semi-month"]) {
            [self resetButtonImageFunction:5];
        }
        if ([[[[responseList objectForKey:@"payroll_details"] objectAtIndex:0]objectForKey:@"period_settings"] isEqualToString:@"custom"]) {
            [self resetButtonImageFunction:6];
        }
        self.radioButton1.userInteractionEnabled=NO;
        self.radioButton2.userInteractionEnabled=NO;
        self.radioButton3.userInteractionEnabled=NO;
        self.radioButton4.userInteractionEnabled=NO;
        self.radioButton5.userInteractionEnabled=NO;
        self.radioButton6.userInteractionEnabled=NO;
        self.radioText1.userInteractionEnabled=NO;
        self.radioText2.userInteractionEnabled=NO;
        self.radioText3.userInteractionEnabled=NO;
        self.radioText4.userInteractionEnabled=NO;
        self.radioText5.userInteractionEnabled=NO;
        self.radioText6.userInteractionEnabled=NO;
        
        
    });
    
    
    
}
//....reset radio button image finction
-(void)resetButtonImageFunction:(int)idValue;
{
    [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
    [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
    [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
    [self.radioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
    [self.radioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
    [self.radioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
    switch (idValue) {
        case 1:
            [self.radioButton1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            
            break;
        case 2:
            [self.radioButton2 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            
            break;
        case 3:
            [self.radioButton3 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            if ([self.checkBoxValueText.text isEqualToString:@"1st"]) {
                self.checkBoxValueText.backgroundColor=[UIColor lightGrayColor];
                [self.checkButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.checkBoxValueText.userInteractionEnabled=NO;

            }
            else{
                [self.checkButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.checkBoxValueText.backgroundColor=[UIColor clearColor];
                self.checkBoxValueText.userInteractionEnabled=YES;
            }
            self.monthlyCheckBoxView.hidden=false;
            self.mandatoryLabel.hidden=false;
            self.checkButton.userInteractionEnabled=YES;
            self.mandatoryLabel.userInteractionEnabled=YES;
            self.checkBoxText.userInteractionEnabled=YES;
            break;
        case 4:
            [self.radioButton4 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            
            break;
        case 5:
            [self.radioButton5 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            
            break;
        case 6:
            [self.radioButton6 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            
            break;
            
        default:
            break;
    }
    
}
//.....dateFormating function
-(void)dateformatFuction:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:dateString];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    self.fomatDateString = [formatter stringFromDate:date];
    NSLog(@"%@",self.fomatDateString);
}
-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning..."
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
