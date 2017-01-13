
//
//  addnewemployee1Class.m
//  bablusdemokpproject
//
//  Created by leonine on 8/20/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.


#import "addnewemployee1Class.h"
#import "addnewemployeeclass.h"
#import "ViewController.h"
#import "custumclasscell.h"
#import "Customcell1.h"
#import "staffinghomeview.h"
#import "homeViewController.h"



@implementation addnewemployee1Class
@synthesize myarray,nationalityFlag,actionFlag,personalDetailsDict,imageFlag;
-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc] init];
    self.myconnection.mydelegate=self;
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.empDict=[[NSMutableDictionary alloc]init];
    
    [self clearFunction];
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"empID"];
    
    [self.myconnection displayNationality];//function call for displaying all nationality
    [self.myconnection addNewEmployeeOfficeDisplayDetails:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];
    
    
    self.myarray=[[NSMutableArray alloc] initWithObjects:@"Eletrictions",@"Helpers",@"Maintaintence",@"Foremen",@"Technicians",@"Duty Fliters",@"Drivers", nil];
    self.bloodgroupArray=[[NSMutableArray alloc] initWithObjects:@"A+",@"A-",@"B+",@"B-",@"AB+",@"AB-",@"O+",@"O-", nil];
    self.martialarray=[[NSMutableArray alloc] initWithObjects:@"Single",@"Married",@"Living Common Law",@"Widowed",@"Separated",@"Divorced", nil];
    self.genderArray=[[NSMutableArray alloc] initWithObjects:@"Male",@"Female", nil];
    self.ratearray=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    
    self.skillsservicearray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.serviceyeararray=[[NSMutableArray alloc] initWithObjects:@"", nil];
    
    self.degreearray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.institutionarray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    
    self.descriptionarray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.experiance=[[NSMutableArray alloc]initWithObjects:@"", nil];
    
    self.custumcellmainarray=[[NSMutableArray alloc] initWithObjects:@"", nil];
    
    self.custumcellmainarray2=[[NSMutableArray alloc] initWithObjects:@"", nil];
    
    self.banknamearray=[[NSMutableArray alloc] init];
    self.filterarraycountry=[[NSMutableArray alloc] init];
    self.contentList2=[[NSMutableArray alloc] init];
    self.departmentarray=[[NSMutableArray alloc] init];
    self.designationarray=[[NSMutableArray alloc] init];
    self.categoryarray=[[NSMutableArray alloc] init];
    self.countrydict=[[NSMutableDictionary alloc] init];
    self.yeararray=[[NSMutableArray alloc] init];
    self.bankIDArray=[[NSMutableArray alloc]init];
    self.workingPremiseArray=[[NSMutableArray alloc]init];
    self.workingPremiseIDArray=[[NSMutableArray alloc]init];
    self.departmentIDArray=[[NSMutableArray alloc]init];
    self.categoryIDArray=[[NSMutableArray alloc]init];
    self.designationIDArray=[[NSMutableArray alloc]init];
    self.educationArray=[[NSMutableArray alloc]init];
    self.skillsArray=[[NSMutableArray alloc]init];
    self.employeeCodeArray=[[NSMutableArray alloc]init];
    self.workingPremiseCodeArray=[[NSMutableArray alloc]init];
    self.departmentCodeArray=[[NSMutableArray alloc]init];
    self.categoryCodeArray=[[NSMutableArray alloc]init];
    
    self.workingPremiseTableView.hidden=true;
    self.bloodgrouptableview.hidden=TRUE;
    self.gendertableview.hidden=TRUE;
    self.martialstatustableview.hidden=TRUE;
    self.nationalitytableview.hidden=TRUE;
    self.datepickerviewfirst.hidden=TRUE;
    self.datepickerviewsecond.hidden=TRUE;
    self.visaexpiryview.hidden=TRUE;
    self.yeartableview.hidden=TRUE;
    self.rateingtableview.hidden=TRUE;
    self.banknametableview.hidden=TRUE;
    self.departmenttableview.hidden=TRUE;
    self.designationtableview.hidden=TRUE;
    self.categorytableiew.hidden=TRUE;
    
    nationalityFlag=0;
    self.y=0;
    actionFlag=self.warningFlag=0;
    imageFlag=0;
    
    self.empID=@"0";
    self.nationalityID=@"";
    self.workingPremiseID=@"";
    self.departmentID=@"";
    self.categoryID=@"";
    self.designationID=@"";
    self.bankID=@"";
    self.employeeCode=@"";
    self.workingPremiseType=@"";
    
   //Datepicker appearance and setting maximum and minimum date
    [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[UIDatePicker class]]]
    setBackgroundColor:[UIColor clearColor]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];//Max Upto current Year
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];//Setting maximum entry as current date
    [comps setYear:-60];//Minimum upto 60 years back
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [self.mydatepicker setMaximumDate:maxDate];
    [self.mydatepicker setMinimumDate:minDate];
    
    
    //For setting date of joining as (current year + 1) Dec 31
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d MMM yyyy"];
    NSString *today=[dateFormat stringFromDate:currentDate];
    NSArray *dateArray=[today componentsSeparatedByString:@" "];
    NSString *maximumTime=[NSString stringWithFormat:@"31 Dec %d",[[dateArray objectAtIndex:2] intValue]+1];
    NSDate *maxDates=[dateFormat dateFromString:maximumTime];
    [self.mydatepickersecond setMaximumDate:maxDates];
    [self.mydatepickersecond setMinimumDate:minDate];

    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //Loading year from 1990 to current year
    int currentYear= [[dateArray objectAtIndex:2] intValue];
    for (int year=1990; year<=currentYear; year++) {
        NSString *years=[NSString stringWithFormat:@"%d",year];
        [self.yeararray addObject:years];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backFunction) name:@"back" object:Nil];
    
    UITapGestureRecognizer *myTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    myTap.numberOfTouchesRequired=1;
    [self addGestureRecognizer:myTap];
    for (UIView *myview in self.scrollView.subviews) {
        for (UIView *views in myview.subviews) {
            [views addGestureRecognizer:myTap];
        }
        
    }
}
-(void)fillDetails
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *educationArray=[self.empDict objectForKey:@"education"];
        NSMutableArray *skillsArray=[self.empDict objectForKey:@"skill"];
        NSMutableDictionary *personalDict=[self.empDict objectForKey:@"basic_info"];
        
        if (!([[personalDict objectForKey:@"emp_encode_image"]isEqualToString:@""])) {
            NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[personalDict objectForKey:@"emp_encode_image"] options:0];
            
            self.employeeprofilepic.image=[UIImage imageWithData:decodedData];
        }
        else
        {
            self.employeeprofilepic.image=[UIImage imageNamed:@"user.png"];
        }
        self.empID=[personalDict objectForKey:@"emp_id"];
        [[NSUserDefaults standardUserDefaults]setObject:[personalDict objectForKey:@"emp_code"] forKey:@"empID"];
        self.employeeNameTextField.text=[personalDict objectForKey:@"emp_name"];
        self.employeeCode=self.employeecodeTextField.text=[personalDict objectForKey:@"e_code"];
            
        self.empCode=[NSString stringWithFormat:@"%@",[personalDict objectForKey:@"emp_code"]];
        [self.barcodeTextView setText: [NSString stringWithFormat:@"(%@)",[personalDict objectForKey:@"emp_code"]]];
        [self.barcodeTextView setFont:[UIFont fontWithName:@"IDAutomationHC39M" size:16.0]];
        if ([[personalDict objectForKey:@"emp_gender"]isEqualToString:@"M"]) {
            self.gendertextfield.text=@"Male";
        }
        else
        {
            self.gendertextfield.text=@"Female";
        }
        NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"yyyy-MM-dd"];
        NSString *dobString=self.dateofbirthstring=[personalDict objectForKey:@"emp_dob"];
        NSDate *dob=[dateFormater dateFromString:dobString];
        [dateFormater setDateFormat:@"dd MMM yyyy"];
        self.dateofbirthtextfield.text=[dateFormater stringFromDate:dob];
        self.martialtextfield.text=[personalDict objectForKey:@"emp_marital_ststus"];
        self.bloodtextfield.text=[personalDict objectForKey:@"emp_blood_group"];
            
        [dateFormater setDateFormat:@"yyyy-MM-dd"];
        NSString *dojString=self.dateofjoingstring=[personalDict objectForKey:@"emp_date_of_join"];
        NSDate *doj=[dateFormater dateFromString:dojString];
        [dateFormater setDateFormat:@"dd-MMM-yyyy"];
        self.dateofjoiningtextfield.text=[dateFormater stringFromDate:doj];
        
        if ([personalDict objectForKey:@"emp_nation_name"]!=(id)[NSNull null]) {
            self.nationalitytextfield.text=[personalDict objectForKey:@"emp_nation_name"];
        }
        self.nationalityID=[personalDict objectForKey:@"emp_nationality"];
        if ([[personalDict objectForKey:@"emp_premise_type"]isEqualToString:@"O"]) {
            self.officetextfield.text=[personalDict objectForKey:@"office_name"];
            self.workingPremiseType=@"O";
        }
        else
        {
            self.officetextfield.text=[personalDict objectForKey:@"store_name"];
            self.workingPremiseType=@"S";
        }
        self.workingPremiseID=[personalDict objectForKey:@"emp_working_premise"];
        self.departmentID=[personalDict objectForKey:@"emp_department"];
        self.departmenttextfield.text=[personalDict objectForKey:@"department_name"];
        self.departmenttextfield.backgroundColor=[UIColor clearColor];
        self.departmenttextfield.userInteractionEnabled=YES;
        self.categoryID=[personalDict objectForKey:@"emp_category"];
        self.categorytextfield.text=[personalDict objectForKey:@"cat_name"];
        self.categorytextfield.backgroundColor=[UIColor clearColor];
        self.categorytextfield.userInteractionEnabled=YES;
        self.designationID=[personalDict objectForKey:@"emp_designation"];
        self.designationtextfield.text=[personalDict objectForKey:@"designation_title"];
        self.designationtextfield.backgroundColor=[UIColor clearColor];
        self.designationtextfield.userInteractionEnabled=YES;
        self.passportNoTextField.text=[personalDict objectForKey:@"emp_passport_no"];
            
        [dateFormater setDateFormat:@"yyyy-MM-dd"];
        NSString *visaExpiry=self.visaexpirystring=[personalDict objectForKey:@"emp_visa_expiry"];
        NSDate *visa=[dateFormater dateFromString:visaExpiry];
        [dateFormater setDateFormat:@"dd MMM yyyy"];
        self.visaexpirytextfield.text=[dateFormater stringFromDate:visa];
            
        self.labourCardNoTextField.text=[personalDict objectForKey:@"emp_labour_card_no"];
        self.nationalIDNoTextField.text=[personalDict objectForKey:@"emp_national_id"];
        self.pfNoTextField.text=[personalDict objectForKey:@"emp_provident_fund"];
        self.incomeTaxNoTextField.text=[personalDict objectForKey:@"emp_income_tax_no"];
        self.esiNoTextField.text=[personalDict objectForKey:@"emp_esi_no"];
        if ([personalDict objectForKey:@"bank_name"]!=(id)[NSNull null]) {
            self.banknametextfield.text=[personalDict objectForKey:@"bank_name"];
        }
        else
            self.banknametextfield.text=@"";
            
        self.bankID=[personalDict objectForKey:@"emp_bank_name"];
        self.bankAccountNoTextField.text=[personalDict objectForKey:@"emp_bank_acc_no"];
        self.wpsNoTextField.text=[personalDict objectForKey:@"emp_wps_id"];
            
        for (int i=0; i<educationArray.count; i++) {
            NSMutableDictionary *educationDict=[educationArray objectAtIndex:i];
            [self.degreearray insertObject:[educationDict objectForKey:@"degree"]atIndex:i];
            [self.institutionarray insertObject:[educationDict objectForKey:@"institution"]atIndex:i];
            [self.serviceyeararray insertObject:[educationDict objectForKey:@"year"]atIndex:i];
        }
        for (int i=0; i<skillsArray.count; i++) {
            NSMutableDictionary *skillsDict=[skillsArray objectAtIndex:i];
            [self.descriptionarray insertObject:[skillsDict objectForKey:@"description"]atIndex:i];
            [self.experiance insertObject:[skillsDict objectForKey:@"experience"]atIndex:i];
            [self.skillsservicearray insertObject:[skillsDict objectForKey:@"proficiency_level"]atIndex:i];
        }
            
            
        [self.mytableview reloadData];
        [self.skillsTableView reloadData];
            
        
        
    });
}
-(void)tapAction
{
    for (UIView *myview in self.scrollView.subviews) {
        for (UIView *views in myview.subviews) {
            if ([views isKindOfClass:[UITableView class]]) {
                views.hidden=true;
            }
        }
        
    }

}
-(void)backFunction
{
    [app hudStop];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"action"] isEqualToString:@"cancel"]) {
        [self.degreearray addObject:@""];
        [self.institutionarray addObject:@""];
        [self.serviceyeararray addObject:@""];
        [self.descriptionarray addObject:@""];
        [self.experiance addObject:@""];
        [self.skillsservicearray addObject:@""];
        [self.mytableview reloadData];
        [self.skillsTableView reloadData];
    }

}
- (IBAction)imagepickeraction:(id)sender {
    
    //Alertcontroller(Action sheet)
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select Source Type"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleActionSheet]; // 1
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Take Photo"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                             
                                                              actionFlag=1;
                                                              [self imagePickerAction];
                                                          }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Upload Existing Photo"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               
                                                               
                                                               actionFlag=2;
                                                               [self imagePickerAction];
                                                           }];
    
    
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                           }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction]; 
    [alert addAction:thirdAction];

    CGRect frame=CGRectMake(160, 100, 0, 0);
    
    alert.popoverPresentationController.sourceView = self;
    alert.popoverPresentationController.sourceRect = frame;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
        [(homeViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        
        [(homeViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    }
    
    
}

-(void)imagePickerAction
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if (actionFlag==1) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
        [(homeViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        
        [(homeViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:picker animated:YES completion:nil];
    }

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imageFlag=1;
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.employeeprofilepic.image = chosenImage;
   // [self.myconnection uploadEmpImage:chosenImage :self.empID];
   // [app hudStart:self];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
   
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField==self.nationalitytextfield) {//Nationality dropdown begin action
        [self dropDownWillHide];
        nationalityFlag=0;
        [self.nationalitytableview reloadData];
        self.nationalitytableview.hidden=false;
        return YES;
    }
    
    else if(textField==self.banknametextfield)//Bank name dropdown begin action
    {
        [self dropDownWillHide];
        if (self.y==1) {
            self.y=0;
            return YES;
        }
        else
        {
            self.banknametextfield.placeholder=@"Select Your Bank";
            [self.banknametableview reloadData];
            self.banknametableview.hidden=FALSE;
            return NO;
        }

    }
    else if(textField==self.departmenttextfield)//Department dropdown begin action
    {
        [self dropDownWillHide];
        if (self.departmenttextfield.text.length>0) {
            self.employeecodeTextField.text=self.empCode;
            NSArray *empCodeArray=[self.employeeCode componentsSeparatedByString:@"-"];
            self.employeeCode=[empCodeArray objectAtIndex:0];
            self.departmenttextfield.text=@"";
            [self resetTextField:self.categorytextfield];
            [self resetTextField:self.designationtextfield];
        }
        else
        {
            [self.departmenttableview reloadData];
            self.departmenttableview.hidden=FALSE;
        }
        
        return NO;
        
    }
    else if(textField==self.designationtextfield)//Designation begin action
    {
        [self dropDownWillHide];
        [self.designationtableview reloadData];
        self.designationtableview.hidden=FALSE;
        return NO;
        
    }
    else if(textField==self.categorytextfield)//Category begin action
    {
        [self dropDownWillHide];
        if (self.categorytextfield.text.length>0) {
            self.employeecodeTextField.text=self.empCode;
            NSArray *empCodeArray=[self.employeeCode componentsSeparatedByString:@"-"];
            self.employeeCode=[NSString stringWithFormat:@"%@-%@",[empCodeArray objectAtIndex:0],[empCodeArray objectAtIndex:1]];
            self.categorytextfield.text=@"";
            [self resetTextField:self.designationtextfield];
        }
        else
        {
            [self.categorytableiew reloadData];
            self.categorytableiew.hidden=FALSE;
        }
        return NO;
    }
    else if (textField==self.visaexpirytextfield)//Visa expiry begin action
    {
        [self dropDownWillHide];
        [self.passportNoTextField resignFirstResponder];
        self.visaexpiryview.hidden=false;
        return  NO;
    }
    else if (textField==self.officetextfield)//Working premise begin action
    {
        [self dropDownWillHide];
        if (self.officetextfield.text.length>0) {
            self.employeecodeTextField.text=self.empCode;
            self.officetextfield.text=@"";
            [self resetTextField:self.departmenttextfield];
            [self resetTextField:self.categorytextfield];
            [self resetTextField:self.designationtextfield];
        }
        else
        {
            [self.workingPremiseTableView reloadData];
            self.workingPremiseTableView.hidden=false;
        }
        return  NO;
    }
    else if (textField==self.gendertextfield)//Gender begin action
    {
        [self dropDownWillHide];
        [self.employeeNameTextField resignFirstResponder];
        self.gendertableview.hidden=false;
        return NO;
    }
    else if (textField==self.dateofbirthtextfield)
    {
        [self dropDownWillHide];
        self.datepickerviewfirst.hidden=false;
        return  NO;
    }
    else if (textField==self.martialtextfield)
    {
        [self dropDownWillHide];
        [self.martialstatustableview reloadData];
         self.martialstatustableview.hidden=false;
         return  NO;
    }
    else if (textField==self.bloodtextfield)
    {
        [self dropDownWillHide];
        [self.bloodgrouptableview reloadData];
        self.bloodgrouptableview.hidden=false;
        return NO;
    }
    else if (textField==self.dateofjoiningtextfield)
    {
        [self dropDownWillHide];
        self.datepickerviewsecond.hidden=false;
        return  NO;
    }
    else if (textField==self.employeecodeTextField)
    {
        self.employeecodeTextField.text=@"";
        self.employeecodeTextField.text=self.empCode;
        return  YES;
    }
   
    else
    {
        //[textField resignFirstResponder];
        return YES;
        
    }
    
    
}



-(IBAction)visadateExpiry:(id)sender
{
    self.visaexpiryview.hidden=false;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.nationalitytextfield) {
        
        return YES;
    }
    else
    {
        
    [textField resignFirstResponder];
        
    return NO;
        
    }
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.banknametextfield) {
        self.bankDropButton.hidden=false;
        self.bankID=self.banknametextfield.text;
        
    }
    if(textField==self.employeecodeTextField)
    {
        self.employeecodeTextField.text = [self.employeecodeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([self.employeeCodeArray containsObject:self.employeecodeTextField.text]) {
            self.warningFlag=1;
            [self alertAction:@"Employee Code Already Exists"];
        }
        else
        {
            self.empCode=self.employeecodeTextField.text;
            self.employeecodeTextField.text=[self.employeeCode stringByAppendingString:self.empCode];
            [self.barcodeTextView setText: [NSString stringWithFormat:@"(%@)",[self.employeecodeTextField text]]];
            [self.barcodeTextView setFont:[UIFont fontWithName:@"IDAutomationHC39M" size:16.0]];
        }
    }
    if (textField==self.nationalitytextfield) {
        self.nationalitytableview.hidden=true;
    }
    return YES;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView==self.mytableview)
    {
         return [self.serviceyeararray count];
    }
   else if (tableView==self.skillsTableView) {
        return [self.skillsservicearray count];
    }
   else if (tableView==self.martialstatustableview)
   {
        return [self.martialarray count];
   }
    
   else if (tableView==self.gendertableview)
   {
       return [self.genderArray count];
   }
   else if (tableView==self.nationalitytableview)
   {
       if (nationalityFlag==1)
       {
           return [self.filterarraycountry count];
       }
       else
       {
           return [self.contentList2 count];
       }
   }
   else if (tableView==self.yeartableview)
   {
       return [self.yeararray count];
   }
   else if (tableView==self.rateingtableview)
   {
       return [self.ratearray count];
   }
   else if (tableView==self.banknametableview)
   {
       return [self.banknamearray count];
   }
   else if (tableView==self.departmenttableview)
   {
       return [self.departmentarray count];
   }
   else if (tableView==self.designationtableview)
   {
       return [self.designationarray count];
   }
   else if (tableView==self.categorytableiew)
   {
       return [self.categoryarray count];
   }
   else if(tableView==self.bloodgrouptableview)
       return [self.bloodgroupArray count];
    else
        return self.workingPremiseArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.mytableview)
    {
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        custumclasscell *cell = (custumclasscell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"custumcell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.yearlabel.text=[self.serviceyeararray objectAtIndex:indexPath.row];
        cell.degree.text=[self.degreearray objectAtIndex:indexPath.row];
        cell.institution.text=[self.institutionarray objectAtIndex:indexPath.row];
        return cell;
    }
    
    
    else  if (tableView==self.skillsTableView)
    {
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        Customcell1 *cell = (Customcell1 *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Customcell1" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        if (!([[self.skillsservicearray objectAtIndex:indexPath.row]isEqualToString:@""])) {
            cell.ratinglabel.text=[NSString stringWithFormat:@"%@/10",[self.skillsservicearray objectAtIndex:indexPath.row]];
        }
        else
            cell.ratinglabel.text=[NSString stringWithFormat:@"%@",[self.skillsservicearray objectAtIndex:indexPath.row]];
        cell.descriptiontext.text=[self.descriptionarray objectAtIndex:indexPath.row];
        if (!([[self.experiance objectAtIndex:indexPath.row]isEqualToString:@""])) {
            cell.experiencetext.text=[NSString stringWithFormat:@"%@ Year",[self.experiance objectAtIndex:indexPath.row]];
        }
        else
            cell.experiencetext.text=[self.experiance objectAtIndex:indexPath.row];
        return cell;
    }
    else  if (tableView==self.martialstatustableview)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text=[self.martialarray objectAtIndex:indexPath.row];
        return cell;
    }
    
    else  if (tableView==self.gendertableview)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text = [self.genderArray objectAtIndex:indexPath.row];
        return cell;
    }
    else  if (tableView==self.nationalitytableview)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        if (nationalityFlag==1)
        {
            cell.textLabel.text = [self.filterarraycountry objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text = [self.contentList2 objectAtIndex:indexPath.row];
        }
        return cell;
    }
    
    else  if (tableView==self.yeartableview)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text = [self.yeararray objectAtIndex:indexPath.row];
        return cell;
    }
    else  if (tableView==self.rateingtableview)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text = [self.ratearray objectAtIndex:indexPath.row];
        return cell;
    }
    
    else  if (tableView==self.banknametableview)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text=[self.banknamearray objectAtIndex:indexPath.row];
        return cell;
    }
    
    else  if (tableView==self.departmenttableview)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        
        cell.textLabel.text=[self.departmentarray objectAtIndex:indexPath.row];
        return cell;
    }
    
    else  if (tableView==self.designationtableview)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text=[self.designationarray objectAtIndex:indexPath.row];
        return cell;
    }
    
    else  if (tableView==self.categorytableiew)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        //NSMutableDictionary *mydict = [self.categoryarray objectAtIndex:indexPath.row];
        cell.textLabel.text=[self.categoryarray objectAtIndex:indexPath.row];
        return cell;
    }

    else if(tableView==self.bloodgrouptableview)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:13.0f];
        cell.textLabel.text=[self.bloodgroupArray objectAtIndex:indexPath.row];
        return cell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:13.0f];
        cell.textLabel.text=[self.workingPremiseArray objectAtIndex:indexPath.row];
        return cell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.bloodgrouptableview) {
        
        //NSMutableDictionary *mydict = [self.bloodgroupArray objectAtIndex:indexPath.row];
        self.bloodtextfield.text=[self.bloodgroupArray objectAtIndex:indexPath.row];
        self.bloodgrouptableview.hidden=TRUE;
        
    }
    
    else if (tableView==self.martialstatustableview) {
        
        // NSMutableDictionary *mydict = [self.martialarray objectAtIndex:indexPath.row];
        self.martialtextfield.text=[self.martialarray objectAtIndex:indexPath.row];
        self.martialstatustableview.hidden=TRUE;
        
    }
    else if (tableView==self.gendertableview) {
        
        self.gendertextfield.text = [self.genderArray objectAtIndex:indexPath.row];
        
        self.gendertableview.hidden=TRUE;
        
    }
    else if (tableView==self.yeartableview) {//Saving degree, institute and year into each array
        
        custumclasscell *cell=(custumclasscell *)[self.mytableview cellForRowAtIndexPath:self.yearindexpath];
        if ((cell.degree.text.length>0)&&(cell.institution.text.length>0)) {
            cell.yearlabel.text = [self.yeararray objectAtIndex:indexPath.row];
            
            self.yeartableview.hidden=TRUE;
            if (self.serviceyeararray.count==self.yearindexpath.row+1) {//Checks whether selected cell for editing is last cell or not
                [self.serviceyeararray insertObject:cell.yearlabel.text atIndex:self.yearindexpath.row];
            }
            else//If not
            {
                [self.serviceyeararray replaceObjectAtIndex:self.yearindexpath.row withObject:cell.yearlabel.text];
            }
            [self.mytableview reloadData];
            
        }
        else
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Error"
                                       message:@"Degree and Institution Cannot be NULL"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           //Do Some action here
                                                       }];
            [alert addAction:ok];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
                    [(homeViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
                }
                else
                {
                    
                    [(homeViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
                }
            });
            self.yeartableview.hidden=TRUE;
        }
    }
    
    else if (tableView==self.rateingtableview) {
        Customcell1 *cell=(Customcell1 *)[self.skillsTableView cellForRowAtIndexPath:self.yearindexpath];
        if ((cell.descriptiontext.text.length>0)&&(cell.experiencetext.text.length>0))
        {
            NSString *str =[NSString stringWithFormat:@"%@",[self.ratearray objectAtIndex:indexPath.row]];
            self.rateingtableview.hidden=TRUE;
            if (self.skillsservicearray.count==self.yearindexpath.row+1) {//Checks whether selected cell for editing is last cell or not
                [self.skillsservicearray insertObject:str atIndex:self.yearindexpath.row];
            }
            else//If  not
            {
                [self.skillsservicearray replaceObjectAtIndex:self.yearindexpath.row withObject:str];
            }
            [self.skillsTableView reloadData];
        }
        else
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Error"
                                       message:@"Decription and Experience Cannot be NULL"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           //Do Some action here
                                                       }];
            [alert addAction:ok];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
                    [(homeViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
                }
                else
                {
                    
                    [(homeViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
                }
            });
            self.rateingtableview.hidden=TRUE;
        }
    }
    
    else if (tableView==self.banknametableview) {
        if (indexPath.row==self.banknamearray.count-1) {//If other option is selected
            self.y=1;
            self.bankDropButton.hidden=true;
            [self.banknametextfield becomeFirstResponder];
            self.banknametextfield.text=@"";
            self.banknametextfield.placeholder=@"Enter you bank name";
            self.banknametableview.hidden=TRUE;
        }
        else
        {
            self.banknametextfield.text=[self.banknamearray objectAtIndex:indexPath.row];
            self.bankID=[self.bankIDArray objectAtIndex:indexPath.row];
            self.banknametableview.hidden=TRUE;
        }
        
    }
    else if (tableView==self.departmenttableview) {
        
        self.departmenttextfield.text=[self.departmentarray objectAtIndex:indexPath.row];
        self.departmentID=[self.departmentIDArray objectAtIndex:indexPath.row];
        self.employeeCode=[NSString stringWithFormat:@"%@-%@",self.employeeCode,[[self.departmentCodeArray objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        self.categorytextfield.userInteractionEnabled=YES;
        self.categorytextfield.backgroundColor=[UIColor clearColor];
        self.departmenttableview.hidden=TRUE;
        
    }
    else if (tableView==self.categorytableiew) {
        
        self.categorytextfield.text=[self.categoryarray objectAtIndex:indexPath.row];
        self.categoryID=[self.categoryIDArray objectAtIndex:indexPath.row];
        
        self.employeeCode=[NSString stringWithFormat:@"%@-%@",self.employeeCode,[[self.categoryCodeArray objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        
        self.designationtextfield.userInteractionEnabled=YES;
        self.designationtextfield.backgroundColor=[UIColor clearColor];
        self.categorytableiew.hidden=TRUE;
        
        NSString *emp=[self.employeeCode stringByAppendingString:self.employeecodeTextField.text];
        self.employeecodeTextField.text=emp;
        
    }
    
    else if (tableView==self.designationtableview) {
        
        self.designationtextfield.text=[self.designationarray objectAtIndex:indexPath.row];
        self.designationID=[self.designationIDArray objectAtIndex:indexPath.row];
        self.designationtableview.hidden=TRUE;
        
        
    }
    
    
    else if (tableView==self.nationalitytableview) {
        
        if (nationalityFlag==1) {
            
            self.nationalitytextfield.text=[self.filterarraycountry objectAtIndex:indexPath.row];
        }
        else
        {
            self.nationalitytextfield.text=[self.contentList2 objectAtIndex:indexPath.row];
        }
        self.nationalityID=[self.countrydict objectForKey:self.nationalitytextfield.text];
        [self.nationalitytextfield resignFirstResponder];
        self.nationalitytableview.hidden=TRUE;
        
    }
    else if (tableView==self.workingPremiseTableView)
    {
        self.officetextfield.text=[self.workingPremiseArray objectAtIndex:indexPath.row];
        if (indexPath.row==0) {
            self.workingPremiseID=[NSString stringWithFormat:@"%@",[self.workingPremiseIDArray objectAtIndex:indexPath.row]];
            self.workingPremiseType=@"O";
        }
        else
        {
            self.workingPremiseID=[NSString stringWithFormat:@"%@",[self.workingPremiseIDArray objectAtIndex:indexPath.row]];
            self.workingPremiseType=@"S";
        }
        self.employeeCode=[[self.workingPremiseCodeArray objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.departmenttextfield.userInteractionEnabled=true;
        self.departmenttextfield.backgroundColor=[UIColor clearColor];
        self.workingPremiseTableView.hidden=true;
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.nationalitytextfield) {
        dispatch_async(dispatch_get_main_queue(), ^{
            nationalityFlag=1;
            self.nationalitytableview.hidden=FALSE;
            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.nationalitytextfield.text stringByReplacingCharactersInRange:range withString:string]];
            self.filterarraycountry = [[self.contentList2 filteredArrayUsingPredicate:bPredicate] mutableCopy];
            [self.nationalitytableview reloadData];
            if ([string isEqualToString:@""] && textField.text.length==1)
            {
                nationalityFlag=0;//
                [self.nationalitytableview reloadData];
            }

        });
        return  YES;
    }
    else if(textField==self.employeeNameTextField)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=79) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz 0123456789"];
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
    else if (textField==self.employeecodeTextField)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=9) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
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
    else if ((textField==self.passportNoTextField) || (textField==self.labourCardNoTextField) || (textField==self.nationalIDNoTextField) || (textField==self.pfNoTextField)||(textField==self.wpsNoTextField))
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=14) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
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
    else if ((textField==self.incomeTaxNoTextField)||(textField==self.esiNoTextField)||(textField==self.bankAccountNoTextField))
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=14) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
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
    else if (textField==self.banknametextfield)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=29) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz 0123456789"];
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


/*-(IBAction)tablebutton:(id)sender
 {
 
 custumclasscell *cell= (custumclasscell *) [self.mytableview cellForRowAtIndexPath:k];
 [cell.changebutton setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
 
 custumclasscell *clickedCell = (custumclasscell*)[[sender superview] superview];
 [clickedCell.changebutton setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
 indexPathCell = [self.mytableview indexPathForCell:clickedCell];
 k=indexPathCell;
 }
 */



- (IBAction)datepickeraction:(id)sender
{
    NSDate *myDate = self.mydatepicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d MMM yyyy"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    self.dateofbirthtextfield.text=prettyVersion;
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"yyyy-MM-d"];
    self.dateofbirthstring = [dateFormat1 stringFromDate:myDate];
    self.datepickerviewfirst.hidden=TRUE;
}

- (IBAction)seconddatepickeraction:(id)sender
{
    NSDate *myDate = self.mydatepickersecond.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d MMM yyyy"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    self.dateofjoiningtextfield.text=prettyVersion;
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"yyyy-MM-d"];
    self.dateofjoingstring = [dateFormat1 stringFromDate:myDate];
    self.datepickerviewsecond.hidden=TRUE;
}

-(IBAction)textfieldbegininaction:(id)sender
{
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,450);
}
-(IBAction)textfieldbegininaction2:(id)sender
{
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,450);
}
-(IBAction)textFieldEndingAction:(id)sender
{
    custumclasscell *cell1 = (custumclasscell *)[[sender superview] superview];
    NSIndexPath *myindex=[self.mytableview indexPathForCell:cell1];
    if (!(cell1.degree.text.length==0)) {
        if (!(myindex.row==self.degreearray.count - 1)) {
            [self.degreearray replaceObjectAtIndex:myindex.row withObject:cell1.degree.text];
        }
        else
        {
            [self.degreearray insertObject:cell1.degree.text atIndex:myindex.row];
            
        }
    }
    else
    {
        if (!(myindex.row==self.degreearray.count - 1)) {
            [self alertAction1: @"Degree field cannot be null. Continue to delete whole row":@"degree" :myindex];
        }
        
        //[self.mytableview reloadData];
        
    }
    
}
-(IBAction)textFieldEndingAction2:(id)sender
{
    custumclasscell *cell1 = (custumclasscell *)[[sender superview] superview];
    NSIndexPath *myindex=[self.mytableview indexPathForCell:cell1];
    if (cell1.institution.text.length > 0) {
        if (!(myindex.row==self.institutionarray.count - 1)) {
            [self.institutionarray replaceObjectAtIndex:myindex.row withObject:cell1.institution.text];
        }
        else
        {
            [self.institutionarray insertObject:cell1.institution.text atIndex:myindex.row];
        }
    }
    else
    {
        if (!(myindex.row==self.institutionarray.count - 1)) {
            [self alertAction1:@"Institute field cannot be null. Continue to delete whole row" :@"institute" : myindex];
        }
        
        //[self.mytableview reloadData];
    }
    
}
-(IBAction)descriptionEndEditing:(id)sender
{
    Customcell1 *cell1 = (Customcell1 *)[[sender superview] superview];
    NSIndexPath *myindex=[self.skillsTableView indexPathForCell:cell1];
    if (!(cell1.descriptiontext.text.length == 0)) {
        if (!(myindex.row==self.descriptionarray.count - 1)) {
            [self.descriptionarray replaceObjectAtIndex:myindex.row withObject:cell1.descriptiontext.text];
        }
        else
        {
            [self.descriptionarray insertObject:cell1.descriptiontext.text atIndex:myindex.row];
        }
    }
    else
    {
        if (!(myindex.row==self.descriptionarray.count - 1)) {
            [self alertAction1:@"Description field cannot be null. Continue to delete whole row" :@"description" : myindex];
        }
        
        //[self.skillsTableView reloadData];
    }
    
}
-(IBAction)experienceEndEditing:(id)sender
{
    Customcell1 *cell1 = (Customcell1 *)[[sender superview] superview];
    NSIndexPath *myindex=[self.skillsTableView indexPathForCell:cell1];
    if (cell1.experiencetext.text.length > 0) {
        if (!(myindex.row==self.experiance.count - 1)) {
            //if ([cell1.experiencetext.text integerValue] > 1) {
                NSString *experienceString=[NSString stringWithFormat:@"%@",cell1.experiencetext.text];
                [self.experiance replaceObjectAtIndex:myindex.row withObject:experienceString];
//            }
//            else
//            {
//                NSString *experienceString=[NSString stringWithFormat:@"%@ Year",cell1.experiencetext.text];
//                [self.experiance replaceObjectAtIndex:myindex.row withObject:experienceString];
//            }
            
        }
        else
        {
            //if ([cell1.experiencetext.text integerValue] > 1) {
                NSString *experienceString=[NSString stringWithFormat:@"%@",cell1.experiencetext.text];
                [self.experiance insertObject:experienceString atIndex:myindex.row];
//            }
//            else
//            {
//                NSString *experienceString=[NSString stringWithFormat:@"%@ Year",cell1.experiencetext.text];
//                [self.experiance insertObject:experienceString atIndex:myindex.row];
//            }
        }
        [self.skillsTableView reloadData];
    }
    else
    {
        if (!(myindex.row==self.experiance.count - 1)) {
            [self alertAction1:@"Experience field can't be null. Continue to delete whole row" : @"experience" : myindex];
        }
        
        //[self.skillsTableView reloadData];
    }
    
}
- (IBAction)visadatepickeraction:(id)sender
{
    NSDate *myDate = self.visapicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d MMM yyyy"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    self.visaexpirytextfield.text=prettyVersion;
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"yyyy-MM-d"];
    self.visaexpirystring = [dateFormat1 stringFromDate:myDate];
    self.visaexpiryview.hidden=TRUE;
}
- (IBAction)visadatetextfieldaction:(id)sender
{
    self.visaexpiryview.hidden=FALSE;
}
-(IBAction)yearfirstresponderaction:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.mytableview];
    self.yearindexpath= [self.mytableview indexPathForRowAtPoint:buttonPosition];
    custumclasscell *cell=(custumclasscell *)[self.mytableview cellForRowAtIndexPath:self.yearindexpath];
    [cell.degree resignFirstResponder];
    [cell.institution resignFirstResponder];
    self.yeartableview.hidden=FALSE;
    if (self.yearindexpath.row>1) {
        self.yeartableview.frame=CGRectMake(350, 588, self.yeartableview.frame.size.width, self.yeartableview.frame.size.height);
    }
    else
    {
        self.yeartableview.frame=CGRectMake(350, buttonPosition.y+560, self.yeartableview.frame.size.width, self.yeartableview.frame.size.height);
    }
}
-(IBAction)rateingfirstresponderaction:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.skillsTableView];
    self.yearindexpath= [self.skillsTableView indexPathForRowAtPoint:buttonPosition];
    Customcell1 *cell=(Customcell1 *)[self.skillsTableView cellForRowAtIndexPath:self.yearindexpath];
    [cell.descriptiontext resignFirstResponder];
    [cell.experiencetext resignFirstResponder];
    self.rateingtableview.hidden=FALSE;
    if (self.yearindexpath.row>1) {
        self.rateingtableview.frame=CGRectMake(723, 588, self.rateingtableview.frame.size.width, self.rateingtableview.frame.size.height);
    }
    else
    {
        self.rateingtableview.frame=CGRectMake(723, buttonPosition.y+560, self.rateingtableview.frame.size.width, self.rateingtableview.frame.size.height);
    }
}
-(IBAction)clearButtonAction:(id)sender
{
    [self clearFunction];
}
-(void)clearFunction
{
    self.employeeNameTextField.text=@"";self.employeecodeTextField.text=@"";self.gendertextfield.text=@"";self.dateofbirthtextfield.text=@"";self.martialtextfield.text=@"";self.bloodtextfield.text=@"";self.dateofjoiningtextfield.text=@"";self.nationalitytextfield.text=@"";self.officetextfield.text=@"";
    self.departmenttextfield.text=@"";self.categorytextfield.text=@"";self.designationtextfield.text=@"";self.passportNoTextField.text=@"";self.visaexpirytextfield.text=@"";self.labourCardNoTextField.text=@"";self.nationalIDNoTextField.text=@"";self.pfNoTextField.text=@"";self.incomeTaxNoTextField.text=@"";self.esiNoTextField.text=@"";self.banknametextfield.text=@"";self.bankAccountNoTextField.text=@"";self.wpsNoTextField.text=@"";self.employeeprofilepic.image=[UIImage imageNamed:@"user.png"];self.dateofbirthstring=@"";self.dateofjoingstring=@"";self.visaexpirystring=@"";
}
-(IBAction)saveAndnext:(id)sender
{
    [self.degreearray removeLastObject];
    [self.institutionarray removeLastObject];
    [self.serviceyeararray removeLastObject];
    [self.mytableview reloadData];
    
    [self.descriptionarray removeLastObject];
    [self.experiance removeLastObject];
    [self.skillsservicearray removeLastObject];
    [self.skillsTableView reloadData];
    
    
    
    
   if ((self.employeeNameTextField.text.length>0)&&(self.employeecodeTextField.text.length>0)&&(self.gendertextfield.text.length>0)&&(self.dateofjoiningtextfield.text.length>0)&&(self.officetextfield.text.length>0)&&(self.departmenttextfield.text.length>0)&&(self.categorytextfield.text.length>0)&&(self.designationtextfield.text.length>0)) {
       
       if ((self.degreearray.count==self.institutionarray.count)&&(self.degreearray.count==self.serviceyeararray.count)) {
           
           
           if ((self.descriptionarray.count==self.experiance.count)&&(self.descriptionarray.count==self.skillsservicearray.count)) {
               
               if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
                   
                   personalDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.employeeNameTextField.text,@"employee_name",self.dateofbirthstring,@"dob",self.martialtextfield.text,@"marital_status",self.bloodtextfield.text,@"blood_group",self.dateofjoingstring,@"joining",self.nationalityID,@"emp_nation",self.workingPremiseID,@"office",self.workingPremiseType,@"pre_type",self.departmentID,@"dept",self.categoryID,@"cat",self.designationID,@"desigantion",self.passportNoTextField.text,@"passport_no",self.visaexpirystring,@"visa_expiry",self.labourCardNoTextField.text,@"labour_card",self.nationalIDNoTextField.text,@"national_id",self.pfNoTextField.text,@"provident_fund",self.incomeTaxNoTextField.text,@"emp_income_tax_no",self.esiNoTextField.text,@"esi",self.bankID,@"bank_name",self.bankAccountNoTextField.text,@"bank_acc",self.wpsNoTextField.text,@"wps",[self.gendertextfield.text substringToIndex:1],@"gender",self.empCode,@"employee_code",self.employeecodeTextField.text,@"e_code",self.degreearray,@"degree",self.institutionarray,@"institute",self.serviceyeararray,@"edu_year",self.descriptionarray,@"description",self.experiance,@"experience",self.skillsservicearray,@"p_level", nil];
                   
                   [self.myconnection addNewEmployeeSave : personalDetailsDict];
                   
               }
               else
               {
                   //Update
                   
                   
                   personalDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.empID,@"employee_id",self.employeeNameTextField.text,@"employee_name",self.dateofbirthstring,@"dob",self.martialtextfield.text,@"marital_status",self.bloodtextfield.text,@"blood_group",self.dateofjoingstring,@"joining",self.nationalityID,@"emp_nation",self.workingPremiseID,@"office",self.workingPremiseType,@"pre_type",self.departmentID,@"dept",self.categoryID,@"cat",self.designationID,@"desigantion",self.passportNoTextField.text,@"passport_no",self.visaexpirystring,@"visa_expiry",self.labourCardNoTextField.text,@"labour_card",self.nationalIDNoTextField.text,@"national_id",self.pfNoTextField.text,@"provident_fund",self.incomeTaxNoTextField.text,@"emp_income_tax_no",self.esiNoTextField.text,@"esi",self.bankID,@"bank_name",self.bankAccountNoTextField.text,@"bank_acc",self.wpsNoTextField.text,@"wps",[self.gendertextfield.text substringToIndex:1],@"gender",self.empCode,@"employee_code",self.employeecodeTextField.text,@"e_code",self.degreearray,@"degree",self.institutionarray,@"institute",self.serviceyeararray,@"edu_year",self.descriptionarray,@"description",self.experiance,@"experience",self.skillsservicearray,@"p_level", nil];
                   [self.myconnection updateEmployee1:personalDetailsDict];
                   
                   
//                   dispatch_async(dispatch_get_main_queue(), ^{
//                       
//                       NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"addnewemployee2View" owner:self options:nil];
//                       [self.superview.superview addSubview:[nib objectAtIndex:0]];
//                   });
               }
               
               [app hudStart:self];
               
               
           }
           else
           {
               [self alertAction:@"Must Enter All Values in Skills Details"];
               [self.descriptionarray addObject:@""];
               [self.experiance addObject:@""];
               [self.skillsservicearray addObject:@""];
               [self.skillsTableView reloadData];
               [self.degreearray addObject:@""];
               [self.institutionarray addObject:@""];
               [self.serviceyeararray addObject:@""];
               [self.mytableview reloadData];
           }
           
           
           
       }
       else
       {
           [self alertAction:@"Must Enter All Values in Educational Details"];
           [self.degreearray addObject:@""];
           [self.institutionarray addObject:@""];
           [self.serviceyeararray addObject:@""];
           [self.mytableview reloadData];
           [self.descriptionarray addObject:@""];
           [self.experiance addObject:@""];
           [self.skillsservicearray addObject:@""];
           [self.skillsTableView reloadData];
       }
    
       
       
       
    }
    else
    {
        [self alertAction:@"Must Enter All the Mandatory Fields"];

    }
}
-(void)alertAction:(NSString *)message
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:[NSString stringWithFormat:@"%@",message]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,self.scrollView.frame.origin.y);
                                                   if (self.warningFlag==1) {
                                                       self.employeecodeTextField.text=[self.employeeCode stringByAppendingString:self.empCode];
                                                       
                                                   }
                                                   self.warningFlag=0;
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
            [(homeViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            
            [(homeViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
    });
}
-(void)alertAction1:(NSString *)message :(NSString *)type :(NSIndexPath *)selectedIndex
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:[NSString stringWithFormat:@"%@",message]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* delete = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   
                                                   if (([type isEqualToString:@"degree"]) || ([type isEqualToString:@"institute"])) {
                                                       [self.degreearray removeObjectAtIndex:selectedIndex.row];
                                                       [self.institutionarray removeObjectAtIndex:selectedIndex.row];
                                                       [self.serviceyeararray removeObjectAtIndex:selectedIndex.row];
                                                       [self.mytableview reloadData];
                                                   }
                                                   else if (([type isEqualToString:@"description"]) || ([type isEqualToString:@"experience"]))
                                                   {
                                                       [self.descriptionarray removeObjectAtIndex:selectedIndex.row];
                                                       [self.experiance removeObjectAtIndex:selectedIndex.row];
                                                       [self.skillsservicearray removeObjectAtIndex:selectedIndex.row];
                                                       [self.skillsTableView reloadData];
                                                   }
                                                   
                                               }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   
                                                   if (([type isEqualToString:@"degree"]) || ([type isEqualToString:@"institute"])) {
                                                       [self.mytableview reloadData];
                                                   }
                                                   else if (([type isEqualToString:@"description"]) || ([type isEqualToString:@"experience"]))
                                                   {
                                                       [self.skillsTableView reloadData];
                                                   }

                                               }];

    [alert addAction:delete];
    [alert addAction:cancel];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
            [(homeViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            
            [(homeViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
    });
}

//-----------------------------------------------Response Part-------------------------------------------------

//Got response if no network connection is available
-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Error"
                               message:@"No internet connection"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
            [(homeViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            
            [(homeViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
    });
    
    
}

-(void)addNewEmployeeSaveResponse:(NSString *)saveResponse
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([saveResponse isEqualToString:@"1"]) {
            [[NSUserDefaults standardUserDefaults]setObject:self.empCode forKey:@"empID"];
            
            if (!([self.employeeprofilepic.image isEqual:[UIImage imageNamed:@"user.png"]])) {
                //Function call to upload image
                [self.myconnection uploadEmpImage:self.employeeprofilepic.image : self.empCode];
                [app hudStart:self];
            }
            else
            {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"addnewemployee2View" owner:self options:nil];
                [self.superview.superview addSubview:[nib objectAtIndex:0]];
            }
        }
        else if([saveResponse isEqualToString:@"2"])
        {
            [self alertAction:@"Employee Code Already Exists"];
            [self.myconnection addNewEmployeeOfficeDisplayDetails:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];
            [self.degreearray addObject:@""];
            [self.institutionarray addObject:@""];
            [self.serviceyeararray addObject:@""];
            [self.mytableview reloadData];
            [self.descriptionarray addObject:@""];
            [self.experiance addObject:@""];
            [self.skillsservicearray addObject:@""];
            [self.skillsTableView reloadData];
            [app hudStop];
        }
        else if([saveResponse isEqualToString:@"3"])
        {
            [self alertAction:@"Employee Name and Date of Birth Already Exists"];
            
            [self.degreearray addObject:@""];
            [self.institutionarray addObject:@""];
            [self.serviceyeararray addObject:@""];
            [self.mytableview reloadData];
            [self.descriptionarray addObject:@""];
            [self.experiance addObject:@""];
            [self.skillsservicearray addObject:@""];
            [self.skillsTableView reloadData];
            [app hudStop];
        }
        else
        {
            [self alertAction:@"Error in Saving"];
            
            [self.degreearray addObject:@""];
            [self.institutionarray addObject:@""];
            [self.serviceyeararray addObject:@""];
            [self.mytableview reloadData];
            [self.descriptionarray addObject:@""];
            [self.experiance addObject:@""];
            [self.skillsservicearray addObject:@""];
            [self.skillsTableView reloadData];
            [app hudStop];
        }
        
    });
}

-(void)createResponse:(id)Response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([Response isEqualToString:@"1"]) {
            if (actionFlag==0) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"addnewemployee2View" owner:self options:nil];
                [self.superview.superview addSubview:[nib objectAtIndex:0]];
            }
            else
            {
                [self.myconnection updateProfilePic:self.employeeprofilepic.image : self.empCode];
                [app hudStart:self];
            }
        }
        
    });
}

-(void)allcountryresponse:(id)countrylist //Response of country listing service for nationality
{
    nationalityFlag=0;
     [self.contentList2 removeAllObjects];
    for (int i=0; i<[countrylist count]; i++) {
        
        NSString *mystring=[[countrylist objectAtIndex:i] objectForKey:@"name"];
        [self.contentList2 addObject:mystring];
        [self.countrydict setObject:[[countrylist objectAtIndex:i] objectForKey:@"nation_id"] forKey:mystring];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"update"]) {
            NSData *newData = [[NSUserDefaults standardUserDefaults] objectForKey:@"employeewholeDetails"];
            self.empDict= [NSKeyedUnarchiver unarchiveObjectWithData:newData];
            [self fillDetails];
        }
        
        [self.nationalitytableview reloadData];
    });
    
}
-(void)serviceGotResponse:(id)responseData//Response of generate Emp Code
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [app hudStop];
        if ([responseData isEqualToString:self.empCode]) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"addnewemployee2View" owner:self options:nil];
            [self.superview.superview addSubview:[nib objectAtIndex:0]];
        }
        else
        {
            
        }
        
    
        
    });
    
}

-(void)AddNewEmployeeIntitalResponse:(id)responseData
{
    [self.banknamearray removeAllObjects];
    [self.bankIDArray removeAllObjects];
    [self.workingPremiseArray removeAllObjects];
    [self.workingPremiseIDArray removeAllObjects];
    [self.departmentIDArray removeAllObjects];
    [self.departmentarray removeAllObjects];
    [self.categoryarray removeAllObjects];
    [self.categoryIDArray removeAllObjects];
    [self.designationarray removeAllObjects];
    [self.designationIDArray removeAllObjects];
    [self.workingPremiseCodeArray removeAllObjects];
    [self.departmentCodeArray removeAllObjects];
    [self.categoryCodeArray removeAllObjects];
    
    NSMutableDictionary *serviceDict=[[NSMutableDictionary alloc]init];
    serviceDict=responseData;
    
    [[NSUserDefaults standardUserDefaults]setObject:[serviceDict mutableCopy] forKey:@"serviceData"];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        NSMutableArray *bankDetailsArray=[responseData objectForKey:@"bank"];
    
        for (int i=0; i<bankDetailsArray.count; i++) {
            NSMutableDictionary *bankDict=[bankDetailsArray objectAtIndex:i];
            [self.banknamearray addObject:[bankDict objectForKey:@"bank_name"]];
            [self.bankIDArray addObject:[bankDict objectForKey:@"bank_id"]];
            
        }
        [self.banknamearray addObject:@"Other"];
        [self.banknametableview reloadData];
    
        NSMutableArray *workingPremiseArray=[responseData objectForKey:@"office"];
        for (int i=0; i<workingPremiseArray.count; i++) {
            NSMutableDictionary *officeDict=[workingPremiseArray objectAtIndex:i];
            [self.workingPremiseArray addObject:[officeDict objectForKey:@"office_name"]];
            [self.workingPremiseIDArray addObject:[officeDict objectForKey:@"id"]];
            [self.workingPremiseCodeArray addObject:[officeDict objectForKey:@"code"]];
        
        }
    
    
        NSMutableArray *storeArray=[responseData objectForKey:@"store"];
        for (int i=0; i<storeArray.count; i++) {
            NSMutableDictionary *storedict=[storeArray objectAtIndex:i];
            [self.workingPremiseArray addObject:[storedict objectForKey:@"store_name"]];
            [self.workingPremiseIDArray addObject:[storedict objectForKey:@"store_id"]];
            [self.workingPremiseCodeArray addObject:[storedict objectForKey:@"code"]];
        }
    
        [self.workingPremiseTableView reloadData];
    
        NSMutableArray *departmentArray=[responseData objectForKey:@"department"];
        for (int i=0; i<departmentArray.count; i++) {
            NSMutableDictionary *deptDict=[departmentArray objectAtIndex:i];
            [self.departmentarray addObject:[deptDict objectForKey:@"department_name"]];
            [self.departmentIDArray addObject:[deptDict objectForKey:@"dept_id"]];
            [self.departmentCodeArray addObject:[deptDict objectForKey:@"code"]];
        
        }
    
        [self.departmenttableview reloadData];
    
        NSMutableArray *categoryArray=[responseData objectForKey:@"category"];
        for (int i=0; i<categoryArray.count; i++) {
            NSMutableDictionary *categoryDict=[categoryArray objectAtIndex:i];
            [self.categoryarray addObject:[categoryDict objectForKey:@"cat_name"]];
            [self.categoryIDArray addObject:[categoryDict objectForKey:@"id"]];
            [self.categoryCodeArray addObject:[categoryDict objectForKey:@"code"]];
        }
        [self.categorytableiew reloadData];
    
    
        NSMutableArray *designationArray=[responseData objectForKey:@"designation_list"];
        for(int i=0;i<designationArray.count;i++)
        {
            NSMutableDictionary *desigDict=[designationArray objectAtIndex:i];
            [self.designationarray addObject:[desigDict objectForKey:@"designation_title"]];
            [self.designationIDArray addObject:[desigDict objectForKey:@"id"]];
        }
        [self.designationtableview reloadData];
        NSMutableArray *empcodeArray=[responseData objectForKey:@"emp_code"];
        for (int i=0; i<empcodeArray.count; i++) {
            NSMutableDictionary *empDict=[empcodeArray objectAtIndex:i];
            [self.employeeCodeArray addObject:[empDict objectForKey:@"emp_code"]];
        }
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
            self.empCode=self.employeecodeTextField.text=[NSString stringWithFormat:@"%@",[responseData objectForKey:@"new_emp_code"]];
            [self.barcodeTextView setText: [NSString stringWithFormat:@"(%@)",[self.employeecodeTextField text]]];
            [self.barcodeTextView setFont:[UIFont fontWithName:@"IDAutomationHC39M" size:16.0]];
        }
        
    });
}

-(void)dropDownWillHide
{
    self.gendertableview.hidden=true;
    self.nationalitytableview.hidden=true;
    self.workingPremiseTableView.hidden=true;
    self.departmenttableview.hidden=true;
    self.categorytableiew.hidden=true;
    self.designationtableview.hidden=true;
    self.banknametableview.hidden=true;
    self.datepickerviewfirst.hidden=true;
    self.datepickerviewsecond.hidden=true;
    self.visaexpiryview.hidden=true;
    self.martialstatustableview.hidden=true;
    self.bloodgrouptableview.hidden=true;
}
-(void)resetTextField:(UITextField *)textField
{
    textField.text=@"";
    textField.userInteractionEnabled=NO;
    textField.backgroundColor=[UIColor lightGrayColor];
}

@end
