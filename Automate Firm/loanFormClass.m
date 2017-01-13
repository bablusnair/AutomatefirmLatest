//
//  loanFormClass.m
//  Automate Firm
//
//  Created by leonine on 9/21/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "loanFormClass.h"
#import "advancedplusCollectionViewCell.h"
#import "homeViewController.h"

@implementation loanFormClass
- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    self.firstArray=[[NSMutableArray alloc] initWithObjects:@"The govt. attestation document is not attached",@"I request you to pls do the needy",@"Attach the medical report", nil];
    
    self.firstView.hidden=TRUE;
    
    
    [ self.mycollectionview registerNib:[UINib nibWithNibName:@"advancedplusCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"signaturecell"];
    self.stamparray=[[NSMutableArray alloc]initWithObjects:@"important-290x100_1.jpg",@"RejectedStamp.jpg",@"urgent-stamp-md.png",@"receivednew.jpeg",@"important-290x100_1.jpg",nil];
    self.stamparray1=[[NSMutableArray alloc]initWithObjects:@"overdue.png",@"final_notice_stamp.png",@"expired.png",@"newconfident.jpeg",@"copy2.jpg",nil];
    self.loanTypeArray=[[NSMutableArray alloc] initWithObjects:@"Housing",@"Vehicle",@"Education",@"Financial",@"Agricultural", nil];
    self.flag=0;
    self.x=0;
    [[UITableView appearanceWhenContainedIn:[UIDatePicker class], nil] setBackgroundColor:nil];
    
    NSDate *date=[NSDate date];
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd/MMM/yyyy"];
    self.applicationDateLabel.text=self.paymentDateText.text=[df stringFromDate:date];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(empSelection) name:@"empSelection" object:Nil];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    advancedplusCollectionViewCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"signaturecell" forIndexPath:indexPath];
    [cell1.stampicon setImage:[UIImage imageNamed:[self.stamparray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    [cell1.stampicon1 setImage:[UIImage imageNamed:[self.stamparray1 objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    return cell1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.LoanTypeTC) {
        return self.loanTypeArray.count;
    }
    if (tableView==self.firstTableView) {
        
        return self.firstArray.count;
    }
    
    else
        return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.LoanTypeTC) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.loanTypeArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return cell;
    }
    else if (tableView==self.firstTableView) {
        
        documentsRemarksTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"documentsRemarksTableCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.remarksLabel.text=[self.firstArray objectAtIndex:indexPath.row];
        return cell;
        
    }
    else
    {
        
        documentflowcellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"simlecell2"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"documentflowtablecell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.LoanTypeTC)
    {
        self.LoanLabel.text=[self.loanTypeArray objectAtIndex:indexPath.row];
        self.LoanTypeTC.hidden=true;
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.numberInstallment) {
        [self alertAction:@"Max. permitted duration is only 3 Years"];
        return YES;
    }
    else if (textField==self.pendingLoanAmount)
    {
        [self alertAction:@"Cannot issue this loan since pending loan amounts are > KWD"];
        
        return NO;
    }
    else if (textField==self.dateJoining)
    {
        [self alertAction:@"An employee should complete  3 Months in the firm to be eligible for this loan"];
        
        return NO;
    }
    else if (textField==self.leaveApplications)
    {
        [self alertAction:@"Time to next approved leave should be                        >  3 months for loan request acceptance"];
        
        return NO;
    }
    else if (textField==self.lastWorkingDay)
    {
        [self alertAction:@"Last working day should be < 2 months"];
        
        return NO;
    }
    else if(textField==self.paymentDateText)
    {
        self.datePickerView.hidden=FALSE;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:0];//Max Upto current Year
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"d MMM yyyy"];
        NSString *today=[dateFormat stringFromDate:currentDate];
        NSArray *dateArray=[today componentsSeparatedByString:@" "];
        NSString *maximumTime=[NSString stringWithFormat:@"%@ %@ %d",[dateArray objectAtIndex:0],[dateArray objectAtIndex:1],[[dateArray objectAtIndex:2] intValue]+1];
        NSDate *maxDates=[dateFormat dateFromString:maximumTime];
        [self.datePicker setMaximumDate:maxDates];
        [self.datePicker setMinimumDate:minDate];
        
        self.flag=1;
        return NO;
    }
    else if (textField==self.deductDateText)
    {
        self.datePickerView.hidden=FALSE;
        self.flag=2;
        return NO;
    }
    
    
    else if (textField==self.visaExpiry)
    {
        [self alertAction:@"Duration for Visa Expiration should be > 3 Months"];
        
        return NO;
    }
    else
    {
        return  YES;
    }
}
-(IBAction)dropDown1:(id)sender
{
    self.LoanTypeTC.hidden=false;
}
-(IBAction)tileButtonClicked:(id)sender
{
    if (self.y%2==0) {
        self.firstView.hidden=FALSE;
        self.y++;
        
    }
    else
    {
        self.firstView.hidden=TRUE;
        self.y++;
    }
}
-(IBAction)dateChanged:(id)sender
{
    NSDate *myDate = self.datePicker.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    if (self.flag==1) {
        self.paymentDateText.text=prettyVersion;
        self.datePickerView.hidden=TRUE;
    }
    else
    {
        self.deductDateText.text=prettyVersion;
        self.datePickerView.hidden=TRUE;
    }
    
}

-(IBAction)signatureAction:(id)sender
{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"signaturethumbview" owner:self options:nil];
    [self addSubview:[nib objectAtIndex:0]];
    
    
}
-(IBAction)stampButtonAction:(id)sender
{
    NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"pjtgenatedcollectionviewscreen" owner:self options:Nil];
    [self addSubview:[myviewarray objectAtIndex:0]];
}

-(IBAction)prioritybutton1action:(id)sender
{
    //priority icon green unclick.png
    //priority icon green.png
    //priority icon red unclick.png
    //priority icon red.png
    //priority icon yellow unclick.png
    //priority icon yellow.png
    [self.priorityButton1 setImage:[UIImage imageNamed:@"priority icon yellow.png"] forState:UIControlStateNormal];
    [self.priorityButton2 setImage:[UIImage imageNamed:@"priority icon green unclick.png"] forState:UIControlStateNormal];
    [self.priorityButton3 setImage:[UIImage imageNamed:@"priority icon red unclick.png"] forState:UIControlStateNormal];
}
-(IBAction)prioritybutton2action:(id)sender
{
    [self.priorityButton1 setImage:[UIImage imageNamed:@"priority icon yellow unclick.png"] forState:UIControlStateNormal];
    [self.priorityButton2 setImage:[UIImage imageNamed:@"priority icon green.png"] forState:UIControlStateNormal];
    [self.priorityButton3 setImage:[UIImage imageNamed:@"priority icon red unclick.png"] forState:UIControlStateNormal];
}
-(IBAction)prioritybutton3action:(id)sender
{
    [self.priorityButton1 setImage:[UIImage imageNamed:@"priority icon yellow unclick.png"] forState:UIControlStateNormal];
    [self.priorityButton2 setImage:[UIImage imageNamed:@"priority icon green unclick.png"] forState:UIControlStateNormal];
    [self.priorityButton3 setImage:[UIImage imageNamed:@"priority icon red.png"] forState:UIControlStateNormal];
}

-(void)alertAction:(NSString *)alertMsg
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:[NSString stringWithFormat:@"%@",alertMsg]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   [self.numberInstallment becomeFirstResponder];
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(homeViewController *)[self.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}

- (IBAction) empSelectionAction :(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"loan" forKey:@"popupType"];
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"employeeSelectionView" owner:self options:nil];
    [self.superview.superview.superview.superview addSubview:[nib objectAtIndex:0]];
}
- (void) empSelection
{
    NSMutableArray *empArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectedEmp"];
    self.empID=[empArray objectAtIndex:0];
    
    if (!([[empArray objectAtIndex:1]isEqualToString:@""])) {
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[empArray objectAtIndex:1] options:0];
        
        self.empIcon.image=[UIImage imageWithData:decodedData];
    }
    else
    {
        self.empIcon.image=[UIImage imageNamed:@"user.png"];
    }
    self.empIcon.layer.cornerRadius = 42.5;
    self.empIcon.layer.masksToBounds = YES;
    self.empIcon.clipsToBounds=YES;
    self.empNameLabel.text=[empArray objectAtIndex:2];
    self.empIDLabel.text=[empArray objectAtIndex:4];
    
    
    
    
    [self.myconnection employeeindividualServicedata:self.empID];
}




//--------------------------------Service Part----------------------------------

-(void)employeeindividualGotreponsedata:(NSMutableDictionary *)idresponsedict
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *empDict=[idresponsedict objectForKey:@"basic_info"];
        
        self.officeNameLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeAbbrv"];
        
        if ([[empDict objectForKey:@"emp_premise_type"]isEqualToString:@"O"]) {
            self.workingPremiseLabel.text=[empDict objectForKey:@"abbreviation"];
        }
        else
        {
            self.workingPremiseLabel.text=[empDict objectForKey:@"abbreviation"];
        }
        
        self.departmentLabel.text=[empDict objectForKey:@"department_name"];
        
        self.designationLabel.text=[empDict objectForKey:@"designation_title"];
        
        if ([empDict objectForKey:@"emp_nation_name"]!=(id)[NSNull null]) {
            self.nationalityLabel.text=[empDict objectForKey:@"emp_nation_name"];
        }
        
        self.passportNOLabel.text=[empDict objectForKey:@"emp_passport_no"];
        
        NSDateFormatter *df=[[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd"];
        NSDate *date1=[df dateFromString:[empDict objectForKey:@"emp_visa_expiry"]];
        [df setDateFormat:@"dd-MM-yyyy"];
        
        self.visaExpiry.text=[df stringFromDate:date1];
        
        
        
        
        NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"yyyy-MM-dd"];
        NSString *dojString=[empDict objectForKey:@"emp_date_of_join"];
        NSDate *doj=[dateFormater dateFromString:dojString];
        [dateFormater setDateFormat:@"dd-MM-yyyy"];
        self.dateJoining.text=[dateFormater stringFromDate:doj];
        
        //self.categoryLabel.text=[empDict objectForKey:@"cat_name"];
    });
    
    
}
- (IBAction)newEmpSignAction:(id)sender {
    
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"newSignatureView" owner:self options:nil];
    UIView *view=[nib objectAtIndex:0];
    [view setFrame:CGRectMake(180, 700, 591, 299)];
    [self.formView addSubview:view];
    
    
}
@end
