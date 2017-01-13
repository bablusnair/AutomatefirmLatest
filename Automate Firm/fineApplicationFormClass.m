//
//  fineApplicationFormClass.m
//  Automate Firm
//
//  Created by leonine on 9/17/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "fineApplicationFormClass.h"
#import "documentflowcellclass.h"

@implementation fineApplicationFormClass

-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    self.firstArray=[[NSMutableArray alloc] initWithObjects:@"The govt. attestation document is not attached",@"I request you to pls do the needy",@"Attach the medical report", nil];
    
    self.firstView.hidden=TRUE;
    
    [self.collectionView2 registerNib:[UINib nibWithNibName:@"advancedplusCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"signaturecell"];
    self.stamparray=[[NSMutableArray alloc]initWithObjects:@"important-290x100_1.jpg",@"RejectedStamp.jpg",@"urgent-stamp-md.png",@"receivednew.jpeg",@"important-290x100_1.jpg",nil];
    self.stamparray1=[[NSMutableArray alloc]initWithObjects:@"overdue.png",@"final_notice_stamp.png",@"expired.png",@"newconfident.jpeg",@"copy2.jpg",nil];
    [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[UIDatePicker class]]]
     setBackgroundColor:[UIColor clearColor]];
    self.violationsArray=[[NSMutableArray alloc]init];
    self.violationIDArray=[[NSMutableArray alloc]init];
    
    NSDate *date=[NSDate date];
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd/MMM/yyyy"];
    self.appleDateLabel.text=[df stringFromDate:date];
    
    
    self.violationTypeTC.layer.borderWidth = 1.0;
    self.violationTypeTC.layer.borderColor = [UIColor blackColor].CGColor;
    self.violationTypeTC.separatorInset = UIEdgeInsetsZero;
    self.violationTypeTC.layoutMargins = UIEdgeInsetsZero;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];//Max Upto current Year
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:date options:0];//Setting maximum entry as current date
    [self.datePicker setMaximumDate:maxDate];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(empSelection) name:@"empSelection" object:Nil];
    
    for (UIView *view in self.myscrollView.subviews) {
        if (view.tag==100) {
            for (UIView *myview in view.subviews) {
                if (myview.tag==100) {
                    for (UIView *subview in myview.subviews) {
                        if ([subview isKindOfClass:[UIButton class]]) {
                            if (subview.tag==100) {
                                subview.userInteractionEnabled=YES;
                            }
                            else
                                subview.userInteractionEnabled=NO;
                        }
                        else
                            subview.userInteractionEnabled=NO;
                    }
                }
                else
                {
                    myview.userInteractionEnabled=NO;
                }
            }
        }
        else
            view.userInteractionEnabled=NO;
    }
    
    
    
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
    if (tableView==self.firstTableView) {
        
        return self.firstArray.count;
    }
    if (tableView==self.violationTypeTC) {
        return self.violationsArray.count;
    }
    
    else
        return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.firstTableView) {
        
        documentsRemarksTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"documentsRemarksTableCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.remarksLabel.text=[self.firstArray objectAtIndex:indexPath.row];
        return cell;
        
    }
    if (tableView==self.violationTypeTC) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.violationsArray objectAtIndex:indexPath.row];
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.textLabel.font=[UIFont systemFontOfSize:13];
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
    if (tableView==self.violationTypeTC) {
        self.violationTypeLabel.text=[[self.violationsArray objectAtIndex:indexPath.row]substringToIndex:2];
        self.formTitleLabel.text= [NSString stringWithFormat:@"FINE FORM (%@)",[self.violationsArray objectAtIndex:indexPath.row]];
         [self.myconnection listCorrespondingFineDetails:[self.violationIDArray objectAtIndex:indexPath.row]];
        
        self.violationTypeTC.hidden=TRUE;
    }
}
-(IBAction)datePickerAction:(id)sender
{
    
    NSDate *myDate = self.datePicker.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    
    self.violationDate.text=prettyVersion;
    self.datePickerView.hidden=TRUE;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.violationDate) {
        self.datePickerView.hidden=FALSE;
        
    }
    return NO;
}

-(IBAction)tileButtonClicked:(id)sender
{
    if (self.x%2==0) {
        self.firstView.hidden=FALSE;
        self.x++;
        
    }
    else
    {
        self.firstView.hidden=TRUE;
        self.x++;
    }
}

-(IBAction)dropDownAction:(id)sender
{
    self.violationTypeTC.hidden=FALSE;
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

-(IBAction)employeeSelectionAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"fine" forKey:@"popupType"];
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"employeeSelectionView" owner:self options:nil];
    [self.superview.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    
    
}

-(void)empSelection
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
    self.empIcon.layer.cornerRadius = 50;
    self.empIcon.layer.masksToBounds = YES;
    self.empIcon.clipsToBounds=YES;
    self.empNameLabel.text=[empArray objectAtIndex:2];
    self.empIDLabel.text=[empArray objectAtIndex:4];
    
    
    

    [self.myconnection listingFineandEmpDetails:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] :self.empID];
    
    for (UIView *view in self.myscrollView.subviews) {
        if (view.tag==100) {
            for (UIView *myview in view.subviews) {
                if (myview.tag==100) {
                    for (UIView *subview in myview.subviews) {
                        subview.userInteractionEnabled=YES;
                    }
                }
                else
                {
                    myview.userInteractionEnabled=YES;
                }
            }
        }
        else
            view.userInteractionEnabled=YES;
    }
}


-(void)viewAllResponse:(id)responseList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.violationIDArray removeAllObjects];
        [self.violationsArray removeAllObjects];
        NSMutableDictionary *empDict=[[responseList objectForKey:@"employee_details"]objectAtIndex:0];
        
        
        NSLog(@"%@",empDict);
        self.officeLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeAbbrv"];
        self.workingPremiseLabel.text=[empDict objectForKey:@"abbreviation"];
        self.departmentLabel.text=[empDict objectForKey:@"department_name"];
        self.designationLabel.text=[empDict objectForKey:@"designation_title"];
       
        if ([[responseList objectForKey:@"employee_nationality"] count]>0) {
            self.nationalityLabel.text=[[[responseList objectForKey:@"employee_nationality"] objectAtIndex:0] objectForKey:@"name"];
        }
        
        self.passportNOLabel.text=[empDict objectForKey:@"emp_passport_no"];
        self.visaLabel.text=[empDict objectForKey:@"emp_visa_expiry"];
        
        NSMutableArray *violationArray=[responseList objectForKey:@"fine_details"];
        for (int i=0; i<violationArray.count; i++) {
            NSMutableDictionary *violationDict=[violationArray objectAtIndex:i];
            [self.violationsArray addObject:[violationDict objectForKey:@"violation_name"]];
            [self.violationIDArray addObject:[violationDict objectForKey:@"fine_id"]];
        }
        
        [self.violationTypeTC reloadData];
    });
}
-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *fineDict=[[responseData objectForKey:@"fine_other_dtls"]objectAtIndex:0];
        self.fineAmountText.text=[fineDict objectForKey:@"fine_amount"];
        self.warningLabel.text=[fineDict objectForKey:@"max_warnings"];
        int installment=[self.fineAmountText.text integerValue]/[[fineDict objectForKey:@"max_installments"] integerValue];
        self.installmentsText.text=[NSString stringWithFormat:@"%d",installment];
        
    });
}
@end
