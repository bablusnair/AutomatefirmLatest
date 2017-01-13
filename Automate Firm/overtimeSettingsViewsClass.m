//
//  overtimeSettingsViewsClass.m
//  Automate Firm
//
//  Created by leonine on 12/4/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "overtimeSettingsViewsClass.h"

#import "groupcollceioncellclass.h"
#import "settingsViewController.h"
@implementation overtimeSettingsViewsClass
@synthesize indexpath,payOTFlag,payOTTextFlag,dropFlag,dropTableFlag,x,y,z,p,q,r,i,j,k,a,b,c,dayFlag,conditionFlag,timeFlag;
-(void)awakeFromNib
{

    [self.mycollectionview registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    timeObj=[[timeConditionsClass alloc]init];
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    //self.mycollectionview.hidden=TRUE;
    
    self.overtimeDict=[[NSMutableDictionary alloc] init];
    self.specificDict=[[NSMutableDictionary alloc] init];
    
    self.action=[[NSUserDefaults standardUserDefaults]objectForKey:@"overtimeAction"];

    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"overtimeAction"]isEqualToString:@"update"])
    {
        [self.myconnection individualOvertimeView:[[NSUserDefaults standardUserDefaults] objectForKey:@"overtimeID"] :[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];
    }
    
    self.flag=0;
    payOTFlag=0;
    payOTTextFlag=0;
    dropFlag=0;
    dropTableFlag=0;
    self.selectedFlag=0;
    self.selectedFlag1=0;
    dayFlag=0;conditionFlag=0;timeFlag=0;
    x=0;y=0;z=0;
    p=0;q=0;r=0;
    i=j=k=0;
    a=b=c=0;
    
    self.reg_date1=self.reg_date2=self.reg_date3=self.reg_ot1=self.reg_ot2=self.reg_ot3=@"";
    self.off_date1=self.off_date2=self.off_date3=self.off_firstDate=self.off_ot1=self.off_ot2=self.off_ot3=@"";
    self.par_date1=self.par_date2=self.par_date3=self.par_firstDate=self.par_ot1=self.par_ot2=self.par_ot3=@"";
    self.hol_date1=self.hol_date2=self.hol_date3=self.hol_firstDate=self.hol_ot1=self.hol_ot2=self.hol_ot3=@"";
    self.reg_pf=self.reg_esi=self.reg_incentives=@"0";
    self.off_same_regular=self.par_same_regular=self.hol_same_regular=@"1";
    
    self.paidLeavesValue=self.paidHolidaysvalue=self.apply7thValue=@"0";
    
    self.currentTab=@"Regular";
    
    self.overtimeTypeArray=[[NSMutableArray alloc]initWithObjects:@"Daily",@"Weekly", nil];
    self.payOTArray=[[NSMutableArray alloc]initWithObjects:@"Time & Quarter (1.25X)",@"Time & Half (1.5X)",@"Double Time (2X)",@"Triple Time (3X)",@"Quadruple Time (4X)",@"Custom Rate per Hour", nil];
    self.payOTDisplayArray=[[NSMutableArray alloc]initWithObjects:@"1.25X",@"1.5X",@"2X",@"3X",@"4X", nil];
    self.payOTDisplayArray1=[[NSMutableArray alloc]initWithObjects:@"Standard Rate",@"1.25X",@"1.5X",@"2X",@"3X",@"4X", nil];
    self.payOTArray1=[[NSMutableArray alloc]initWithObjects:@"Standard Rate",@"Time & Quarter (1.25X)",@"Time & Half (1.5X)",@"Double Time (2X)",@"Triple Time (3X)",@"Quadruple Time (4X)",@"Custom Rate per Hour", nil];
    self.dropArray=[[NSMutableArray alloc]initWithObjects:@"After Standard Working Hours",@"Whole Day",@"First Certain Duration", nil];
    self.workingHoursArray=[[NSMutableArray alloc]initWithObjects:@" Include hours exceeding stand. working hours",@" Exclude hours exceeding stand. working hours", nil];
    
    self.dayArray=[[NSMutableArray alloc]initWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    self.dummyDayArray=[[NSMutableArray alloc]initWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    self.specificConditionArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    self.specificPayOTRateArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    self.conditionsTableView.hidden=true;
    self.conditionArray=[[NSMutableArray alloc] initWithObjects:@"If OT working hours b/w",@"Whole Day apply rate OT 1", nil];
    self.grouparray=[[NSMutableArray alloc] init];
    
    
    self.regularButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.offdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.partialdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.holidayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.specificDayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    
    [self.regularCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    [self.regularCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    [self.regularCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    
    
    self.overtimeTypeTC.hidden=true;
        self.datePickerView.hidden=true;
    self.datePicker1View.hidden=true;
    self.payOTTC.hidden=true;
    
    self.dropTableView.hidden=true;
    self.offDayFirstView.hidden=true;
    self.partialFirstView.hidden=true;
    self.holidayFirstView.hidden=true;
    self.weeklyWorkingHoursTC.hidden=true;
    self.specificDayTC.hidden=true;
    
    self.regularMandatoryLabel1.hidden=true;
    self.regularMandatoryLabel2.hidden=true;
    self.offdayMandatoryLabel1.hidden=true;
    self.offdayMandatoryLabel2.hidden=true;
    self.partialMandatoryLabel1.hidden=true;
    self.partialMandatoryLabel2.hidden=true;
    self.holidayMandatoryLabel1.hidden=true;
    self.holidayMandatoryLabel2.hidden=true;
    self.weeklyMandatoryLabel1.hidden=true;
    
    
    [self resetRegularDailyLimit];
    
    [self resetDay1];
    
    self.secondView.hidden=true;
    self.thirdView.hidden=true;
    self.fourthView.hidden=true;
    self.fifthView.hidden=true;
    self.sixthView.hidden=true;
    self.seventhView.hidden=true;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self.datePicker addTarget:self action:@selector(datePickedValueChanged:)
               forControlEvents:UIControlEventValueChanged];

    
    //Set the appearance of uidatepicker
    
    [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[UIDatePicker class]]]
     setBackgroundColor:[UIColor clearColor]];
  
    
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
    if(tableView==self.overtimeTypeTC)
    {
        return self.overtimeTypeArray.count;
    }
    else if(tableView==self.payOTTC)
    {
        if(dropTableFlag==0)
        {
            return  self.payOTArray.count;
        }
        else
        {
            return self.payOTArray1.count;
        }
    }
    else if(tableView==self.dropTableView)
    {
        return self.dropArray.count;
    }
    else if(tableView==self.weeklyWorkingHoursTC)
    {
        return self.workingHoursArray.count;
    }
    else if(tableView==self.specificDayTC)
    {
        return  self.dayArray.count;
    }
    else
    {
        return self.conditionArray.count;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.overtimeTypeTC) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.overtimeTypeArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return  cell;
    }
    else if(tableView==self.payOTTC)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        if (dropTableFlag==0) {
            cell.textLabel.text=[self.payOTArray objectAtIndex: indexPath.row];
        }
        else
        {
            cell.textLabel.text=[self.payOTArray1 objectAtIndex: indexPath.row];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return  cell;
    }
    else if(tableView==self.dropTableView)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.dropArray objectAtIndex: indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return cell;
    }
    else if(tableView==self.weeklyWorkingHoursTC)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"str"];
       
        cell.textLabel.font=[UIFont systemFontOfSize:11];
        cell.textLabel.text=[self.workingHoursArray objectAtIndex:indexPath.row];
        return  cell;
    }
    else if(tableView==self.specificDayTC)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.dayArray objectAtIndex: indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return cell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.conditionArray objectAtIndex: indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.overtimeTypeTC) {
        if (indexPath.row==0) {
            [self regulardayAction];
            [self resetWeeklyDailyLimit];
            [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            self.offdayButton.enabled=YES;
            self.partialdayButton.enabled=YES;
            self.holidayButton.enabled=YES;
            self.specificDayButton.enabled=YES;
            self.partialdayIcon.image=[UIImage imageNamed:@"partial_day_blue.png"];
            self.offdayIcon.image=[UIImage imageNamed:@"off_day_blue.png"];
            self.holidayIcon.image=[UIImage imageNamed:@"holiday_blue.png"];
            self.specificdayIcon.image=[UIImage imageNamed:@"specific_day_blue.png"];
        }
        else if (indexPath.row==1)
        {
            [self resetRegularDailyLimit];
            [self resetOffdayDailyLimit];
            [self resetPartialDialyLimit];
            [self resetHolidayDialyLimit];
            [self resetDay1];
            
            self.partialdayIcon.image=[UIImage imageNamed:@"partial_day__grey.png"];
            self.offdayIcon.image=[UIImage imageNamed:@"off_day_grey.png"];
            self.holidayIcon.image=[UIImage imageNamed:@"holiday_grey.png"];
            self.specificdayIcon.image=[UIImage imageNamed:@"specific_day_grey.png"];

            
            [self resetWeeklyDailyLimit];
            self.currentTab=@"Weekly";
            self.regularButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            self.offdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
            self.partialdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
            self.holidayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
            self.specificDayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
            [self.regularButton setImage:[UIImage imageNamed:@"tab_1_active.png"] forState:UIControlStateNormal];
            self.offdayButton.enabled=NO;
            [self.offdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
            self.partialdayButton.enabled=NO;
            [self.partialdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
            self.holidayButton.enabled=NO;
            [self.holidayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
            self.specificDayButton.enabled=NO;
            [self.specificDayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
            [self.contentScrollView setContentOffset:CGPointMake(2965, 0) animated:NO];
        }
        self.overtimeTypeText.text=[self.overtimeTypeArray objectAtIndex:indexPath.row];
        self.overtimeTypeTC.hidden=true;
    }
    else if (tableView==self.payOTTC)
    {
        if (payOTFlag==1) {
            if (indexPath.row==5) {
                self.regularPayOTText1.text=@"";
                payOTTextFlag=1;
                [self.regularPayOTText1 becomeFirstResponder];
                self.payOTTC.hidden=true;
            }
            else
            {
                self.regularPayOTText1.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                self.reg_ot1=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                self.regularAfterText1.backgroundColor=[UIColor clearColor];
                self.regularAfterText1.userInteractionEnabled=true;
                self.doneButton.enabled=YES;
                self.payOTTC.hidden=true;
            }
        }
        if (payOTFlag==2) {
            if (indexPath.row==5) {
                payOTTextFlag=1;
                self.regularPayOTText2.text=@"";
                [self.regularPayOTText2 becomeFirstResponder];
                self.payOTTC.hidden=true;
            }
            else
            {
                self.regularAfterText2.backgroundColor=[UIColor clearColor];
                self.regularAfterText2.userInteractionEnabled=true;
                self.selectedFlag=0;
                self.regularMandatoryLabel1.hidden=true;
                if (dropTableFlag==0) {
                    self.regularPayOTText2.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    
                    self.reg_ot2=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                }
                else
                {
                    self.regularPayOTText2.text=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                    self.reg_ot2=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                }
                self.payOTTC.hidden=true;
            }
        }
        if (payOTFlag==3) {
            if (indexPath.row==5) {
                payOTTextFlag=1;
                self.regularPayOTText3.text=@"";
                [self.regularPayOTText3 becomeFirstResponder];
                self.payOTTC.hidden=true;
            }
            else
            {
                self.selectedFlag1=0;
                self.regularMandatoryLabel2.hidden=true;
                if (dropTableFlag==0) {
                    self.regularPayOTText3.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.reg_ot3=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                }
                else
                {
                    self.regularPayOTText3.text=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                    self.reg_ot3=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                }
                self.payOTTC.hidden=true;
            }
        }
        if (payOTFlag==4) {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.offdayPayOTText1.text=@"";
                    [self.offdayPayOTText1 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.offdayAfterText1.backgroundColor=[UIColor clearColor];
                    self.offdayAfterText1.userInteractionEnabled=true;
                    self.offdayPayOTText1.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.off_ot1=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.payOTTC.hidden=true;
                    self.doneButton.enabled=YES;
                }

            }
            else
            {
                if (indexPath.row==6) {
                    payOTTextFlag=1;
                    self.offdayPayOTText1.text=@"";
                    [self.offdayPayOTText1 becomeFirstResponder];
                    
                    
                    self.offdayAfterText1.backgroundColor=[UIColor lightGrayColor];
                    self.offdayPayOTText2.userInteractionEnabled=YES;
                    self.offdayPayOTText2.backgroundColor=[UIColor clearColor];
                   //
                    self.offdayAfterText1.text=[self.offDayFirstText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSArray *myarray=[self.offdayAfterText1.text componentsSeparatedByString:@" "];
                    self.off_date2=[NSString stringWithFormat:@"%@:%@",[myarray objectAtIndex:0],[myarray objectAtIndex:2]];
                    //
                    self.offdayAfterText1.userInteractionEnabled=NO;
                    
                    
                    self.payOTTC.hidden=true;
                }
                else //if (indexPath.row==0)
                {
                    self.doneButton.enabled=YES;
                    self.offdayAfterText1.backgroundColor=[UIColor lightGrayColor];
                    self.offdayPayOTText2.userInteractionEnabled=YES;
                    self.offdayPayOTText2.backgroundColor=[UIColor clearColor];
                    
                    self.offdayPayOTText1.text=[self.payOTDisplayArray1 objectAtIndex:indexPath.row];
                    self.off_ot1=[self.payOTDisplayArray1 objectAtIndex:indexPath.row];
                    self.offdayAfterText1.text=[self.offDayFirstText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSArray *myarray=[self.offdayAfterText1.text componentsSeparatedByString:@" "];
                    self.off_date2=[NSString stringWithFormat:@"%@:%@",[myarray objectAtIndex:0],[myarray objectAtIndex:2]];
                    self.offdayAfterText1.userInteractionEnabled=NO;
                    self.offdayAfterText1.backgroundColor=[UIColor clearColor];
                    self.payOTTC.hidden=true;
                }
            }
            
        }
        if (payOTFlag==5) {
            if(dropTableFlag==0)
            {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.offdayPayOTText2.text=@"";
                    [self.offdayPayOTText2 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.selectedFlag=0;
                    self.offdayMandatoryLabel1.hidden=true;
                    self.offdayAfterText2.backgroundColor=[UIColor clearColor];
                    self.offdayAfterText2.userInteractionEnabled=true;
                    self.offdayPayOTText2.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.off_ot2=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.payOTTC.hidden=true;
                }

            }
            else
            {
                if (indexPath.row==6) {
                    payOTTextFlag=1;
                    self.offdayPayOTText2.text=@"";
                    [self.offdayPayOTText2 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.selectedFlag=0;
                    self.offdayMandatoryLabel1.hidden=true;
                    self.offdayAfterText2.backgroundColor=[UIColor clearColor];
                    self.offdayAfterText2.userInteractionEnabled=true;
                    self.offdayPayOTText2.text=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                    self.off_ot2=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                    self.payOTTC.hidden=true;
                }

            }
        }
        if (payOTFlag==6) {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.offdayPayOTText3.text=@"";
                    [self.offdayPayOTText3 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.selectedFlag1=0;
                    self.offdayMandatoryLabel2.hidden=true;
                    self.offdayPayOTText3.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.off_ot3=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.payOTTC.hidden=true;
                }

            }
            else
            {
                if (indexPath.row==6) {
                    payOTTextFlag=1;
                    self.offdayPayOTText3.text=@"";
                    [self.offdayPayOTText3 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.selectedFlag1=0;
                    self.offdayMandatoryLabel2.hidden=true;
                    self.offdayPayOTText3.text=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                    self.off_ot3=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                    self.payOTTC.hidden=true;
                }
            }
        }
        
        
        if (payOTFlag==7) {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.partialPayOTText1.text=@"";
                    [self.partialPayOTText1 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.doneButton.enabled=YES;
                    self.partialAfterText1.backgroundColor=[UIColor clearColor];
                    self.partialAfterText1.userInteractionEnabled=true;
                    self.partialPayOTText1.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.par_ot1=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.payOTTC.hidden=true;
                }
                
            }
            else
            {
                if (indexPath.row==6) {
                    payOTTextFlag=1;
                    self.partialPayOTText1.text=@"";
                    [self.partialPayOTText1 becomeFirstResponder];
                    
                    
                    self.partialAfterText1.text=[self.partialFirstText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSArray *myarray=[self.partialAfterText1.text componentsSeparatedByString:@" "];
                    self.par_date2=[NSString stringWithFormat:@"%@:%@",[myarray objectAtIndex:0],[myarray objectAtIndex:2]];
                   
                    
                    self.partialAfterText1.backgroundColor=[UIColor lightGrayColor];
                    self.partialAfterText1.userInteractionEnabled=NO;
                    self.partialPayOTText2.backgroundColor=[UIColor clearColor];
                    self.partialPayOTText2.userInteractionEnabled=YES;
                    
                    self.payOTTC.hidden=true;
                }
                else //if (indexPath.row==0)
                {
                    self.doneButton.enabled=YES;
                    self.par_ot1=self.partialPayOTText1.text=[self.payOTDisplayArray1 objectAtIndex:indexPath.row];
                    
                    self.partialAfterText1.text=[self.partialFirstText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];                    NSArray *myarray=[self.partialAfterText1.text componentsSeparatedByString:@" "];
                    self.par_date2=[NSString stringWithFormat:@"%@:%@",[myarray objectAtIndex:0],[myarray objectAtIndex:2]];
                    
                    self.partialAfterText1.backgroundColor=[UIColor lightGrayColor];
                    self.partialAfterText1.userInteractionEnabled=NO;
                    self.partialPayOTText2.backgroundColor=[UIColor clearColor];
                    self.partialPayOTText2.userInteractionEnabled=YES;
                    self.payOTTC.hidden=true;
                }
            }
            
        }
        
        if (payOTFlag==8) {
            if(dropTableFlag==0)
            {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.partialPayOTText2.text=@"";
                    [self.partialPayOTText2 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.par_ot2=self.partialPayOTText2.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.selectedFlag=0;
                    self.partialMandatoryLabel1.hidden=true;
                    self.partialAfterText2.backgroundColor=[UIColor clearColor];
                    self.partialAfterText2.userInteractionEnabled=true;
                    self.payOTTC.hidden=true;
                }
                
            }
            else
            {
                if (indexPath.row==6) {
                    payOTTextFlag=1;
                    self.partialPayOTText2.text=@"";
                    [self.partialPayOTText2 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.par_ot2=self.partialPayOTText2.text=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                    self.selectedFlag=0;
                    self.partialMandatoryLabel1.hidden=true;
                    self.partialAfterText2.backgroundColor=[UIColor clearColor];
                    self.partialAfterText2.userInteractionEnabled=true;
                    self.payOTTC.hidden=true;
                }
                
            }

        }
        if (payOTFlag==9) {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.partialPayOTText3.text=@"";
                    [self.partialPayOTText3 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.par_ot3=self.partialPayOTText3.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.partialMandatoryLabel2.hidden=true;
                    self.selectedFlag1=0;
                    self.payOTTC.hidden=true;
                }
                
            }
            else
            {
                if (indexPath.row==6) {
                    payOTTextFlag=1;
                    self.partialPayOTText3.text=@"";
                    [self.partialPayOTText3 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.par_ot3=self.partialPayOTText3.text=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                    self.selectedFlag1=0;
                    self.partialMandatoryLabel2.hidden=true;
                    self.payOTTC.hidden=true;
                }
            }

        }
        if (payOTFlag==10) {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.holidayPayOTText1.text=@"";
                    [self.holidayPayOTText1 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.doneButton.enabled=YES;
                    self.hol_ot1=self.holidayPayOTText1.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.holidayAfterText1.backgroundColor=[UIColor clearColor];
                    self.holidayAfterText1.userInteractionEnabled=true;
                    self.payOTTC.hidden=true;
                }
                
            }
            else
            {
                if (indexPath.row==6) {
                    payOTTextFlag=1;
                    self.holidayPayOTText1.text=@"";
                    [self.holidayPayOTText1 becomeFirstResponder];
                    
                    self.holidayAfterText1.text=[self.holidayFirstText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];                    NSArray *myarray=[self.holidayAfterText1.text componentsSeparatedByString:@" "];
                    self.hol_date2=[NSString stringWithFormat:@"%@:%@",[myarray objectAtIndex:0],[myarray objectAtIndex:2]];
                    
                    
                    self.holidayAfterText1.userInteractionEnabled=NO;
                    
                    self.holidayAfterText1.backgroundColor=[UIColor lightGrayColor];
                    self.holidayPayOTText2.backgroundColor=[UIColor clearColor];
                    self.holidayPayOTText2.userInteractionEnabled=true;
                    
                    self.payOTTC.hidden=true;
                }
                else //if (indexPath.row==0)
                {
                    self.doneButton.enabled=YES;
                    self.hol_ot1=self.holidayPayOTText1.text=[self.payOTDisplayArray1 objectAtIndex:indexPath.row];
                    
                    
                    self.holidayAfterText1.text=[self.holidayFirstText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];                    NSArray *myarray=[self.holidayAfterText1.text componentsSeparatedByString:@" "];
                    self.hol_date2=[NSString stringWithFormat:@"%@:%@",[myarray objectAtIndex:0],[myarray objectAtIndex:2]];
                    
                    
                    self.holidayAfterText1.userInteractionEnabled=NO;
                    self.holidayAfterText1.backgroundColor=[UIColor lightGrayColor];
                    self.holidayPayOTText2.backgroundColor=[UIColor clearColor];
                    self.holidayPayOTText2.userInteractionEnabled=true;
                    self.payOTTC.hidden=true;
                }
            }
            
        }
        if (payOTFlag==11) {
            if(dropTableFlag==0)
            {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.holidayPayOTText2.text=@"";
                    [self.holidayPayOTText2 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.hol_ot2=self.holidayPayOTText2.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.holidayAfterText2.backgroundColor=[UIColor clearColor];
                    self.holidayAfterText2.userInteractionEnabled=true;
                    self.selectedFlag=0;
                    self.holidayMandatoryLabel1.hidden=true;
                    self.payOTTC.hidden=true;
                }
                
            }
            else
            {
                if (indexPath.row==6) {
                    payOTTextFlag=1;
                    self.holidayPayOTText2.text=@"";
                    [self.holidayPayOTText2 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.hol_ot2=self.holidayPayOTText2.text=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                    self.holidayAfterText2.backgroundColor=[UIColor clearColor];
                    self.holidayAfterText2.userInteractionEnabled=true;
                    self.selectedFlag=0;
                    self.holidayMandatoryLabel1.hidden=true;
                    self.payOTTC.hidden=true;
                }
                
            }
            
        }
        if (payOTFlag==12) {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.holidayPayOTText3.text=@"";
                    [self.holidayPayOTText3 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.hol_ot3=self.holidayPayOTText3.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.selectedFlag1=0;
                    self.holidayMandatoryLabel2.hidden=true;
                    self.payOTTC.hidden=true;
                }
                
            }
            else
            {
                if (indexPath.row==6) {
                    payOTTextFlag=1;
                    self.holidayPayOTText3.text=@"";
                    [self.holidayPayOTText3 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.hol_ot3=self.holidayPayOTText3.text=[self.payOTDisplayArray1 objectAtIndex: indexPath.row];
                    self.selectedFlag1=0;
                    self.holidayMandatoryLabel2.hidden=true;
                    self.payOTTC.hidden=true;
                }
            }
            
        }
        else if (payOTFlag==13)
        {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.weeklyPayOTText1.text=@"";
                    [self.weeklyPayOTText1 becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.reg_ot1=self.weeklyPayOTText1.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    self.selectedFlag=0;
                    self.doneButton.enabled=YES;
                    self.payOTTC.hidden=true;
                }
                
            }

        }
        else if (payOTFlag==14)
        {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    
                    self.payOTTC.hidden=true;
                }
                else
                {
                    
                    self.selectedFlag1=0;
                    self.payOTTC.hidden=true;
                }
                
            }

        }
        else if (payOTFlag==15)
        {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.specificPayOT1Text.text=@"";
                    [self.specificPayOT1Text becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.specificPayOT1Text.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    [self.specificPayOTRateArray replaceObjectAtIndex:0 withObject:self.specificPayOT1Text.text];
                    self.selectedFlag=0;
                    self.secondView.hidden=false;
                    [self resetDay2];
                    self.payOTTC.hidden=true;
                    self.doneButton.enabled=YES;
                }
                
            }

        }
        else if (payOTFlag==16)
        {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.specificPayOT2Text.text=@"";
                    [self.specificPayOT2Text becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.specificPayOT2Text.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    [self.specificPayOTRateArray replaceObjectAtIndex:1 withObject:self.specificPayOT2Text.text];
                    self.selectedFlag=0;
                    self.thirdView.hidden=false;
                    [self resetDay3];
                    self.payOTTC.hidden=true;
                    self.doneButton.enabled=YES;
                }
                
            }
            
        }
        else if (payOTFlag==17)
        {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.specificPayOT3Text.text=@"";
                    [self.specificPayOT3Text becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.specificPayOT3Text.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    [self.specificPayOTRateArray replaceObjectAtIndex:2 withObject:self.specificPayOT3Text.text];
                    self.selectedFlag=0;
                    self.fourthView.hidden=false;
                    [self resetDay4];
                    self.payOTTC.hidden=true;
                    self.doneButton.enabled=YES;
                }
                
            }
            
        }
        else if (payOTFlag==18)
        {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.specificPayOT4Text.text=@"";
                    [self.specificPayOT4Text becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.specificPayOT4Text.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    [self.specificPayOTRateArray replaceObjectAtIndex:3 withObject:self.specificPayOT4Text.text];
                    self.selectedFlag=0;
                    self.fifthView.hidden=false;
                    [self resetDay5];
                    self.payOTTC.hidden=true;
                    self.doneButton.enabled=YES;
                }
                
            }
            
        }
        else if (payOTFlag==19)
        {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.specificPayOT5Text.text=@"";
                    [self.specificPayOT5Text becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.specificPayOT5Text.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    [self.specificPayOTRateArray replaceObjectAtIndex:4 withObject:self.specificPayOT5Text.text];
                    self.selectedFlag=0;
                    self.sixthView.hidden=false;
                    [self resetDay6];
                    self.payOTTC.hidden=true;
                    self.doneButton.enabled=YES;
                }
                
            }
            
        }
        else if (payOTFlag==20)
        {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.specificPayOT6Text.text=@"";
                    [self.specificPayOT6Text becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.specificPayOT6Text.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    [self.specificPayOTRateArray replaceObjectAtIndex:5 withObject:self.specificPayOT6Text.text];
                    self.selectedFlag=0;
                    self.seventhView.hidden=false;
                    [self resetDay7];
                    self.payOTTC.hidden=true;
                    self.doneButton.enabled=YES;
                }
                
            }
            
        }
        else if (payOTFlag==21)
        {
            if (dropTableFlag==0) {
                if (indexPath.row==5) {
                    payOTTextFlag=1;
                    self.specificPayOT7Text.text=@"";
                    [self.specificPayOT7Text becomeFirstResponder];
                    self.payOTTC.hidden=true;
                }
                else
                {
                    self.specificPayOT7Text.text=[self.payOTDisplayArray objectAtIndex: indexPath.row];
                    [self.specificPayOTRateArray replaceObjectAtIndex:6 withObject:self.specificPayOT7Text.text];
                    self.selectedFlag=0;
                    
                    self.payOTTC.hidden=true;
                    self.doneButton.enabled=YES;
                }
                
            }
            
        }
       
    }
    else if(tableView==self.dropTableView)
    {
        if (dropFlag==1) {
            if (indexPath.row==1) {
                dropTableFlag=0;
                [self.payOTTC reloadData];
                [self resetOffdayFirstText];
                self.offDayDropView.hidden=false;
                self.offDayFirstView.hidden=true;
                self.offDaywholeView.hidden=true;
                self.offdayPayOTText1.backgroundColor=[UIColor clearColor];
                self.offdayPayOTText1.userInteractionEnabled=true;
                
            }
            else if (indexPath.row==0)
            {
                dropTableFlag=0;
                [self.payOTTC reloadData];
                [self resetOffdayFirstText];
                self.offDayDropView.hidden=false;
                self.offDayFirstView.hidden=true;
                self.offDaywholeView.hidden=false;
                self.offdayPayOTText1.text=@"";
                self.offdayAfterText1.text=@"";
                self.offdayAfterText1.userInteractionEnabled=NO;
                self.offdayAfterText1.backgroundColor=[UIColor lightGrayColor];
                self.offdayPayOTText1.backgroundColor=[UIColor clearColor];
                self.offdayPayOTText1.userInteractionEnabled=true;
            }
            else if (indexPath.row==2)
            {
                dropTableFlag=1;
                [self.payOTTC reloadData];
                [self resetOffdayFirstText];
                self.offDayDropView.hidden=true;
                self.offDayFirstView.hidden=false;
                self.offDaywholeView.hidden=false;
                self.offdayPayOTText1.backgroundColor=[UIColor lightGrayColor];
                self.offdayPayOTText1.userInteractionEnabled=false;
                self.offDayFirstView.frame=CGRectMake(600, 120, self.offDayFirstView.frame.size.width, self.offDayFirstView.frame.size.height);
            }
            self.dropLabel1.text=[self.dropArray objectAtIndex:indexPath.row];
            self.dropTableView.hidden=true;
        }
        else if(dropFlag==2)
        {
            if (indexPath.row==1) {
                dropTableFlag=0;
                [self.payOTTC reloadData];
                [self resetPartialFirstText];
                self.partialDropView.hidden=false;
                self.partialFirstView.hidden=true;
                self.partialWholeView.hidden=true;
                self.partialPayOTText1.backgroundColor=[UIColor clearColor];
                self.partialPayOTText1.userInteractionEnabled=true;
                
            }
            else if (indexPath.row==0)
            {
                dropTableFlag=0;
                [self.payOTTC reloadData];
                [self resetPartialFirstText];
                self.partialDropView.hidden=false;
                self.partialFirstView.hidden=true;
                self.partialWholeView.hidden=false;
                self.partialPayOTText1.backgroundColor=[UIColor clearColor];
                self.partialPayOTText1.userInteractionEnabled=true;
            }
            else if (indexPath.row==2)
            {
                dropTableFlag=1;
                [self.payOTTC reloadData];
                [self resetPartialFirstText];
                self.partialDropView.hidden=true;
                self.partialFirstView.hidden=false;
                self.partialWholeView.hidden=false;
                self.partialPayOTText1.backgroundColor=[UIColor lightGrayColor];
                self.partialPayOTText1.userInteractionEnabled=false;
                self.partialFirstView.frame=CGRectMake(1193, 120, self.partialFirstView.frame.size.width, self.partialFirstView.frame.size.height);
            }
            self.dropLabel2.text=[self.dropArray objectAtIndex:indexPath.row];
            self.dropTableView.hidden=true;

        }
        else if (dropFlag==3)
        {
            if (indexPath.row==1) {
                dropTableFlag=0;
                [self.payOTTC reloadData];
                [self resetHolidayFirstText];
                self.holidayDropView.hidden=false;
                self.holidayFirstView.hidden=true;
                self.holidayWholeView.hidden=true;
                self.holidayPayOTText1.backgroundColor=[UIColor clearColor];
                self.holidayPayOTText1.userInteractionEnabled=true;
                
            }
            else if (indexPath.row==0)
            {
                dropTableFlag=0;
                [self.payOTTC reloadData];
                [self resetHolidayFirstText];
                self.holidayDropView.hidden=false;
                self.holidayFirstView.hidden=true;
                self.holidayWholeView.hidden=false;
                self.holidayPayOTText1.backgroundColor=[UIColor clearColor];
                self.holidayPayOTText1.userInteractionEnabled=true;
            }
            else if (indexPath.row==2)
            {
                dropTableFlag=1;
                [self.payOTTC reloadData];
                [self resetHolidayFirstText];
                self.holidayDropView.hidden=true;
                self.holidayFirstView.hidden=false;
                self.holidayWholeView.hidden=false;
                self.holidayPayOTText1.backgroundColor=[UIColor lightGrayColor];
                self.holidayPayOTText1.userInteractionEnabled=false;
                self.holidayFirstView.frame=CGRectMake(1786, 120, self.holidayFirstView.frame.size.width, self.holidayFirstView.frame.size.height);
            }
            self.dropLabel3.text=[self.dropArray objectAtIndex:indexPath.row];
            self.dropTableView.hidden=true;
        }
    }
    else if (tableView==self.weeklyWorkingHoursTC)
    {
        self.weeklyWorkingHoursText.text=[self.workingHoursArray objectAtIndex: indexPath.row];
        self.weeklyWorkingHoursTC.hidden=true;
    }
    else if (tableView==self.specificDayTC)
    {
        if (dayFlag==1) {
            self.specificDay1Text.text=[self.dayArray objectAtIndex: indexPath.row];
            [self.dayArray removeObject:self.specificDay1Text.text];
            self.specificCondition1Text.backgroundColor=[UIColor clearColor];
            self.specificCondition1Text.userInteractionEnabled=YES;
            self.doneButton.enabled=NO;
            
        }
        else if (dayFlag==2)
        {
            self.specificDay2Text.text=[self.dayArray objectAtIndex: indexPath.row];
            [self.dayArray removeObject:self.specificDay2Text.text];
            self.specificCondition2Text.backgroundColor=[UIColor clearColor];
            self.specificCondition2Text.userInteractionEnabled=YES;
            self.doneButton.enabled=NO;
        }
        else if (dayFlag==3)
        {
            self.specificDay3Text.text=[self.dayArray objectAtIndex: indexPath.row];
            [self.dayArray removeObject:self.specificDay3Text.text];
            self.specificCondition3Text.backgroundColor=[UIColor clearColor];
            self.specificCondition3Text.userInteractionEnabled=YES;
            self.doneButton.enabled=NO;
        }
        else if (dayFlag==4)
        {
            self.specificDay4Text.text=[self.dayArray objectAtIndex: indexPath.row];
            [self.dayArray removeObject:self.specificDay4Text.text];
            self.specificCondition4Text.backgroundColor=[UIColor clearColor];
            self.specificCondition4Text.userInteractionEnabled=YES;
            self.doneButton.enabled=NO;
        }
        else if (dayFlag==5)
        {
            self.specificDay5Text.text=[self.dayArray objectAtIndex: indexPath.row];
            [self.dayArray removeObject:self.specificDay5Text.text];
            self.specificCondition5Text.backgroundColor=[UIColor clearColor];
            self.specificCondition5Text.userInteractionEnabled=YES;
            self.doneButton.enabled=NO;
        }
        else if (dayFlag==6)
        {
            self.specificDay6Text.text=[self.dayArray objectAtIndex: indexPath.row];
            [self.dayArray removeObject:self.specificDay6Text.text];
            self.specificCondition6Text.backgroundColor=[UIColor clearColor];
            self.specificCondition6Text.userInteractionEnabled=YES;
            self.doneButton.enabled=NO;
        }
        else if (dayFlag==7)
        {
            self.specificDay7Text.text=[self.dayArray objectAtIndex: indexPath.row];
            [self.dayArray removeObject:self.specificDay7Text.text];
            self.specificCondition7Text.backgroundColor=[UIColor clearColor];
            self.specificCondition7Text.userInteractionEnabled=YES;
            self.doneButton.enabled=NO;
        }
        self.specificDayTC.hidden=true;
    }
    else if (tableView==self.conditionsTableView)
    {
        if (conditionFlag==1) {
            if (indexPath.row==0) {
                self.specificFromTime1Text.text=@"";
                self.specificFromTime1Text.backgroundColor=[UIColor clearColor];
                self.specificFromTime1Text.userInteractionEnabled=YES;
                self.specificPayOT1Text.text=@"";
                self.specificPayOT1Text.backgroundColor=[UIColor lightGrayColor];
                self.specificPayOT1Text.userInteractionEnabled=NO;
                [self.specificConditionArray replaceObjectAtIndex:0 withObject:@"spec_hrs_bw"];
            }
            else
            {
                self.specificFromTime1Text.text=@"00:00";
                self.specificFromTime1Text.backgroundColor=[UIColor lightGrayColor];
                self.specificFromTime1Text.userInteractionEnabled=NO;
                self.specificToTime1Text.text=@"00:00";
                self.specificToTime1Text.backgroundColor=[UIColor lightGrayColor];
                self.specificToTime1Text.userInteractionEnabled=NO;
                self.specificPayOT1Text.text=@"";
                self.specificPayOT1Text.backgroundColor=[UIColor clearColor];
                self.specificPayOT1Text.userInteractionEnabled=YES;
                [self.specificConditionArray replaceObjectAtIndex:0 withObject:@"spec_whole_day"];
            }
            self.specificCondition1Text.text=[self.conditionArray objectAtIndex:indexPath.row];
            self.conditionsTableView.hidden=true;
        }
        if (conditionFlag==2) {
            if (indexPath.row==0) {
                self.specificFromTime2Text.text=@"";
                self.specificFromTime2Text.backgroundColor=[UIColor clearColor];
                self.specificFromTime2Text.userInteractionEnabled=YES;
                self.specificPayOT2Text.text=@"";
                self.specificPayOT2Text.backgroundColor=[UIColor lightGrayColor];
                self.specificPayOT2Text.userInteractionEnabled=NO;
                [self.specificConditionArray replaceObjectAtIndex:1 withObject:@"spec_hrs_bw"];
                
            }
            else
            {
                self.specificFromTime2Text.text=@"00:00";
                self.specificFromTime2Text.backgroundColor=[UIColor lightGrayColor];
                self.specificFromTime2Text.userInteractionEnabled=NO;
                self.specificToTime2Text.text=@"00:00";
                self.specificToTime2Text.backgroundColor=[UIColor lightGrayColor];
                self.specificToTime2Text.userInteractionEnabled=NO;
                self.specificPayOT2Text.text=@"";
                self.specificPayOT2Text.backgroundColor=[UIColor clearColor];
                self.specificPayOT2Text.userInteractionEnabled=YES;
                [self.specificConditionArray replaceObjectAtIndex:1 withObject:@"spec_whole_day"];
            }
            self.specificCondition2Text.text=[self.conditionArray objectAtIndex:indexPath.row];
            self.conditionsTableView.hidden=true;
        }
        if (conditionFlag==3) {
            if (indexPath.row==0) {
                self.specificFromTime3Text.text=@"";
                self.specificFromTime3Text.backgroundColor=[UIColor clearColor];
                self.specificFromTime3Text.userInteractionEnabled=YES;
                self.specificPayOT3Text.text=@"";
                self.specificPayOT3Text.backgroundColor=[UIColor lightGrayColor];
                self.specificPayOT3Text.userInteractionEnabled=NO;
                [self.specificConditionArray replaceObjectAtIndex:2 withObject:@"spec_hrs_bw"];
                
            }
            else
            {
                self.specificFromTime3Text.text=@"00:00";
                self.specificFromTime3Text.backgroundColor=[UIColor lightGrayColor];
                self.specificFromTime3Text.userInteractionEnabled=NO;
                self.specificToTime3Text.text=@"00:00";
                self.specificToTime3Text.backgroundColor=[UIColor lightGrayColor];
                self.specificToTime3Text.userInteractionEnabled=NO;
                self.specificPayOT3Text.text=@"";
                self.specificPayOT3Text.backgroundColor=[UIColor clearColor];
                self.specificPayOT3Text.userInteractionEnabled=YES;
                [self.specificConditionArray replaceObjectAtIndex:2 withObject:@"spec_whole_day"];
            }
            self.specificCondition3Text.text=[self.conditionArray objectAtIndex:indexPath.row];
            self.conditionsTableView.hidden=true;
        }
        if (conditionFlag==4) {
            if (indexPath.row==0) {
                self.specificFromTime4Text.text=@"";
                self.specificFromTime4Text.backgroundColor=[UIColor clearColor];
                self.specificFromTime4Text.userInteractionEnabled=YES;
                self.specificPayOT4Text.text=@"";
                self.specificPayOT4Text.backgroundColor=[UIColor lightGrayColor];
                self.specificPayOT4Text.userInteractionEnabled=NO;
                [self.specificConditionArray replaceObjectAtIndex:3 withObject:@"spec_hrs_bw"];
                
            }
            else
            {
                self.specificFromTime4Text.text=@"00:00";
                self.specificFromTime4Text.backgroundColor=[UIColor lightGrayColor];
                self.specificFromTime4Text.userInteractionEnabled=NO;
                self.specificToTime4Text.text=@"00:00";
                self.specificToTime4Text.backgroundColor=[UIColor lightGrayColor];
                self.specificToTime4Text.userInteractionEnabled=NO;
                self.specificPayOT4Text.text=@"";
                self.specificPayOT4Text.backgroundColor=[UIColor clearColor];
                self.specificPayOT4Text.userInteractionEnabled=YES;
                [self.specificConditionArray replaceObjectAtIndex:3 withObject:@"spec_whole_day"];
            }
            self.specificCondition4Text.text=[self.conditionArray objectAtIndex:indexPath.row];
            self.conditionsTableView.hidden=true;
        }
        
        if (conditionFlag==5) {
            if (indexPath.row==0) {
                self.specificFromTime5Text.text=@"";
                self.specificFromTime5Text.backgroundColor=[UIColor clearColor];
                self.specificFromTime5Text.userInteractionEnabled=YES;
                self.specificPayOT5Text.text=@"";
                self.specificPayOT5Text.backgroundColor=[UIColor lightGrayColor];
                self.specificPayOT5Text.userInteractionEnabled=NO;
                [self.specificConditionArray replaceObjectAtIndex:4 withObject:@"spec_hrs_bw"];
                
            }
            else
            {
                self.specificFromTime5Text.text=@"00:00";
                self.specificFromTime5Text.backgroundColor=[UIColor lightGrayColor];
                self.specificFromTime5Text.userInteractionEnabled=NO;
                self.specificToTime5Text.text=@"00:00";
                self.specificToTime5Text.backgroundColor=[UIColor lightGrayColor];
                self.specificToTime5Text.userInteractionEnabled=NO;
                self.specificPayOT5Text.text=@"";
                self.specificPayOT5Text.backgroundColor=[UIColor clearColor];
                self.specificPayOT5Text.userInteractionEnabled=YES;
                [self.specificConditionArray replaceObjectAtIndex:4 withObject:@"spec_whole_day"];
            }
            self.specificCondition5Text.text=[self.conditionArray objectAtIndex:indexPath.row];
            self.conditionsTableView.hidden=true;
        }
        if (conditionFlag==6) {
            if (indexPath.row==0) {
                self.specificFromTime6Text.text=@"";
                self.specificFromTime6Text.backgroundColor=[UIColor clearColor];
                self.specificFromTime6Text.userInteractionEnabled=YES;
                self.specificPayOT6Text.text=@"";
                self.specificPayOT6Text.backgroundColor=[UIColor lightGrayColor];
                self.specificPayOT6Text.userInteractionEnabled=NO;
                [self.specificConditionArray replaceObjectAtIndex:5 withObject:@"spec_hrs_bw"];
                
            }
            else
            {
                self.specificFromTime6Text.text=@"00:00";
                self.specificFromTime6Text.backgroundColor=[UIColor lightGrayColor];
                self.specificFromTime6Text.userInteractionEnabled=NO;
                self.specificToTime6Text.text=@"00:00";
                self.specificToTime6Text.backgroundColor=[UIColor lightGrayColor];
                self.specificToTime6Text.userInteractionEnabled=NO;
                self.specificPayOT6Text.text=@"";
                self.specificPayOT6Text.backgroundColor=[UIColor clearColor];
                self.specificPayOT6Text.userInteractionEnabled=YES;
                [self.specificConditionArray replaceObjectAtIndex:5 withObject:@"spec_whole_day"];
            }
            self.specificCondition6Text.text=[self.conditionArray objectAtIndex:indexPath.row];
            self.conditionsTableView.hidden=true;
        }
        if (conditionFlag==7) {
            if (indexPath.row==0) {
                self.specificFromTime7Text.text=@"";
                self.specificFromTime7Text.backgroundColor=[UIColor clearColor];
                self.specificFromTime7Text.userInteractionEnabled=YES;
                self.specificPayOT7Text.text=@"";
                self.specificPayOT7Text.backgroundColor=[UIColor lightGrayColor];
                self.specificPayOT7Text.userInteractionEnabled=NO;
                [self.specificConditionArray replaceObjectAtIndex:6 withObject:@"spec_hrs_bw"];
                
            }
            else
            {
                self.specificFromTime7Text.text=@"00:00";
                self.specificFromTime7Text.backgroundColor=[UIColor lightGrayColor];
                self.specificFromTime7Text.userInteractionEnabled=NO;
                self.specificToTime7Text.text=@"00:00";
                self.specificToTime7Text.backgroundColor=[UIColor lightGrayColor];
                self.specificToTime7Text.userInteractionEnabled=NO;
                self.specificPayOT7Text.text=@"";
                self.specificPayOT7Text.backgroundColor=[UIColor clearColor];
                self.specificPayOT7Text.userInteractionEnabled=YES;
                [self.specificConditionArray replaceObjectAtIndex:6 withObject:@"spec_whole_day"];
            }
            self.specificCondition7Text.text=[self.conditionArray objectAtIndex:indexPath.row];
            self.conditionsTableView.hidden=true;
        }


    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.overtimeTypeText) {
        self.overtimeTypeTC.hidden=false;
        return  NO;
    }
    else if (textField==self.regularDailyLimitText)
    {
        if (self.regularDailyLimitText.text.length > 0) {
            [self resetRegularDailyLimit];
            return NO;
        }
        else
        {
            self.datePickerView.frame=CGRectMake(0, 367, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            [self datePickedIntialValueChanged];
            
            self.datePickerView.hidden=false;
            self.flag=1;
            return  NO;
            
        }
    }
    
    else if (textField==self.regularAfterText1)
    {
        if (self.regularAfterText1.text.length > 0) {
            [self resetRegularAfter1];
            return NO;
        }
        else
        {
            if(self.regularPayOTText1.text.length > 0)
            {
                self.regularAfterText1.userInteractionEnabled=true;
                self.flag=3;
                self.datePickerView.frame=CGRectMake(278, 400, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
                [self datePickedIntialValueChanged];
                
                self.datePickerView.hidden=false;
                return  NO;
            }
            else
            {
                return  NO;
            }
            
        }
    }
    else if (textField==self.regularAfterText2)
    {
        if (self.regularAfterText2.text.length > 0) {
            [self resetRegularAfter2];
            return  NO;
        }
        else
        {
            if (self.regularPayOTText2.text.length > 0) {
                self.regularAfterText2.userInteractionEnabled=true;
                self.flag=4;
                self.datePickerView.frame=CGRectMake(0, 383, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
                [self datePickedIntialValueChanged];
                self.datePickerView.hidden=false;
                return  NO;
            }
            else
            {
                return  NO;
            }
        }
        
    }
    else if (textField==self.regularPayOTText1)
    {
        if (self.regularDailyLimitText.text.length > 0) {
            self.regularPayOTText1.userInteractionEnabled=true;
            if (payOTTextFlag==0) {
                payOTFlag=1;
                self.payOTTC.frame=CGRectMake(148, 433, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return  YES;
        }
        else
        {
            return  NO;
        }
    }
    else if (textField==self.regularPayOTText2)
    {
        if (self.regularAfterText1.text.length > 0) {
            self.regularPayOTText2.userInteractionEnabled=true;
            if (payOTTextFlag==0) {
                payOTFlag=2;
                self.payOTTC.frame=CGRectMake(434, 433, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return  YES;
        }
        else
        {
            return  NO;
        }
    }
    else if (textField==self.regularPayOTText3)
    {
        if (self.regularAfterText2.text.length > 0) {
            self.regularPayOTText3.userInteractionEnabled=true;
            if (payOTTextFlag==0) {
                payOTFlag=3;
                self.payOTTC.frame=CGRectMake(148, 474, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return YES;
        }
        else
        {
            return  NO;
        }
    }
    else if (textField==self.regularCheckText1)
    {
        return  NO;
    }
    else if (textField==self.offDayFirstText)
    {
        if (self.offDayFirstText.text.length > 0) {
            [self resetOffdayFirstText];
            return  NO;
        }
        else
        {
            if (self.offdayDailyLimitText.text.length > 0) {
                [self datePickedIntialValueChanged];
                self.flag=5;
                self.datePickerView.frame=CGRectMake(0, 383, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
                self.datePickerView.hidden=false;
                return  NO;
            }
            else
            {
                return  NO;
            }
            
        }
    }
    else if (textField==self.offdayDailyLimitText)
    {
        if (self.offdayDailyLimitText.text.length > 0) {
            [self resetOffdayDailyLimit];
            return  NO;
        }
        else
        {
            [self datePickedIntialValueChanged];
            self.datePickerView.frame=CGRectMake(0, 367, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=false;
            self.flag=6;
            return  NO;
            
        }
    }
    
    else if (textField==self.offdayAfterText1)
    {
        if (self.offdayAfterText1.text.length > 0) {
            [self resetOffdayAfter1];
            return  NO;
        }
        else
            
        {
            if (self.offdayPayOTText1.text.length > 0) {
                [self datePickedIntialValueChanged];
                self.flag=7;
                self.datePickerView.frame=CGRectMake(278, 400, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
                self.datePickerView.hidden=false;
                return  NO;
            }
            else
            {
                return  NO;
            }
        }
        
    }
    else if (textField==self.offdayAfterText2)
    {
        if (self.offdayAfterText2.text.length > 0) {
            [self resetOffdayAfter2];
            return NO;
        }
        else
        {
            if (self.offdayPayOTText2.text.length > 0) {
                [self datePickedIntialValueChanged];
                self.flag=8;
                self.datePickerView.frame=CGRectMake(0, 400, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
                self.datePickerView.hidden=false;
                return  NO;
            }
            else
            {
                return  NO;
            }
        }
        
    }
    else if (textField==self.offdayPayOTText1)
    {
        if (self.offdayDailyLimitText.text.length > 0) {
            if (payOTTextFlag==0) {
                payOTFlag=4;
                self.payOTTC.frame=CGRectMake(158, 433, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return  YES;
        }
        else
        {
            return  NO;
        }
    }
    else if (textField==self.offdayPayOTText2)
    {
        if (self.offdayAfterText1.text.length > 0) {
            if (payOTTextFlag==0) {
                payOTFlag=5;
                self.payOTTC.frame=CGRectMake(438, 433, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return  YES;
        }
        else
        {
            return  NO;
        }
    }
    else if (textField==self.offdayPayOTText3)
    {
        if (self.offdayAfterText2.text.length > 0) {
            if (payOTTextFlag==0) {
                payOTFlag=6;
                self.payOTTC.frame=CGRectMake(158, 474, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return YES;
        }
        else
        {
            return  NO;
        }
        
        
    }
    else if (textField==self.partialDailyLimitText)
    {
        if (self.partialDailyLimitText.text.length > 0) {
            [self resetPartialDialyLimit];
            return  NO;
        }
        else
        {
            [self datePickedIntialValueChanged];
            self.datePickerView.frame=CGRectMake(0 , 367, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=false;
            self.flag=9;
            return  NO;
        }
        
    }
    else if (textField==self.partialFirstText)
    {
        if (self.partialFirstText.text.length > 0) {
            [self resetPartialFirstText];
            return  NO;
        }
        else
        {
            if (self.partialDailyLimitText.text.length > 0) {
                [self datePickedIntialValueChanged];
                self.flag=10;
                self.datePickerView.frame=CGRectMake(0, 383, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
                self.datePickerView.hidden=false;
                return  NO;
                
            }
            else
            {
                return  NO;
            }
        }
        
    }
    else if (textField==self.partialAfterText1)
    {
        if (self.partialAfterText1.text.length > 0) {
            [self resetPartialAfter1];
            return  NO;
        }
        else
        {
            if (self.partialPayOTText1.text.length > 0) {
                [self datePickedIntialValueChanged];
                self.flag=11;
                self.datePickerView.frame=CGRectMake(278, 400, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
                self.datePickerView.hidden=false;
                return  NO;
            }
            else
            {
                return  NO;
            }
        }
        
    }
    else if (textField==self.partialAfterText2)
    {
        if (self.partialAfterText2.text.length > 0) {
            [self resetPartialAfter2];
            return  NO;
        }
        else
        {
            [self datePickedIntialValueChanged];
            if (self.partialPayOTText2.text.length > 0) {
                self.flag=12;
                self.datePickerView.frame=CGRectMake(0, 400, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
                self.datePickerView.hidden=false;
                return  NO;
            }
            else
            {
                return  NO;
            }
        }
        
    }
    else if (textField==self.partialPayOTText1)
    {
        if (self.partialDailyLimitText.text.length > 0) {
            if (payOTTextFlag==0) {
                payOTFlag=7;
                self.payOTTC.frame=CGRectMake(158, 433, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return  YES;
        }
        else
        {
            return  NO;
        }
    }
    else if (textField==self.partialPayOTText2)
    {
        if (self.partialAfterText1.text.length > 0) {
            if (payOTTextFlag==0) {
                payOTFlag=8;
                self.payOTTC.frame=CGRectMake(438, 433, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return  YES;
        }
        else
        {
            return  NO;
        }
        
    }
    else if (textField==self.partialPayOTText3)
    {
        if (self.partialAfterText2.text.length > 0) {
            if (payOTTextFlag==0) {
                payOTFlag=9;
                self.payOTTC.frame=CGRectMake(158, 474                                                                   , self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return YES;
        }
        else
        {
            return  NO;
        }
    }
    else if (textField==self.holidayDailyLimitText)
    {
        if (self.holidayDailyLimitText.text.length > 0) {
            [self resetHolidayDialyLimit];
        }
        else
        {
            [self datePickedIntialValueChanged];
            self.datePickerView.frame=CGRectMake(0, 367, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=false;
            self.flag=13;
        }
        
        return  NO;
    }
    else if (textField==self.holidayFirstText)
    {
        if (self.holidayFirstText.text.length > 0) {
            [self resetHolidayFirstText];
            return  NO;
        }
        else
        {
            if (self.holidayDailyLimitText.text.length > 0) {
                [self datePickedIntialValueChanged];
                self.flag=14;
                self.datePickerView.frame=CGRectMake(0, 383, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
                self.datePickerView.hidden=false;
                return  NO;
            }
            else
            {
                return  NO;
            }
            
        }
    }
    else if (textField==self.holidayAfterText1)
    {
        if (self.holidayAfterText1.text.length > 0) {
            [self resetHolidayAfter1];
            return  NO;
        }
        else
        {
            if (self.holidayPayOTText1.text.length > 0) {
                [self datePickedIntialValueChanged];
                self.flag=15;
                self.datePickerView.frame=CGRectMake(278, 400, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
                self.datePickerView.hidden=false;
                return  NO;
            }
            else
            {
                return  NO;
            }
        }
        
    }
    else if (textField==self.holidayAfterText2)
    {
        if (self.holidayAfterText2.text.length > 0) {
            [self resetHolidayAfter2];
            return  NO;
        }
        else
        {
            if (self.holidayPayOTText2.text.length > 0) {
                [self datePickedIntialValueChanged];
                self.flag=16;
                self.datePickerView.frame=CGRectMake(0, 400, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
                self.datePickerView.hidden=false;
                return  NO;
                
            }
            else
            {
                return  NO;
            }
        }
        
    }
    else if (textField==self.holidayPayOTText1)
    {
        if (self.holidayDailyLimitText.text.length > 0) {
            if (payOTTextFlag==0) {
                payOTFlag=10;
                self.payOTTC.frame=CGRectMake(158, 433, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return  YES;
        }
        else
        {
            return  NO;
        }
        
    }
    else if (textField==self.holidayPayOTText2)
    {
        if (self.holidayAfterText1.text.length > 0) {
            if (payOTTextFlag==0) {
                payOTFlag=11;
                self.payOTTC.frame=CGRectMake(438, 433, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return  YES;
        }
        else
        {
            return  NO;
        }
        
    }
    else if (textField==self.holidayPayOTText3)
    {
        if (self.holidayAfterText2.text.length > 0) {
            if (payOTTextFlag==0) {
                payOTFlag=12;
                self.payOTTC.frame=CGRectMake(158, 474, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return YES;
        }
        else
        {
            return  NO;
        }
        
    }
    else if (textField==self.weeklyDailyLimitText)
    {
        if (self.weeklyDailyLimitText.text.length > 0) {
            [self resetWeeklyDailyLimit];
        }
        else
        {
            [self datePickedIntialValueChanged];
            self.datePickerView.frame=CGRectMake(0, 368, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=false;
            self.flag=17;
        }
        
        return  NO;
        
    }
    else if (textField==self.weeklyAfterText1)
    {
        if (self.weeklyAfterText1.text.length > 0) {
            [self resetWeeklyAfter1];
            return  NO;
        }
        else
            return  YES;
    }
    else if (textField==self.weeklyPayOTText1)
    {
        if (self.weeklyAfterText1.text.length > 0) {
            if (payOTTextFlag==0) {
                payOTFlag=13;
                self.payOTTC.frame=CGRectMake(45, 436, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
                self.payOTTC.hidden=false;
                return  NO;
            }
            else
                return YES;
        }
        else
        {
            return  NO;
        }
        
        
        
    }
    else if (textField==self.weeklyCheckText1)
    {
        if (p%2==0) {
            [self.weeklyCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_pf=@"1";
            p++;
        }
        else
        {
            [self.weeklyCheckButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_pf=@"0";
            p++;
        }
        
        return  NO;
    }
    else if (textField==self.weeklyCheckText2)
    {
        if (q%2==0) {
            [self.weeklyCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_esi=@"1";
            q++;
        }
        else
        {
            [self.weeklyCheckButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_esi=@"0";
            q++;
        }
        
        return  NO;
    }
    else if (textField==self.weeklyCheckText3)
    {
        if (r%2==0) {
            [self.weeklyCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_incentives=@"1";
            r++;
        }
        else
        {
            [self.weeklyCheckButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_incentives=@"0";
            r++;
        }
        
        return  NO;
    }
    
    else if (textField==self.weeklyCheckText4)
    {
        if (i%2==0) {
            [self.weeklyCheckButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.paidLeavesValue=@"1";
            i++;
        }
        else
        {
            [self.weeklyCheckButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.paidLeavesValue=@"0";
            i++;
        }
        
        return  NO;
    }
    else if (textField==self.weeklyCheckText5)
    {
        if (j%2==0) {
            [self.weeklyCheckButton5 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.paidHolidaysvalue=@"1";
            j++;
        }
        else
        {
            [self.weeklyCheckButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.paidHolidaysvalue=@"0";
            j++;
        }
        
        return  NO;
    }
    else if (textField==self.weeklyCheckText6)
    {
        if (k%2==0) {
            [self.weeklyCheckButton6 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.apply7thValue=@"1";
            k++;
        }
        else
        {
            [self.weeklyCheckButton6 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.apply7thValue=@"0";
            k++;
        }
        
        return  NO;
    }
    else if (textField==self.checkText1)
    {
        if (a%2==0) {
            [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_pf=@"1";
            a++;
        }
        else
        {
            [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_pf=@"0";
            a++;
        }
        
        return  NO;
    }
    else if (textField==self.checkText2)
    {
        if (b%2==0) {
            [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_esi=@"1";
            b++;
        }
        else
        {
            [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_esi=@"0";
            b++;
        }
        
        return  NO;
    }
    else if (textField==self.checkText3)
    {
        if (c%2==0) {
            [self.checkButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_incentives=@"1";
            c++;
        }
        else
        {
            [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_incentives=@"0";
            c++;
        }
        
        return  NO;
    }
    else if (textField==self.weeklyWorkingHoursText)
    {
        self.weeklyWorkingHoursTC.hidden=false;
        return  NO;
    }
    else if (textField==self.specificDay1Text)
    {
        
        if (self.specificDay1Text.text.length > 0) {
            [self resetDay1];
            [self resetDay2];
            [self resetDay3];
            [self resetDay4];
            [self resetDay5];
            [self resetDay6];
            [self resetDay7];
        }
        else
        {
            dayFlag=1;
            self.specificDayTC.frame=CGRectMake(25, 361, self.specificDayTC.frame.size.width, self.specificDayTC.frame.size.height);
            self.specificDayTC.hidden=false;
            
        }
        [self.specificDayTC reloadData];
        return  NO;
    }
    else if (textField==self.specificDay2Text)
    {
        if (self.specificDay2Text.text.length > 0) {
            [self resetDay2];
            [self resetDay3];
            [self resetDay4];
            [self resetDay5];
            [self resetDay6];
            [self resetDay7];
        }
        else
        {
            dayFlag=2;
            self.specificDayTC.frame=CGRectMake(25, 389, self.specificDayTC.frame.size.width, self.specificDayTC.frame.size.height);
            self.specificDayTC.hidden=false;
        }
        [self.specificDayTC reloadData];
        return  NO;
    }
    else if (textField==self.specificDay3Text)
    {
        if (self.specificDay3Text.text.length > 0) {
            [self resetDay3];
            [self resetDay4];
            [self resetDay5];
            [self resetDay6];
            [self resetDay7];
        }
        else
        {
            dayFlag=3;
            self.specificDayTC.frame=CGRectMake(25, 420, self.specificDayTC.frame.size.width, self.specificDayTC.frame.size.height);
            self.specificDayTC.hidden=false;
        }
        [self.specificDayTC reloadData];
        return  NO;
    }
    else if (textField==self.specificDay4Text)
    {
        if (self.specificDay4Text.text.length > 0) {
            [self resetDay4];
            [self resetDay5];
            [self resetDay6];
            [self resetDay7];
        }
        else
        {
            dayFlag=4;
            self.specificDayTC.frame=CGRectMake(25, 439, self.specificDayTC.frame.size.width, self.specificDayTC.frame.size.height);
            self.specificDayTC.hidden=false;
        }
        [self.specificDayTC reloadData];
        return  NO;
    }
    else if (textField==self.specificDay5Text)
    {
        if (self.specificDay5Text.text.length > 0) {
            [self resetDay5];
            [self resetDay6];
            [self resetDay7];
        }
        else
        {
            dayFlag=5;
            self.specificDayTC.frame=CGRectMake(25, 439, self.specificDayTC.frame.size.width, self.specificDayTC.frame.size.height);
            self.specificDayTC.hidden=false;
        }
        [self.specificDayTC reloadData];
        return  NO;
    }
    else if (textField==self.specificDay6Text)
    {
        if (self.specificDay6Text.text.length > 0) {
            [self resetDay6];
            [self resetDay7];
            
        }
        else
        {
            dayFlag=6;
            self.specificDayTC.frame=CGRectMake(25, 439, self.specificDayTC.frame.size.width, self.specificDayTC.frame.size.height);
            self.specificDayTC.hidden=false;
        }
        [self.specificDayTC reloadData];
        return  NO;
    }
    else if (textField==self.specificDay7Text)
    {
        if (self.specificDay7Text.text.length > 0) {
            [self resetDay7];
        }
        else
        {
            dayFlag=7;
            self.specificDayTC.frame=CGRectMake(25, 439, self.specificDayTC.frame.size.width, self.specificDayTC.frame.size.height);
            self.specificDayTC.hidden=false;
        }
        [self.specificDayTC reloadData];
        return  YES;
    }
    else if (textField==self.specificCondition1Text)
    {
        conditionFlag=1;
        self.conditionsTableView.hidden=false;
        self.conditionsTableView.frame=CGRectMake(119, 361, self.conditionsTableView.frame.size.width, self.conditionsTableView.frame.size.height);
        return  NO;
    }
    else if (textField==self.specificCondition2Text)
    {
        conditionFlag=2;
        self.conditionsTableView.hidden=false;
        self.conditionsTableView.frame=CGRectMake(119, 390, self.conditionsTableView.frame.size.width, self.conditionsTableView.frame.size.height);
        return  NO;
    }
    else if (textField==self.specificCondition3Text)
    {
        conditionFlag=3;
        self.conditionsTableView.hidden=false;
        self.conditionsTableView.frame=CGRectMake(119, 418, self.conditionsTableView.frame.size.width, self.conditionsTableView.frame.size.height);
        return  NO;
    }
    else if (textField==self.specificCondition4Text)
    {
        conditionFlag=4;
        self.conditionsTableView.hidden=false;
        self.conditionsTableView.frame=CGRectMake(119, 448, self.conditionsTableView.frame.size.width, self.conditionsTableView.frame.size.height);
        return  NO;
    }
    else if (textField==self.specificCondition5Text)
    {
        conditionFlag=5;
        self.conditionsTableView.hidden=false;
        self.conditionsTableView.frame=CGRectMake(119, 477, self.conditionsTableView.frame.size.width, self.conditionsTableView.frame.size.height);
        return  NO;
    }
    else if (textField==self.specificCondition6Text)
    {
        conditionFlag=6;
        self.conditionsTableView.hidden=false;
        self.conditionsTableView.frame=CGRectMake(119, 499, self.conditionsTableView.frame.size.width, self.conditionsTableView.frame.size.height);
        return  NO;
    }
    else if (textField==self.specificCondition7Text)
    {
        conditionFlag=7;
        self.conditionsTableView.hidden=false;
        self.conditionsTableView.frame=CGRectMake(119, 499, self.conditionsTableView.frame.size.width, self.conditionsTableView.frame.size.height);
        return  NO;
    }
    else if (textField==self.specificFromTime1Text)
    {
        if (self.specificFromTime1Text.text.length > 0) {
        }
        else
        {
            [self timeInitialSettings];
            self.datePicker1View.frame=CGRectMake(299, 361, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            timeFlag=1;
        }
        
        return  NO;
    }
    else if (textField==self.specificToTime1Text)
    {
        if (self.specificToTime1Text.text.length > 0) {
        }
        else
        {
            timeFlag=2;
            [self timeMaxSettings:self.specificFromTime1Text.text];
            self.datePicker1View.frame=CGRectMake(384, 361, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            
        }
        
        return  NO;
    }
    else if (textField==self.specificFromTime2Text)
    {
        if (self.specificFromTime2Text.text.length > 0) {
        }
        else
        {
            [self timeInitialSettings];
            self.datePicker1View.frame=CGRectMake(299, 383, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            timeFlag=3;
        }
        
        return  NO;
    }
    else if (textField==self.specificToTime2Text)
    {
        if (self.specificToTime2Text.text.length > 0) {
        }
        else
        {
            timeFlag=4;
            [self timeMaxSettings:self.specificFromTime2Text.text];
            self.datePicker1View.frame=CGRectMake(384, 383, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            
        }
        
        return  NO;
    }
    else if (textField==self.specificFromTime3Text)
    {
        if (self.specificFromTime3Text.text.length > 0) {
        }
        else
        {
            [self timeInitialSettings];
            self.datePicker1View.frame=CGRectMake(299, 400, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            timeFlag=5;
        }
        
        return  NO;
    }
    else if (textField==self.specificToTime3Text)
    {
        if (self.specificToTime3Text.text.length > 0) {
        }
        else
        {
            timeFlag=6;
            [self timeMaxSettings:self.specificFromTime3Text.text];
            self.datePicker1View.frame=CGRectMake(384, 400, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            
        }
        
        return  NO;
    }
    else if (textField==self.specificFromTime4Text)
    {
        if (self.specificFromTime4Text.text.length > 0) {
        }
        else
        {
            [self timeInitialSettings];
            self.datePicker1View.frame=CGRectMake(299, 400, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            timeFlag=7;
        }
        
        return  NO;
    }
    else if (textField==self.specificToTime4Text)
    {
        if (self.specificToTime4Text.text.length > 0) {
        }
        else
        {
            timeFlag=8;
            [self timeMaxSettings:self.specificFromTime4Text.text];
            self.datePicker1View.frame=CGRectMake(384, 400, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            
        }
        
        return  NO;
    }
    else if (textField==self.specificFromTime5Text)
    {
        if (self.specificFromTime5Text.text.length > 0) {
        }
        else
        {
            [self timeInitialSettings];
            self.datePicker1View.frame=CGRectMake(299, 400, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            timeFlag=9;
        }
        
        return  NO;
    }
    else if (textField==self.specificToTime5Text)
    {
        if (self.specificToTime5Text.text.length > 0) {
        }
        else
        {
            timeFlag=10;
            [self timeMaxSettings:self.specificFromTime5Text.text];
            self.datePicker1View.frame=CGRectMake(384, 400, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            
        }
        
        return  NO;
    }
    else if (textField==self.specificFromTime6Text)
    {
        if (self.specificFromTime6Text.text.length > 0) {
        }
        else
        {
            [self timeInitialSettings];
            self.datePicker1View.frame=CGRectMake(299, 400, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            timeFlag=11;
        }
        
        return  NO;
    }
    else if (textField==self.specificToTime6Text)
    {
        if (self.specificToTime6Text.text.length > 0) {
        }
        else
        {
            timeFlag=12;
            [self timeMaxSettings:self.specificFromTime6Text.text];
            self.datePicker1View.frame=CGRectMake(384, 400, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            
        }
        
        return  NO;
    }
    else if (textField==self.specificFromTime7Text)
    {
        if (self.specificFromTime7Text.text.length > 0) {
        }
        else
        {
            [self timeInitialSettings];
            self.datePicker1View.frame=CGRectMake(299, 400, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            timeFlag=13;
        }
        
        return  NO;
    }
    else if (textField==self.specificToTime7Text)
    {
        if (self.specificToTime7Text.text.length > 0) {
        }
        else
        {
            timeFlag=14;
            [self timeMaxSettings:self.specificFromTime7Text.text];
            self.datePicker1View.frame=CGRectMake(384, 400, self.datePicker1View.frame.size.width, self.datePicker1View.frame.size.height);
            self.datePicker1View.hidden=false;
            
        }
        
        return  NO;
    }
    else if (textField==self.specificPayOT1Text)
    {
        if (payOTTextFlag==0) {
            payOTFlag=15;
            self.payOTTC.frame=CGRectMake(445, 361, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
            self.payOTTC.hidden=false;
            return  NO;
        }
        else
            return YES;
        
    }
    else if (textField==self.specificPayOT2Text)
    {
        if (payOTTextFlag==0) {
            payOTFlag=16;
            self.payOTTC.frame=CGRectMake(445, 390, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
            self.payOTTC.hidden=false;
            return  NO;
        }
        else
            return YES;
        
    }
    else if (textField==self.specificPayOT3Text)
    {
        if (payOTTextFlag==0) {
            payOTFlag=17;
            self.payOTTC.frame=CGRectMake(445, 419, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
            self.payOTTC.hidden=false;
            return  NO;
        }
        else
            return YES;
        
    }
    else if (textField==self.specificPayOT4Text)
    {
        if (payOTTextFlag==0) {
            payOTFlag=18;
            self.payOTTC.frame=CGRectMake(445, 448, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
            self.payOTTC.hidden=false;
            return  NO;
        }
        else
            return YES;
        
    }
    else if (textField==self.specificPayOT5Text)
    {
        if (payOTTextFlag==0) {
            payOTFlag=19;
            self.payOTTC.frame=CGRectMake(445, 475, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
            self.payOTTC.hidden=false;
            return  NO;
        }
        else
            return YES;
        
    }
    else if (textField==self.specificPayOT6Text)
    {
        if (payOTTextFlag==0) {
            payOTFlag=20;
            self.payOTTC.frame=CGRectMake(445, 475, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
            self.payOTTC.hidden=false;
            return  NO;
        }
        else
            return YES;
        
    }
    else if (textField==self.specificPayOT7Text)
    {
        if (payOTTextFlag==0) {
            payOTFlag=21;
            self.payOTTC.frame=CGRectMake(445, 475, self.payOTTC.frame.size.width, self.payOTTC.frame.size.height);
            self.payOTTC.hidden=false;
            return  NO;
        }
        else
            return YES;
    }
    
    
    
    else
        return  YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.regularPayOTText1) {
        payOTTextFlag=0;
        if (self.regularPayOTText1.text.length > 0) {
            if (self.regularPayOTText1.text.length < 7) {
                float amount=[self.regularPayOTText1.text floatValue];
                self.regularPayOTText1.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.reg_ot1=self.regularPayOTText1.text;
                self.regularAfterText1.backgroundColor=[UIColor clearColor];
                self.regularAfterText1.userInteractionEnabled=true;
                self.doneButton.enabled=YES;
            }
        }
        return  YES;
    }
    else if (textField==self.regularPayOTText2)
    {
        payOTTextFlag=0;
        if (self.regularPayOTText2.text.length > 0) {
            if (self.regularPayOTText2.text.length < 7) {
                float amount=[self.regularPayOTText2.text floatValue];
                self.regularPayOTText2.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.reg_ot2=self.regularPayOTText2.text;
                self.regularAfterText2.backgroundColor=[UIColor clearColor];
                self.regularAfterText2.userInteractionEnabled=true;
                self.selectedFlag=0;
                self.regularMandatoryLabel1.hidden=true;
                
            }
        }
        return  YES;
    }
    else if (textField==self.regularPayOTText3)
    {
        payOTTextFlag=0;
        if (self.regularPayOTText3.text.length > 0) {
            if (self.regularPayOTText3.text.length < 7) {
                float amount=[self.regularPayOTText3.text floatValue];
                self.reg_ot3=[NSString stringWithFormat:@"%.1f",amount];
                self.regularPayOTText3.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.regularMandatoryLabel2.hidden=true;
                self.selectedFlag1=0;
            }
        }
        return  YES;
    }
    if (textField==self.offdayPayOTText1) {
        payOTTextFlag=0;
        if (self.offdayPayOTText1.text.length > 0) {
            if (self.offdayPayOTText1.text.length < 7) {
                float amount=[self.offdayPayOTText1.text floatValue];
                self.off_ot1=[NSString stringWithFormat:@"%.1f",amount];
                self.offdayPayOTText1.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.offdayAfterText1.backgroundColor=[UIColor clearColor];
                self.offdayAfterText1.userInteractionEnabled=true;
                self.doneButton.enabled=YES;
            }
        }
        return  YES;
    }
    else if (textField==self.offdayPayOTText2)
    {
        payOTTextFlag=0;
        if (self.offdayPayOTText2.text.length > 0) {
            if (self.offdayPayOTText2.text.length < 7) {
                float amount=[self.offdayPayOTText2.text floatValue];
                self.off_ot2=[NSString stringWithFormat:@"%.1f",amount];
                self.offdayPayOTText2.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag=0;
                self.offdayAfterText2.backgroundColor=[UIColor clearColor];
                self.offdayAfterText2.userInteractionEnabled=true;
                self.offdayMandatoryLabel1.hidden=true;
            }
        }
        return  YES;
    }
    else if (textField==self.offdayPayOTText3)
    {
        payOTTextFlag=0;
        if (self.offdayPayOTText3.text.length > 0) {
            if (self.offdayPayOTText3.text.length < 7) {
                float amount=[self.offdayPayOTText3.text floatValue];
                self.off_ot3=[NSString stringWithFormat:@"%.1f",amount];
                self.offdayPayOTText3.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag1=0;
                self.offdayMandatoryLabel2.hidden=true;
            }
        }
        return  YES;
    }
    else if (textField==self.partialPayOTText1)
    {
        payOTTextFlag=0;
        if (self.partialPayOTText1.text.length > 0) {
            if (self.partialPayOTText1.text.length < 7) {
                float amount=[self.partialPayOTText1.text floatValue];
                self.par_ot1=[NSString stringWithFormat:@"%.1f",amount];
                self.partialPayOTText1.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.partialAfterText1.backgroundColor=[UIColor clearColor];
                self.partialAfterText1.userInteractionEnabled=YES;
                self.doneButton.enabled=YES;
            }
        }
        return  YES;
    }
    else if (textField==self.partialPayOTText2)
    {
        payOTTextFlag=0;
        if (self.partialPayOTText2.text.length > 0) {
            if (self.partialPayOTText2.text.length < 7) {
                float amount=[self.partialPayOTText2.text floatValue];
                self.par_ot2=[NSString stringWithFormat:@"%.1f",amount];
                self.partialPayOTText2.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag=0;
                self.partialAfterText2.backgroundColor=[UIColor clearColor];
                self.partialAfterText2.userInteractionEnabled=true;
                self.partialMandatoryLabel1.hidden=true;
            }
        }
        return  YES;
    }
    else if(textField==self.partialPayOTText3)
    {
        payOTTextFlag=0;
        if (self.partialPayOTText3.text.length > 0) {
            if (self.partialPayOTText3.text.length < 7) {
                float amount=[self.partialPayOTText3.text floatValue];
                self.par_ot3=[NSString stringWithFormat:@"%.1f",amount];
                self.partialPayOTText3.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag1=0;
                self.partialMandatoryLabel2.hidden=true;
            }
        }
        return  YES;
    }
    else if (textField==self.holidayPayOTText1)
    {
        payOTTextFlag=0;
        if (self.holidayPayOTText1.text.length > 0) {
            if (self.holidayPayOTText1.text.length < 7) {
                float amount=[self.holidayPayOTText1.text floatValue];
                self.hol_ot1=[NSString stringWithFormat:@"%.1f",amount];
                self.holidayPayOTText1.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.holidayAfterText1.backgroundColor=[UIColor clearColor];
                self.holidayAfterText1.userInteractionEnabled=YES;
                self.doneButton.enabled=YES;
            }
        }
        return  YES;
    }
    else if (textField==self.holidayPayOTText2)
    {
        payOTTextFlag=0;
        if (self.holidayPayOTText2.text.length > 0) {
            if (self.holidayPayOTText2.text.length < 7) {
                float amount=[self.holidayPayOTText2.text floatValue];
                self.hol_ot2=[NSString stringWithFormat:@"%.1f",amount];
                self.holidayPayOTText2.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag=0;
                self.holidayAfterText2.backgroundColor=[UIColor clearColor];
                self.holidayAfterText2.userInteractionEnabled=true;
                self.holidayMandatoryLabel1.hidden=true;
            }
        }
        return  YES;
        
    }
    else if (textField==self.holidayPayOTText3)
    {
        payOTTextFlag=0;
        if (self.holidayPayOTText3.text.length > 0) {
            if (self.holidayPayOTText3.text.length < 7) {
                float amount=[self.holidayPayOTText3.text floatValue];
                self.hol_ot3=[NSString stringWithFormat:@"%.1f",amount];
                self.holidayPayOTText3.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag1=0;
                self.holidayMandatoryLabel2.hidden=true;
            }
        }
        return  YES;
        
    }
    else if (textField==self.weeklyPayOTText1)
    {
        payOTTextFlag=0;
        if (self.weeklyPayOTText1.text.length > 0) {
            if (self.weeklyPayOTText1.text.length < 7) {
                float amount=[self.weeklyPayOTText1.text floatValue];
                self.reg_ot1=[NSString stringWithFormat:@"%.1f",amount];
                self.weeklyPayOTText1.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag=0;
                self.doneButton.enabled=YES;
                
            }
        }
        return  YES;
    }
    else if (textField==self.specificPayOT1Text)
    {
        payOTTextFlag=0;
        if (self.specificPayOT1Text.text.length > 0) {
            if (self.specificPayOT1Text.text.length < 7) {
                float amount=[self.specificPayOT1Text.text floatValue];
                [self.specificPayOTRateArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%.1f",amount]];
                self.specificPayOT1Text.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag1=0;
                self.secondView.hidden=false;
                self.doneButton.enabled=YES;
                [self resetDay2];
            }
        }
        return  YES;
    }
    
    else if (textField==self.specificPayOT2Text)
    {
        payOTTextFlag=0;
        if (self.specificPayOT2Text.text.length > 0) {
            if (self.specificPayOT2Text.text.length < 7) {
                float amount=[self.specificPayOT2Text.text floatValue];
                [self.specificPayOTRateArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.1f",amount]];
                self.specificPayOT2Text.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag1=0;
                self.thirdView.hidden=false;
                self.doneButton.enabled=YES;
                [self resetDay3];
            }
        }
        return  YES;
    }
    
    else if (textField==self.specificPayOT3Text)
    {
        payOTTextFlag=0;
        if (self.specificPayOT3Text.text.length > 0) {
            if (self.specificPayOT3Text.text.length < 7) {
                float amount=[self.specificPayOT3Text.text floatValue];
                [self.specificPayOTRateArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.1f",amount]];
                self.specificPayOT3Text.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag1=0;
                self.fourthView.hidden=false;
                self.doneButton.enabled=YES;
                [self resetDay4];
            }
        }
        return  YES;
    }
    else if (textField==self.specificPayOT4Text)
    {
        payOTTextFlag=0;
        if (self.specificPayOT4Text.text.length > 0) {
            if (self.specificPayOT4Text.text.length < 7) {
                float amount=[self.specificPayOT4Text.text floatValue];
                [self.specificPayOTRateArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.1f",amount]];
                self.specificPayOT4Text.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag1=0;
                self.fifthView.hidden=false;
                self.doneButton.enabled=YES;
                [self resetDay5];
            }
        }
        return  YES;
    }
    
    else if (textField==self.specificPayOT5Text)
    {
        payOTTextFlag=0;
        if (self.specificPayOT5Text.text.length > 0) {
            if (self.specificPayOT5Text.text.length < 7) {
                float amount=[self.specificPayOT5Text.text floatValue];
                [self.specificPayOTRateArray replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%.1f",amount]];
                self.specificPayOT5Text.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag1=0;
                self.sixthView.hidden=false;
                self.doneButton.enabled=YES;
                [self resetDay6];
            }
        }
        return  YES;
    }
    
    else if (textField==self.specificPayOT6Text)
    {
        payOTTextFlag=0;
        if (self.specificPayOT6Text.text.length > 0) {
            if (self.specificPayOT6Text.text.length < 7) {
                float amount=[self.specificPayOT6Text.text floatValue];
                [self.specificPayOTRateArray replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%.1f",amount]];
                self.specificPayOT6Text.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag1=0;
                self.seventhView.hidden=false;
                self.doneButton.enabled=YES;
                [self resetDay7];
            }
        }
        return  YES;
    }
    
    else if (textField==self.specificPayOT7Text)
    {
        payOTTextFlag=0;
        if (self.specificPayOT7Text.text.length > 0) {
            if (self.specificPayOT7Text.text.length < 7) {
                float amount=[self.specificPayOT7Text.text floatValue];
                [self.specificPayOTRateArray replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%.1f",amount]];
                self.specificPayOT7Text.text=[NSString stringWithFormat:@"%.1f/hr",amount];
                self.selectedFlag1=0;
                self.doneButton.enabled=YES;
                
            }
        }
        return  YES;
    }
    
    
    else if (textField==self.weeklyAfterText1)
    {
        self.reg_date2=self.weeklyAfterText1.text;
        self.weeklyPayOTText1.backgroundColor=[UIColor clearColor];
        self.weeklyPayOTText1.userInteractionEnabled=TRUE;
        self.weeklyMandatoryLabel1.hidden=false;
        return  YES;
    }
    
    else
        return  YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.overtimeNameText) {
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
            return YES;
        }
        
    }
    else if (textField==self.abbrvText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
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
        
    }
    else if ((textField==self.regularPayOTText1) || (textField==self.regularPayOTText2) || (textField==self.regularPayOTText3) || (textField==self.offdayPayOTText1) || (textField==self.offdayPayOTText2) || (textField==self.offdayPayOTText3) || (textField==self.partialPayOTText1) || (textField==self.partialPayOTText2) || (textField==self.partialPayOTText3) || (textField==self.holidayPayOTText1) || (textField==self.holidayPayOTText2) || (textField==self.holidayPayOTText3) || (textField==self.specificPayOT1Text) || (textField==self.specificPayOT2Text) || (textField==self.specificPayOT3Text) || (textField==self.specificPayOT4Text) || (textField==self.specificPayOT5Text) || (textField==self.specificPayOT6Text) || (textField==self.specificPayOT7Text) || (textField==self.weeklyPayOTText1) )
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
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
        
    }
    else if(textField==self.weeklyAfterText1)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
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
        
    }
    else
    {
        return YES;
    }
    return false;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView==self.descriptionTextView) {
        if ([text isEqualToString:@""]) {
            return YES;
        }
        if (textView.text.length<=149) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar u = [text characterAtIndex:0];
            if ([myCharSet characterIsMember:u])
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
        return  YES;
    }
    return  false;
}


-(IBAction)groupselectionaction:(id)sender
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"grouppopupview" owner:self options:nil];
    [self addSubview:[nib objectAtIndex:0]];
}

-(void)willRemoveSubview:(UIView *)subview
{
    self.mycollectionview.hidden=FALSE;
    NSMutableArray *selectedGropupArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
    [self.grouparray removeAllObjects];
    [self.grouparray addObjectsFromArray:selectedGropupArray];
    [self.mycollectionview reloadData];
}


-(IBAction)tabButtonAction:(id)sender{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        
        self.dropTableFlag=0;
        [self.payOTTC reloadData];
        
        if ([self.currentTab isEqualToString:@"Offday"]) {
            if ((self.offdayDailyLimitText.text.length >0) && (self.offdayPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self regulardayAction];
                
            }
            else
            {
                [self alertAction];
            }
        }
        
        
        if ([self.currentTab isEqualToString:@"Partialday"]) {
            if ((self.partialDailyLimitText.text.length >0) && (self.partialPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self regulardayAction];
            }
            else
            {
                [self alertAction];
            }
        }
        
        
        
        if ([self.currentTab isEqualToString:@"Holiday"]) {
            if ((self.holidayDailyLimitText.text.length >0) && (self.holidayPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self regulardayAction];
                
            }
            else
            {
                [self alertAction];
            }
        }
        if ([self.currentTab isEqualToString:@"Specificday"]) {
            [self regulardayAction];
        }
        
        

        
    }
    else if (button.tag==2)
    {
        if ([self.dropLabel1.text isEqualToString:@"First Certain Duration"]) {
            self.dropTableFlag=1;
            [self.payOTTC reloadData];
        }
        else
        {
            self.dropTableFlag=0;
            [self.payOTTC reloadData];
        }
        if ([self.currentTab isEqualToString:@"Regular"]) {
            if ((self.regularDailyLimitText.text.length >0) && (self.regularPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                if ([self.regularCheckButton1.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                    [self offdayRegularView];
                }
                
                [self offdayAction];
                
            }
            else
            {
                [self alertAction];
            }
        }
        
        
        if ([self.currentTab isEqualToString:@"Partialday"]) {
            if ((self.partialDailyLimitText.text.length >0) && (self.partialPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
               
                if ([self.regularCheckButton1.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                    [self offdayRegularView];
                }
                [self offdayAction];
            }
            else
            {
                [self alertAction];
            }
        }
        
        
        
        if ([self.currentTab isEqualToString:@"Holiday"]) {
            if ((self.holidayDailyLimitText.text.length >0) && (self.holidayPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                if ([self.regularCheckButton1.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                    [self offdayRegularView];
                }
                [self offdayAction];
                
            }
            else
            {
                [self alertAction];
            }
        }

        if ([self.currentTab isEqualToString:@"Specificday"]) {
            [self offdayAction];
            [self offdayRegularView];
            
            if ([self.regularCheckButton1.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                [self offdayRegularView];
            }
        }
        
        
        
    }
    else if (button.tag==3)
    {
        if ([self.dropLabel2.text isEqualToString:@"First Certain Duration"]) {
            self.dropTableFlag=1;
            [self.payOTTC reloadData];
        }
        else
        {
            self.dropTableFlag=0;
            [self.payOTTC reloadData];
        }

        
        if ([self.currentTab isEqualToString:@"Offday"]) {
            if ((self.offdayDailyLimitText.text.length >0) && (self.offdayPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self partialdayAction];
                if ([self.regularCheckButton2.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                    [self partialdayRegularView];
                };
            }
            else
            {
                [self alertAction];
            }
        }
        
        
        if ([self.currentTab isEqualToString:@"Regular"]) {
            if ((self.regularDailyLimitText.text.length >0) && (self.regularPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self partialdayAction];
                
                if ([self.regularCheckButton2.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                    [self partialdayRegularView];
                };
            }
            else
            {
                [self alertAction];
            }
        }
        
        
        
        if ([self.currentTab isEqualToString:@"Holiday"]) {
            if ((self.holidayDailyLimitText.text.length >0) && (self.holidayPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self partialdayAction];
               
                if ([self.regularCheckButton2.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                    [self partialdayRegularView];
                };
                
            }
            else
            {
                [self alertAction];
            }
        }
        
        if ([self.currentTab isEqualToString:@"Specificday"]) {
            [self partialdayAction];
            
            if ([self.regularCheckButton2.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                [self partialdayRegularView];
            };
        }

        
    }
    else if (button.tag==4)
    {
        if ([self.dropLabel3.text isEqualToString:@"First Certain Duration"]) {
            self.dropTableFlag=1;
            [self.payOTTC reloadData];
        }
        else
        {
            self.dropTableFlag=0;
            [self.payOTTC reloadData];
        }

        if ([self.currentTab isEqualToString:@"Offday"]) {
            if ((self.offdayDailyLimitText.text.length >0) && (self.offdayPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self holidayAction];
                if ([self.regularCheckButton3.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                    [self holidayRegularView];
                };
                
            }
            else
            {
                [self alertAction];
            }
        }
        
        
        if ([self.currentTab isEqualToString:@"Regular"]) {
            if ((self.regularDailyLimitText.text.length >0) && (self.regularPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self holidayAction];
                if ([self.regularCheckButton3.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                    [self holidayRegularView];
                };
            }
            else
            {
                [self alertAction];
            }
        }
        
        
        
        if ([self.currentTab isEqualToString:@"Partialday"]) {
            if ((self.partialDailyLimitText.text.length >0) && (self.partialPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self holidayAction];
                if ([self.regularCheckButton3.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                    [self holidayRegularView];
                };
                
            }
            else
            {
                [self alertAction];
            }
        }

        if ([self.currentTab isEqualToString:@"Specificday"]) {
            [self holidayAction];
            if ([self.regularCheckButton3.currentImage isEqual:[UIImage imageNamed:@"check_box.png32.png"]]) {
                [self holidayRegularView];
            };
        }
        
    }
    else
    {
        self.dropTableFlag=0;
        [self.payOTTC reloadData];
        if ([self.currentTab isEqualToString:@"Offday"]) {
            if ((self.offdayDailyLimitText.text.length >0) && (self.offdayPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self specificdayAction];
                
            }
            else
            {
                [self alertAction];
            }
        }
        
        
        if ([self.currentTab isEqualToString:@"Regular"]) {
            if ((self.regularDailyLimitText.text.length >0) && (self.regularPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self specificdayAction];
            }
            else
            {
                [self alertAction];
            }
        }
        
        
        
        if ([self.currentTab isEqualToString:@"Partialday"]) {
            if ((self.partialDailyLimitText.text.length >0) && (self.partialPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self specificdayAction];
                
            }
            else
            {
                [self alertAction];
            }
        }
        if ([self.currentTab isEqualToString:@"Holiday"]) {
            if ((self.holidayDailyLimitText.text.length >0) && (self.holidayPayOTText1.text.length >0) && (self.selectedFlag==0) && (self.selectedFlag1==0)) {
                
                [self specificdayAction];
                
            }
            else
            {
                [self alertAction];
            }
        }

        
        
    }
}
-(IBAction)doneButtonAction:(id)sender
{
    if ((self.overtimeNameText.text.length>0)&&(self.abbrvText.text.length>0)) {
       
        if((self.regularMandatoryLabel1.hidden==true) && (self.regularMandatoryLabel2.hidden==true) && (self.offdayMandatoryLabel1.hidden==true) && (self.offdayMandatoryLabel2.hidden==true) && (self.partialMandatoryLabel1.hidden==true) && (self.partialMandatoryLabel2.hidden==true) && (self.holidayMandatoryLabel1.hidden==true) && (self.holidayMandatoryLabel2.hidden==true))
        {
            [self.overtimeDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] forKey:@"oid"];
            [self.overtimeDict setObject:self.overtimeNameText.text forKey:@"ot_name"];
            [self.overtimeDict setObject:self.abbrvText.text forKey:@"ot_abbr"];
            [self.overtimeDict setObject:self.overtimeTypeText.text forKey:@"ot_type"];
            [self.overtimeDict setObject:self.descriptionTextView.text forKey:@"ot_des"];
            
            if ([self.overtimeTypeText.text isEqualToString:@"Daily"]) {
                
                //Regular
                [self.overtimeDict setObject:self.reg_date1 forKey:@"reg_overtime_limit"];
                [self.overtimeDict setObject:self.reg_ot1 forKey:@"reg_ot_1_rate"];
                [self.overtimeDict setObject:self.reg_date2 forKey:@"reg_ot_time2"];
                [self.overtimeDict setObject:self.reg_ot2 forKey:@"reg_ot_2_rate"];
                [self.overtimeDict setObject:self.reg_date3 forKey:@"reg_ot_time3"];
                [self.overtimeDict setObject:self.reg_ot3 forKey:@"reg_ot_3_rate"];
                [self.overtimeDict setObject:self.reg_pf forKey:@"pf"];
                [self.overtimeDict setObject:self.reg_esi forKey:@"esi"];
                [self.overtimeDict setObject:self.reg_incentives forKey:@"incentive"];
                
                //Offday
                [self.overtimeDict setObject:self.off_date1 forKey:@"off_overtime_limit"];
                if ([self.dropLabel1.text isEqualToString:@"After Standard Working Hours"]) {
                    [self.overtimeDict setObject:@"1" forKey:@"off_day_type"];
                }
                else if ([self.dropLabel1.text isEqualToString:@"Whole Day"])
                {
                    [self.overtimeDict setObject:@"2" forKey:@"off_day_type"];
                }
                else
                {
                    [self.overtimeDict setObject:@"3" forKey:@"off_day_type"];
                }
                
                [self.overtimeDict setObject:self.off_firstDate forKey:@"off_hour"];
                [self.overtimeDict setObject:self.off_ot1 forKey:@"off_ot_1_rate"];
                [self.overtimeDict setObject:self.off_date2 forKey:@"off_ot_time2"];
                [self.overtimeDict setObject:self.off_ot2 forKey:@"off_ot_2_rate"];
                [self.overtimeDict setObject:self.off_date3 forKey:@"off_ot_time3"];
                [self.overtimeDict setObject:self.off_ot3 forKey:@"off_ot_3_rate"];
                [self.overtimeDict setObject:self.off_same_regular forKey:@"same_reg_off"];
                
                //Partial Day
                [self.overtimeDict setObject:self.par_date1 forKey:@"par_overtime_limit"];
                
                if ([self.dropLabel2.text isEqualToString:@"After Standard Working Hours"]) {
                    [self.overtimeDict setObject:@"1" forKey:@"par_day_type"];
                }
                else if ([self.dropLabel2.text isEqualToString:@"Whole Day"])
                {
                    [self.overtimeDict setObject:@"2" forKey:@"par_day_type"];
                }
                else
                {
                    [self.overtimeDict setObject:@"3" forKey:@"par_day_type"];
                }
                
                [self.overtimeDict setObject:self.par_firstDate forKey:@"par_hour"];
                [self.overtimeDict setObject:self.par_ot1 forKey:@"par_ot_1_rate"];
                [self.overtimeDict setObject:self.par_date2 forKey:@"par_ot_time2"];
                [self.overtimeDict setObject:self.par_ot2 forKey:@"par_ot_2_rate"];
                [self.overtimeDict setObject:self.par_date3 forKey:@"par_ot_time3"];
                [self.overtimeDict setObject:self.par_ot3 forKey:@"par_ot_3_rate"];
                [self.overtimeDict setObject:self.par_same_regular forKey:@"same_reg_par"];
                
                //Holiday
                [self.overtimeDict setObject:self.hol_date1 forKey:@"holi_overtime_limit"];
                
                if ([self.dropLabel3.text isEqualToString:@"After Standard Working Hours"]) {
                    [self.overtimeDict setObject:@"1" forKey:@"holi_day_type"];
                }
                else if ([self.dropLabel3.text isEqualToString:@"Whole Day"])
                {
                    [self.overtimeDict setObject:@"2" forKey:@"holi_day_type"];
                }
                else
                {
                    [self.overtimeDict setObject:@"3" forKey:@"holi_day_type"];
                }
                [self.overtimeDict setObject:self.hol_firstDate forKey:@"holi_hour"];
                [self.overtimeDict setObject:self.hol_ot1 forKey:@"holi_ot_1_rate"];
                [self.overtimeDict setObject:self.hol_date2 forKey:@"holi_ot_time2"];
                [self.overtimeDict setObject:self.hol_ot2 forKey:@"holi_ot_2_rate"];
                [self.overtimeDict setObject:self.hol_date3 forKey:@"holi_ot_time3"];
                [self.overtimeDict setObject:self.hol_ot3 forKey:@"holi_ot_3_rate"];
                [self.overtimeDict setObject:self.hol_same_regular forKey:@"same_reg_holi"];
                
                //Specific Day
                NSMutableArray *dayArray=[[NSMutableArray alloc]initWithObjects:self.specificDay1Text.text,self.specificDay2Text.text,self.specificDay3Text.text,self.specificDay4Text.text,self.specificDay5Text.text,self.specificDay6Text.text,self.specificDay7Text.text, nil];
                [dayArray removeObject:@""];
                [self.overtimeDict setObject:dayArray forKey:@"spec_day"];
                
                [self.specificConditionArray removeObject:@""];
                [self.overtimeDict setObject:self.specificConditionArray forKey:@"spec_condition"];
                
                NSMutableArray *startTimeArray=[[NSMutableArray alloc]initWithObjects:self.specificFromTime1Text.text,self.specificFromTime2Text.text,self.specificFromTime3Text.text,self.specificFromTime4Text.text,self.specificFromTime5Text.text,self.specificFromTime6Text.text,self.specificFromTime7Text.text, nil];
                
                
                
                [startTimeArray removeObject:@""];
                for(int item=0;item<startTimeArray.count;item++)
                {
                    
                    if (!([[startTimeArray objectAtIndex:item]isEqualToString:@"00:00"])) {
                        NSArray *startTime=[[startTimeArray objectAtIndex:item]componentsSeparatedByString:@":"];
                        
                        NSArray *time=[[startTime objectAtIndex:1]componentsSeparatedByString:@" "];
                        if ([[time objectAtIndex:1]isEqualToString:@"PM"]) {
                            int hour=[[startTime objectAtIndex:0] integerValue]+12;
                            NSString *myTime=[NSString stringWithFormat:@"%d:%@",hour,[time objectAtIndex:0]];
                            [startTimeArray replaceObjectAtIndex:item withObject:myTime];
                        }
                        else
                        {
                            NSString *myTime=[NSString stringWithFormat:@"%@:%@",[startTime objectAtIndex:0],[time objectAtIndex:0]];
                            [startTimeArray replaceObjectAtIndex:item withObject:myTime];
                        }
                    }

                }
                
                [self.overtimeDict setObject:startTimeArray forKey:@"spec_start"];
                
                NSMutableArray *endTimeArray=[[NSMutableArray alloc] initWithObjects:self.specificToTime1Text.text,self.specificToTime2Text.text,self.specificToTime3Text.text,self.specificToTime4Text.text,self.specificToTime5Text.text,self.specificToTime6Text.text,self.specificToTime7Text.text, nil];
                [endTimeArray removeObject:@""];
                
                for (int item=0; item<endTimeArray.count; item++) {
                    if (!([[endTimeArray objectAtIndex:item]isEqualToString:@"00:00"])) {
                        NSArray *endTime=[[endTimeArray objectAtIndex:item]componentsSeparatedByString:@":"];
                        
                        NSArray *time=[[endTime objectAtIndex:1]componentsSeparatedByString:@" "];
                        if ([[time objectAtIndex:1]isEqualToString:@"PM"]) {
                            int hour=[[endTime objectAtIndex:0] integerValue]+12;
                            NSString *myTime=[NSString stringWithFormat:@"%d:%@",hour,[time objectAtIndex:0]];
                            [endTimeArray replaceObjectAtIndex:item withObject:myTime];
                        }
                        else
                        {
                            NSString *myTime=[NSString stringWithFormat:@"%@:%@",[endTime objectAtIndex:0],[time objectAtIndex:0]];
                            [endTimeArray replaceObjectAtIndex:item withObject:myTime];
                        }
                    }

                }
                
                
                [self.overtimeDict setObject:endTimeArray forKey:@"spec_end"];
                
                [self.specificPayOTRateArray removeObject:@""];
                [self.overtimeDict setObject:self.specificPayOTRateArray forKey:@"spec_rate"];
                
                
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation" ]count]>0) {
                    [self.overtimeDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedDesignation"] forKey:@"designation_list"];
                    
                }
                else
                {
                    [self.overtimeDict setObject:@"" forKey:@"designation_list"];
                }
                
                
                if ([self.action isEqualToString:@"create"]) {
                    [self.myconnection createNewOvertime:self.overtimeDict];
                }
                else
                {
                    [self.overtimeDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"overtimeID"] forKey:@"over_id"];
                    [self.myconnection updateOvertimeRule:self.overtimeDict];
                }
            }
            else
            {
                [self.overtimeDict setObject:self.reg_date1 forKey:@"reg_overtime_limit"];
                [self.overtimeDict setObject:self.reg_date2 forKey:@"reg_ot_time2"];
                [self.overtimeDict setObject:self.reg_ot1 forKey:@"reg_ot_1_rate"];
                [self.overtimeDict setObject:self.reg_pf forKey:@"pf"];
                [self.overtimeDict setObject:self.reg_esi forKey:@"esi"];
                [self.overtimeDict setObject:self.reg_incentives forKey:@"incentive"];
                [self.overtimeDict setObject:self.weeklyWorkingHoursText.text forKey:@"calculation"];
                [self.overtimeDict setObject:self.paidLeavesValue forKey:@"paid_leaves"];
                [self.overtimeDict setObject:self.paidHolidaysvalue forKey:@"paid_holidays"];
                [self.overtimeDict setObject:self.apply7thValue forKey:@"apply_7"];
                
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation" ]count]>0) {
                    [self.overtimeDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedDesignation"] forKey:@"designation_list"];
                }
                else
                {
                    [self.overtimeDict setObject:@"" forKey:@"designation_list"];
                }
                
                if ([self.action isEqualToString:@"create"]) {
                    [self.myconnection createNewOvertime:self.overtimeDict];
                }
                else
                {
                    [self.overtimeDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"overtimeID"] forKey:@"over_id"];
                    [self.myconnection updateOvertimeRule:self.overtimeDict];
                }
            }
        }
        else
        {
            [self showalerviewcontroller:@"Mandatory Fields are Required"];
        }
        
        
    }
    else
    {
        [self showalerviewcontroller:@"Overtime Name and Abbreviation is Mandatory"];
    }
    
    
    
}
-(IBAction)cancelButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}

-(IBAction)doneTimerAction:(id)sender
{
    NSDate *myDate = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH :mm"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    NSArray *timeArray=[prettyVersion componentsSeparatedByString:@":"];
    NSString *selectedTime=[NSString stringWithFormat:@" %@Hrs %@ Mins",[timeArray objectAtIndex:0],[timeArray objectAtIndex:1]];
    if (self.flag==1) {
        self.regularDailyLimitText.text=selectedTime;
        self.reg_date1=prettyVersion;
        self.regularPayOTText1.backgroundColor=[UIColor clearColor];
        self.regularPayOTText1.userInteractionEnabled=true;
        self.doneButton.enabled=NO;
    }
    if (self.flag==3) {
        self.regularAfterText1.text=selectedTime;
        self.reg_date2=prettyVersion;
        self.regularMandatoryLabel1.hidden=false;
        self.regularPayOTText2.backgroundColor=[UIColor clearColor];
        self.regularPayOTText2.userInteractionEnabled=true;
        self.selectedFlag=1;
    }
    if (self.flag==4) {
        self.regularAfterText2.text=selectedTime;
        self.reg_date3=prettyVersion;
        self.regularMandatoryLabel2.hidden=false;
        self.regularPayOTText3.backgroundColor=[UIColor clearColor];
        self.regularPayOTText3.userInteractionEnabled=true;
        self.selectedFlag1=1;
    }
    if (self.flag==5) {
        self.offDayFirstText.text=selectedTime;
        self.off_firstDate=prettyVersion;
        self.offdayPayOTText1.backgroundColor=[UIColor clearColor];
        self.offdayPayOTText1.userInteractionEnabled=true;
    }
    if (self.flag==6) {
        self.offdayDailyLimitText.text=selectedTime;
        self.off_date1=prettyVersion;
        self.offDayFirstText.backgroundColor=[UIColor clearColor];
        self.offDayFirstText.userInteractionEnabled=true;
        self.offdayPayOTText1.backgroundColor=[UIColor clearColor];
        self.offdayPayOTText1.userInteractionEnabled=true;
        self.doneButton.enabled=NO;
    }
    if (self.flag==7) {
        self.offdayAfterText1.text=selectedTime;
        self.off_date2=prettyVersion;
        self.selectedFlag=1;
        self.offdayPayOTText2.backgroundColor=[UIColor clearColor];
        self.offdayPayOTText2.userInteractionEnabled=true;
        self.offdayMandatoryLabel1.hidden=false;
        
    }
    if (self.flag==8) {
        self.offdayAfterText2.text=selectedTime;
        self.off_date3=prettyVersion;
        self.selectedFlag1=1;
        self.offdayPayOTText3.backgroundColor=[UIColor clearColor];
        self.offdayPayOTText3.userInteractionEnabled=true;
        self.offdayMandatoryLabel2.hidden=false;
    }
    if (self.flag==9) {
        self.partialDailyLimitText.text=selectedTime;
        self.par_date1=prettyVersion;
        self.partialFirstText.backgroundColor=[UIColor clearColor];
        self.partialFirstText.userInteractionEnabled=true;
        self.partialPayOTText1.backgroundColor=[UIColor clearColor];
        self.partialPayOTText1.userInteractionEnabled=true;
        self.doneButton.enabled=NO;
    }
    if (self.flag==10) {
        self.partialFirstText.text=selectedTime;
        self.par_firstDate=prettyVersion;
        self.partialPayOTText1.backgroundColor=[UIColor clearColor];
        self.partialPayOTText1.userInteractionEnabled=true;
    }
    if (self.flag==11) {
        self.partialAfterText1.text=selectedTime;
        self.par_date2=prettyVersion;
        self.selectedFlag=1;
        self.partialPayOTText2.backgroundColor=[UIColor clearColor];
        self.partialPayOTText2.userInteractionEnabled=true;
        self.partialMandatoryLabel1.hidden=false;
    }
    if (self.flag==12) {
        self.partialAfterText2.text=selectedTime;
        self.par_date3=prettyVersion;
        self.selectedFlag1=1;
        self.partialPayOTText3.backgroundColor=[UIColor clearColor];
        self.partialPayOTText3.userInteractionEnabled=true;
        self.partialMandatoryLabel2.hidden=false;
        
    }
    if (self.flag==13) {
        self.holidayDailyLimitText.text=selectedTime;
        self.hol_date1=prettyVersion;
        self.holidayFirstText.backgroundColor=[UIColor clearColor];
        self.holidayFirstText.userInteractionEnabled=true;
        self.holidayPayOTText1.backgroundColor=[UIColor clearColor];
        self.holidayPayOTText1.userInteractionEnabled=true;
        self.doneButton.enabled=NO;
        
    }
    if (self.flag==14) {
        self.holidayFirstText.text=selectedTime;
        self.hol_firstDate=prettyVersion;
        self.holidayPayOTText1.backgroundColor=[UIColor clearColor];
        self.holidayPayOTText1.userInteractionEnabled=true;
    }
    if (self.flag==15) {
        self.holidayAfterText1.text=selectedTime;
        self.hol_date2=prettyVersion;
        self.selectedFlag=1;
        self.holidayPayOTText2.backgroundColor=[UIColor clearColor];
        self.holidayPayOTText2.userInteractionEnabled=true;
        self.holidayMandatoryLabel1.hidden=false;
        
    }
    if (self.flag==16) {
        self.holidayAfterText2.text=selectedTime;
        self.hol_date3=prettyVersion;
        self.selectedFlag1=1;
        self.holidayPayOTText3.backgroundColor=[UIColor clearColor];
        self.holidayPayOTText3.userInteractionEnabled=true;
        self.holidayMandatoryLabel2.hidden=false;
    }
    if (self.flag==17) {
        self.weeklyDailyLimitText.text=selectedTime;
        self.reg_date1=prettyVersion;
        self.weeklyAfterText1.backgroundColor=[UIColor clearColor];
        self.weeklyAfterText1.userInteractionEnabled=true;
        self.doneButton.enabled=NO;
    }
    self.datePickerView.hidden=TRUE;
}



-(IBAction)regularCheckButtonAction:(id)sender
{
    if (self.regularDailyLimitText.text.length > 0) {
        UIButton *button=(UIButton *)sender;
        if (button.tag==1) {
            if (x%2==0) {
                [self.regularCheckButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                [self resetOffdayDailyLimit];
                self.offdayDailyLimitText.backgroundColor=[UIColor whiteColor];
                self.offdayDailyLimitText.text=@"";
                self.offdayAfterText1.text=@"";
                self.offdayAfterText2.text=@"";
                self.offdayPayOTText1.text=@"";
                self.offdayPayOTText2.text =@"";
                self.offdayPayOTText3.text=@"";
                
                self.offdayDailyLimitText.userInteractionEnabled=YES;
                self.offdayAfterText1.userInteractionEnabled=YES;
                self.offdayAfterText2.userInteractionEnabled=YES;
                self.offdayPayOTText1.userInteractionEnabled=YES;
                self.offdayPayOTText2.userInteractionEnabled=YES;
                self.offdayPayOTText3.userInteractionEnabled=YES;
                self.dropButton1.userInteractionEnabled=YES;
                self.x++;
                
                self.off_same_regular=@"0";

            }
            else
            {
                
                [self offdayRegularView];
                
                 self.off_same_regular=@"1";
                self.x++;

                
                
            }
            
            
            
        }
        else if (button.tag==2)
        {
            if (y%2==0) {
                
                [self.regularCheckButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                [self resetPartialDialyLimit];
                self.partialDailyLimitText.backgroundColor=[UIColor whiteColor];
                self.partialDailyLimitText.text=@"";
                self.partialAfterText1.text=@"";
                self.partialAfterText2.text=@"";
                self.partialPayOTText1.text=@"";
                self.partialPayOTText2.text =@"";
                self.partialPayOTText3.text=@"";
                
                self.partialDailyLimitText.userInteractionEnabled=YES;
                self.partialAfterText1.userInteractionEnabled=YES;
                self.partialAfterText2.userInteractionEnabled=YES;
                self.partialPayOTText1.userInteractionEnabled=YES;
                self.partialPayOTText2.userInteractionEnabled=YES;
                self.partialPayOTText3.userInteractionEnabled=YES;
                self.dropButton2.userInteractionEnabled=YES;
                self.y++;
                
                self.par_same_regular=@"0";
            }
            else
            {
                [self partialdayRegularView];
                 y++;
                self.par_same_regular=@"1";
            }
        }
        else if (button.tag==3)
        {
            if (z%2==0) {
                [self.regularCheckButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                [self resetHolidayDialyLimit];
                self.holidayDailyLimitText.backgroundColor=[UIColor clearColor];
                self.holidayDailyLimitText.text=@"";
                self.holidayAfterText1.text=@"";
                self.holidayAfterText2.text=@"";
                self.holidayPayOTText1.text=@"";
                self.holidayPayOTText2.text =@"";
                self.holidayPayOTText3.text=@"";
                
                self.holidayDailyLimitText.userInteractionEnabled=YES;
                self.holidayAfterText1.userInteractionEnabled=YES;
                self.holidayAfterText2.userInteractionEnabled=YES;
                self.holidayPayOTText1.userInteractionEnabled=YES;
                self.holidayPayOTText2.userInteractionEnabled=YES;
                self.holidayPayOTText3.userInteractionEnabled=YES;
                self.dropButton3.userInteractionEnabled=YES;
                self.z++;
                self.hol_same_regular=@"0";

            }
            else
            {
                [self holidayRegularView];
                z++;
                self.hol_same_regular=@"1";
                
            }
        }

    }
    else
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Warning"
                                   message:@"You must fill Regular Days to Continue"
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
}
-(IBAction)dropButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        dropFlag=1;
        self.dropTableView.hidden=false;
    }
    else if (button.tag==2)
    {
        dropFlag=2;
        self.dropTableView.hidden=false;
    }
    else if (button.tag==3)
    {
        dropFlag=3;
        self.dropTableView.hidden=false;
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


-(void)resetRegularDailyLimit
{
    self.doneButton.enabled=YES;
    self.regularDailyLimitText.text=@"";
    self.regularPayOTText1.text=@"";
    self.regularPayOTText1.userInteractionEnabled=false;
    self.regularPayOTText1.backgroundColor=[UIColor lightGrayColor];
    self.regularAfterText1.text=@"";
    self.regularAfterText1.userInteractionEnabled=false;
    self.regularAfterText1.backgroundColor=[UIColor lightGrayColor];
    self.regularPayOTText2.text=@"";
    self.regularPayOTText2.userInteractionEnabled=false;
    self.regularPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.regularAfterText2.text=@"";
    self.regularAfterText2.userInteractionEnabled=false;
    self.regularAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.regularPayOTText3.text=@"";
    self.regularPayOTText3.userInteractionEnabled=false;
    self.regularPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.regularMandatoryLabel1.hidden=true;
    self.regularMandatoryLabel2.hidden=true;
    self.reg_date1=self.reg_date3=self.reg_date2=self.reg_ot1=self.reg_ot2=self.reg_ot3=@"";
    
}
-(void)resetRegularAfter1
{
    self.regularAfterText1.text=@"";
    self.regularPayOTText2.text=@"";
    self.regularPayOTText2.userInteractionEnabled=false;
    self.regularPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.regularAfterText2.text=@"";
    self.regularAfterText2.userInteractionEnabled=false;
    self.regularAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.regularPayOTText3.text=@"";
    self.regularPayOTText3.userInteractionEnabled=false;
    self.regularPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.regularMandatoryLabel1.hidden=true;
    self.regularMandatoryLabel2.hidden=true;
    self.reg_date2=self.reg_ot2=self.reg_date3=self.reg_ot3=@"";
    self.selectedFlag=0;
}
-(void)resetRegularAfter2
{
    self.regularAfterText2.text=@"";
    self.regularPayOTText3.text=@"";
    self.regularPayOTText3.userInteractionEnabled=false;
    self.regularPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.regularMandatoryLabel2.hidden=true;
    self.reg_date3=self.reg_ot3=@"";
    self.selectedFlag1=0;
}
-(void)resetOffdayDailyLimit
{
    self.doneButton.enabled=YES;
    self.offdayDailyLimitText.text=@"";
    self.offDayFirstText.text=@"";
    self.offDayFirstText.backgroundColor=[UIColor lightGrayColor];
    self.offDayFirstText.userInteractionEnabled=NO;
    self.offdayPayOTText1.text=@"";
    self.offdayPayOTText1.userInteractionEnabled=false;
    self.offdayPayOTText1.backgroundColor=[UIColor lightGrayColor];
    self.offdayAfterText1.text=@"";
    self.offdayAfterText1.userInteractionEnabled=false;
    self.offdayAfterText1.backgroundColor=[UIColor lightGrayColor];
    self.offdayPayOTText2.text=@"";
    self.offdayPayOTText2.userInteractionEnabled=false;
    self.offdayPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.offdayAfterText2.text=@"";
    self.offdayAfterText2.userInteractionEnabled=false;
    self.offdayAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.offdayPayOTText3.text=@"";
    self.offdayPayOTText3.userInteractionEnabled=false;
    self.offdayPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.offdayMandatoryLabel1.hidden=true;
    self.offdayMandatoryLabel2.hidden=true;
    self.off_date1=self.off_date3=self.off_date2=self.off_firstDate=self.off_ot1=self.off_ot2=self.off_ot3=@"";
    
}
-(void)resetOffdayFirstText
{
    self.offDayFirstText.text=@"";
    self.offdayPayOTText1.text=@"";
    self.offdayAfterText1.text=@"";
    self.offdayAfterText1.userInteractionEnabled=false;
    self.offdayAfterText1.backgroundColor=[UIColor lightGrayColor];
    self.offdayPayOTText2.text=@"";
    self.offdayPayOTText2.userInteractionEnabled=false;
    self.offdayPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.offdayAfterText2.text=@"";
    self.offdayAfterText2.userInteractionEnabled=false;
    self.offdayAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.offdayPayOTText3.text=@"";
    self.offdayPayOTText3.userInteractionEnabled=false;
    self.offdayPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.offdayMandatoryLabel1.hidden=true;
    self.offdayMandatoryLabel2.hidden=true;
    self.off_date3=self.off_date2=self.off_firstDate=self.off_ot1=self.off_ot2=self.off_ot3=@"";
}
-(void)resetOffdayAfter1
{
    self.offdayAfterText1.text=@"";
    self.offdayPayOTText2.text=@"";
    self.offdayPayOTText2.userInteractionEnabled=false;
    self.offdayPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.offdayAfterText2.text=@"";
    self.offdayAfterText2.userInteractionEnabled=false;
    self.offdayAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.offdayPayOTText3.text=@"";
    self.offdayPayOTText3.userInteractionEnabled=false;
    self.offdayPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.offdayMandatoryLabel1.hidden=true;
    self.offdayMandatoryLabel2.hidden=true;
    self.off_date2=self.off_ot2=self.off_date3=self.off_ot3=@"";
    self.selectedFlag=0;
}
-(void)resetOffdayAfter2
{
    self.offdayAfterText2.text=@"";
    self.offdayPayOTText3.text=@"";
    self.offdayPayOTText3.userInteractionEnabled=false;
    self.offdayPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.offdayMandatoryLabel2.hidden=true;
    self.off_date3=self.off_ot3=@"";
    self.selectedFlag1=0;
}
-(void)resetPartialDialyLimit
{
    self.doneButton.enabled=YES;
    self.partialDailyLimitText.text=@"";
    self.partialFirstText.text=@"";
    self.partialFirstText.backgroundColor=[UIColor lightGrayColor];
    self.partialFirstText.userInteractionEnabled=NO;
    self.partialPayOTText1.text=@"";
    self.partialPayOTText1.userInteractionEnabled=false;
    self.partialPayOTText1.backgroundColor=[UIColor lightGrayColor];
    self.partialAfterText1.text=@"";
    self.partialAfterText1.userInteractionEnabled=false;
    self.partialAfterText1.backgroundColor=[UIColor lightGrayColor];
    self.partialPayOTText2.text=@"";
    self.partialPayOTText2.userInteractionEnabled=false;
    self.partialPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.partialAfterText2.text=@"";
    self.partialAfterText2.userInteractionEnabled=false;
    self.partialAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.partialPayOTText3.text=@"";
    self.partialPayOTText3.userInteractionEnabled=false;
    self.partialPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.partialMandatoryLabel1.hidden=true;
    self.partialMandatoryLabel2.hidden=true;
    
    self.par_date1=self.par_firstDate=self.par_ot1=self.par_date2=self.par_ot2=self.par_date3=self.par_ot3=@"";

}
-(void)resetPartialFirstText
{
    self.partialFirstText.text=@"";
    self.partialPayOTText1.text=@"";
    self.partialAfterText1.text=@"";
    self.partialAfterText1.userInteractionEnabled=false;
    self.partialAfterText1.backgroundColor=[UIColor lightGrayColor];
    self.partialPayOTText2.text=@"";
    self.partialPayOTText2.userInteractionEnabled=false;
    self.partialPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.partialAfterText2.text=@"";
    self.partialAfterText2.userInteractionEnabled=false;
    self.partialAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.partialPayOTText3.text=@"";
    self.partialPayOTText3.userInteractionEnabled=false;
    self.partialPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.partialMandatoryLabel1.hidden=true;
    self.partialMandatoryLabel2.hidden=true;
    
    self.par_firstDate=self.par_ot1=self.par_date2=self.par_ot2=self.par_date3=self.par_ot3=@"";
}
-(void)resetPartialAfter1
{
    self.partialAfterText1.text=@"";
    self.partialPayOTText2.text=@"";
    self.partialPayOTText2.userInteractionEnabled=false;
    self.partialPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.partialAfterText2.text=@"";
    self.partialAfterText2.userInteractionEnabled=false;
    self.partialAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.partialPayOTText3.text=@"";
    self.partialPayOTText3.userInteractionEnabled=false;
    self.partialPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.partialMandatoryLabel1.hidden=true;
    self.partialMandatoryLabel2.hidden=true;
    self.selectedFlag=0;
    self.par_date2=self.par_ot2=self.par_date3=self.par_ot3=@"";
}
-(void)resetPartialAfter2
{
    self.partialAfterText2.text=@"";
    self.partialPayOTText3.text=@"";
    self.partialPayOTText3.userInteractionEnabled=false;
    self.partialPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.partialMandatoryLabel2.hidden=true;
    self.selectedFlag1=0;
    
    self.par_date3=self.par_ot3=@"";
}
-(void)resetHolidayDialyLimit
{
    self.doneButton.enabled=YES;
    self.holidayDailyLimitText.text=@"";
    self.holidayFirstText.text=@"";
    self.holidayFirstText.backgroundColor=[UIColor lightGrayColor];
    self.holidayFirstText.userInteractionEnabled=NO;
    self.holidayPayOTText1.text=@"";
    self.holidayPayOTText1.userInteractionEnabled=false;
    self.holidayPayOTText1.backgroundColor=[UIColor lightGrayColor];
    self.holidayAfterText1.text=@"";
    self.holidayAfterText1.userInteractionEnabled=false;
    self.holidayAfterText1.backgroundColor=[UIColor lightGrayColor];
    self.holidayPayOTText2.text=@"";
    self.holidayPayOTText2.userInteractionEnabled=false;
    self.holidayPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.holidayAfterText2.text=@"";
    self.holidayAfterText2.userInteractionEnabled=false;
    self.holidayAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.holidayPayOTText3.text=@"";
    self.holidayPayOTText3.userInteractionEnabled=false;
    self.holidayPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.holidayMandatoryLabel1.hidden=true;
    
    self.holidayMandatoryLabel2.hidden=true;
    
    self.hol_date1=self.hol_firstDate=self.hol_ot1=self.hol_date2=self.hol_ot2=self.hol_date3=self.hol_ot3=@"";
}
-(void)resetHolidayFirstText
{
    self.holidayFirstText.text=@"";
    self.holidayPayOTText1.text=@"";
    self.holidayAfterText1.text=@"";
    self.holidayAfterText1.userInteractionEnabled=false;
    self.holidayAfterText1.backgroundColor=[UIColor lightGrayColor];
    self.holidayPayOTText2.text=@"";
    self.holidayPayOTText2.userInteractionEnabled=false;
    self.holidayPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.holidayAfterText2.text=@"";
    self.holidayAfterText2.userInteractionEnabled=false;
    self.holidayAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.holidayPayOTText3.text=@"";
    self.holidayPayOTText3.userInteractionEnabled=false;
    self.holidayPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.holidayMandatoryLabel1.hidden=true;
    self.holidayMandatoryLabel2.hidden=true;
    
    self.hol_firstDate=self.hol_ot1=self.hol_date2=self.hol_ot2=self.hol_date3=self.hol_ot3=@"";
}
-(void)resetHolidayAfter1
{
    self.holidayAfterText1.text=@"";
    self.holidayPayOTText2.text=@"";
    self.holidayPayOTText2.userInteractionEnabled=false;
    self.holidayPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.holidayAfterText2.text=@"";
    self.holidayAfterText2.userInteractionEnabled=false;
    self.holidayAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.holidayPayOTText3.text=@"";
    self.holidayPayOTText3.userInteractionEnabled=false;
    self.holidayPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.holidayMandatoryLabel1.hidden=true;
    self.holidayMandatoryLabel2.hidden=true;
    self.selectedFlag=0;
    self.hol_date2=self.hol_ot2=self.hol_date3=self.hol_ot3=@"";
}
-(void)resetHolidayAfter2
{
    self.holidayAfterText2.text=@"";
    self.holidayPayOTText3.text=@"";
    self.holidayPayOTText3.userInteractionEnabled=false;
    self.holidayPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.holidayMandatoryLabel2.hidden=true;
    self.hol_date3=self.hol_ot3=@"";
    self.selectedFlag1=0;
}

-(void)resetWeeklyDailyLimit
{
    self.weeklyDailyLimitText.text=@"";
    self.weeklyAfterText1.text=@"";
    self.weeklyAfterText1.userInteractionEnabled=FALSE;
    self.weeklyAfterText1.backgroundColor=[UIColor lightGrayColor];
    self.weeklyPayOTText1.text=@"";
    self.weeklyPayOTText1.userInteractionEnabled=FALSE;
    self.weeklyPayOTText1.backgroundColor=[UIColor lightGrayColor];
    
   
    
    self.weeklyMandatoryLabel1.hidden=true;
}
-(void)resetWeeklyAfter1
{
    self.weeklyAfterText1.text=@"";
    self.weeklyPayOTText1.text=@"";
    self.weeklyPayOTText1.userInteractionEnabled=FALSE;
    self.weeklyPayOTText1.backgroundColor=[UIColor lightGrayColor];
    self.weeklyMandatoryLabel1.hidden=true;
}

-(void)resetDay1
{
    self.specificDay1Text.text=@"";
    
    self.specificCondition1Text.text=@"";
    self.specificCondition1Text.backgroundColor=[UIColor lightGrayColor];
    self.specificCondition1Text.userInteractionEnabled=NO;
    
    self.specificFromTime1Text.text=@"";
    self.specificFromTime1Text.backgroundColor=[UIColor lightGrayColor];
    self.specificFromTime1Text.userInteractionEnabled=NO;
    
    self.specificToTime1Text.text=@"";
    self.specificToTime1Text.backgroundColor=[UIColor lightGrayColor];
    self.specificToTime1Text.userInteractionEnabled=NO;
    
    self.specificPayOT1Text.text=@"";
    self.specificPayOT1Text.backgroundColor=[UIColor lightGrayColor];
    self.specificPayOT1Text.userInteractionEnabled=NO;
    
    [self.dayArray removeAllObjects];
    for (int h=0; h<self.specificConditionArray.count; h++) {
        [self.specificConditionArray replaceObjectAtIndex:h withObject:@""];
    }
    for (int m=0; m<self.specificPayOTRateArray.count; m++) {
        [self.specificPayOTRateArray replaceObjectAtIndex:m withObject:@""];
    }
    
    
    [self.dayArray addObjectsFromArray:self.dummyDayArray];
    self.secondView.hidden=true;
    self.thirdView.hidden=true;
    self.fourthView.hidden=true;
    self.fifthView.hidden=true;
    self.sixthView.hidden=true;
    self.seventhView.hidden=true;
    
    
    
}
-(void)resetDay2
{
    self.specificDay2Text.text=@"";
    
    self.specificCondition2Text.text=@"";
    self.specificCondition2Text.backgroundColor=[UIColor lightGrayColor];
    self.specificCondition2Text.userInteractionEnabled=NO;
    
    self.specificFromTime2Text.text=@"";
    self.specificFromTime2Text.backgroundColor=[UIColor lightGrayColor];
    self.specificFromTime2Text.userInteractionEnabled=NO;
    
    self.specificToTime2Text.text=@"";
    self.specificToTime2Text.backgroundColor=[UIColor lightGrayColor];
    self.specificToTime2Text.userInteractionEnabled=NO;
    
    self.specificPayOT2Text.text=@"";
    self.specificPayOT2Text.backgroundColor=[UIColor lightGrayColor];
    self.specificPayOT2Text.userInteractionEnabled=NO;
    
    
    [self.dayArray removeAllObjects];
    [self.dayArray addObjectsFromArray:self.dummyDayArray];
    [self.dayArray removeObject:self.specificDay1Text.text];
    
    self.thirdView.hidden=true;
    self.fourthView.hidden=true;
    self.fifthView.hidden=true;
    self.sixthView.hidden=true;
    self.seventhView.hidden=true;
    
    int count=self.specificConditionArray.count-1;
    for (int p1=0; p1<count; p1++) {
        [self resetSpecific:1];
    }
    
}
-(void)resetDay3
{
    self.specificDay3Text.text=@"";
    
    self.specificCondition3Text.text=@"";
    self.specificCondition3Text.backgroundColor=[UIColor lightGrayColor];
    self.specificCondition3Text.userInteractionEnabled=NO;
    
    self.specificFromTime3Text.text=@"";
    self.specificFromTime3Text.backgroundColor=[UIColor lightGrayColor];
    self.specificFromTime3Text.userInteractionEnabled=NO;
    
    self.specificToTime3Text.text=@"";
    self.specificToTime3Text.backgroundColor=[UIColor lightGrayColor];
    self.specificToTime3Text.userInteractionEnabled=NO;
    
    self.specificPayOT3Text.text=@"";
    self.specificPayOT3Text.backgroundColor=[UIColor lightGrayColor];
    self.specificPayOT3Text.userInteractionEnabled=NO;
    
    [self.dayArray removeAllObjects];
    [self.dayArray addObjectsFromArray:self.dummyDayArray];
    [self.dayArray removeObject:self.specificDay1Text.text];
    [self.dayArray removeObject:self.specificDay2Text.text];
    
    self.fourthView.hidden=true;
    self.fifthView.hidden=true;
    self.sixthView.hidden=true;
    self.seventhView.hidden=true;
    
    int count=self.specificConditionArray.count-2;
    for (int p1=0; p1<count; p1++) {
        [self resetSpecific:2];
    }

    
}
-(void)resetDay4
{
    self.specificDay4Text.text=@"";
    
    self.specificCondition4Text.text=@"";
    self.specificCondition4Text.backgroundColor=[UIColor lightGrayColor];
    self.specificCondition4Text.userInteractionEnabled=NO;
    
    self.specificFromTime4Text.text=@"";
    self.specificFromTime4Text.backgroundColor=[UIColor lightGrayColor];
    self.specificFromTime4Text.userInteractionEnabled=NO;
    
    self.specificToTime4Text.text=@"";
    self.specificToTime4Text.backgroundColor=[UIColor lightGrayColor];
    self.specificToTime4Text.userInteractionEnabled=NO;
    
    self.specificPayOT4Text.text=@"";
    self.specificPayOT4Text.backgroundColor=[UIColor lightGrayColor];
    self.specificPayOT4Text.userInteractionEnabled=NO;
    
    [self.dayArray removeAllObjects];
    [self.dayArray addObjectsFromArray:self.dummyDayArray];
    [self.dayArray removeObject:self.specificDay1Text.text];
    [self.dayArray removeObject:self.specificDay2Text.text];
    [self.dayArray removeObject:self.specificDay3Text.text];
    
    self.fifthView.hidden=true;
    self.sixthView.hidden=true;
    self.seventhView.hidden=true;
   
    int count=self.specificConditionArray.count-3;
    for (int p1=0; p1<count; p1++) {
        [self resetSpecific:3];
    }
}
-(void)resetDay5
{
    self.specificDay5Text.text=@"";
    
    self.specificCondition5Text.text=@"";
    self.specificCondition5Text.backgroundColor=[UIColor lightGrayColor];
    self.specificCondition5Text.userInteractionEnabled=NO;
    
    self.specificFromTime5Text.text=@"";
    self.specificFromTime5Text.backgroundColor=[UIColor lightGrayColor];
    self.specificFromTime5Text.userInteractionEnabled=NO;
    
    self.specificToTime5Text.text=@"";
    self.specificToTime5Text.backgroundColor=[UIColor lightGrayColor];
    self.specificToTime5Text.userInteractionEnabled=NO;
    
    self.specificPayOT5Text.text=@"";
    self.specificPayOT5Text.backgroundColor=[UIColor lightGrayColor];
    self.specificPayOT5Text.userInteractionEnabled=NO;
    
    
    [self.dayArray removeAllObjects];
    [self.dayArray addObjectsFromArray:self.dummyDayArray];
    [self.dayArray removeObject:self.specificDay1Text.text];
    [self.dayArray removeObject:self.specificDay2Text.text];
    [self.dayArray removeObject:self.specificDay3Text.text];
    [self.dayArray removeObject:self.specificDay4Text.text];
    
    self.sixthView.hidden=true;
    self.seventhView.hidden=true;
    
    int count=self.specificConditionArray.count-4;
    for (int p1=0; p1<count; p1++) {
        [self resetSpecific:4];
    }
}
-(void)resetDay6
{
    self.specificDay6Text.text=@"";
    
    self.specificCondition6Text.text=@"";
    self.specificCondition6Text.backgroundColor=[UIColor lightGrayColor];
    self.specificCondition6Text.userInteractionEnabled=NO;
    
    self.specificFromTime6Text.text=@"";
    self.specificFromTime6Text.backgroundColor=[UIColor lightGrayColor];
    self.specificFromTime6Text.userInteractionEnabled=NO;
    
    self.specificToTime6Text.text=@"";
    self.specificToTime6Text.backgroundColor=[UIColor lightGrayColor];
    self.specificToTime6Text.userInteractionEnabled=NO;
    
    self.specificPayOT6Text.text=@"";
    self.specificPayOT6Text.backgroundColor=[UIColor lightGrayColor];
    self.specificPayOT6Text.userInteractionEnabled=NO;
    
    [self.dayArray removeAllObjects];
    [self.dayArray addObjectsFromArray:self.dummyDayArray];
    [self.dayArray removeObject:self.specificDay1Text.text];
    [self.dayArray removeObject:self.specificDay2Text.text];
    [self.dayArray removeObject:self.specificDay3Text.text];
    [self.dayArray removeObject:self.specificDay4Text.text];
    [self.dayArray removeObject:self.specificDay5Text.text];
    
    self.seventhView.hidden=true;
    
    int count=self.specificConditionArray.count-5;
    for (int p1=0; p1<count; p1++) {
        [self resetSpecific:5];
    }
}
-(void)resetDay7
{
    self.specificDay7Text.text=@"";
    
    self.specificCondition7Text.text=@"";
    self.specificCondition7Text.backgroundColor=[UIColor lightGrayColor];
    self.specificCondition7Text.userInteractionEnabled=NO;
    
    self.specificFromTime7Text.text=@"";
    self.specificFromTime7Text.backgroundColor=[UIColor lightGrayColor];
    self.specificFromTime7Text.userInteractionEnabled=NO;
    
    self.specificToTime7Text.text=@"";
    self.specificToTime7Text.backgroundColor=[UIColor lightGrayColor];
    self.specificToTime7Text.userInteractionEnabled=NO;
    
    self.specificPayOT7Text.text=@"";
    self.specificPayOT7Text.backgroundColor=[UIColor lightGrayColor];
    self.specificPayOT7Text.userInteractionEnabled=NO;
    
    [self.dayArray removeAllObjects];
    [self.dayArray addObjectsFromArray:self.dummyDayArray];
    [self.dayArray removeObject:self.specificDay1Text.text];
    [self.dayArray removeObject:self.specificDay2Text.text];
    [self.dayArray removeObject:self.specificDay3Text.text];
    [self.dayArray removeObject:self.specificDay4Text.text];
    [self.dayArray removeObject:self.specificDay5Text.text];
    [self.dayArray removeObject:self.specificDay6Text.text];
    
    int count=self.specificConditionArray.count-6;
    for (int p1=0; p1<count; p1++) {
        [self resetSpecific:6];
    }
}
-(void)resetSpecific:(int)value
{
    [self.specificConditionArray replaceObjectAtIndex:value withObject:@""];
    [self.specificPayOTRateArray replaceObjectAtIndex:value withObject:@""];
}
-(void)datePickedIntialValueChanged
{
    NSDate *date4 = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date4];
    [components setHour: 0];
    [components setMinute: 5];
    NSDate *startDate = [gregorian dateFromComponents: components];
        
    [components setHour: 23];
    [components setMinute: 55];
    NSDate *endDate = [gregorian dateFromComponents: components];
        
    [self.datePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
    [self.datePicker setMinimumDate:startDate];
    [self.datePicker setMaximumDate:endDate];
    [self.datePicker setDate:startDate animated:YES];
    [self.datePicker reloadInputViews];
    
}
-(void)datePickedValueChanged:(id)sender
{
    if (self.flag==3)
    {
        
        float totalSeconds=[timeObj timerGotValueChanged:self.regularDailyLimitText.text];
        if (self.datePicker.countDownDuration > totalSeconds) { //5400 seconds = 1h30min
            [self.datePicker setCountDownDuration: totalSeconds]; //Defaults to 1 minute
            
        }

    }
    else if (self.flag==4)
    {
        NSString *str=self.regularAfterText1.text;
        NSString *str1=self.regularDailyLimitText.text;
        
        float totalSeconds= [timeObj timerGetRemainingValue:str :str1];
        if (self.datePicker.countDownDuration > totalSeconds) { //5400 seconds = 1h30min
            [self.datePicker setCountDownDuration: totalSeconds]; //Defaults to 1 minute
            
        }


    }
    else if ((self.flag==5) || (self.flag==7))
    {
        NSString *str=self.offdayDailyLimitText.text;

        float totalSeconds=[timeObj timerGotValueChanged:str];
        if (self.datePicker.countDownDuration > totalSeconds) { //5400 seconds = 1h30min
            [self.datePicker setCountDownDuration: totalSeconds]; //Defaults to 1 minute
            
        }

    }
    else if (self.flag==8)
    {
        NSString *str=self.offdayAfterText1.text;
        NSString *str1=self.offdayDailyLimitText.text;
        float totalSeconds=[timeObj timerGetRemainingValue:str :str1];
        if (self.datePicker.countDownDuration > totalSeconds) { //5400 seconds = 1h30min
            [self.datePicker setCountDownDuration: totalSeconds]; //Defaults to 1 minute
            
        }

    }
    else if ((self.flag==10) || (self.flag==11))
    {
        NSString *str=self.partialDailyLimitText.text;
        float totalSeconds=[timeObj timerGotValueChanged:str];
        if (self.datePicker.countDownDuration > totalSeconds) { //5400 seconds = 1h30min
            [self.datePicker setCountDownDuration: totalSeconds]; //Defaults to 1 minute
            
        }

    }
    else if (self.flag==12)
    {
        NSString *str=self.partialAfterText1.text;
        NSString *str1=self.partialDailyLimitText.text;
        float totalSeconds=[timeObj timerGetRemainingValue:str :str1];
        if (self.datePicker.countDownDuration > totalSeconds) { //5400 seconds = 1h30min
            [self.datePicker setCountDownDuration: totalSeconds]; //Defaults to 1 minute
            
        }

    }
    else if ((self.flag==14) || (self.flag==15))
    {
        NSString *str=self.holidayDailyLimitText.text;

        float totalSeconds=[timeObj timerGotValueChanged:str];
        if (self.datePicker.countDownDuration > totalSeconds) { //5400 seconds = 1h30min
            [self.datePicker setCountDownDuration: totalSeconds]; //Defaults to 1 minute
            
        }

    }
    else if (self.flag==16)
    {
        NSString *str=self.holidayAfterText1.text;
        NSString *str1=self.holidayDailyLimitText.text;
        float totalSeconds=[timeObj timerGetRemainingValue:str :str1];
        if (self.datePicker.countDownDuration > totalSeconds) { //5400 seconds = 1h30min
            [self.datePicker setCountDownDuration: totalSeconds]; //Defaults to 1 minute
            
        }

    }
}
-(void)regulardayAction
{
    self.currentTab=@"Regular";
    self.regularButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.offdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.partialdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.holidayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.specificDayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    [self.regularButton setImage:[UIImage imageNamed:@"tab_1_active.png"] forState:UIControlStateNormal];
    [self.offdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.partialdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.holidayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.specificDayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)offdayAction
{
    self.currentTab=@"Offday";
    self.offdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.regularButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.partialdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.holidayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.specificDayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    [self.offdayButton setImage:[UIImage imageNamed:@"tab_1_active.png"] forState:UIControlStateNormal];
    [self.regularButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.partialdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.holidayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.specificDayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.contentScrollView setContentOffset:CGPointMake(593, 0) animated:YES];
}
-(void)partialdayAction
{
    self.currentTab=@"Partialday";
    self.partialdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.regularButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.offdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.holidayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.specificDayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    [self.partialdayButton setImage:[UIImage imageNamed:@"tab_1_active.png"] forState:UIControlStateNormal];
    [self.regularButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.offdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.holidayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.specificDayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.contentScrollView setContentOffset:CGPointMake(1186, 0) animated:YES];

}
-(void)holidayAction
{
    self.currentTab=@"Holiday";
    self.holidayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.regularButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.offdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.partialdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.specificDayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    [self.holidayButton setImage:[UIImage imageNamed:@"tab_1_active.png"] forState:UIControlStateNormal];
    [self.regularButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.offdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.partialdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.specificDayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.contentScrollView setContentOffset:CGPointMake(1779, 0) animated:YES];
}
-(void)specificdayAction
{
    self.currentTab=@"Specificday";
    self.specificDayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.regularButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.offdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.partialdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    self.holidayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    [self.specificDayButton setImage:[UIImage imageNamed:@"tab_1_active.png"] forState:UIControlStateNormal];
    [self.regularButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.offdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.partialdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.holidayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
    [self.contentScrollView setContentOffset:CGPointMake(2372, 0) animated:YES];
    
//    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"overtimeAction"]isEqualToString:@"create"]) {
//        <#statements#>
//    }
    
}
-(void)alertAction
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:@"Please input all mandatory fields"
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

-(void)offdayRegularView
{
    [self.regularCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    self.offdayDailyLimitText.text=self.regularDailyLimitText.text;
    self.offdayAfterText1.text=self.regularAfterText1.text;
    self.offdayAfterText2.text=self.regularAfterText2.text;
    self.offdayPayOTText1.text=self.regularPayOTText1.text;
    self.offdayPayOTText2.text=self.regularPayOTText2.text;
    self.offdayPayOTText3.text=self.regularPayOTText3.text;
    self.dropLabel1.text=@"After Standard Working Hours";
    self.offDayFirstView.hidden=true;
    self.offDayDropView.hidden=false;
    self.offDaywholeView.hidden=false;
    self.off_date1=self.reg_date1;
    self.off_date2=self.reg_date2;
    self.off_date3=self.reg_date3;
    self.off_ot1=self.reg_ot1;
    self.off_ot2=self.reg_ot2;
    self.off_ot3=self.reg_ot3;
    self.off_firstDate=@"";
    
    self.offdayDailyLimitText.backgroundColor=[UIColor lightGrayColor];
    self.offdayDailyLimitText.userInteractionEnabled=NO;
    
    self.offDayFirstText.backgroundColor=[UIColor lightGrayColor];
    self.offDayFirstText.userInteractionEnabled=NO;
    self.offdayPayOTText1.userInteractionEnabled=false;
    self.offdayPayOTText1.backgroundColor=[UIColor lightGrayColor];
    self.offdayAfterText1.userInteractionEnabled=false;
    self.offdayAfterText1.backgroundColor=[UIColor lightGrayColor];
    self.offdayPayOTText2.userInteractionEnabled=false;
    self.offdayPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.offdayAfterText2.userInteractionEnabled=false;
    self.offdayAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.offdayPayOTText3.userInteractionEnabled=false;
    self.offdayPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.dropButton1.userInteractionEnabled=NO;
}
-(void)partialdayRegularView
{
    [self.regularCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    
    self.partialDailyLimitText.text=self.regularDailyLimitText.text;
    self.partialAfterText1.text=self.regularAfterText1.text;
    self.partialAfterText2.text=self.regularAfterText2.text;
    self.partialPayOTText1.text=self.regularPayOTText1.text;
    self.partialPayOTText2.text = self.regularPayOTText2.text;
    self.partialPayOTText3.text=self.regularPayOTText3.text;
    self.dropLabel2.text=@"After Standard Working Hours";
    self.partialFirstView.hidden=true;
    self.partialDropView.hidden=false;
    self.partialWholeView.hidden=false;
    
    self.par_date1=self.reg_date1;
    self.par_date2=self.reg_date2;
    self.par_date3=self.reg_date3;
    self.par_ot1=self.reg_ot1;
    self.par_ot2=self.reg_ot2;
    self.par_ot3=self.reg_ot3;
    self.par_firstDate=@"";
    
    
    self.partialDailyLimitText.backgroundColor=[UIColor lightGrayColor];
    self.partialDailyLimitText.userInteractionEnabled=NO;
    
    self.partialFirstText.backgroundColor=[UIColor lightGrayColor];
    self.partialFirstText.userInteractionEnabled=NO;
    self.partialPayOTText1.userInteractionEnabled=false;
    self.partialPayOTText1.backgroundColor=[UIColor lightGrayColor];
    self.partialAfterText1.userInteractionEnabled=false;
    self.partialAfterText1.backgroundColor=[UIColor lightGrayColor];
    self.partialPayOTText2.userInteractionEnabled=false;
    self.partialPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.partialAfterText2.userInteractionEnabled=false;
    self.partialAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.partialPayOTText3.userInteractionEnabled=false;
    self.partialPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.dropButton2.userInteractionEnabled=NO;

   

}

-(void)holidayRegularView
{
    [self.regularCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    
    self.holidayDailyLimitText.text=self.regularDailyLimitText.text;
    self.holidayAfterText1.text=self.regularAfterText1.text;
    self.holidayAfterText2.text=self.regularAfterText2.text;
    self.holidayPayOTText1.text=self.regularPayOTText1.text;
    self.holidayPayOTText2.text = self.regularPayOTText2.text;
    self.holidayPayOTText3.text=self.regularPayOTText3.text;
    self.dropLabel3.text=@"After Standard Working Hours";
    self.holidayFirstView.hidden=true;
    self.holidayDropView.hidden=false;
    self.holidayWholeView.hidden=false;
    
    
    self.hol_date1=self.reg_date1;
    self.hol_date2=self.reg_date2;
    self.hol_date3=self.reg_date3;
    self.hol_ot1=self.reg_ot1;
    self.hol_ot2=self.reg_ot2;
    self.hol_ot3=self.reg_ot3;
    self.hol_firstDate=@"";
    
    self.holidayDailyLimitText.backgroundColor=[UIColor lightGrayColor];
    self.holidayDailyLimitText.userInteractionEnabled=NO;
    
    self.holidayFirstText.backgroundColor=[UIColor lightGrayColor];
    self.holidayFirstText.userInteractionEnabled=NO;
    self.holidayPayOTText1.userInteractionEnabled=false;
    self.holidayPayOTText1.backgroundColor=[UIColor lightGrayColor];
    self.holidayAfterText1.userInteractionEnabled=false;
    self.holidayAfterText1.backgroundColor=[UIColor lightGrayColor];
    self.holidayPayOTText2.userInteractionEnabled=false;
    self.holidayPayOTText2.backgroundColor=[UIColor lightGrayColor];
    self.holidayAfterText2.userInteractionEnabled=false;
    self.holidayAfterText2.backgroundColor=[UIColor lightGrayColor];
    self.holidayPayOTText3.userInteractionEnabled=false;
    self.holidayPayOTText3.backgroundColor=[UIColor lightGrayColor];
    self.dropButton3.userInteractionEnabled=NO;
}
-(IBAction)weeklyCheckAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        if (p%2==0) {
            [self.weeklyCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_pf=@"1";
            p++;
        }
        else
        {
            [self.weeklyCheckButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_pf=@"0";
            p++;
        }
    }
    if (button.tag==2) {
        if (q%2==0) {
            [self.weeklyCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_esi=@"1";
            q++;
        }
        else
        {
            [self.weeklyCheckButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_esi=@"0";
            q++;
        }
    }

    if (button.tag==3) {
        if (r%2==0) {
            [self.weeklyCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_incentives=@"1";
            r++;
        }
        else
        {
            [self.weeklyCheckButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_incentives=@"0";
            r++;
        }
    }

}

-(IBAction)weeklyCheckAction1:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        if (i%2==0) {
            [self.weeklyCheckButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.paidLeavesValue=@"1";
            i++;
        }
        else
        {
            [self.weeklyCheckButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.paidLeavesValue=@"0";
            i++;
        }
    }
    if (button.tag==2) {
        if (j%2==0) {
            [self.weeklyCheckButton5 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.paidHolidaysvalue=@"1";
            j++;
        }
        else
        {
            [self.weeklyCheckButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.paidHolidaysvalue=@"0";
            j++;
        }
    }
    
    if (button.tag==3) {
        if (k%2==0) {
            [self.weeklyCheckButton6 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.apply7thValue=@"1";
            k++;
        }
        else
        {
            [self.weeklyCheckButton6 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.apply7thValue=@"0";
            k++;
        }
    }
    
}

-(IBAction)checkButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        if (a%2==0) {
            [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_pf=@"1";
            a++;
        }
        else
        {
            [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_pf=@"0";
            a++;
        }
    }
    if (button.tag==2) {
        if (b%2==0) {
            [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_esi=@"1";
            b++;
        }
        else
        {
            [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_esi=@"0";
            b++;
        }
    }
    
    if (button.tag==3) {
        if (c%2==0) {
            [self.checkButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.reg_incentives=@"1";
            c++;
        }
        else
        {
            [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.reg_incentives=@"0";
            c++;
        }
    }
    
}

-(IBAction)timeAction:(id)sender
{
    NSDate *myDate = self.datePicker1.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm a"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    if (timeFlag==1) {
        self.specificFromTime1Text.text=prettyVersion;
        self.specificFromTime1Text.text=prettyVersion;
        self.specificToTime1Text.backgroundColor=[UIColor clearColor];
        self.specificToTime1Text.userInteractionEnabled=YES;
    }
    if (timeFlag==2) {
        self.specificToTime1Text.text=prettyVersion;
        self.specificPayOT1Text.backgroundColor=[UIColor clearColor];
        self.specificPayOT1Text.userInteractionEnabled=YES;
    }
    if (timeFlag==3) {
        self.specificFromTime2Text.text=prettyVersion;
        self.specificToTime2Text.backgroundColor=[UIColor clearColor];
        self.specificToTime2Text.userInteractionEnabled=YES;
    }
    if (timeFlag==4) {
        self.specificToTime2Text.text=prettyVersion;
        self.specificPayOT2Text.backgroundColor=[UIColor clearColor];
        self.specificPayOT2Text.userInteractionEnabled=YES;
    }
    if (timeFlag==5) {
        self.specificFromTime3Text.text=prettyVersion;
        self.specificToTime3Text.backgroundColor=[UIColor clearColor];
        self.specificToTime3Text.userInteractionEnabled=YES;
    }
    if (timeFlag==6) {
        self.specificToTime3Text.text=prettyVersion;
        self.specificPayOT3Text.backgroundColor=[UIColor clearColor];
        self.specificPayOT3Text.userInteractionEnabled=YES;
    }
    if (timeFlag==7) {
        self.specificFromTime4Text.text=prettyVersion;
        self.specificToTime4Text.backgroundColor=[UIColor clearColor];
        self.specificToTime4Text.userInteractionEnabled=YES;
    }
    if (timeFlag==8) {
        self.specificToTime4Text.text=prettyVersion;
        self.specificPayOT4Text.backgroundColor=[UIColor clearColor];
        self.specificPayOT4Text.userInteractionEnabled=YES;
    }
    if (timeFlag==9) {
        self.specificFromTime5Text.text=prettyVersion;
        self.specificToTime5Text.backgroundColor=[UIColor clearColor];
        self.specificToTime5Text.userInteractionEnabled=YES;
    }
    if (timeFlag==10) {
        self.specificToTime5Text.text=prettyVersion;
        self.specificPayOT5Text.backgroundColor=[UIColor clearColor];
        self.specificPayOT5Text.userInteractionEnabled=YES;
    }
    if (timeFlag==11) {
        self.specificFromTime6Text.text=prettyVersion;
        self.specificToTime6Text.backgroundColor=[UIColor clearColor];
        self.specificToTime6Text.userInteractionEnabled=YES;
    }
    if (timeFlag==12) {
        self.specificToTime6Text.text=prettyVersion;
        self.specificPayOT6Text.backgroundColor=[UIColor clearColor];
        self.specificPayOT6Text.userInteractionEnabled=YES;
    }
    
    if (timeFlag==13) {
        self.specificFromTime7Text.text=prettyVersion;
        self.specificToTime7Text.backgroundColor=[UIColor clearColor];
        self.specificToTime7Text.userInteractionEnabled=YES;
    }
    if (timeFlag==14) {
        self.specificToTime7Text.text=prettyVersion;
        self.specificPayOT7Text.backgroundColor=[UIColor clearColor];
        self.specificPayOT7Text.userInteractionEnabled=YES;
    }

    self.datePicker1View.hidden=true;
    
}
-(void)timeInitialSettings
{

    
    NSMutableArray *timesArray=[[NSMutableArray alloc]init];
    timesArray=[timeObj timeInitialSettings];
    NSDate *startDate=[timesArray objectAtIndex:0];
    NSDate *endDate=[timesArray objectAtIndex:1];
    
    [self.datePicker1 setDatePickerMode:UIDatePickerModeTime];
    [self.datePicker1 setMinimumDate:startDate];
    [self.datePicker1 setMaximumDate:endDate];
    [self.datePicker1 setDate:startDate animated:YES];
    [self.datePicker1 reloadInputViews];
}
-(void)timeMaxSettings:(NSString *)currentTime
{
    NSString *time=[timeObj timeMinimumValueSetting:currentTime];
    NSArray *timeArray=[time componentsSeparatedByString:@"###"];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker1.date];
    [components setHour:[[timeArray objectAtIndex:0] integerValue]];
    [components setMinute:[[timeArray objectAtIndex:1]integerValue]];
    NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
    self.datePicker1.minimumDate = date;
}

-(void)specificDayList:(int)count
{
    for (int spec=0; spec<count; spec++) {
        if (spec==0) {
            self.firstView.hidden=false;
            NSMutableDictionary*mydict=[self.specificDict objectForKey:@"0"];
            self.specificDay1Text.text=[mydict objectForKey:@"days"];
            
            [self.dayArray removeAllObjects];
            [self.dayArray addObjectsFromArray:self.dummyDayArray];
            [self.dayArray removeObject:self.specificDay1Text.text];
            
            //self.dayArray;
            [self changeTextFieldAction:self.specificDay1Text];
            if ([[mydict objectForKey:@"conditions"]isEqualToString:@"spec_hrs_bw"]) {
                [self.specificConditionArray replaceObjectAtIndex:0 withObject:@"spec_hrs_bw"];
                self.specificCondition1Text.text=@"If OT working hours b/w";
                [self changeTextFieldAction:self.specificCondition1Text];
                self.specificFromTime1Text.text=[mydict objectForKey:@"start"];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH.mm";
                NSDate *date = [dateFormatter dateFromString:self.specificFromTime1Text.text];
                
                dateFormatter.dateFormat = @"hh:mm a";
                self.specificFromTime1Text.text = [dateFormatter stringFromDate:date];
                
                
                [self changeTextFieldAction:self.specificFromTime1Text];
                
                
                self.specificToTime1Text.text=[mydict objectForKey:@"end"];
                
                NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                dateFormatter1.dateFormat = @"HH.mm";
                NSDate *date1 = [dateFormatter1 dateFromString:self.specificToTime1Text.text];
                
                dateFormatter1.dateFormat = @"hh:mm a";
                self.specificToTime1Text.text = [dateFormatter1 stringFromDate:date1];
                
                [self changeTextFieldAction:self.specificToTime1Text];
                
            }
            else
            {
                self.specificCondition1Text.text=@"Whole Day apply rate OT 1";
                [self.specificConditionArray replaceObjectAtIndex:0 withObject:@"spec_whole_day"];
                [self changeTextFieldAction:self.specificCondition1Text];
            }
            self.specificPayOT1Text.text=[mydict objectForKey:@"rate"];
            [self.specificPayOTRateArray replaceObjectAtIndex:0 withObject:[mydict objectForKey:@"rate"]];
            [self changeTextFieldAction:self.specificPayOT1Text];
        }
        else if (spec==1)
        {
            self.secondView.hidden=false;
            NSMutableDictionary*mydict=[self.specificDict objectForKey:@"1"];
            self.specificDay2Text.text=[mydict objectForKey:@"days"];
            
            [self.dayArray removeAllObjects];
            [self.dayArray addObjectsFromArray:self.dummyDayArray];
            [self.dayArray removeObject:self.specificDay1Text.text];
            [self.dayArray removeObject:self.specificDay2Text.text];
            
            
            [self changeTextFieldAction:self.specificDay2Text];
            if ([[mydict objectForKey:@"conditions"]isEqualToString:@"spec_hrs_bw"]) {
                self.specificCondition2Text.text=@"If OT working hours b/w";
                [self changeTextFieldAction:self.specificCondition2Text];
                self.specificFromTime2Text.text=[mydict objectForKey:@"start"];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH.mm";
                NSDate *date = [dateFormatter dateFromString:self.specificFromTime2Text.text];
                
                dateFormatter.dateFormat = @"hh:mm a";
                self.specificFromTime2Text.text = [dateFormatter stringFromDate:date];
                
                [self changeTextFieldAction:self.specificFromTime2Text];
                self.specificToTime2Text.text=[mydict objectForKey:@"end"];
                
                NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                dateFormatter1.dateFormat = @"HH.mm";
                NSDate *date1 = [dateFormatter1 dateFromString:self.specificToTime2Text.text];
                
                dateFormatter1.dateFormat = @"hh:mm a";
                self.specificToTime2Text.text = [dateFormatter1 stringFromDate:date1];
                
                
                [self changeTextFieldAction:self.specificToTime2Text];
                [self.specificConditionArray replaceObjectAtIndex:1 withObject:@"spec_hrs_bw"];
            }
            else
            {
                self.specificCondition2Text.text=@"Whole Day apply rate OT 1";
                [self changeTextFieldAction:self.specificCondition2Text];
                [self.specificConditionArray replaceObjectAtIndex:1 withObject:@"spec_whole_day"];
            }
            self.specificPayOT2Text.text=[mydict objectForKey:@"rate"];
            [self.specificPayOTRateArray replaceObjectAtIndex:1 withObject:[mydict objectForKey:@"rate"]];
            [self changeTextFieldAction:self.specificPayOT2Text];
        }
        else if (spec==2)
        {
            self.thirdView.hidden=false;
            NSMutableDictionary*mydict=[self.specificDict objectForKey:@"2"];
            self.specificDay3Text.text=[mydict objectForKey:@"days"];
            
            [self.dayArray removeAllObjects];
            [self.dayArray addObjectsFromArray:self.dummyDayArray];
            [self.dayArray removeObject:self.specificDay1Text.text];
            [self.dayArray removeObject:self.specificDay2Text.text];
            [self.dayArray removeObject:self.specificDay3Text.text];
            
            [self changeTextFieldAction:self.specificDay3Text];
            if ([[mydict objectForKey:@"conditions"]isEqualToString:@"spec_hrs_bw"]) {
                self.specificCondition3Text.text=@"If OT working hours b/w";
                [self changeTextFieldAction:self.specificCondition3Text];
                self.specificFromTime3Text.text=[mydict objectForKey:@"start"];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH.mm";
                NSDate *date = [dateFormatter dateFromString:self.specificFromTime3Text.text];
                
                dateFormatter.dateFormat = @"hh:mm a";
                self.specificFromTime3Text.text = [dateFormatter stringFromDate:date];
                
                [self changeTextFieldAction:self.specificFromTime3Text];
                self.specificToTime3Text.text=[mydict objectForKey:@"end"];
                
                NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                dateFormatter1.dateFormat = @"HH.mm";
                NSDate *date1 = [dateFormatter1 dateFromString:self.specificToTime3Text.text];
                
                dateFormatter1.dateFormat = @"hh:mm a";
                self.specificToTime3Text.text = [dateFormatter1 stringFromDate:date1];
                
                [self changeTextFieldAction:self.specificToTime3Text];
                [self.specificConditionArray replaceObjectAtIndex:2 withObject:@"spec_hrs_bw"];
            }
            else
            {
                self.specificCondition3Text.text=@"Whole Day apply rate OT 1";
                [self changeTextFieldAction:self.specificCondition3Text];
                [self.specificConditionArray replaceObjectAtIndex:2 withObject:@"spec_whole_day"];
            }
            self.specificPayOT3Text.text=[mydict objectForKey:@"rate"];
            [self.specificPayOTRateArray replaceObjectAtIndex:2 withObject:[mydict objectForKey:@"rate"]];
            [self changeTextFieldAction:self.specificPayOT3Text];
        }
        else if (spec==3)
        {
            self.fourthView.hidden=false;
            NSMutableDictionary*mydict=[self.specificDict objectForKey:@"3"];
            self.specificDay4Text.text=[mydict objectForKey:@"days"];
            
            [self.dayArray removeAllObjects];
            [self.dayArray addObjectsFromArray:self.dummyDayArray];
            [self.dayArray removeObject:self.specificDay1Text.text];
            [self.dayArray removeObject:self.specificDay2Text.text];
            [self.dayArray removeObject:self.specificDay3Text.text];
            [self.dayArray removeObject:self.specificDay4Text.text];
            
            
            [self changeTextFieldAction:self.specificDay4Text];
            if ([[mydict objectForKey:@"conditions"]isEqualToString:@"spec_hrs_bw"]) {
                self.specificCondition4Text.text=@"If OT working hours b/w";
                [self changeTextFieldAction:self.specificCondition4Text];
                self.specificFromTime4Text.text=[mydict objectForKey:@"start"];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH.mm";
                NSDate *date = [dateFormatter dateFromString:self.specificFromTime4Text.text];
                
                dateFormatter.dateFormat = @"hh:mm a";
                self.specificFromTime4Text.text = [dateFormatter stringFromDate:date];
                
                [self changeTextFieldAction:self.specificFromTime4Text];
                self.specificToTime4Text.text=[mydict objectForKey:@"end"];
                
                NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                dateFormatter1.dateFormat = @"HH.mm";
                NSDate *date1 = [dateFormatter1 dateFromString:self.specificToTime4Text.text];
                
                dateFormatter1.dateFormat = @"hh:mm a";
                self.specificToTime4Text.text = [dateFormatter1 stringFromDate:date1];
                
                [self changeTextFieldAction:self.specificToTime4Text];
                [self.specificConditionArray replaceObjectAtIndex:3 withObject:@"spec_hrs_bw"];
            }
            else
            {
                self.specificCondition4Text.text=@"Whole Day apply rate OT 1";
                [self changeTextFieldAction:self.specificCondition4Text];
                [self.specificConditionArray replaceObjectAtIndex:3 withObject:@"spec_whole_day"];
            }
            self.specificPayOT4Text.text=[mydict objectForKey:@"rate"];
            [self.specificPayOTRateArray replaceObjectAtIndex:3 withObject:[mydict objectForKey:@"rate"]];
            [self changeTextFieldAction:self.specificPayOT4Text];
        }
        else if (spec==4)
        {
            self.fifthView.hidden=false;
            NSMutableDictionary*mydict=[self.specificDict objectForKey:@"4"];
            self.specificDay5Text.text=[mydict objectForKey:@"days"];
            
            [self.dayArray removeAllObjects];
            [self.dayArray addObjectsFromArray:self.dummyDayArray];
            [self.dayArray removeObject:self.specificDay1Text.text];
            [self.dayArray removeObject:self.specificDay2Text.text];
            [self.dayArray removeObject:self.specificDay3Text.text];
            [self.dayArray removeObject:self.specificDay4Text.text];
            [self.dayArray removeObject:self.specificDay5Text.text];
            
            
            [self changeTextFieldAction:self.specificDay5Text];
            if ([[mydict objectForKey:@"conditions"]isEqualToString:@"spec_hrs_bw"]) {
                self.specificCondition5Text.text=@"If OT working hours b/w";
                [self changeTextFieldAction:self.specificCondition5Text];
                self.specificFromTime5Text.text=[mydict objectForKey:@"start"];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH.mm";
                NSDate *date = [dateFormatter dateFromString:self.specificFromTime5Text.text];
                
                dateFormatter.dateFormat = @"hh:mm a";
                self.specificFromTime5Text.text = [dateFormatter stringFromDate:date];
                
                [self changeTextFieldAction:self.specificFromTime5Text];
                self.specificToTime5Text.text=[mydict objectForKey:@"end"];
                
                NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                dateFormatter1.dateFormat = @"HH.mm";
                NSDate *date1 = [dateFormatter1 dateFromString:self.specificToTime5Text.text];
                
                dateFormatter1.dateFormat = @"hh:mm a";
                self.specificToTime5Text.text = [dateFormatter1 stringFromDate:date1];
                
                [self changeTextFieldAction:self.specificToTime5Text];
                [self.specificConditionArray replaceObjectAtIndex:4 withObject:@"spec_hrs_bw"];
            }
            else
            {
                self.specificCondition5Text.text=@"Whole Day apply rate OT 1";
                [self changeTextFieldAction:self.specificCondition5Text];
                [self.specificConditionArray replaceObjectAtIndex:4 withObject:@"spec_whole_day"];
            }
            self.specificPayOT5Text.text=[mydict objectForKey:@"rate"];
            [self.specificPayOTRateArray replaceObjectAtIndex:4 withObject:[mydict objectForKey:@"rate"]];
            [self changeTextFieldAction:self.specificPayOT5Text];
        }
        else if (spec==5)
        {
            self.sixthView.hidden=false;
            NSMutableDictionary*mydict=[self.specificDict objectForKey:@"5"];
            self.specificDay6Text.text=[mydict objectForKey:@"days"];
            
            [self.dayArray removeAllObjects];
            [self.dayArray addObjectsFromArray:self.dummyDayArray];
            [self.dayArray removeObject:self.specificDay1Text.text];
            [self.dayArray removeObject:self.specificDay2Text.text];
            [self.dayArray removeObject:self.specificDay3Text.text];
            [self.dayArray removeObject:self.specificDay4Text.text];
            [self.dayArray removeObject:self.specificDay5Text.text];
            [self.dayArray removeObject:self.specificDay6Text.text];
            
            [self changeTextFieldAction:self.specificDay6Text];
            if ([[mydict objectForKey:@"conditions"]isEqualToString:@"spec_hrs_bw"]) {
                self.specificCondition6Text.text=@"If OT working hours b/w";
                [self changeTextFieldAction:self.specificCondition6Text];
                self.specificFromTime6Text.text=[mydict objectForKey:@"start"];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH.mm";
                NSDate *date = [dateFormatter dateFromString:self.specificFromTime6Text.text];
                
                dateFormatter.dateFormat = @"hh:mm a";
                self.specificFromTime6Text.text = [dateFormatter stringFromDate:date];
                
                [self changeTextFieldAction:self.specificFromTime6Text];
                self.specificToTime6Text.text=[mydict objectForKey:@"end"];
                
                NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                dateFormatter1.dateFormat = @"HH.mm";
                NSDate *date1 = [dateFormatter1 dateFromString:self.specificToTime6Text.text];
                
                dateFormatter1.dateFormat = @"hh:mm a";
                self.specificToTime6Text.text = [dateFormatter1 stringFromDate:date1];
                
                [self changeTextFieldAction:self.specificToTime6Text];
                [self.specificConditionArray replaceObjectAtIndex:5 withObject:@"spec_hrs_bw"];
            }
            else
            {
                self.specificCondition6Text.text=@"Whole Day apply rate OT 1";
                [self changeTextFieldAction:self.specificCondition6Text];
                [self.specificConditionArray replaceObjectAtIndex:5 withObject:@"spec_whole_day"];
            }
            self.specificPayOT6Text.text=[mydict objectForKey:@"rate"];
            [self.specificPayOTRateArray replaceObjectAtIndex:5 withObject:[mydict objectForKey:@"rate"]];
            [self changeTextFieldAction:self.specificPayOT6Text];
        }
        else if (spec==6)
        {
            self.seventhView.hidden=false;
            NSMutableDictionary*mydict=[self.specificDict objectForKey:@"6"];
            self.specificDay7Text.text=[mydict objectForKey:@"days"];
            [self changeTextFieldAction:self.specificDay7Text];
            if ([[mydict objectForKey:@"conditions"]isEqualToString:@"spec_hrs_bw"]) {
                self.specificCondition7Text.text=@"If OT working hours b/w";
                [self changeTextFieldAction:self.specificCondition7Text];
                self.specificFromTime7Text.text=[mydict objectForKey:@"start"];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH.mm";
                NSDate *date = [dateFormatter dateFromString:self.specificFromTime7Text.text];
                
                dateFormatter.dateFormat = @"hh:mm a";
                self.specificFromTime7Text.text = [dateFormatter stringFromDate:date];
                
                [self changeTextFieldAction:self.specificFromTime7Text];
                self.specificToTime7Text.text=[mydict objectForKey:@"end"];
                
                NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                dateFormatter1.dateFormat = @"HH.mm";
                NSDate *date1 = [dateFormatter1 dateFromString:self.specificToTime7Text.text];
                
                dateFormatter1.dateFormat = @"hh:mm a";
                self.specificToTime7Text.text = [dateFormatter1 stringFromDate:date1];
                
                [self changeTextFieldAction:self.specificToTime7Text];
                [self.specificConditionArray replaceObjectAtIndex:6 withObject:@"spec_hrs_bw"];
            }
            else
            {
                self.specificCondition7Text.text=@"Whole Day apply rate OT 1";
                [self changeTextFieldAction:self.specificCondition7Text];
                [self.specificConditionArray replaceObjectAtIndex:6 withObject:@"spec_whole_day"];
            }
            self.specificPayOT7Text.text=[mydict objectForKey:@"rate"];
            [self.specificPayOTRateArray replaceObjectAtIndex:6 withObject:[mydict objectForKey:@"rate"]];
            [self changeTextFieldAction:self.specificPayOT7Text];
        }

    }
    if (count==0) {
        self.firstView.hidden=false;
    }
    else if (count==1) {
        self.secondView.hidden=false;
    }
    else if(count==2)
    {
        self.thirdView.hidden=false;
    }
    else if(count==3)
    {
        self.fourthView.hidden=false;
    }
    else if(count==4)
    {
        self.fifthView.hidden=false;
    }
    else if(count==5)
    {
        self.sixthView.hidden=false;
    }
    else if(count==6)
    {
        self.seventhView.hidden=false;
    }
}
-(void)changeTextFieldAction:(UITextField *)textfield
{
    textfield.userInteractionEnabled=YES;
    textfield.backgroundColor=[UIColor clearColor];
}

//<<<------------------------------Service Response------------------------------>>>
//Alert Response
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
//Response for listing all created overtime
-(void)initiallyruleviewresponse:(NSMutableArray *)viewrulearray
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
    if ([viewrulearray count]>0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            payrollSettingsViewsClass *ob = (payrollSettingsViewsClass *)self.superview.superview;
            
            [ob initiallyruleviewresponse:viewrulearray];
            
            [self removeFromSuperview];
        });
        
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
}

//Individual View Service Response
-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableArray *overtimeDetails=[responseData objectForKey:@"overtime_details"];
        NSMutableDictionary *overtimeDict=[overtimeDetails objectAtIndex:0];
        
        self.overtimeNameText.text=[overtimeDict objectForKey:@"name"];
        self.abbrvText.text=[overtimeDict objectForKey:@"abr"];
        self.overtimeTypeText.text=[overtimeDict objectForKey:@"type"];
        NSLog(@"%@",self.overtimeTypeText.text);
        if ([self.overtimeTypeText.text isEqualToString:@"Daily"]) {
            //Regular day
            if (!([[overtimeDict objectForKey:@"reg_daily_limit"]isEqualToString:@""])) {
                self.reg_date1=[overtimeDict objectForKey:@"reg_daily_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"reg_daily_limit"] componentsSeparatedByString:@":"];
                self.regularDailyLimitText.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.regularPayOTText1.backgroundColor=[UIColor clearColor];
                self.regularPayOTText1.userInteractionEnabled=YES;
                
            }
            if (!([[overtimeDict objectForKey:@"reg_overtime_1_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"reg_overtime_1_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.regularPayOTText1.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"reg_overtime_1_rate"] ];
                   
                }
                else
                {
                    self.regularPayOTText1.text=[overtimeDict objectForKey:@"reg_overtime_1_rate"];
                }
                
                self.reg_ot1=[overtimeDict objectForKey:@"reg_overtime_1_rate"];
                self.regularAfterText1.backgroundColor=[UIColor clearColor];
                self.regularAfterText1.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"reg_over_time_1_limit"]isEqualToString:@""])) {
                self.reg_date2=[overtimeDict objectForKey:@"reg_over_time_1_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"reg_over_time_1_limit"] componentsSeparatedByString:@":"];
                self.regularAfterText1.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.regularPayOTText2.backgroundColor=[UIColor clearColor];
                self.regularPayOTText2.userInteractionEnabled=YES;
                
            }
            if (!([[overtimeDict objectForKey:@"reg_overtime_2_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"reg_overtime_2_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.regularPayOTText2.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"reg_overtime_2_rate"] ];
                    
                }
                else
                {
                    self.regularPayOTText2.text=[overtimeDict objectForKey:@"reg_overtime_2_rate"];
                }
                
                self.reg_ot2=[overtimeDict objectForKey:@"reg_overtime_2_rate"];
                self.regularAfterText2.backgroundColor=[UIColor clearColor];
                self.regularAfterText2.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"reg_over_time_2_limit"]isEqualToString:@""])) {
                self.reg_date3=[overtimeDict objectForKey:@"reg_over_time_2_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"reg_over_time_2_limit"] componentsSeparatedByString:@":"];
                self.regularAfterText2.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.regularPayOTText3.backgroundColor=[UIColor clearColor];
                self.regularPayOTText3.userInteractionEnabled=YES;
                
            }
            if (!([[overtimeDict objectForKey:@"reg_overtime_3_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"reg_overtime_3_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.regularPayOTText3.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"reg_overtime_3_rate"] ];
                    
                }
                else
                {
                    self.regularPayOTText3.text=[overtimeDict objectForKey:@"reg_overtime_3_rate"];
                }
                
                self.reg_ot3=[overtimeDict objectForKey:@"reg_overtime_3_rate"];
            }
            
            if ([[overtimeDict objectForKey:@"pf"]isEqualToString:@"1"]) {
                [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.reg_pf=@"1";
                self.a=1;
            }
            else
            {
                [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.reg_pf=@"0";
                
            }
            if ([[overtimeDict objectForKey:@"esi"]isEqualToString:@"1"]) {
                [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.reg_esi=@"1";
                self.b=1;
            }
            else
            {
                [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.reg_esi=@"0";
                
            }
            if ([[overtimeDict objectForKey:@"incentive"]isEqualToString:@"1"]) {
                [self.checkButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.reg_incentives=@"1";
                self.c=1;
            }
            else
            {
                [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.reg_incentives=@"1";
                
            }
            
            //Off day
            
            if ([[overtimeDict objectForKey:@"off_same_regular"]isEqualToString:@"1"]) {
                self.off_same_regular=@"1";
                [self.regularCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [self.regularCheckButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.off_same_regular=@"0";
                self.x=1;
            }
            if (!([[overtimeDict objectForKey:@"off_daily_limit"]isEqualToString:@""])) {
                self.off_date1=[overtimeDict objectForKey:@"off_daily_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"off_daily_limit"] componentsSeparatedByString:@":"];
                self.offdayDailyLimitText.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.offdayPayOTText1.backgroundColor=[UIColor clearColor];
                self.offdayPayOTText1.userInteractionEnabled=YES;
                
            }
            if (!([[overtimeDict objectForKey:@"off_hour"]isEqualToString:@""])) {
                self.off_firstDate=[overtimeDict objectForKey:@"off_hour"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"off_hour"] componentsSeparatedByString:@":"];
                self.offDayFirstText.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.offdayPayOTText1.backgroundColor=[UIColor clearColor];
                self.offdayPayOTText1.userInteractionEnabled=YES;
                
            }
            if (!([[overtimeDict objectForKey:@"off_overtime_1_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"off_overtime_1_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.offdayPayOTText1.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"off_overtime_1_rate"] ];
                    
                }
                else
                {
                    self.offdayPayOTText1.text= [overtimeDict objectForKey:@"off_overtime_1_rate"];
                }
                
                self.off_ot1=[overtimeDict objectForKey:@"off_overtime_1_rate"];
                self.offdayAfterText1.backgroundColor=[UIColor clearColor];
                self.offdayAfterText1.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"off_over_time_1_limit"]isEqualToString:@""])) {
                self.off_date2=[overtimeDict objectForKey:@"off_over_time_1_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"off_over_time_1_limit"] componentsSeparatedByString:@":"];
                self.offdayAfterText1.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                                                                                          [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.offdayPayOTText2.backgroundColor=[UIColor clearColor];
                self.offdayPayOTText2.userInteractionEnabled=YES;
                
            }
            if (!([[overtimeDict objectForKey:@"off_overtime_2_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"off_overtime_2_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.offdayPayOTText2.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"off_overtime_2_rate"] ];
                    
                }
                else
                {
                    self.offdayPayOTText2.text=[overtimeDict objectForKey:@"off_overtime_2_rate"];
                }
                
                self.off_ot2=[overtimeDict objectForKey:@"off_overtime_2_rate"];
                self.offdayAfterText2.backgroundColor=[UIColor clearColor];
                self.offdayAfterText2.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"off_over_time_2_limit"]isEqualToString:@""])) {
                self.off_date3=[overtimeDict objectForKey:@"off_over_time_2_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"off_over_time_2_limit"] componentsSeparatedByString:@":"];
                self.offdayAfterText2.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                                                                                          [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.offdayPayOTText3.backgroundColor=[UIColor clearColor];
                self.offdayPayOTText3.userInteractionEnabled=YES;
                
            }
            if (!([[overtimeDict objectForKey:@"off_overtime_3_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"off_overtime_3_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.offdayPayOTText3.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"off_overtime_3_rate"] ];
                    
                }
                else
                {
                    self.offdayPayOTText3.text=[overtimeDict objectForKey:@"off_overtime_3_rate"];
                }
                
                self.off_ot3=[overtimeDict objectForKey:@"off_overtime_3_rate"];
            }
            if ([[overtimeDict objectForKey:@"off_overtime_type"] isEqualToString:@"1"]) {
                
                self.dropLabel1.text=@"After Standard Working Hours";
                self.offDayDropView.hidden=false;
                self.offDayFirstView.hidden=true;
                self.offDaywholeView.hidden=false;
                
            }
            else if ([[overtimeDict objectForKey:@"off_overtime_type"] isEqualToString:@"2"])
            {
                self.dropLabel1.text=@"Whole Day";
                self.offDayDropView.hidden=false;
                self.offDayFirstView.hidden=true;
                self.offDaywholeView.hidden=true;
                
            }
            else
            {
                self.dropLabel1.text=@"First Certain Duration";
                self.offDayDropView.hidden=true;
                self.offDayFirstView.hidden=false;
                self.offDaywholeView.hidden=false;
                self.offDayFirstView.frame=CGRectMake(600, 120, self.offDayFirstView.frame.size.width, self.offDayFirstView.frame.size.height);
            }
            
            //Partial day
            
            if ([[overtimeDict objectForKey:@"par_same_regular"]isEqualToString:@"1"]) {
                [self.regularCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.par_same_regular=@"1";
                
            }
            else
            {
                [self.regularCheckButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.y=1;
                self.par_same_regular=@"0";
            }
            
            if (!([[overtimeDict objectForKey:@"par_daily_limit"]isEqualToString:@""])) {
                self.par_date1=[overtimeDict objectForKey:@"par_daily_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"par_daily_limit"] componentsSeparatedByString:@":"];
                self.partialDailyLimitText.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                                                                                               [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.partialPayOTText1.backgroundColor=[UIColor clearColor];
                self.partialPayOTText1.userInteractionEnabled=YES;
                
            }
            if (!([[overtimeDict objectForKey:@"par_hour"]isEqualToString:@""])) {
                self.par_firstDate=[overtimeDict objectForKey:@"par_hour"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"par_hour"] componentsSeparatedByString:@":"];
                self.partialFirstText.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                                                                                          [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.partialPayOTText1.backgroundColor=[UIColor clearColor];
                self.partialPayOTText1.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"par_overtime_1_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"par_overtime_1_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.partialPayOTText1.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"par_overtime_1_rate"] ];
                    
                }
                else
                {
                    self.partialPayOTText1.text= [overtimeDict objectForKey:@"par_overtime_1_rate"];
                }
                
                self.par_ot1=[overtimeDict objectForKey:@"par_overtime_1_rate"];
                self.partialAfterText1.backgroundColor=[UIColor clearColor];
                self.partialAfterText1.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"par_over_time_1_limit"]isEqualToString:@""])) {
                self.par_date2=[overtimeDict objectForKey:@"par_over_time_1_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"par_over_time_1_limit"] componentsSeparatedByString:@":"];
                self.partialAfterText1.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                                                                                           [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.partialPayOTText2.backgroundColor=[UIColor clearColor];
                self.partialPayOTText2.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"par_overtime_2_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"par_overtime_2_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.partialPayOTText2.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"par_overtime_2_rate"] ];
                    
                }
                else
                {
                    self.partialPayOTText2.text=[overtimeDict objectForKey:@"par_overtime_2_rate"];
                }
                
                self.par_ot2=[overtimeDict objectForKey:@"par_overtime_2_rate"];
                self.partialAfterText2.backgroundColor=[UIColor clearColor];
                self.partialAfterText2.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"par_over_time_2_limit"]isEqualToString:@""])) {
                self.par_date3=[overtimeDict objectForKey:@"par_over_time_2_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"par_over_time_2_limit"] componentsSeparatedByString:@":"];
                self.partialAfterText2.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                                                                                           [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.partialPayOTText3.backgroundColor=[UIColor clearColor];
                self.partialPayOTText3.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"par_overtime_3_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"par_overtime_3_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.partialPayOTText3.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"par_overtime_3_rate"] ];
                    
                }
                else
                {
                    self.partialPayOTText3.text=[overtimeDict objectForKey:@"par_overtime_3_rate"];
                }
                
                self.par_ot3=[overtimeDict objectForKey:@"par_overtime_2_rate"];
            }
            self.dropLabel2.text=[overtimeDict objectForKey:@"par_overtime_type"];
            
            if ([[overtimeDict objectForKey:@"par_overtime_type"] isEqualToString:@"1"]) {
                self.dropLabel2.text=@"After Standard Working Hours";
                self.partialDropView.hidden=false;
                self.partialFirstView.hidden=true;
                self.partialWholeView.hidden=false;
                
            }
            else if ([[overtimeDict objectForKey:@"par_overtime_type"] isEqualToString:@"2"])
            {
                self.dropLabel2.text=@"Whole Day";
                self.partialDropView.hidden=false;
                self.partialFirstView.hidden=true;
                self.partialWholeView.hidden=true;
            }
            else
            {
                self.dropLabel2.text=@"First Certain Duration";
                self.partialDropView.hidden=true;
                self.partialFirstView.hidden=false;
                self.partialWholeView.hidden=false;
                self.partialFirstView.frame=CGRectMake(1193, 120, self.partialFirstView.frame.size.width, self.partialFirstView.frame.size.height);
            }
            
            //Holiday
            
            if ([[overtimeDict objectForKey:@"holi_same_regular"]isEqualToString:@"1"]) {
                [self.regularCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.hol_same_regular=@"1";
                
            }
            else
            {
                [self.regularCheckButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.z=1;
                self.hol_same_regular=@"0";
            }
            
            if (!([[overtimeDict objectForKey:@"holi_daily_limit"]isEqualToString:@""])) {
                self.hol_date1=[overtimeDict objectForKey:@"holi_daily_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"holi_daily_limit"] componentsSeparatedByString:@":"];
                self.holidayDailyLimitText.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                                                                                               [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.holidayPayOTText1.backgroundColor=[UIColor clearColor];
                self.holidayPayOTText1.userInteractionEnabled=YES;
                
            }
            if (!([[overtimeDict objectForKey:@"holi_hour"]isEqualToString:@""])) {
                self.hol_firstDate=[overtimeDict objectForKey:@"holi_hour"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"holi_hour"] componentsSeparatedByString:@":"];
                self.holidayFirstText.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                                                                                          [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.holidayPayOTText1.backgroundColor=[UIColor clearColor];
                self.holidayPayOTText1.userInteractionEnabled=YES;
            }
            
            if (!([[overtimeDict objectForKey:@"holi_overtime_1_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"holi_overtime_1_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.holidayPayOTText1.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"holi_overtime_1_rate"] ];
                    
                }
                else
                {
                    self.holidayPayOTText1.text=[overtimeDict objectForKey:@"holi_overtime_1_rate"];
                }
                
                self.hol_ot1=[overtimeDict objectForKey:@"holi_overtime_1_rate"];
                self.holidayAfterText1.backgroundColor=[UIColor clearColor];
                self.holidayAfterText1.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"holi_over_time_1_limit"]isEqualToString:@""])) {
                self.hol_date2=[overtimeDict objectForKey:@"holi_over_time_1_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"holi_over_time_1_limit"] componentsSeparatedByString:@":"];
                self.holidayAfterText1.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                                                                                           [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.holidayPayOTText2.backgroundColor=[UIColor clearColor];
                self.holidayPayOTText2.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"holi_overtime_2_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"holi_overtime_2_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.holidayPayOTText2.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"holi_overtime_2_rate"] ];
                    
                }
                else
                {
                    self.holidayPayOTText2.text=[overtimeDict objectForKey:@"holi_overtime_2_rate"];
                }
                
                self.hol_ot2=[overtimeDict objectForKey:@"holi_overtime_2_rate"];
                self.holidayAfterText2.backgroundColor=[UIColor clearColor];
                self.holidayAfterText2.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"holi_over_time_2_limit"]isEqualToString:@""])) {
                self.hol_date3=[overtimeDict objectForKey:@"holi_over_time_2_limit"];
                NSArray *dateArray=[[overtimeDict objectForKey:@"holi_over_time_2_limit"] componentsSeparatedByString:@":"];
                self.holidayAfterText2.text=[NSString stringWithFormat:@" %@ Hrs %@ Mins",[[dateArray objectAtIndex:0]stringByTrimmingCharactersInSet:
                                                                                           [NSCharacterSet whitespaceCharacterSet]],[dateArray objectAtIndex:1]];
                self.holidayPayOTText3.backgroundColor=[UIColor clearColor];
                self.holidayPayOTText3.userInteractionEnabled=YES;
            }
            if (!([[overtimeDict objectForKey:@"holi_overtime_3_rate"]isEqualToString:@""])) {
                
                NSRange range = [[overtimeDict objectForKey:@"holi_overtime_3_rate"] rangeOfString:@"X"];
                if (!(range.location != NSNotFound)) {
                    self.holidayPayOTText3.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"holi_overtime_3_rate"] ];
                    
                }
                else
                {
                    self.holidayPayOTText3.text=[overtimeDict objectForKey:@"holi_overtime_3_rate"];
                }
                
                self.hol_ot3=[overtimeDict objectForKey:@"holi_overtime_3_rate"];
            }
            
            self.dropLabel3.text=[overtimeDict objectForKey:@"holi_overtime_type"];
            if ([self.dropLabel3.text isEqualToString:@"1"]) {
                self.dropLabel3.text=@"After Standard Working Hours";
                self.holidayDropView.hidden=false;
                self.holidayFirstView.hidden=true;
                self.holidayWholeView.hidden=false;
            }
            else if ([self.dropLabel3.text isEqualToString:@"2"])
            {
                self.dropLabel3.text=@"Whole Day";
                self.holidayDropView.hidden=false;
                self.holidayFirstView.hidden=true;
                self.holidayWholeView.hidden=true;
            }
            else if([self.dropLabel3.text isEqualToString:@"3"])
            {
                self.dropLabel3.text=@"First Certain Duration";
                self.holidayDropView.hidden=true;
                self.holidayFirstView.hidden=false;
                self.holidayWholeView.hidden=false;
                self.holidayFirstView.frame=CGRectMake(1786, 120, self.holidayFirstView.frame.size.width, self.holidayFirstView.frame.size.height);
            }
            NSMutableArray *specificDayArray=[responseData objectForKey:@"specific_date"];
            for (int v=0; v<specificDayArray.count; v++) {
                NSMutableDictionary *specific=[specificDayArray objectAtIndex:v];
                [self.specificDict setObject:specific forKey:[NSString stringWithFormat:@"%i",v]];
            }
            [self specificDayList:specificDayArray.count];
            
        }
        else
        {
            self.partialdayIcon.image=[UIImage imageNamed:@"partial_day__grey.png"];
            self.offdayIcon.image=[UIImage imageNamed:@"off_day_grey.png"];
            self.holidayIcon.image=[UIImage imageNamed:@"holiday_grey.png"];
            self.specificdayIcon.image=[UIImage imageNamed:@"specific_day_grey.png"];
            
            
            [self resetWeeklyDailyLimit];
            self.currentTab=@"Weekly";
            self.regularButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            self.offdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
            self.partialdayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
            self.holidayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
            self.specificDayButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
            [self.regularButton setImage:[UIImage imageNamed:@"tab_1_active.png"] forState:UIControlStateNormal];
            self.offdayButton.enabled=NO;
            [self.offdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
            self.partialdayButton.enabled=NO;
            [self.partialdayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
            self.holidayButton.enabled=NO;
            [self.holidayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
            self.specificDayButton.enabled=NO;
            [self.specificDayButton setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateNormal];
            [self.contentScrollView setContentOffset:CGPointMake(2965, 0) animated:NO];
            
            if (!([[overtimeDict objectForKey:@"reg_daily_limit"]isEqualToString:@""])) {
                NSArray *dateArray=[[overtimeDict objectForKey:@"reg_daily_limit"] componentsSeparatedByString:@":"];
                self.weeklyDailyLimitText.text=[NSString stringWithFormat:@"%@ Hrs %@ Mins",[dateArray objectAtIndex:0],[dateArray objectAtIndex:1]];
                self.weeklyAfterText1.backgroundColor=[UIColor clearColor];
                self.weeklyAfterText1.userInteractionEnabled=YES;
            }
            self.weeklyAfterText1.text=[overtimeDict objectForKey:@"reg_over_time_1_limit"];
            self.weeklyPayOTText1.backgroundColor=[UIColor clearColor];
            self.weeklyPayOTText1.userInteractionEnabled=YES;
            NSRange range = [[overtimeDict objectForKey:@"reg_overtime_1_rate"] rangeOfString:@"X"];
            if (!(range.location != NSNotFound)) {
                self.weeklyPayOTText1.text=[NSString stringWithFormat:@"%@ /hr", [overtimeDict objectForKey:@"reg_overtime_1_rate"] ];
                
            }
            else
            {
                self.weeklyPayOTText1.text=[overtimeDict objectForKey:@"reg_overtime_1_rate"];
            }
            
            self.reg_ot1=[overtimeDict objectForKey:@"reg_overtime_1_rate"];
            if ([[overtimeDict objectForKey:@"pf"]isEqualToString:@"1"]) {
                [self.weeklyCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.p=1;
            }
            else
            {
                [self.weeklyCheckButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            }
            
            if ([[overtimeDict objectForKey:@"esi"]isEqualToString:@"1"]) {
                [self.weeklyCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.q=1;
            }
            else
            {
                [self.weeklyCheckButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            }
            
            if ([[overtimeDict objectForKey:@"incentive"]isEqualToString:@"1"]) {
                [self.weeklyCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.r=1;
            }
            else
            {
                [self.weeklyCheckButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            }
            self.weeklyWorkingHoursText.text=[overtimeDict objectForKey:@"calculation"];
            if ([[overtimeDict objectForKey:@"paid_leaves"]isEqualToString:@"1"]) {
                [self.weeklyCheckButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.i=1;
            }
            else
            {
                [self.weeklyCheckButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            }
            if ([[overtimeDict objectForKey:@"paid_holidays"]isEqualToString:@"1"]) {
                [self.weeklyCheckButton5 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.
                j=1;
            }
            else
            {
                [self.weeklyCheckButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            }
            if ([[overtimeDict objectForKey:@"apply_7"]isEqualToString:@"1"]) {
                [self.weeklyCheckButton6 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.k=1;
            }
            else
            {
                [self.weeklyCheckButton6 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            }
            
        }
        if ([overtimeDict objectForKey:@"description"]!=(id)[NSNull null])
        {
            self.descriptionTextView.text=[overtimeDict objectForKey:@"description"];
        }
        
        for (int of=0; of<[[responseData objectForKey:@"office_designation"]count]; of++) {
            
            NSMutableDictionary *localDict1=[[responseData objectForKey:@"office_designation"] objectAtIndex:of];
            
            NSString *myString=[NSString stringWithFormat:@"%@:%@",[localDict1 objectForKey:@"office_name"],[localDict1 objectForKey:@"designation_title"]];
            
            [self.grouparray addObject:myString];
            
        }
        
        for (int st=0; st<[[responseData objectForKey:@"store_designation"]count]; st++) {
            
            NSMutableDictionary *localDict1=[[responseData objectForKey:@"store_designation"] objectAtIndex:st];
            
            NSString *myString=[NSString stringWithFormat:@"%@:%@",[localDict1 objectForKey:@"store_name"],[localDict1 objectForKey:@"designation_title"]];
            
            [self.grouparray addObject:myString];
            
        }
        
        [self.mycollectionview reloadData];
        
    });
    
    
    
}
@end
