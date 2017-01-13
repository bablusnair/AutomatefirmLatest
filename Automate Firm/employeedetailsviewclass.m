//
//  employeedetailsviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/9/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "employeedetailsviewclass.h"
#import "weekcell.h"
@implementation employeedetailsviewclass
-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    NSData *newData = [[NSUserDefaults standardUserDefaults] objectForKey:@"employeewholeDetails"];
    NSDictionary *employeedictdetails = [NSKeyedUnarchiver unarchiveObjectWithData:newData];
    
    self.detailsDict=[[NSMutableDictionary alloc]init];
    self.detailsDict = [employeedictdetails objectForKey:@"basic_info"] ;
    
    
    
    NSArray *myarray = [[NSBundle mainBundle] loadNibNamed:@"firstscrollview" owner:self options:nil];
    [self.firstScrollView addSubview:[myarray objectAtIndex:0]];
    NSArray *myarray2 = [[NSBundle mainBundle] loadNibNamed:@"secondscrollview" owner:self options:nil];
    [self.secondScrollView addSubview:[myarray2 objectAtIndex:0]];
    
    
    self.leaveArray=[[NSMutableArray alloc]init];
    self.holidayArray=[[NSMutableArray alloc]init];
    self.loanArray=[[NSMutableArray alloc]init];
    self.expenseReimbursementArray=[[NSMutableArray alloc]init];
    
    self.weekAbbrv=@"";
    self.weekDescription=@"";
    self.payAbbrv=@"";
    self.payDescription=@"";
    self.shiftAbbrv=@"";
    self.shiftDescription=@"";
    self.overtimeAbbrv=@"";
    self.overtimeDescription=@"";
    
    [self displayDetails];
    
    [self.myconnection listRuleAccordingtoDesignation:[self.detailsDict objectForKey:@"emp_code"]];
    [super awakeFromNib];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
        return 8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==4) {
        return self.leaveArray.count;
    }
    else if (section==5)
    {
        return self.holidayArray.count;
    }
    else if (section==6)
    {
        return self.loanArray.count;
    }
    else if (section==7)
    {
        return self.expenseReimbursementArray.count;
    }
    else
        return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==4)
    {
        newearningscellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"newearningscell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.mylabel.text=[self.leaveArray objectAtIndex:indexPath.row];
        cell.labelKWD.hidden=TRUE;
        return cell;
    }
    else if (indexPath.section==5)
    {
        newearningscellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"newearningscell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.mylabel.text=[self.holidayArray objectAtIndex:indexPath.row];
        cell.labelKWD.hidden=TRUE;
        return cell;
    }
    else if (indexPath.section==6)
    {
        newearningscellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"newearningscell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.mylabel.text=[self.loanArray objectAtIndex:indexPath.row];
        cell.labelKWD.hidden=TRUE;
        return cell;
    }
    else if (indexPath.section==7)
    {
        newearningscellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"newearningscell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.mylabel.text=[self.expenseReimbursementArray objectAtIndex:indexPath.row];
        cell.labelKWD.hidden=TRUE;
        return cell;
    }
    else  {
        weekcell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"weekcell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        if (indexPath.section==0) {
            cell.mylabel1.text=self.weekAbbrv;
            cell.mylabel2.text=self.weekDescription;
        }
        else if (indexPath.section==1)
        {
            cell.mylabel1.text=self.payAbbrv;
            cell.mylabel2.text=self.payDescription;
        }
        else if (indexPath.section==2)
        {
            cell.mylabel1.text=self.shiftAbbrv;
            cell.mylabel2.text=self.shiftDescription;
        }
        else
        {
            cell.mylabel1.text=self.overtimeAbbrv;
            cell.mylabel2.text=self.overtimeDescription;
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.mainTableView) {

            if (section==0) {
        
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
            UIImageView *myimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            myimgview.image=[UIImage imageNamed:@"staffingpath.png"];
            [view addSubview:myimgview];
            UIImageView *myimgview2 = [[UIImageView alloc] initWithFrame:CGRectMake(155, 5, 25,25)];
            myimgview2.image=[UIImage imageNamed:@"week_icon1.png"];
            [myimgview addSubview:myimgview2];
            UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 25)];
            titlelabel.text=@"Weeks";
            titlelabel.textColor=[UIColor whiteColor];
            titlelabel.font = [UIFont fontWithName:@"Oxygen-Bold" size:13];
            [myimgview addSubview:titlelabel];
            return view;
        }
        else  if (section==1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
            UIImageView *myimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            myimgview.image=[UIImage imageNamed:@"staffingpath.png"];
            UIImageView *myimgview2 = [[UIImageView alloc] initWithFrame:CGRectMake(155, 5, 25,25)];
            myimgview2.image=[UIImage imageNamed:@"ss.png"];
            [myimgview addSubview:myimgview2];
            [view addSubview:myimgview];
            UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 25)];
            titlelabel.text=@"Pay Structure";
            titlelabel.textColor=[UIColor whiteColor];
            titlelabel.font = [UIFont fontWithName:@"Oxygen-Bold" size:13];
            [myimgview addSubview:titlelabel];
            return view;
        }
        else  if (section==2) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
            UIImageView *myimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            myimgview.image=[UIImage imageNamed:@"staffingpath.png"];
            [view addSubview:myimgview];
            UIImageView *myimgview2 = [[UIImageView alloc] initWithFrame:CGRectMake(155, 5, 25,25)];
            myimgview2.image=[UIImage imageNamed:@"shift_icon1.png"];
            [myimgview addSubview:myimgview2];
            UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 25)];
            titlelabel.text=@"Shifts";
            titlelabel.textColor=[UIColor whiteColor];
            titlelabel.font = [UIFont fontWithName:@"Oxygen-Bold" size:13];
            [myimgview addSubview:titlelabel];
            return view;
        }
        else  if (section==3) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
            UIImageView *myimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            myimgview.image=[UIImage imageNamed:@"staffingpath.png"];
            [view addSubview:myimgview];
            UIImageView *myimgview2 = [[UIImageView alloc] initWithFrame:CGRectMake(155,5,25,25)];
            myimgview2.image=[UIImage imageNamed:@"overtime_icon.png"];
            [myimgview addSubview:myimgview2];
            UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 25)];
            titlelabel.text=@"Overtimes";
            titlelabel.textColor=[UIColor whiteColor];
            titlelabel.font = [UIFont fontWithName:@"Oxygen-Bold" size:13];
            [myimgview addSubview:titlelabel];
            return view;
        }
        else if(section==4)
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
            UIImageView *myimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            myimgview.image=[UIImage imageNamed:@"staffingpath.png"];
            [view addSubview:myimgview];
            UIImageView *myimgview2 = [[UIImageView alloc] initWithFrame:CGRectMake(155,5,25,25)];
            myimgview2.image=[UIImage imageNamed:@"leaves1.png"];
            [myimgview addSubview:myimgview2];
            UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 25)];
            titlelabel.text=@"Leaves";
            titlelabel.textColor=[UIColor whiteColor];
            titlelabel.font = [UIFont fontWithName:@"Oxygen-Bold" size:13];
            [myimgview addSubview:titlelabel];
            return view;
        }
        else if (section==5)
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
            UIImageView *myimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            myimgview.image=[UIImage imageNamed:@"staffingpath.png"];
            [view addSubview:myimgview];
            UIImageView *myimgview2 = [[UIImageView alloc] initWithFrame:CGRectMake(155,5,25,25)];
            myimgview2.image=[UIImage imageNamed:@"2.png"];
            [myimgview addSubview:myimgview2];
            UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 25)];
            titlelabel.text=@"Holidays";
            titlelabel.textColor=[UIColor whiteColor];
            titlelabel.font = [UIFont fontWithName:@"Oxygen-Bold" size:13];
            [myimgview addSubview:titlelabel];
            return view;
        }
        else if (section==6)
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
            UIImageView *myimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            myimgview.image=[UIImage imageNamed:@"staffingpath.png"];
            [view addSubview:myimgview];
            UIImageView *myimgview2 = [[UIImageView alloc] initWithFrame:CGRectMake(155,5,25,25)];
            myimgview2.image=[UIImage imageNamed:@"icon_loan.png"];
            [myimgview addSubview:myimgview2];
            UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 25)];
            titlelabel.text=@"Loan";
            titlelabel.textColor=[UIColor whiteColor];
            titlelabel.font = [UIFont fontWithName:@"Oxygen-Bold" size:13];
            [myimgview addSubview:titlelabel];
            return view;
        }
        else
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 36)];
            UIImageView *myimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            myimgview.image=[UIImage imageNamed:@"staffingpath.png"];
            [view addSubview:myimgview];
            UIImageView *myimgview2 = [[UIImageView alloc] initWithFrame:CGRectMake(155,5,25,25)];
            myimgview2.image=[UIImage imageNamed:@"3.png"];
            [myimgview addSubview:myimgview2];
            UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 1, 150, 33)];
            titlelabel.numberOfLines=2;
            titlelabel.text=@"Expense Reimbursement";
            titlelabel.textColor=[UIColor whiteColor];
            titlelabel.font = [UIFont fontWithName:@"Oxygen-Bold" size:13];
            [myimgview addSubview:titlelabel];
            return view;
        }
    }
    else
        return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section==4) || (indexPath.section==5) || (indexPath.section==6) || (indexPath.section==7)) {
        return 30;

    }
    else
        return 75;
}
-(void)displayDetails
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.empNameLabel.text=[self.detailsDict objectForKey:@"emp_name"];
        self.empCodeLabel.text=[self.detailsDict objectForKey:@"e_code"];
        if ([[self.detailsDict objectForKey:@"emp_gender"]isEqualToString:@"M"]) {
            self.genderLabel.text=@"Male";
        }
        else
        {
            self.genderLabel.text=@"Female";
        }
        NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"yyyy-MM-dd"];
        NSString *dobString=[self.detailsDict objectForKey:@"emp_dob"];
        NSDate *dob=[dateFormater dateFromString:dobString];
        [dateFormater setDateFormat:@"dd MMM yyyy"];
        self.dobLabel.text=[dateFormater stringFromDate:dob];
        
        if ([self. detailsDict objectForKey:@"emp_nation_name"]!=(id)[NSNull null]) {
            self.nationalityLabel.text=[self. detailsDict objectForKey:@"emp_nation_name"];
        }
        
        self.bloodGroupLabel.text=[self.detailsDict objectForKey:@"emp_blood_group"];
        self.maritalStatusLabel.text=[self.detailsDict objectForKey:@"emp_marital_ststus"];
        
        [dateFormater setDateFormat:@"yyyy-MM-dd"];
        NSDate *doj=[dateFormater dateFromString:[self.detailsDict objectForKey:@"emp_date_of_join"]];
        [dateFormater setDateFormat:@"dd MMM yyyy"];
        self.dojLabel.text=[dateFormater stringFromDate:doj];
        
        if ([[self.detailsDict objectForKey:@"emp_premise_type"]isEqualToString:@"O"]) {
            self.workingPremisesLabel.text=[self.detailsDict objectForKey:@"office_name"];
        }
        else
        {
            self.workingPremisesLabel.text=[self.detailsDict objectForKey:@"store_name"];
        }
        self.departmentLabel.text=[self.detailsDict objectForKey:@"department_name"];
        self.categoryLabel.text=[self.detailsDict objectForKey:@"cat_name"];
        self.designationLabel.text=[self.detailsDict objectForKey:@"designation_title"];
        self.empStatusLabel.text=[self.detailsDict objectForKey:@"emp_status"];
        
    });
}

-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *desigDetails=[[responseData objectForKey:@"week_rule"] objectForKey:@"selected"];
        if ([desigDetails isKindOfClass:[NSMutableDictionary class]]) {
            self.weekAbbrv=[desigDetails objectForKey:@"abr"];
            self.weekDescription=[desigDetails objectForKey:@"description"];
        }
        
        
        desigDetails=[[responseData objectForKey:@"pay_rule"] objectForKey:@"selected"];
        if ([desigDetails isKindOfClass:[NSMutableDictionary class]]) {
            self.payAbbrv=[desigDetails objectForKey:@"abr"];
            self.payDescription=[desigDetails objectForKey:@"description"];
        }
        desigDetails=[[responseData objectForKey:@"shift"] objectForKey:@"selected"];
        if ([desigDetails isKindOfClass:[NSMutableDictionary class]]) {
            self.shiftAbbrv=[desigDetails objectForKey:@"shift_abbrv"];
            self.shiftDescription=[desigDetails objectForKey:@"shift_description"];
        }
        
        desigDetails=[[responseData objectForKey:@"over_time"] objectForKey:@"selected"];
        if ([desigDetails isKindOfClass:[NSMutableDictionary class]]) {
            self.overtimeAbbrv=[desigDetails objectForKey:@"abr"];
            self.overtimeDescription=[desigDetails objectForKey:@"description"];
        }
        NSMutableArray *desigArray=[responseData objectForKey:@"holidays"];
        for (int i=0; i<desigArray.count; i++) {
            NSMutableDictionary *holidayDict=[desigArray objectAtIndex:i];
            [self.holidayArray addObject:[holidayDict objectForKey:@"holyday_name"]];
            
        }
        
        desigArray=[responseData objectForKey:@"reimbersment"];
        for (int i=0; i<desigArray.count; i++) {
            NSMutableDictionary *reimbersmentDict=[desigArray objectAtIndex:i];
            [self.expenseReimbursementArray addObject:[reimbersmentDict objectForKey:@"expen_abbr"]];
        }
        
        desigArray=[responseData objectForKey:@"leave"];
        for (int i=0; i<desigArray.count; i++) {
            NSMutableDictionary *leaveDict=[desigArray objectAtIndex:i];
            [self.leaveArray addObject:[leaveDict objectForKey:@"leave_abbrv"]];
        }
        
        desigArray=[responseData objectForKey:@"loan"];
        for (int i=0; i<desigArray.count; i++) {
            NSMutableDictionary *loanDict=[desigArray objectAtIndex:i];
            [self.loanArray addObject:[loanDict objectForKey:@"abbreviation"]];
        }
        
        [self.mainTableView reloadData];
    });
   
    
    
    
}

@end
