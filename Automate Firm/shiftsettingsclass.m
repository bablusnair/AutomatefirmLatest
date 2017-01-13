//
//  shiftsettingsclass.m
//  bablusdemokpproject
//
//  Created by leonine on 18/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "shiftsettingsclass.h"
#import "groupcollceioncellclass.h"
#import "settingsViewController.h"
#import "attendancesettingsviewclass.h"
@implementation shiftsettingsclass
@synthesize indexpath,flagValue,flagValue1,serviceStr;
-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc] init];
    self.myconnection.mydelegate=self;
    objTime=[[timeConditionsClass alloc]init];
    objApp=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:@"shiftAction"];
    
    if ([str isEqualToString:@"update"]) {
        [self.myconnection displaySelectedShiftRule:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]:[[NSUserDefaults standardUserDefaults]objectForKey:@"shiftruleid"]];
        [objApp hudStart:self];
    }
    
    serviceStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"shiftAction"];
    
    [self.mycollectionview registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    self.mycollectionview.hidden=TRUE;
    self.dayshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"attendancerf.png"]];
    self.noonshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
    self.nightshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
    self.grouparray=[[NSMutableArray alloc] init];
    self.shiftTypeArray=[[NSMutableArray alloc] initWithObjects:@"Regular",@"Rotational", nil];
    self.breakTypeArray=[[NSMutableArray alloc]initWithObjects:@"Fixed Break",@"Duration Based", nil];
    self.datePickerView.hidden=true;
    
    self.groupIDarray=[[NSMutableArray alloc] init];
     self.datePickerView1.hidden=true;
      self.datePickerView2.hidden=true;
    self.datePickerView3.hidden=true;
    self.shiftTypetableView.hidden=true;
    self.dayBreakTypeTC.hidden=true;
    self.swingBreakTypeTC.hidden=true;
    self.nightBreakTypeTC.hidden=true;
    self.dayBreakTypeText.userInteractionEnabled=NO;
    self.swingBreakTypeText.userInteractionEnabled=NO;
    self.nightBreakTypeText.userInteractionEnabled=NO;
    self.breakDuration.userInteractionEnabled=false;
    self.swingbreakDuration.userInteractionEnabled=false;
    self.nightbreakDuration.userInteractionEnabled=false;
    
    
    self.flag=0;
    self.flagValue=1;
    self.flagValue1=1;
    self.x=self.y=self.z=self.p=self.q=self.r=self.i=self.j=self.k=0;
    self.timerFlag1=self.timerFlag2=0;
    self.dayShiftStartTimeFlag=self.dayShiftEndTimeFlag=self.dayPunchStartTimeFlag=0;
    self.dayBreakBeginTimeFlag=self.breakDurationFlag=0;
    
    self.swingShiftStartTimeFlag=self.swingShiftEndTimeFlag=self.swingPunchStartTimeFlag=0;
    self.swingBreakBeginTimeFlag=0;
    
    self.nightShiftStartTimeFlag=self.nightShiftEndTimeFlag=self.nightPunchStartTimeFlag=0;
    self.nightBreakBeginTimeFlag=0;
    
    self.dayInTimeValue=@"0";
    self.dayOutTimeValue=@"0";
    self.swingInTimeValue=@"0";
    self.swingOutTimeValue=@"0";
    self.nightInTimeValue=@"0";
    self.nightOutTimeValue=@"0";
    //To set placeholder Text Color
    [self.workingHours setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.breakDuration setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.swingworkingHours setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.swingbreakDuration setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.nightworkingHours setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.nightbreakDuration setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //Set the appearance of uidatepicker
    
    [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[UIDatePicker class]]]
     setBackgroundColor:[UIColor clearColor]];
    
    [self.datePicker3 addTarget:self action:@selector(datePickedValueChanged:)
              forControlEvents:UIControlEventValueChanged];
    
}
-(void)datePickedValueChanged:(id)sender
{
    if (self.breakDurationFlag==1) {
        
        float totalSeconds=[objTime timerGetValueChanged:self.workingHours.text];
        if (self.datePicker3.countDownDuration > totalSeconds) { //5400 seconds = 1h30min
            [self.datePicker3 setCountDownDuration: totalSeconds]; //Defaults to 1 minute
                
        }
    }
    else if (self.breakDurationFlag==2)
    {
        float totalSeconds=[objTime timerGetValueChanged:self.swingworkingHours.text];
        
        if (self.datePicker3.countDownDuration > totalSeconds) { //5400 seconds = 1h30min
            [self.datePicker3 setCountDownDuration: totalSeconds]; //Defaults to 1 minute
            
        }

    }
    else if (self.breakDurationFlag==3)
    {
        float totalSeconds=[objTime timerGetValueChanged:self.nightworkingHours.text];
        
        if (self.datePicker3.countDownDuration > totalSeconds) { //5400 seconds = 1h30min
            [self.datePicker3 setCountDownDuration: totalSeconds]; //Defaults to 1 minute
            
        }

    }

}
-(IBAction)groupselectionaction:(id)sender
{
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"grouppopupview" owner:self options:nil];
    [self addSubview:[nib objectAtIndex:0]];
    
    
}

-(IBAction)shiftarrangebuttonaction:(id)sender
{
    
    UIButton *mybutton=(UIButton *)sender;
    
    if (mybutton.tag==1) {
        
        if (self.flagValue1==2) {
            
            if (((self.swingtimeText2.text.length>0)&&(self.swingtimeText3.text.length>0)&&(self.swingtimeText1.text.length>0))||(([self.swingtimeText1.text isEqualToString:@""])&&([self.swingtimeText2.text isEqualToString:@""])&&([self.swingtimeText3.text isEqualToString:@""]))) {
                
                self.flagValue1=1;
                
                [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                
                self.dayshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"attendancerf.png"]];
                self.noonshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
                self.nightshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
                
                
                self.datePickerView.hidden=true;
                self.datePickerView1.hidden=true;
                self.datePickerView2.hidden=true;
                self.datePickerView3.hidden=true;
                
                //Datepicker Reset

                NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                timeArray=[objTime timeInitialSettings];
                NSDate *startDate=[timeArray objectAtIndex:0];
                NSDate *endDate=[timeArray objectAtIndex:1];
                
                [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                [self.datePicker setMinimumDate:startDate];
                [self.datePicker setMaximumDate:endDate];
                [self.datePicker setDate:startDate animated:YES];
                [self.datePicker reloadInputViews];
                
                
            }
            else
            {
                
                [self alertViewAction];
                
            }
            
        }
        else if (self.flagValue1==3)
        {
            if ((([self.nighttimeText1.text isEqualToString:@""])&&([self.nighttimeText2.text isEqualToString:@""])&&([self.nighttimeText3.text isEqualToString:@""])) || ((self.nighttimeText1.text.length>0)&&(self.nighttimeText2.text.length>0)&&(self.nighttimeText3.text.length>0)))
            {
                self.flagValue1=1;
                //self.shiftStartTimeFlag=self.shiftEndTimeFlag=self.punchStartTimeFlag=self.breakBeginTimeFlag=0;
                
                [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                
                self.dayshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"attendancerf.png"]];
                self.noonshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
                self.nightshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
                
                self.datePickerView.hidden=true;
                self.datePickerView1.hidden=true;
                self.datePickerView2.hidden=true;
                self.datePickerView3.hidden=true;
                
                //Datepicker Reset
                
                NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                timeArray=[objTime timeInitialSettings];
                NSDate *startDate=[timeArray objectAtIndex:0];
                NSDate *endDate=[timeArray objectAtIndex:1];
                
                [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                [self.datePicker setMinimumDate:startDate];
                [self.datePicker setMaximumDate:endDate];
                [self.datePicker setDate:startDate animated:YES];
                [self.datePicker reloadInputViews];
            }
            else
            {
                [self alertViewAction];
            }

        }
        
    }
    else if (mybutton.tag==2)
    {
        
        if (self.flagValue1==1) {
            if (((self.timeText2.text.length>0)&&(self.timeText3.text.length>0)&&(self.timeText1.text.length>0)) || (([self.timeText1.text isEqualToString:@""])&&([self.timeText2.text isEqualToString:@""])&&([self.timeText3.text isEqualToString:@""]))) {
                
                
                self.flagValue1=2;
                //self.shiftStartTimeFlag=self.shiftEndTimeFlag=self.punchStartTimeFlag=self.breakBeginTimeFlag=0;
                
                [self.contentScrollView setContentOffset:CGPointMake(578, 0) animated:YES];
               
                self.dayshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
                self.noonshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"attendancerf.png"]];
                self.nightshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
                
                self.datePickerView.hidden=true;
                self.datePickerView1.hidden=true;
                self.datePickerView2.hidden=true;
                self.datePickerView3.hidden=true;
                
                //DatePicker Reset
                
                
                NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                timeArray=[objTime timeInitialSettings];
                NSDate *startDate=[timeArray objectAtIndex:0];
                NSDate *endDate=[timeArray objectAtIndex:1];
                
                [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                [self.datePicker setMinimumDate:startDate];
                [self.datePicker setMaximumDate:endDate];
                [self.datePicker setDate:startDate animated:YES];
                [self.datePicker reloadInputViews];
                
            }
            else
            {
                [self alertViewAction];
            }


        }
        else if (flagValue1==3)
        {
            if((([self.nighttimeText1.text isEqualToString:@""])&&([self.nighttimeText2.text isEqualToString:@""])&&([self.nighttimeText3.text isEqualToString:@""])) || ((self.nighttimeText1.text.length>0)&&(self.nighttimeText2.text.length>0)&&(self.nighttimeText3.text.length>0)))
            {
                self.flagValue1=2;
                //self.shiftStartTimeFlag=self.shiftEndTimeFlag=self.punchStartTimeFlag=self.breakBeginTimeFlag=0;
            
            
                [self.contentScrollView setContentOffset:CGPointMake(578, 0) animated:YES];
                
                self.dayshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
                self.noonshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"attendancerf.png"]];
                self.nightshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
            
                self.datePickerView.hidden=true;
                self.datePickerView1.hidden=true;
                self.datePickerView2.hidden=true;
                self.datePickerView3.hidden=true;
                
                
                //Datepicker Reset
        
                NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                timeArray=[objTime timeInitialSettings];
                NSDate *startDate=[timeArray objectAtIndex:0];
                NSDate *endDate=[timeArray objectAtIndex:1];
            
                [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                [self.datePicker setMinimumDate:startDate];
                [self.datePicker setMaximumDate:endDate];
                [self.datePicker setDate:startDate animated:YES];
                [self.datePicker reloadInputViews];
            
            }
            else
            {
                [self alertViewAction];
            }

        }
    }
    
    else
    {
        if (self.flagValue1==1) {
            if (((self.timeText1.text.length>0)&&(self.timeText2.text.length>0)&&(self.timeText3.text.length>0))||(([self.timeText1.text isEqualToString:@""])&&([self.timeText2.text isEqualToString:@""])&&([self.timeText3.text isEqualToString:@""]))) {
                
                //self.shiftStartTimeFlag=self.shiftEndTimeFlag=self.punchStartTimeFlag=self.breakBeginTimeFlag=0;
                self.flagValue1=3;
                
                
                [self.contentScrollView setContentOffset:CGPointMake(1156, 0) animated:YES];
               
                self.dayshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
                self.noonshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
                self.nightshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"attendancerf.png"]];
                
                
                self.datePickerView.hidden=true;
                self.datePickerView1.hidden=true;
                self.datePickerView2.hidden=true;
                self.datePickerView3.hidden=true;
                
                //Datepicker reset
                
                NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                timeArray=[objTime timeInitialSettings];
                NSDate *startDate=[timeArray objectAtIndex:0];
                NSDate *endDate=[timeArray objectAtIndex:1];
                
                [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                [self.datePicker setMinimumDate:startDate];
                [self.datePicker setMaximumDate:endDate];
                [self.datePicker setDate:startDate animated:YES];
                [self.datePicker reloadInputViews];
                
                
            }
            else
            {
                [self alertViewAction];
            }


        }
        else if (self.flagValue1==2)
        {
            if(((self.swingtimeText1.text.length>0)&&(self.swingtimeText2.text.length>0)&&(self.swingtimeText3.text.length>0)) || (([self.swingtimeText1.text isEqualToString:@""])&&([self.swingtimeText2.text isEqualToString:@""])&&([self.swingtimeText3.text isEqualToString:@""])))
                {
                   // self.shiftStartTimeFlag=self.shiftEndTimeFlag=self.punchStartTimeFlag=self.breakBeginTimeFlag=0;
                    self.flagValue1=3;
                
                
                    [self.contentScrollView setContentOffset:CGPointMake(1156, 0) animated:YES];
                   
                    self.dayshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
                    self.noonshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"staffingpath.png"]];
                    self.nightshift.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"attendancerf.png"]];
                
                    
                    self.datePickerView.hidden=true;
                    self.datePickerView1.hidden=true;
                    self.datePickerView2.hidden=true;
                    self.datePickerView3.hidden=true;
                
                    //Datepicker reset
                    
                    
                    NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                    timeArray=[objTime timeInitialSettings];
                    NSDate *startDate=[timeArray objectAtIndex:0];
                    NSDate *endDate=[timeArray objectAtIndex:1];
                
                    [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                    [self.datePicker setMinimumDate:startDate];
                    [self.datePicker setMaximumDate:endDate];
                    [self.datePicker setDate:startDate animated:YES];
                    [self.datePicker reloadInputViews];
                
            }
            else
            {
                [self alertViewAction];
            }
        }
    }
}


-(IBAction)discardButtonAction:(id)sender
{
    if (self.flagValue1==1) {
        
        [self resetDayShift];
    }
    else if(self.flagValue1==2)
    {
        [self resetSwingShift];

    }
    else
    {
        [self resetNightShift];

    }
}
-(IBAction)donebuttonaction:(id)sender
{
    if ((self.shiftNameText.text.length>0)&&(self.abbrbText.text.length>0)&&(self.shiftTypeText.text.length>0)){//&&(self.groupIDarray.count>0)) {
        
        
        if ((self.timeText1.text.length > 0) && (self.swingtimeText1.text.length > 0) && (self.nighttimeText1.text.length > 0))
        {
            if (((self.timeText2.text.length > 0)&&(self.timeText3.text.length > 0)) && ((self.swingtimeText2.text.length > 0)&&(self.swingtimeText3.text.length > 0)) && ((self.nighttimeText2.text.length > 0) && (self.nighttimeText3.text.length > 0))) {
                
                [self saveAction:serviceStr];
                
            }
            else
            {
                [self alertViewAction];
            }
        }
        
        else if ((self.timeText1.text.length > 0) && (self.swingtimeText1.text.length > 0))
        {
            if (((self.timeText2.text.length > 0)&&(self.timeText3.text.length > 0)) && ((self.swingtimeText2.text.length > 0)&&(self.swingtimeText3.text.length > 0)))
            {
                [self saveAction:serviceStr];
            }
            else
            {
                [self alertViewAction];
            }
        }
        else if ((self.timeText1.text.length > 0) && (self.nighttimeText1.text.length > 0))
        {
            if (((self.timeText2.text.length > 0)&&(self.timeText3.text.length > 0)) && ((self.nighttimeText2.text.length > 0) && (self.nighttimeText3.text.length > 0)))
            {
                [self saveAction:serviceStr];
            }
            else
            {
                [self alertViewAction];
            }

        }
        else if ((self.swingtimeText1.text.length > 0) && (self.nighttimeText1.text.length > 0))
        {
            if (((self.swingtimeText2.text.length > 0)&&(self.swingtimeText3.text.length > 0)) && ((self.nighttimeText2.text.length > 0) && (self.nighttimeText3.text.length > 0)))
            {
                [self saveAction:serviceStr];
            }
            else
            {
                [self alertViewAction];
            }
            
        }
        else if ((self.timeText1.text.length > 0) || (self.swingtimeText1.text.length > 0) || (self.nighttimeText1.text.length > 0)) {
            if (((self.timeText2.text.length > 0)&&(self.timeText3.text.length > 0)) || ((self.swingtimeText2.text.length > 0)&&(self.swingtimeText3.text.length > 0)) || ((self.nighttimeText2.text.length > 0) && (self.nighttimeText3.text.length > 0))) {
                
                [self saveAction:serviceStr];
                
            }
            else
            {
                [self alertViewAction];
            }
        }
        else
        {
            [self saveAction:serviceStr];
        }
    }
    else
    {
        [self alertViewAction];

    }
}

-(void)saveAction:(NSString *)action
{
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"close" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    
    NSString *designationList=@"";
    if (self.grouparray.count > 0) {
        designationList=[self.grouparray componentsJoinedByString:@"###"];
    }
    [objApp hudStart:self];
    
    if ([action isEqualToString:@"create"]) {
        
        [self.myconnection createNewShiftRule:self.shiftNameText.text shift_abbrv:self.abbrbText.text shift_type:self.shiftTypeText.text shift_description:self.shiftDescription.text day_punch_start:self.timeText1.text day_shift_start:self.timeText2.text day_shift_end:self.timeText3.text day_working_hours:self.workingHours.text day_break_type:self.dayBreakTypeText.text day_break_begin:self.timeText4.text day_break_end:self.timeText5.text day_break_duration:self.breakDuration.text day_intime_chekbox:self.dayInTimeValue day_outtime_checkbox:self.dayOutTimeValue day_intime_value:self.inTimeText.text day_outtime_value:self.outTimeText.text swing_punch_start:self.swingtimeText1.text swing_shift_start:self.swingtimeText2.text swing_shift_end:self.swingtimeText3.text swing_working_hours:self.swingworkingHours.text swing_break_type:self.swingBreakTypeText.text swing_break_begin:self.swingtimeText4.text swing_break_end:self.swingtimeText5.text swing_break_duration:self.swingbreakDuration.text swing_inttime_checkbox:self.swingInTimeValue swing_outtime_checkbox:self.swingOutTimeValue swing_intime_value:self.swinginTimeText.text swing_outtime_value:self.swingoutTimeText.text night_punch_start:self.nighttimeText1.text night_shift_start:self.nighttimeText2.text night_shift_end:self.nighttimeText3.text night_working_hours:self.nightworkingHours.text night_break_type:self.nightBreakTypeText.text night_break_begin:self.nighttimeText4.text night_break_end:self.nighttimeText5.text night_break_duration:self.nightbreakDuration.text night_intime_checkbox:self.nightInTimeValue night_outtime_checkbox:self.nightOutTimeValue night_intime_value:self.nightinTimeText.text night_outtime_value:self.nightoutTimeText.text shift_status:@"C" shift_created_by:@"admin" officeID:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId" ]:designationList:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"]];
    }
    else
    {
        [self.myconnection updateShiftRule:[[NSUserDefaults standardUserDefaults]objectForKey:@"shiftruleid"] shift_name:self.shiftNameText.text shift_abbrv:self.abbrbText.text shift_type:self.shiftTypeText.text shift_description:self.shiftDescription.text day_punch_start:self.timeText1.text day_shift_start:self.timeText2.text day_shift_end:self.timeText3.text day_working_hours:self.workingHours.text day_break_type:self.dayBreakTypeText.text day_break_begin:self.timeText4.text day_break_end:self.timeText5.text day_break_duration:self.breakDuration.text day_intime_chekbox:self.dayInTimeValue day_outtime_checkbox:self.dayOutTimeValue day_intime_value:self.inTimeText.text day_outtime_value:self.outTimeText.text swing_punch_start:self.swingtimeText1.text swing_shift_start:self.swingtimeText2.text swing_shift_end:self.swingtimeText3.text swing_working_hours:self.swingworkingHours.text swing_break_type:self.swingBreakTypeText.text swing_break_begin:self.swingtimeText4.text swing_break_end:self.swingtimeText5.text swing_break_duration:self.swingbreakDuration.text swing_inttime_checkbox:self.swingInTimeValue swing_outtime_checkbox:self.swingOutTimeValue swing_intime_value:self.swinginTimeText.text swing_outtime_value:self.swingoutTimeText.text night_punch_start:self.nighttimeText1.text night_shift_start:self.nighttimeText2.text night_shift_end:self.nighttimeText3.text night_working_hours:self.nightworkingHours.text night_break_type:self.nightBreakTypeText.text night_break_begin:self.nighttimeText4.text night_break_end:self.nighttimeText5.text night_break_duration:self.nightbreakDuration.text night_intime_checkbox:self.nightInTimeValue night_outtime_checkbox:self.nightOutTimeValue night_intime_value:self.nightinTimeText.text night_outtime_value:self.nightoutTimeText.text shift_status:@"C" shift_created_by:@"admin" officeID:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]:designationList :[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"]];
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];

}

-(IBAction)cancelbuttonaction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"close" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
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
    if (tableView==self.shiftTypetableView) {
        return self.shiftTypeArray.count;
    }
    else
        return self.breakTypeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.shiftTypetableView) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.shiftTypeArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return  cell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.breakTypeArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return  cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.shiftTypetableView) {
        self.shiftTypeText.text=[self.shiftTypeArray objectAtIndex:indexPath.row];
        self.shiftTypetableView.hidden=true;
    }
    else if(tableView==self.dayBreakTypeTC)
    {
        if (indexPath.row==0) {
            self.timeText4.userInteractionEnabled=true;
            self.breakDuration.text=@"";
            self.breakDuration.userInteractionEnabled=false;
            self.timeText4.backgroundColor=[UIColor clearColor];
            self.breakDuration.backgroundColor=[UIColor lightGrayColor];
        }
        else
        {
            self.timeText4.userInteractionEnabled=false;
            self.timeText5.userInteractionEnabled=false;
            self.timeText4.text=@"";
            self.timeText5.text=@"";
            self.breakDuration.text=@"";
            self.breakDuration.userInteractionEnabled=true;
            self.timeText4.backgroundColor=[UIColor lightGrayColor];
            self.timeText5.backgroundColor=[UIColor lightGrayColor];
            self.breakDuration.backgroundColor=[UIColor clearColor];
        }
        self.dayBreakTypeText.text=[self.breakTypeArray objectAtIndex:indexPath.row];
        self.dayBreakTypeTC.hidden=true;
    }
    else if (tableView==self.swingBreakTypeTC)
    {
        if (indexPath.row==0) {
            self.swingtimeText4.userInteractionEnabled=true;
            self.swingbreakDuration.text=@"";
            self.swingbreakDuration.userInteractionEnabled=false;
            self.swingtimeText4.backgroundColor=[UIColor clearColor];
            self.swingbreakDuration.backgroundColor=[UIColor lightGrayColor];
        }
        else
        {
            self.swingtimeText4.userInteractionEnabled=false;
            self.swingtimeText5.userInteractionEnabled=false;
            self.swingtimeText4.text=@"";
            self.swingtimeText5.text=@"";
            self.swingbreakDuration.text=@"";
            self.swingbreakDuration.userInteractionEnabled=true;
            self.swingtimeText4.backgroundColor=[UIColor lightGrayColor];
            self.swingtimeText5.backgroundColor=[UIColor lightGrayColor];
            self.swingbreakDuration.backgroundColor=[UIColor clearColor];
        }
        self.swingBreakTypeText.text=[self.breakTypeArray objectAtIndex:indexPath.row];
        self.swingBreakTypeTC.hidden=true;
    }
    else if (tableView==self.nightBreakTypeTC)
    {
        if (indexPath.row==0) {
            self.nighttimeText4.userInteractionEnabled=true;
            self.nightbreakDuration.text=@"";
            self.nightbreakDuration.userInteractionEnabled=false;
            self.nighttimeText4.backgroundColor=[UIColor clearColor];
            self.nightbreakDuration.backgroundColor=[UIColor lightGrayColor];
        }
        else
        {
            self.nighttimeText4.userInteractionEnabled=false;
            self.nighttimeText5.userInteractionEnabled=false;
            self.nighttimeText4.text=@"";
            self.nighttimeText5.text=@"";
            self.nightbreakDuration.text=@"";
            self.nightbreakDuration.userInteractionEnabled=true;
            self.nighttimeText4.backgroundColor=[UIColor lightGrayColor];
            self.nighttimeText5.backgroundColor=[UIColor lightGrayColor];
            self.nightbreakDuration.backgroundColor=[UIColor clearColor];
        }
        self.nightBreakTypeText.text=[self.breakTypeArray objectAtIndex:indexPath.row];
        self.nightBreakTypeTC.hidden=true;
    }
    
}
-(void)willRemoveSubview:(UIView *)subview
{
    self.mycollectionview.hidden=FALSE;
    NSMutableArray *selectedGroupArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
    NSMutableArray *selectedGroupsIdarray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedGroupsID"];
    [self.grouparray removeAllObjects];
    [self.groupIDarray removeAllObjects];
    [self.grouparray addObjectsFromArray:selectedGroupArray];
    [self.groupIDarray addObjectsFromArray:selectedGroupsIdarray];
    [self.mycollectionview reloadData];
}

-(IBAction)checkboxactionbutton:(id)sender
{
    if ((self.dayShiftStartTimeFlag==1)&&(self.dayShiftEndTimeFlag==1)) {
        UIButton *mybutton=(UIButton *)sender;
    
        if (mybutton.tag==1) {
            [self dayShiftInTimeCheckBoxAction];
        }
        else if(mybutton.tag==3)
        {
            [self dayShiftOutTimeCheckBoxAction];
        }
    }
}
-(IBAction)swingcheckboxactionbutton:(id)sender
{
    if ((self.swingShiftStartTimeFlag==1)&&(self.swingShiftEndTimeFlag==1)) {
    UIButton *mybutton=(UIButton *)sender;
    
    if (mybutton.tag==2)
    {
        [self swingShiftInTimeCheckBoxAction];
    }
    
    else
    {
        [self swingShiftOutTimeCheckBoxAction];
        
    }
    }
}
-(IBAction)nightcheckboxactionbutton:(id)sender
{
    if ((self.nightShiftStartTimeFlag==1)&&(self.nightShiftEndTimeFlag==1)) {
        UIButton *mybutton=(UIButton *)sender;
    
        if (mybutton.tag==2)
        {
            [self nightShiftInTimeCheckBoxAction];
        }
        else
        {
            [self nightShiftOutTimeCheckBoxAction];
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.checkBoxText1) {
        if ((self.dayShiftStartTimeFlag==1)&&(self.dayShiftEndTimeFlag==1)) {
            [self dayShiftInTimeCheckBoxAction];
        }
        return NO;
    }
    if (textField==self.checkBoxText3)
    {
        if ((self.dayShiftStartTimeFlag==1)&&(self.dayShiftEndTimeFlag==1)) {
            [self dayShiftOutTimeCheckBoxAction];
        }
        return NO;
    }
    if (textField==self.swingcheckBoxText2)
    {
        if ((self.swingShiftStartTimeFlag==1)&&(self.swingShiftEndTimeFlag==1)) {
            [self swingShiftInTimeCheckBoxAction];
        }
        return NO;
    }
    if (textField==self.swingcheckBoxText3)
    {
        if ((self.swingShiftStartTimeFlag==1)&&(self.swingShiftEndTimeFlag==1)) {
            [self swingShiftOutTimeCheckBoxAction];
        }
        return NO;
    }
    
    if (textField==self.nightcheckBoxText2)
    {
        if ((self.nightShiftStartTimeFlag==1)&&(self.nightShiftEndTimeFlag==1)) {
            [self nightShiftInTimeCheckBoxAction];
        }
        return NO;
    }
    if (textField==self.nightcheckBoxText3)
    {
        if ((self.nightShiftStartTimeFlag==1)&&(self.nightShiftEndTimeFlag==1)) {
            [self nightShiftOutTimeCheckBoxAction];
        }
        return NO;
    }

    
    if (textField==self.timeText1) {
        if (self.timeText1.text.length>0) {
            self.flag=1;
            self.datePickerView.frame=CGRectMake(0, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
            
            
            
            NSMutableArray *timeArray=[[NSMutableArray alloc]init];
            timeArray=[objTime timeInitialSettings];
            NSDate *startDate=[timeArray objectAtIndex:0];
            NSDate *endDate=[timeArray objectAtIndex:1];
            
            [self.datePicker setDatePickerMode:UIDatePickerModeTime];
            [self.datePicker setMinimumDate:startDate];
            [self.datePicker setMaximumDate:endDate];
            [self.datePicker setDate:startDate animated:YES];
            [self.datePicker reloadInputViews];
            
            [self resetDayShift];
            self.x=0;
            self.z=0;
        }
        self.flag=1;
        self.datePickerView.frame=CGRectMake(0, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
        self.datePickerView.hidden=FALSE;
        return NO;
    }
    if (textField==self.timeText2) {
        if (self.dayPunchStartTimeFlag==1) {
            if (self.timeText2.text.length >0) {
                NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                timeArray=[objTime timeInitialSettings];
                NSDate *startDate=[timeArray objectAtIndex:0];
                NSDate *endDate=[timeArray objectAtIndex:1];
                
                [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                [self.datePicker setMinimumDate:startDate];
                [self.datePicker setMaximumDate:endDate];
                [self.datePicker setDate:startDate animated:YES];
                [self.datePicker reloadInputViews];
                
            }

            
            self.timeText2.text=@"";
            self.timeText3.text=@"";
            self.timeText3.userInteractionEnabled=NO;
            self.timeText3.backgroundColor=[UIColor lightGrayColor];
            self.timeText4.text=@"";
            self.timeText4.userInteractionEnabled=NO;
            self.timeText4.backgroundColor=[UIColor lightGrayColor];
            self.timeText5.text=@"";
            self.timeText5.userInteractionEnabled=NO;
            self.timeText5.backgroundColor=[UIColor lightGrayColor];
            self.workingHours.text=@"";
            self.dayBreakTypeText.text=@"";
            self.dayBreakTypeText.userInteractionEnabled=NO;
            self.dayBreakTypeText.backgroundColor=[UIColor lightGrayColor];
            self.breakDuration.text=@"";
            self.breakDuration.userInteractionEnabled=NO;
            self.breakDuration.backgroundColor=[UIColor lightGrayColor];
            self.inTimeText.text=@"";
            self.inTimeText.userInteractionEnabled=NO;
            self.inTimeText.backgroundColor=[UIColor lightGrayColor];
            self.outTimeText.text=@"";
            self.outTimeText.userInteractionEnabled=NO;
            self.outTimeText.backgroundColor=[UIColor lightGrayColor];
            [self.firstcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            [self.thirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.dayShiftStartTimeFlag=0;
            self.dayShiftEndTimeFlag=0;
            self.x=0;
            self.z=0;
            self.dayInTimeValue=@"0";
            self.dayOutTimeValue=@"0";
            
            
            
            
            NSString *time=[objTime timeMinimumValueSetting:self.timeText1.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue] - 10];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;

            
            
            self.flag=2;
            self.datePickerView.frame=CGRectMake(126, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        return  NO;
    }
    if (textField==self.timeText3) {
        if (self.dayShiftStartTimeFlag==1) {
            if (self.timeText3.text.length > 0) {

                
                NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                timeArray=[objTime timeInitialSettings];
                NSDate *startDate=[timeArray objectAtIndex:0];
                NSDate *endDate=[timeArray objectAtIndex:1];
                
                [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                [self.datePicker setMinimumDate:startDate];
                [self.datePicker setMaximumDate:endDate];
                [self.datePicker setDate:startDate animated:YES];
                [self.datePicker reloadInputViews];

            }
            
            
            self.timeText3.text=@"";
            self.timeText4.text=@"";
            self.timeText4.userInteractionEnabled=NO;
            self.timeText4.backgroundColor=[UIColor lightGrayColor];
            self.timeText5.text=@"";
            self.timeText5.userInteractionEnabled=NO;
            self.timeText5.backgroundColor=[UIColor lightGrayColor];
            self.workingHours.text=@"";
            self.dayBreakTypeText.text=@"";
            self.dayBreakTypeText.userInteractionEnabled=NO;
            self.dayBreakTypeText.backgroundColor=[UIColor lightGrayColor];
            self.breakDuration.text=@"";
            self.breakDuration.userInteractionEnabled=NO;
            self.breakDuration.backgroundColor=[UIColor lightGrayColor];
            self.inTimeText.text=@"";
            self.inTimeText.userInteractionEnabled=NO;
            self.inTimeText.backgroundColor=[UIColor lightGrayColor];
            self.outTimeText.text=@"";
            self.outTimeText.userInteractionEnabled=NO;
            self.outTimeText.backgroundColor=[UIColor lightGrayColor];
            [self.firstcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            [self.thirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            //self.shiftStartTimeFlag=0;
            self.dayShiftEndTimeFlag=0;
            self.x=0;
            self.z=0;
            self.dayInTimeValue=@"0";
            self.dayOutTimeValue=@"0";
            
            
            NSString *time=[objTime timeMinimumValueSetting:self.timeText2.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;
            
            
            self.flag=3;
            self.datePickerView.frame=CGRectMake(258, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;

        }
        return  NO;
    }
    if (textField==self.timeText4) {
        if ((self.dayShiftStartTimeFlag==1)&&(self.dayShiftEndTimeFlag==1)) {
            //if (self.timeText5.text.length>0) {
                           // }
            
            self.timeText4.text=@"";
            self.timeText5.text=@"";
            self.breakDuration.text=@"";
            self.timeText5.userInteractionEnabled=NO;
            
            NSString *time=[objTime timeMinimumValueSetting:self.timeText2.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;
            
            
            
            NSString *time1=[objTime timeMinimumValueSetting:self.timeText3.text];
            NSArray *timeArray1=[time1 componentsSeparatedByString:@"###"];
            [components setHour:[[timeArray1 objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray1 objectAtIndex:1] integerValue] - 20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.maximumDate = date1;
            
            
//            NSMutableArray *timeArray=[[NSMutableArray alloc]init];
//            timeArray=[objTime timeMinMaxValueSetting:self.timeText2.text :self.timeText3.text];
//            NSDate *startDate=[timeArray objectAtIndex:0];
//            NSDate *endDate=[timeArray objectAtIndex:1];
//            
//            [self.datePicker setDatePickerMode:UIDatePickerModeTime];
//            [self.datePicker setMinimumDate:startDate];
//            [self.datePicker setMaximumDate:endDate];
//            [self.datePicker setDate:startDate animated:YES];
//            //[self.datePicker reloadInputViews];
            
            self.flag=4;
            self.datePickerView.frame=CGRectMake(126, 328, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        return  NO;
    }
    if (textField==self.timeText5) {
        if (self.dayBreakBeginTimeFlag==1) {
            
            
            
            NSString *time=[objTime timeMinimumValueSetting:self.timeText4.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;
            
            
            
            NSString *time1=[objTime timeMinimumValueSetting:self.timeText3.text];
            NSArray *timeArray1=[time1 componentsSeparatedByString:@"###"];
            
            [components setHour:[[timeArray1 objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray1 objectAtIndex:1] integerValue] - 20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.maximumDate = date1;
            
            
            self.flag=5;
            self.datePickerView.frame=CGRectMake(258, 328, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        return  NO;
    }
    
    //if (textField==self.breakDuration) {
        
    
    //}
    
    if (textField==self.swingtimeText1) {
        if (self.swingtimeText1.text.length>0) {
            self.datePickerView.hidden=FALSE;
            

            
            NSMutableArray *timeArray=[[NSMutableArray alloc]init];
            timeArray=[objTime timeInitialSettings];
            NSDate *startDate=[timeArray objectAtIndex:0];
            NSDate *endDate=[timeArray objectAtIndex:1];
            
            [self.datePicker setDatePickerMode:UIDatePickerModeTime];
            [self.datePicker setMinimumDate:startDate];
            [self.datePicker setMaximumDate:endDate];
            [self.datePicker setDate:startDate animated:YES];
            [self.datePicker reloadInputViews];
            

            
            [self resetSwingShift];
            
            self.q=0;
            self.r=0;
            
            self.datePickerView.frame=CGRectMake(0, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        self.flag=6;
        self.datePickerView.frame=CGRectMake(0, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
        self.datePickerView.hidden=FALSE;
        return NO;
    }
    if (textField==self.swingtimeText2) {
        if (self.swingPunchStartTimeFlag==1) {
            
            if (self.swingtimeText2.text.length >0) {
                NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                timeArray=[objTime timeInitialSettings];
                NSDate *startDate=[timeArray objectAtIndex:0];
                NSDate *endDate=[timeArray objectAtIndex:1];
                
                [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                [self.datePicker setMinimumDate:startDate];
                [self.datePicker setMaximumDate:endDate];
                [self.datePicker setDate:startDate animated:YES];
                [self.datePicker reloadInputViews];
                
            }

            
            self.swingtimeText2.text=@"";
            self.swingtimeText3.text=@"";
            self.swingtimeText3.userInteractionEnabled=NO;
            self.swingtimeText3.backgroundColor=[UIColor lightGrayColor];
            self.swingtimeText4.text=@"";
            self.swingtimeText4.userInteractionEnabled=NO;
            self.swingtimeText4.backgroundColor=[UIColor lightGrayColor];
            self.swingtimeText5.text=@"";
            self.swingtimeText5.userInteractionEnabled=NO;
            self.swingtimeText5.backgroundColor=[UIColor lightGrayColor];
            self.swingworkingHours.text=@"";
            self.swingBreakTypeText.text=@"";
            self.swingBreakTypeText.userInteractionEnabled=NO;
            self.swingBreakTypeText.backgroundColor=[UIColor lightGrayColor];
            self.swingbreakDuration.text=@"";
            self.swingbreakDuration.userInteractionEnabled=NO;
            self.swingbreakDuration.backgroundColor=[UIColor lightGrayColor];
            self.swinginTimeText.text=@"";
            self.swinginTimeText.userInteractionEnabled=NO;
            self.swinginTimeText.backgroundColor=[UIColor lightGrayColor];
            self.swingoutTimeText.text=@"";
            self.swingoutTimeText.userInteractionEnabled=NO;
            self.swingoutTimeText.backgroundColor=[UIColor lightGrayColor];
            [self.swingsecondcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            [self.swingthirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.swingShiftStartTimeFlag=0;
            self.swingShiftEndTimeFlag=0;
            self.swingInTimeValue=@"0";
            self.swingOutTimeValue=@"0";
            self.q=0;
            self.r=0;

            
            
            NSString *time=[objTime timeMinimumValueSetting:self.swingtimeText1.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0]integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue] - 10];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;
            
            
            self.flag=7;
            self.datePickerView.frame=CGRectMake(126, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        return  NO;
    }
    if (textField==self.swingtimeText3) {
        if (self.swingShiftStartTimeFlag==1) {
            if (self.swingtimeText3.text.length > 0) {

                
                NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                timeArray=[objTime timeInitialSettings];
                NSDate *startDate=[timeArray objectAtIndex:0];
                NSDate *endDate=[timeArray objectAtIndex:1];
                
                [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                [self.datePicker setMinimumDate:startDate];
                [self.datePicker setMaximumDate:endDate];
                [self.datePicker setDate:startDate animated:YES];
                [self.datePicker reloadInputViews];
                
            }

            self.swingtimeText3.text=@"";
            self.swingtimeText4.text=@"";
            self.swingtimeText4.userInteractionEnabled=NO;
            self.swingtimeText4.backgroundColor=[UIColor lightGrayColor];
            self.swingtimeText5.text=@"";
            self.swingtimeText5.userInteractionEnabled=NO;
            self.swingtimeText5.backgroundColor=[UIColor lightGrayColor];
            self.swingworkingHours.text=@"";
            self.swingBreakTypeText.text=@"";
            self.swingBreakTypeText.userInteractionEnabled=NO;
            self.swingBreakTypeText.backgroundColor=[UIColor lightGrayColor];
            self.swingbreakDuration.text=@"";
            self.swingbreakDuration.userInteractionEnabled=NO;
            self.swingbreakDuration.backgroundColor=[UIColor lightGrayColor];
            self.swinginTimeText.text=@"";
            self.swinginTimeText.userInteractionEnabled=NO;
            self.swinginTimeText.backgroundColor=[UIColor lightGrayColor];
            self.swingoutTimeText.text=@"";
            self.swingoutTimeText.userInteractionEnabled=NO;
            self.swingoutTimeText.backgroundColor=[UIColor lightGrayColor];
            [self.swingsecondcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            [self.swingthirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            //self.shiftStartTimeFlag=0;
            self.swingShiftEndTimeFlag=0;
            self.swingInTimeValue=@"0";
            self.swingOutTimeValue=@"0";
            self.q=0;
            self.r=0;

            
            
            
            NSString *time=[objTime timeMinimumValueSetting:self.swingtimeText2.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0]integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;
            
            
            self.flag=8;
            self.datePickerView.frame=CGRectMake(258, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        return  NO;
    }
    if (textField==self.swingtimeText4) {
        if ((self.swingShiftStartTimeFlag==1)&&(self.swingShiftEndTimeFlag==1)) {
            //if (self.swingtimeText5.text.length>0) {
                //self.swingtimeText5.text=@"";
            //}
            self.swingtimeText4.text=@"";
            self.swingtimeText5.text=@"";
            self.swingbreakDuration.text=@"";
            self.swingtimeText5.userInteractionEnabled=NO;
            
            

            
            NSString *time=[objTime timeMinimumValueSetting:self.swingtimeText2.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;
            
            
            
            
            NSString *time1=[objTime timeMinimumValueSetting:self.swingtimeText3.text];
            NSArray *timeArray1=[time1 componentsSeparatedByString:@"###"];
            
            [components setHour:[[timeArray1 objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray1 objectAtIndex:1] integerValue] - 20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.maximumDate = date1;
            
            
            self.flag=9;
            self.datePickerView.frame=CGRectMake(126, 328, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        return  NO;
    }
    if (textField==self.swingtimeText5) {
        if (self.swingBreakBeginTimeFlag==1) {
            
            NSString *time=[objTime timeMinimumValueSetting:self.swingtimeText4.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;
            
            
            NSString *time1=[objTime timeMinimumValueSetting:self.swingtimeText3.text];
            NSArray *timeArray1=[time1 componentsSeparatedByString:@"###"];
            
            [components setHour:[[timeArray1 objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray1 objectAtIndex:1] integerValue] - 20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.maximumDate = date1;

            
            self.flag=10;
            self.datePickerView.frame=CGRectMake(258, 328, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        
        return  NO;
    }
    
    if (textField==self.nighttimeText1) {
        
        if (self.nighttimeText1.text.length>0) {
            [self resetNightShift];
            self.j=0;
            self.k=0;

            
            NSMutableArray *timeArray=[[NSMutableArray alloc]init];
            timeArray=[objTime timeInitialSettings];
            NSDate *startDate=[timeArray objectAtIndex:0];
            NSDate *endDate=[timeArray objectAtIndex:1];
            
            [self.datePicker setDatePickerMode:UIDatePickerModeTime];
            [self.datePicker setMinimumDate:startDate];
            [self.datePicker setMaximumDate:endDate];
            [self.datePicker setDate:startDate animated:YES];
            [self.datePicker reloadInputViews];
            
            self.flag=11;
            self.datePickerView.frame=CGRectMake(0, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        self.flag=11;
        self.datePickerView.frame=CGRectMake(0, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
        self.datePickerView.hidden=FALSE;
        return NO;
    }
    if (textField==self.nighttimeText2) {
        if (self.nightPunchStartTimeFlag==1) {
            
            
            if (self.nighttimeText2.text.length >0) {
                NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                timeArray=[objTime timeInitialSettings];
                NSDate *startDate=[timeArray objectAtIndex:0];
                NSDate *endDate=[timeArray objectAtIndex:1];
                
                [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                [self.datePicker setMinimumDate:startDate];
                [self.datePicker setMaximumDate:endDate];
                [self.datePicker setDate:startDate animated:YES];
                [self.datePicker reloadInputViews];
                
            }

            
            self.nighttimeText2.text=@"";
            self.nighttimeText3.text=@"";
            self.nighttimeText3.userInteractionEnabled=NO;
            self.nighttimeText3.backgroundColor=[UIColor lightGrayColor];
            self.nighttimeText4.text=@"";
            self.nighttimeText4.userInteractionEnabled=NO;
            self.nighttimeText4.backgroundColor=[UIColor lightGrayColor];
            self.nighttimeText5.text=@"";
            self.nighttimeText5.userInteractionEnabled=NO;
            self.nighttimeText5.backgroundColor=[UIColor lightGrayColor];
            self.nightworkingHours.text=@"";
            self.nightBreakTypeText.text=@"";
            self.nightBreakTypeText.userInteractionEnabled=NO;
            self.nightBreakTypeText.backgroundColor=[UIColor lightGrayColor];
            self.nightbreakDuration.text=@"";
            self.nightbreakDuration.userInteractionEnabled=NO;
            self.nightbreakDuration.backgroundColor=[UIColor lightGrayColor];
            self.nightinTimeText.text=@"";
            self.nightinTimeText.userInteractionEnabled=NO;
            self.nightinTimeText.backgroundColor=[UIColor lightGrayColor];
            self.nightoutTimeText.text=@"";
            self.nightoutTimeText.userInteractionEnabled=NO;
            self.nightoutTimeText.backgroundColor=[UIColor lightGrayColor];
            [self.nightsecondcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            [self.nightthirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.nightShiftStartTimeFlag=0;
            self.nightShiftEndTimeFlag=0;
            self.nightInTimeValue=@"0";
            self.nightOutTimeValue=@"0";
            self.j=0;
            self.k=0;

            
            
            NSString *time=[objTime timeMinimumValueSetting:self.nighttimeText1.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue] - 10];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;
            
            self.flag=12;
            self.datePickerView.frame=CGRectMake(126, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        return  NO;
    }
    if (textField==self.nighttimeText3) {
        if (self.nightShiftStartTimeFlag==1) {
            if (self.nighttimeText3.text.length > 0)
            {

                
                NSMutableArray *timeArray=[[NSMutableArray alloc]init];
                timeArray=[objTime timeInitialSettings];
                NSDate *startDate=[timeArray objectAtIndex:0];
                NSDate *endDate=[timeArray objectAtIndex:1];
                
                [self.datePicker setDatePickerMode:UIDatePickerModeTime];
                [self.datePicker setMinimumDate:startDate];
                [self.datePicker setMaximumDate:endDate];
                [self.datePicker setDate:startDate animated:YES];
                [self.datePicker reloadInputViews];

            }
            self.nighttimeText3.text=@"";
            self.nighttimeText4.text=@"";
            self.nighttimeText4.userInteractionEnabled=NO;
            self.nighttimeText4.backgroundColor=[UIColor lightGrayColor];
            self.nighttimeText5.text=@"";
            self.nighttimeText5.userInteractionEnabled=NO;
            self.nighttimeText5.backgroundColor=[UIColor lightGrayColor];
            self.nightworkingHours.text=@"";
            self.nightBreakTypeText.text=@"";
            self.nightBreakTypeText.userInteractionEnabled=NO;
            self.nightBreakTypeText.backgroundColor=[UIColor lightGrayColor];
            self.nightbreakDuration.text=@"";
            self.nightbreakDuration.userInteractionEnabled=NO;
            self.nightbreakDuration.backgroundColor=[UIColor lightGrayColor];
            self.nightinTimeText.text=@"";
            self.nightinTimeText.userInteractionEnabled=NO;
            self.nightinTimeText.backgroundColor=[UIColor lightGrayColor];
            self.nightoutTimeText.text=@"";
            self.nightoutTimeText.userInteractionEnabled=NO;
            self.nightoutTimeText.backgroundColor=[UIColor lightGrayColor];
            [self.nightsecondcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            [self.nightthirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            //self.shiftStartTimeFlag=0;
            self.nightShiftEndTimeFlag=0;
            self.nightInTimeValue=@"0";
            self.nightOutTimeValue=@"0";
            self.j=0;
            self.k=0;

        
        
            
            NSString *time=[objTime timeMinimumValueSetting:self.nighttimeText2.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
            //[components setSeconds:seconds];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;

            
            self.flag=13;
            self.datePickerView.frame=CGRectMake(258, 260, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        return  NO;
    }
    if (textField==self.nighttimeText4) {
        if ((self.nightShiftStartTimeFlag==1)&&(self.nightShiftEndTimeFlag==1)) {
           // if (self.nighttimeText5.text.length>0) {
                //self.nighttimeText5.text=@"";
            //}
            self.nighttimeText4.text=@"";
            self.nighttimeText5.text=@"";
            self.nightbreakDuration.text=@"";
            self.nighttimeText5.userInteractionEnabled=NO;
            
            
            NSString *time=[objTime timeMinimumValueSetting:self.nighttimeText2.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
            //[components setSeconds:seconds];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;
            
            
            
            
            NSString *time1=[objTime timeMinimumValueSetting:self.nighttimeText3.text];
            NSArray *timeArray1=[time1 componentsSeparatedByString:@"###"];
            
            [components setHour:[[timeArray1 objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray1 objectAtIndex:1] integerValue]-20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.maximumDate = date1;
            
            
            self.flag=14;
            self.datePickerView.frame=CGRectMake(126, 328, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        
        return  NO;
    }
    if (textField==self.nighttimeText5) {
        if (self.nightBreakBeginTimeFlag==1) {
            
            
            NSString *time=[objTime timeMinimumValueSetting:self.nighttimeText4.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.minimumDate = date;
            
            
            
            
            NSString *time1=[objTime timeMinimumValueSetting:self.nighttimeText3.text];
            NSArray *timeArray1=[time1 componentsSeparatedByString:@"###"];
            
            [components setHour:[[timeArray1 objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray1 objectAtIndex:1] integerValue]-20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker.maximumDate = date1;
            
            self.flag=15;
            self.datePickerView.frame=CGRectMake(258, 328, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
        }
        
        return  NO;
    }

    
    if ((textField==self.workingHours)||(textField==self.swingworkingHours)||(textField==self.nightworkingHours))
    {
        return NO;
    }
    if(textField==self.breakDuration)
    {
        self.breakDurationFlag=1;
        NSInteger hour=8;
        NSInteger minute=10;
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker1.date];
        [components setHour:hour];
        [components setMinute:minute+10];
        NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
        self.datePicker3.minimumDate = date;
        self.datePickerView3.frame=CGRectMake(362, 328, self.datePickerView3.frame.size.width, self.datePickerView3.frame.size.height);
        self.datePickerView3.hidden=false;
        return  NO;
    }
    if(textField==self.swingbreakDuration)
    {
        self.breakDurationFlag=2;
        self.datePickerView3.frame=CGRectMake(362, 328, self.datePickerView3.frame.size.width, self.datePickerView3.frame.size.height);
        self.datePickerView3.hidden=false;
        return  NO;
    }
    if(textField==self.nightbreakDuration)
    {
        self.breakDurationFlag=3;
        self.datePickerView3.frame=CGRectMake(362, 328, self.datePickerView3.frame.size.width, self.datePickerView3.frame.size.height);
        self.datePickerView3.hidden=false;
        return NO;
    }
    if (textField==self.inTimeText) {
        if ((self.dayShiftStartTimeFlag==1)&&(self.dayShiftEndTimeFlag==1)&&([self.firstcheck.currentImage isEqual:[UIImage imageNamed:@"check_box_tick.png"]])) {
            self.timerFlag1=1;
            if (self.outTimeText.text.length>0) {
                self.outTimeText.text=@"";
            }
            
            

            
            NSString *time=[objTime timeMinimumValueSetting:self.timeText2.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];
            
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker1.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker1.minimumDate = date;
            
            

            
            NSString *time1=[objTime timeMinimumValueSetting:self.timeText3.text];
            NSArray *timeArray1=[time1 componentsSeparatedByString:@"###"];
            
            
            [components setHour:[[timeArray1 objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray1 objectAtIndex:1] integerValue]-20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker1.maximumDate = date1;
            
            
            self.datePickerView1.frame=CGRectMake(198, 390, self.datePickerView1.frame.size.width, self.datePickerView1.frame.size.height);
            self.datePickerView1.hidden=false;
        }
        return  NO;
    }
    if (textField==self.outTimeText) {
        if ((self.dayShiftEndTimeFlag==1)&&(self.dayShiftStartTimeFlag==1)&&([self.thirdcheck.currentImage isEqual:[UIImage imageNamed:@"check_box_tick.png"]])) {
            self.timerFlag2=1;
            
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker2.date];
            if (self.inTimeText.text.length>0) {

                NSString *time=[objTime timeMinimumValueSetting:self.inTimeText.text];
                NSArray *timeArray=[time componentsSeparatedByString:@"###"];

                
                [components setHour:[[timeArray objectAtIndex:0] integerValue]];
                [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
                NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
                self.datePicker2.minimumDate = date;
            }
            else
            {

                
                NSString *time=[objTime timeMinimumValueSetting:self.timeText2.text];
                NSArray *timeArray=[time componentsSeparatedByString:@"###"];

                
                
//                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker2.date];
                [components setHour:[[timeArray objectAtIndex:0] integerValue]];
                [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
                NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
                self.datePicker2.minimumDate = date;
            }
            
            
            
            
            NSString *time=[objTime timeMinimumValueSetting:self.timeText3.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];

            
            
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]-20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker2.maximumDate = date1;
            
            
            self.datePickerView2.frame=CGRectMake(198, 420, self.datePickerView2.frame.size.width, self.datePickerView2.frame.size.height);
            self.datePickerView2.hidden=false;
        }
        return  NO;
    }
    if (textField==self.swinginTimeText) {
        if ((self.swingShiftStartTimeFlag==1)&&(self.swingShiftEndTimeFlag==1)&&([self.swingsecondcheck.currentImage isEqual:[UIImage imageNamed:@"check_box_tick.png"]])) {
            self.timerFlag1=2;
            
            if (self.swingoutTimeText.text.length>0) {
                self.swingoutTimeText.text=@"";
            }
            
            

            
            NSString *time=[objTime timeMinimumValueSetting:self.swingtimeText2.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];

            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker1.date];
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:0] integerValue]];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker1.minimumDate = date;
            
            

            
            NSString *time1=[objTime timeMinimumValueSetting:self.swingtimeText3.text];
            NSArray *timeArray1=[time1 componentsSeparatedByString:@"###"];

            
            [components setHour:[[timeArray1 objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray1 objectAtIndex:1] integerValue]-20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker1.maximumDate = date1;
            
            
            self.datePickerView1.frame=CGRectMake(198, 390, self.datePickerView1.frame.size.width, self.datePickerView1.frame.size.height);
            self.datePickerView1.hidden=false;
        }
        return  NO;
    }
    if (textField==self.swingoutTimeText) {
        if ((self.swingShiftEndTimeFlag==1)&&(self.swingShiftStartTimeFlag==1)&&([self.swingthirdcheck.currentImage isEqual:[UIImage imageNamed:@"check_box_tick.png"]])) {
            self.timerFlag2=2;
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker2.date];
            
            if (self.swinginTimeText.text.length>0) {
                
                
                NSString *time=[objTime timeMinimumValueSetting:self.swinginTimeText.text];
                NSArray *timeArray=[time componentsSeparatedByString:@"###"];

                
                //NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker2.date];
                [components setHour:[[timeArray objectAtIndex:0] integerValue]];
                [components setMinute:[[timeArray objectAtIndex:1]integerValue]];
                NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
                self.datePicker2.minimumDate = date;
            }
            else
            {

                
                NSString *time=[objTime timeMinimumValueSetting:self.swingtimeText2.text];
                NSArray *timeArray=[time componentsSeparatedByString:@"###"];

                
                
                //NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker2.date];
                [components setHour:[[timeArray objectAtIndex: 0] integerValue]];
                [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
                NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
                self.datePicker2.minimumDate = date;
            }
            
            

            
            NSString *time=[objTime timeMinimumValueSetting:self.swingtimeText3.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];

            
            [components setHour:[[timeArray objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1] integerValue]-20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker2.maximumDate = date1;
            
            
            self.datePickerView2.frame=CGRectMake(198, 420, self.datePickerView2.frame.size.width, self.datePickerView2.frame.size.height);
            self.datePickerView2.hidden=false;
        }
        return  NO;
    }
    if (textField==self.nightinTimeText) {
        if ((self.nightShiftStartTimeFlag==1)&&(self.nightShiftEndTimeFlag==1)&&([self.nightsecondcheck.currentImage isEqual:[UIImage imageNamed:@"check_box_tick.png"]])) {
            self.timerFlag1=3;
            
            if (self.nightoutTimeText.text.length>0) {
                self.nightoutTimeText.text=@"";
            }
            
            

            NSString *time=[objTime timeMinimumValueSetting:self.nighttimeText2.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];

            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker1.date];
            [components setHour:[[timeArray objectAtIndex:0]integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1]integerValue]];
            NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker1.minimumDate = date;
            
            

            
            NSString *time1=[objTime timeMinimumValueSetting:self.nighttimeText3.text];
            NSArray *timeArray1=[time1 componentsSeparatedByString:@"###"];

            
            [components setHour:[[timeArray1 objectAtIndex:0] integerValue]];
            [components setMinute:[[timeArray1 objectAtIndex:1] integerValue]-20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker1.maximumDate = date1;
            
            
            
            self.datePickerView1.frame=CGRectMake(198, 390, self.datePickerView1.frame.size.width, self.datePickerView1.frame.size.height);
            self.datePickerView1.hidden=false;
        }
        return  NO;
    }
    if (textField==self.nightoutTimeText) {
        if ((self.nightShiftEndTimeFlag==1)&&(self.nightShiftStartTimeFlag==1)&&([self.nightthirdcheck.currentImage isEqual:[UIImage imageNamed:@"check_box_tick.png"]])) {
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSIntegerMax fromDate:self.datePicker2.date];
            
            if (self.nightinTimeText.text.length>0) {
                
               
                NSString *time=[objTime timeMinimumValueSetting:self.nightinTimeText.text];
                NSArray *timeArray=[time componentsSeparatedByString:@"###"];

                
                [components setHour:[[timeArray objectAtIndex:0] integerValue]];
                [components setMinute:[[timeArray objectAtIndex:1] integerValue]];
                NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
                self.datePicker2.minimumDate = date;
            }
            else
            {
                NSString *time=[objTime timeMinimumValueSetting:self.nighttimeText2.text];
                NSArray *timeArray=[time componentsSeparatedByString:@"###"];

                [components setHour:[[timeArray objectAtIndex:0]integerValue]];
                [components setMinute:[[timeArray objectAtIndex:1]integerValue]];
                NSDate *date= [[NSCalendar currentCalendar] dateFromComponents:components];
                self.datePicker2.minimumDate = date;
            }
            
            NSString *time=[objTime timeMinimumValueSetting:self.nighttimeText3.text];
            NSArray *timeArray=[time componentsSeparatedByString:@"###"];

            [components setHour:[[timeArray objectAtIndex:0]integerValue]];
            [components setMinute:[[timeArray objectAtIndex:1]integerValue]-20];
            NSDate *date1= [[NSCalendar currentCalendar] dateFromComponents:components];
            self.datePicker2.maximumDate = date1;
            
            
            self.timerFlag2=3;
            self.datePickerView2.frame=CGRectMake(198, 420, self.datePickerView2.frame.size.width, self.datePickerView2.frame.size.height);
            self.datePickerView2.hidden=false;
        }
        return  NO;
    }
    if (textField==self.shiftTypeText) {
        self.shiftTypetableView.hidden=false;
        return  NO;
    }
    if (textField==self.dayBreakTypeText) {
        self.dayBreakTypeTC.hidden=false;
        self.datePickerView.hidden=TRUE;
        return  NO;
    }
    if (textField==self.swingBreakTypeText) {
        self.swingBreakTypeTC.hidden=false;
        self.datePickerView.hidden=TRUE;
        return  NO;
    }
    if (textField==self.nightBreakTypeText) {
        self.nightBreakTypeTC.hidden=false;
        self.datePickerView.hidden=TRUE;
        return  NO;
    }
    else
        return YES;
}
-(IBAction)doneTimerAction1:(id)sender
{
    NSDate *myDate = self.datePicker1.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm a"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    if (self.timerFlag1==1) {
        self.inTimeText.text=prettyVersion;

    }
    else if (self.timerFlag1==2)
    {
        self.swinginTimeText.text=prettyVersion;
    }
    else if (self.timerFlag1==3)
    {
        self.nightinTimeText.text=prettyVersion;
    }
    self.datePickerView1.hidden=true;

}
-(IBAction)doneTimerAction2:(id)sender
{
    NSDate *myDate = self.datePicker2.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm a"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    if (self.timerFlag2==1) {
        self.outTimeText.text=prettyVersion;

    }
    else if (self.timerFlag2==2)
    {
        self.swingoutTimeText.text=prettyVersion;
    }
    else if (self.timerFlag2==3)
    {
        self.nightoutTimeText.text=prettyVersion;
    }
    self.datePickerView2.hidden=true;
    
}
-(IBAction)doneTimerAction3:(id)sender
{
    NSDate *myDate = self.datePicker3.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH :mm"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    NSArray *timeArray=[prettyVersion componentsSeparatedByString:@":"];
    NSString *selectedTime=[NSString stringWithFormat:@"%@Hrs %@ Mins",[timeArray objectAtIndex:0],[timeArray objectAtIndex:1]];
    if (self.breakDurationFlag==1) {
        self.breakDuration.text=selectedTime;
    }
    else if (self.breakDurationFlag==2)
    {
        self.swingbreakDuration.text=selectedTime;
    }
    else
        self.nightbreakDuration.text=selectedTime;
    self.datePickerView3.hidden=true;
}

-(IBAction)doneTimerAction:(id)sender
{
    NSDate *myDate = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm a"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    if (self.flag==1) {
        self.timeText1.text=prettyVersion;
        self.timeText2.backgroundColor=[UIColor clearColor];
        self.timeText2.userInteractionEnabled=YES;
        self.dayPunchStartTimeFlag=1;
    }
    if (self.flag==2) {
        self.timeText2.text=prettyVersion;
        self.timeText3.backgroundColor=[UIColor clearColor];
        self.timeText3.userInteractionEnabled=YES;
        self.dayShiftStartTimeFlag=1;
    }
    if (self.flag==3) {
        self.timeText3.text=prettyVersion;
        self.dayShiftEndTimeFlag=1;
        self.timeText4.backgroundColor=[UIColor clearColor];
        self.timeText4.userInteractionEnabled=YES;
        
        
        self.dayBreakTypeText.text=@"Fixed Break";
        self.dayBreakTypeText.userInteractionEnabled=YES;
        self.dayBreakTypeText.backgroundColor=[UIColor clearColor];
        NSDateFormatter *df=[[NSDateFormatter alloc] init];
        // Set the date format according to your needs
        [df setDateFormat:@"hh:mm a"]; //for 12 hour format
        //[df setDateFormat:@"MM/dd/YYYY HH:mm "]  // for 24 hour format
        NSDate *date1 = [df dateFromString:self.timeText2.text];
        NSDate *date2 = [df dateFromString:self.timeText3.text];
        int timeDiff=[date2 timeIntervalSinceDate:date1];
        int hours=timeDiff/3600;
        float remainder=timeDiff%3600;
        remainder=remainder/60;
        
        NSLog(@"%i",hours);
        NSLog(@"%f",remainder);
        if (hours>1) {
            self.workingHours.text=[NSString stringWithFormat:@"%i Hrs %.f Mins",hours,remainder];
        }
        else
            self.workingHours.text=[NSString stringWithFormat:@"%i Hr %.f Mins",hours,remainder];
        
    }
    if (self.flag==4) {
        self.timeText4.text=prettyVersion;
        self.timeText5.backgroundColor=[UIColor clearColor];
        self.timeText5.userInteractionEnabled=true;
        self.dayBreakBeginTimeFlag=1;
    }
    if (self.flag==5) {
        self.timeText5.text=prettyVersion;
        
        
        NSDateFormatter *df=[[NSDateFormatter alloc] init];
        // Set the date format according to your needs
        [df setDateFormat:@"hh:mm a"]; //for 12 hour format
        //[df setDateFormat:@"MM/dd/YYYY HH:mm "]  // for 24 hour format
        NSDate *date1 = [df dateFromString:self.timeText4.text];
        NSDate *date2 = [df dateFromString:self.timeText5.text];
        int timeDiff=[date2 timeIntervalSinceDate:date1];
        int hours=timeDiff/3600;
        float remainder=timeDiff%3600;
        remainder=remainder/60;
        
        NSLog(@"%i",hours);
        NSLog(@"%f",remainder);
        if (hours>1) {
            self.breakDuration.text=[NSString stringWithFormat:@"%i Hrs %.f Mins",hours,remainder];
        }
        else
            self.breakDuration.text=[NSString stringWithFormat:@"%i Hr %.f Mins",hours,remainder];
        
        
    }
    if (self.flag==6) {
        self.swingPunchStartTimeFlag=1;
        self.swingtimeText2.backgroundColor=[UIColor clearColor];
        self.swingtimeText2.userInteractionEnabled=YES;
        self.swingtimeText1.text=prettyVersion;
    }
    if (self.flag==7) {
        self.swingtimeText2.text=prettyVersion;
        self.swingtimeText3.userInteractionEnabled=YES;
        self.swingtimeText3.backgroundColor=[UIColor clearColor];
        self.swingShiftStartTimeFlag=1;
            }
    if (self.flag==8) {
        self.swingtimeText3.text=prettyVersion;
        self.swingShiftEndTimeFlag=1;
        self.swingtimeText4.userInteractionEnabled=YES;
        self.swingtimeText4.backgroundColor=[UIColor clearColor];
        self.swingBreakTypeText.text=@"Fixed Break";
        self.swingBreakTypeText.backgroundColor=[UIColor clearColor];
        self.swingBreakTypeText.userInteractionEnabled=YES;
        NSDateFormatter *df=[[NSDateFormatter alloc] init];
        // Set the date format according to your needs
        [df setDateFormat:@"hh:mm a"]; //for 12 hour format
        //[df setDateFormat:@"MM/dd/YYYY HH:mm "]  // for 24 hour format
        NSDate *date1 = [df dateFromString:self.swingtimeText2.text];
        NSDate *date2 = [df dateFromString:self.swingtimeText3.text];
        int timeDiff=[date2 timeIntervalSinceDate:date1];
        int hours=timeDiff/3600;
        float remainder=timeDiff%3600;
        remainder=remainder/60;
        
        NSLog(@"%i",hours);
        NSLog(@"%f",remainder);
        if (hours>1) {
            self.swingworkingHours.text=[NSString stringWithFormat:@"%i Hrs %.f Mins",hours,remainder];
        }
        else
            self.swingworkingHours.text=[NSString stringWithFormat:@"%i Hr %.f Mins",hours,remainder];
        
    }
    if (self.flag==9) {
        self.swingtimeText4.text=prettyVersion;
        self.swingtimeText5.userInteractionEnabled=YES;
        self.swingtimeText5.backgroundColor=[UIColor clearColor];
        self.swingBreakBeginTimeFlag=1;
    }
    if (self.flag==10) {
        self.swingtimeText5.text=prettyVersion;
        
        NSDateFormatter *df=[[NSDateFormatter alloc] init];
        // Set the date format according to your needs
        [df setDateFormat:@"hh:mm a"]; //for 12 hour format
        //[df setDateFormat:@"MM/dd/YYYY HH:mm "]  // for 24 hour format
        NSDate *date1 = [df dateFromString:self.swingtimeText4.text];
        NSDate *date2 = [df dateFromString:self.swingtimeText5.text];
        int timeDiff=[date2 timeIntervalSinceDate:date1];
        int hours=timeDiff/3600;
        float remainder=timeDiff%3600;
        remainder=remainder/60;
        
        NSLog(@"%i",hours);
        NSLog(@"%f",remainder);
        if (hours>1) {
            self.swingbreakDuration.text=[NSString stringWithFormat:@"%i Hrs %.f Mins",hours,remainder];
        }
        else
            self.swingbreakDuration.text=[NSString stringWithFormat:@"%i Hr %.f Mins",hours,remainder];
    }
    if (self.flag==11) {
        self.nightPunchStartTimeFlag=1;
        self.nighttimeText2.userInteractionEnabled=YES;
        self.nighttimeText2.backgroundColor=[UIColor clearColor];
        self.nighttimeText1.text=prettyVersion;
    }
    if (self.flag==12) {
        self.nighttimeText2.text=prettyVersion;
        self.nighttimeText3.userInteractionEnabled=YES;
        self.nighttimeText3.backgroundColor=[UIColor clearColor];
        self.nightShiftStartTimeFlag=1;
    }
    if (self.flag==13) {
        self.nighttimeText3.text=prettyVersion;
        self.nightShiftEndTimeFlag=1;
        self.nighttimeText4.userInteractionEnabled=YES;
        self.nighttimeText4.backgroundColor=[UIColor clearColor];
        self.nightBreakTypeText.text=@"Fixed Break";
        self.nightBreakTypeText.userInteractionEnabled=YES;
        self.nightBreakTypeText.backgroundColor=[UIColor clearColor];
        
        NSDateFormatter *df=[[NSDateFormatter alloc] init];
        // Set the date format according to your needs
        [df setDateFormat:@"hh:mm a"]; //for 12 hour format
        //[df setDateFormat:@"MM/dd/YYYY HH:mm "]  // for 24 hour format
        NSDate *date1 = [df dateFromString:self.nighttimeText2.text];
        NSDate *date2 = [df dateFromString:self.nighttimeText3.text];
        int timeDiff=[date2 timeIntervalSinceDate:date1];
        int hours=timeDiff/3600;
        float remainder=timeDiff%3600;
        remainder=remainder/60;
        
        NSLog(@"%i",hours);
        NSLog(@"%f",remainder);
        if (hours>1) {
            self.nightworkingHours.text=[NSString stringWithFormat:@"%i Hrs %.f Mins",hours,remainder];
        }
        else
            self.nightworkingHours.text=[NSString stringWithFormat:@"%i Hr %.f Mins",hours,remainder];
    }
    if (self.flag==14) {
        self.nightBreakBeginTimeFlag=1;
        self.nighttimeText5.backgroundColor=[UIColor clearColor];
        self.nighttimeText5.userInteractionEnabled=true;
        self.nighttimeText4.text=prettyVersion;
    }
    if (self.flag==15) {
        self.nighttimeText5.text=prettyVersion;
        
        
        NSDateFormatter *df=[[NSDateFormatter alloc] init];
        // Set the date format according to your needs
        [df setDateFormat:@"hh:mm a"]; //for 12 hour format
        //[df setDateFormat:@"MM/dd/YYYY HH:mm "]  // for 24 hour format
        NSDate *date1 = [df dateFromString:self.nighttimeText4.text];
        NSDate *date2 = [df dateFromString:self.nighttimeText5.text];
        int timeDiff=[date2 timeIntervalSinceDate:date1];
        int hours=timeDiff/3600;
        float remainder=timeDiff%3600;
        remainder=remainder/60;
        
        NSLog(@"%i",hours);
        NSLog(@"%f",remainder);
        if (hours>1) {
            self.nightbreakDuration.text=[NSString stringWithFormat:@"%i Hrs %.f Mins",hours,remainder];
        }
        else
            self.nightbreakDuration.text=[NSString stringWithFormat:@"%i Hr %.f Mins",hours,remainder];
        
    }
    self.datePickerView.hidden=TRUE;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string

{
    if (textField==self.abbrbText) {
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
        }
        else
        {
            return  NO;
        }
        
    }
    else if (textField==self.shiftNameText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=44) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz"];
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
        {
            return  NO;
        }
    }
    else
    {
        return YES;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    if (textView==self.shiftDescription) {
        if ([text isEqualToString:@""]) {
            return YES;
        }
        if (textView.text.length<=80) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
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

-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Error"
                               message:[NSString stringWithFormat:@"%@",errorMessage]
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
-(void)initiallyShiftRuleViewResponse:(NSMutableArray *)shiftRulesArray
{
    if ([shiftRulesArray count]>0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            attendancesettingsviewclass *ob = (attendancesettingsviewclass *)self.superview.superview;
        
            [ob savedShiftsArray:shiftRulesArray];
        
            [self removeFromSuperview];
        });
        
        
    }
}
-(void)updateruleviewresponse:(id)updateruleData
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.grouparray removeAllObjects];
        [self.groupIDarray removeAllObjects];
        
        //NSMutableArray *updaterulearray=[updateruleDict objectForKey:@"shift_details"];
//        NSMutableArray *designationArray=[updateruleDict objectForKey:@"designationArray"];
//        for (int i=0; i<designationArray.count; i++) {
//            NSMutableDictionary *tempDict=[designationArray objectAtIndex:i];
//            [self.groupIDarray addObject:[tempDict objectForKey:@"designation_id"]];
//            [self.grouparray addObject:[tempDict objectForKey:@"designation_name"]];
//        }
        
        
        
//        NSString *mystring=[[updateruleData objectAtIndex:0]objectForKey:@"desi_details"];
//        if (!([mystring isEqualToString:@""])) {
//            NSArray *desigArray=[mystring componentsSeparatedByString:@"###"];
//            [self.grouparray addObjectsFromArray:desigArray];
//            [self.mycollectionview reloadData];
//            
//        }
        
        
        
        NSString *mystring=[[updateruleData objectAtIndex:0]objectForKey:@"desi_details"];
        
        if ([[updateruleData objectAtIndex:0]objectForKey:@"desi_details"]!=(id)[NSNull null])
        {
            NSArray *desigArray=[mystring componentsSeparatedByString:@"###"];
            [self.grouparray addObjectsFromArray:desigArray];
            [self.mycollectionview reloadData];
            
        }

        
        
        NSMutableDictionary *selectedDict=[updateruleData objectAtIndex:0];
        self.shiftNameText.text=[selectedDict objectForKey:@"shift_name"];
        self.abbrbText.text=[selectedDict objectForKey:@"shift_abbrv"];
        self.shiftTypeText.text=[selectedDict objectForKey:@"shift_type"];
        //dispatch_sync(dispatch_get_main_queue(), ^{
            self.shiftDescription.text=[selectedDict objectForKey:@"shift_description"];
        //});
    
        self.timeText1.text=[selectedDict objectForKey:@"day_punch_start"];
        if (self.timeText1.text.length>0) {
            self.timeText2.backgroundColor=[UIColor clearColor];
            self.timeText2.userInteractionEnabled=YES;
            self.dayPunchStartTimeFlag=1;
        }
        self.timeText2.text=[selectedDict objectForKey:@"day_shift_start"];
        if (self.timeText2.text.length>0) {
            self.timeText3.backgroundColor=[UIColor clearColor];
            self.dayShiftStartTimeFlag=1;
            
        }
        self.timeText3.text=[selectedDict objectForKey:@"day_shift_end"];
        if (self.timeText3.text.length>0) {
            self.timeText4.backgroundColor=[UIColor clearColor];
            self.dayShiftEndTimeFlag=1;
            self.dayBreakTypeText.userInteractionEnabled=YES;
        }
        self.workingHours.text=[selectedDict objectForKey:@"day_working_hours"];
        self.dayBreakTypeText.text=[selectedDict objectForKey:@"day_break_type"];
        self.timeText4.text=[selectedDict objectForKey:@"day_break_begin"];
        if (self.timeText4.text.length>0) {
            self.timeText5.backgroundColor=[UIColor clearColor];
            self.breakDuration.backgroundColor=[UIColor lightGrayColor];
        }
        else
        {
            self.breakDuration.backgroundColor=[UIColor clearColor];
            self.timeText4.backgroundColor=[UIColor lightGrayColor];
            self.timeText5.backgroundColor=[UIColor lightGrayColor];
        }
        self.timeText5.text=[selectedDict objectForKey:@"day_break_end"];
        self.breakDuration.text=[selectedDict objectForKey:@"day_break_duration"];
        if ([[selectedDict objectForKey:@"day_intime_chekbox"]isEqualToString:@"1"]) {
            [self.firstcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.x=1;
            self.dayInTimeValue=@"1";
            self.inTimeText.backgroundColor=[UIColor clearColor];
        }
        else
        {
            [self.firstcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        }
        self.inTimeText.text=[selectedDict objectForKey:@"day_intime_value"];
    
        if ([[selectedDict objectForKey:@"day_outtime_checkbox"]isEqualToString:@"1"]) {
            [self.thirdcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.outTimeText.backgroundColor=[UIColor clearColor];
            self.z=1;
            self.dayOutTimeValue=@"1";
        }
        else
        {
            [self.thirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        }
        self.outTimeText.text=[selectedDict objectForKey:@"day_outtime_value"];
        
    
    
        self.swingtimeText1.text=[selectedDict objectForKey:@"swing_punch_start"];
        if (self.swingtimeText1.text.length>0) {
            self.swingtimeText2.backgroundColor=[UIColor clearColor];
            self.swingPunchStartTimeFlag=1;
        }
        self.swingtimeText2.text=[selectedDict objectForKey:@"swing_shift_start"];
        if (self.swingtimeText2.text.length>0) {
            self.swingtimeText3.backgroundColor=[UIColor clearColor];
            self.swingShiftStartTimeFlag=1;
        }
        self.swingtimeText3.text=[selectedDict objectForKey:@"swing_shift_end"];
        if (self.swingtimeText3.text.length>0) {
            self.swingtimeText4.backgroundColor=[UIColor clearColor];
            self.swingShiftEndTimeFlag=1;
            self.swingBreakTypeText.userInteractionEnabled=YES;
        }
        self.swingworkingHours.text=[selectedDict objectForKey:@"swing_working_hours"];
        self.swingBreakTypeText.text=[selectedDict objectForKey:@"swing_break_type"];
        self.swingtimeText4.text=[selectedDict objectForKey:@"swing_break_begin"];
        if (self.swingtimeText4.text.length>0) {
            self.swingtimeText5.backgroundColor=[UIColor clearColor];
            self.swingbreakDuration.backgroundColor=[UIColor lightGrayColor];
        }
        else
        {
            self.swingbreakDuration.backgroundColor=[UIColor clearColor];
            self.swingtimeText4.backgroundColor=[UIColor lightGrayColor];
            self.swingtimeText5.backgroundColor=[UIColor lightGrayColor];
        }

        self.swingtimeText5.text=[selectedDict objectForKey:@"swing_break_end"];
        self.swingbreakDuration.text=[selectedDict objectForKey:@"swing_break_duration"];
        if ([[selectedDict objectForKey:@"swing_inttime_checkbox"]isEqualToString:@"1"]) {
            [self.swingsecondcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.swinginTimeText.backgroundColor=[UIColor clearColor];
            self.q=1;
            self.swingInTimeValue=@"1";

        }
        else
        {
            [self.swingsecondcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        }
        self.swinginTimeText.text=[selectedDict objectForKey:@"swing_intime_value"];
    
        if ([[selectedDict objectForKey:@"swing_outtime_checkbox"]isEqualToString:@"1"]) {
            [self.swingthirdcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.swingoutTimeText.backgroundColor=[UIColor clearColor];
            self.r=1;
            self.swingOutTimeValue=@"1";

        }
        else
        {
            [self.swingthirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        }
        self.swingoutTimeText.text=[selectedDict objectForKey:@"swing_outtime_value"];
    
    
    
    
        self.nighttimeText1.text=[selectedDict objectForKey:@"night_punch_start"];
        if (self.nighttimeText1.text.length>0) {
            self.nighttimeText2.backgroundColor=[UIColor clearColor];
            self.nightPunchStartTimeFlag=1;
        }
        self.nighttimeText2.text=[selectedDict objectForKey:@"night_shift_start"];
        if (self.nighttimeText2.text.length>0) {
            self.nighttimeText3.backgroundColor=[UIColor clearColor];
            self.nightShiftStartTimeFlag=1;
        }
        self.nighttimeText3.text=[selectedDict objectForKey:@"night_shift_end"];
        if (self.nighttimeText3.text.length>0) {
            self.nighttimeText4.backgroundColor=[UIColor clearColor];
            self.nightShiftEndTimeFlag=1;
            self.nightBreakTypeText.userInteractionEnabled=YES;
        }
        self.nightworkingHours.text=[selectedDict objectForKey:@"night_working_hours"];
        self.nightBreakTypeText.text=[selectedDict objectForKey:@"night_break_type"];
        self.nighttimeText4.text=[selectedDict objectForKey:@"night_break_begin"];
        if (self.nighttimeText4.text.length>0) {
            self.nighttimeText5.backgroundColor=[UIColor clearColor];
            self.nightbreakDuration.backgroundColor=[UIColor lightGrayColor];
        }
        else
        {
            self.nightbreakDuration.backgroundColor=[UIColor clearColor];
            self.nighttimeText4.backgroundColor=[UIColor lightGrayColor];
            self.nighttimeText5.backgroundColor=[UIColor lightGrayColor];
        }

        self.nighttimeText5.text=[selectedDict objectForKey:@"night_break_end"];
        self.nightbreakDuration.text=[selectedDict objectForKey:@"night_break_duration"];
        
        if ([[selectedDict objectForKey:@"night_intime_checkbox"]isEqualToString:@"1"]) {
            [self.nightsecondcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.nightinTimeText.backgroundColor=[UIColor clearColor];
            self.j=1;
            self.nightInTimeValue=@"1";
        }
        else
        {
            [self.nightsecondcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:   UIControlStateNormal];
        }
        self.nightinTimeText.text=[selectedDict objectForKey:@"night_intime_value"];
    
        if ([[selectedDict objectForKey:@"night_outtime_checkbox"]isEqualToString:@"1"]) {
            [self.nightthirdcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.nightoutTimeText.backgroundColor=[UIColor clearColor];
            self.k=1;
            self.nightOutTimeValue=@"1";
        }
        else
        {
            [self.nightthirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        }
        self.nightoutTimeText.text=[selectedDict objectForKey:@"night_outtime_value"];
        self.mycollectionview.hidden=false;
        [self.mycollectionview reloadData];
        
        [objApp hudStop];
        
        
    });
}

-(void)resetDayShift
{
    self.timeText1.text=@"";
    self.timeText2.text=@"";
    self.timeText2.backgroundColor=[UIColor lightGrayColor];
    self.timeText2.userInteractionEnabled=NO;
    self.timeText3.text=@"";
    self.timeText3.backgroundColor=[UIColor lightGrayColor];
    self.timeText3.userInteractionEnabled=NO;
    self.timeText4.text=@"";
    self.timeText4.backgroundColor=[UIColor lightGrayColor];
    self.timeText4.userInteractionEnabled=NO;
    self.timeText5.text=@"";
    self.timeText5.backgroundColor=[UIColor lightGrayColor];
    self.timeText5.userInteractionEnabled=NO;
    self.inTimeText.text=@"";
    self.inTimeText.backgroundColor=[UIColor lightGrayColor];
    self.inTimeText.userInteractionEnabled=NO;
    self.outTimeText.text=@"";
    self.outTimeText.backgroundColor=[UIColor lightGrayColor];
    self.outTimeText.userInteractionEnabled=NO;
    self.workingHours.text=@"";
    self.breakDuration.text=@"";
    self.breakDuration.userInteractionEnabled=NO;
    self.breakDuration. backgroundColor=[UIColor lightGrayColor];
    self.dayBreakTypeText.userInteractionEnabled=NO;
    self.dayShiftStartTimeFlag=0;
    self.dayShiftEndTimeFlag=0;
    [self.firstcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
    [self.thirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
    self.datePickerView.hidden=true;
    self.datePickerView1.hidden=true;
    self.datePickerView2.hidden=true;
    self.dayInTimeValue=@"0";
    self.dayOutTimeValue=@"0";
}
-(void)resetSwingShift
{
    self.swingtimeText1.text=@"";
    self.swingtimeText2.text=@"";
    self.swingtimeText2.backgroundColor=[UIColor lightGrayColor];
    self.swingtimeText2.userInteractionEnabled=NO;
    self.swingtimeText3.text=@"";
    self.swingtimeText3.backgroundColor=[UIColor lightGrayColor];
    self.swingtimeText3.userInteractionEnabled=NO;
    self.swingtimeText4.text=@"";
    self.swingtimeText4.backgroundColor=[UIColor lightGrayColor];
    self.swingtimeText4.userInteractionEnabled=NO;
    self.swingtimeText5.text=@"";
    self.swingtimeText5.backgroundColor=[UIColor lightGrayColor];
    self.swingtimeText5.userInteractionEnabled=NO;
    self.swinginTimeText.text=@"";
    self.swinginTimeText.backgroundColor=[UIColor lightGrayColor];
    self.swinginTimeText.userInteractionEnabled=NO;
    self.swingoutTimeText.text=@"";
    self.swingoutTimeText.backgroundColor=[UIColor lightGrayColor];
    self.swingoutTimeText.userInteractionEnabled=NO;
    self.swingworkingHours.text=@"";
    self.swingbreakDuration.text=@"";
    self.swingbreakDuration.userInteractionEnabled=NO;
    self.swingbreakDuration.backgroundColor=[UIColor lightGrayColor];
    self.swingBreakTypeText.userInteractionEnabled=NO;
    self.swingShiftStartTimeFlag=0;
    self.swingShiftEndTimeFlag=0;
    [self.swingsecondcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
    [self.swingthirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
    self.datePickerView.hidden=true;
    self.datePickerView1.hidden=true;
    self.datePickerView2.hidden=true;
    self.swingInTimeValue=@"0";
    self.swingOutTimeValue=@"0";
}
-(void)resetNightShift
{
    self.nighttimeText1.text=@"";
    self.nighttimeText2.text=@"";
    self.nighttimeText2.backgroundColor=[UIColor lightGrayColor];
    self.nighttimeText2.userInteractionEnabled=NO;
    self.nighttimeText3.text=@"";
    self.nighttimeText3.backgroundColor=[UIColor lightGrayColor];
    self.nighttimeText3.userInteractionEnabled=NO;
    self.nighttimeText4.text=@"";
    self.nighttimeText4.backgroundColor=[UIColor lightGrayColor];
    self.nighttimeText4.userInteractionEnabled=NO;
    self.nighttimeText5.text=@"";
    self.nighttimeText5.backgroundColor=[UIColor lightGrayColor];
    self.nighttimeText5.userInteractionEnabled=NO;
    self.nightinTimeText.text=@"";
    self.nightinTimeText.backgroundColor=[UIColor lightGrayColor];
    self.nightinTimeText.userInteractionEnabled=NO;
    self.nightoutTimeText.text=@"";
    self.nightoutTimeText.backgroundColor=[UIColor lightGrayColor];
    self.nightoutTimeText.userInteractionEnabled=NO;
    self.nightworkingHours.text=@"";
    self.nightbreakDuration.text=@"";
    self.nightbreakDuration.userInteractionEnabled=NO;
    self.nightbreakDuration.backgroundColor=[UIColor lightGrayColor];
    self.nightBreakTypeText.userInteractionEnabled=NO;
    self.nightShiftStartTimeFlag=0;
    self.nightShiftEndTimeFlag=0;
    [self.nightsecondcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
    [self.nightthirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
    self.datePickerView.hidden=true;
    self.datePickerView1.hidden=true;
    self.datePickerView2.hidden=true;
    self.nightInTimeValue=@"0";
    self.nightOutTimeValue=@"0";
}
-(void)dayShiftInTimeCheckBoxAction
{
    if (self.x%2==0) {
        [self.firstcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
        self.inTimeText.userInteractionEnabled=YES;
        self.inTimeText.backgroundColor=[UIColor clearColor];
        self.x++;
        self.dayInTimeValue=@"1";
       // [self checkBoxDoneDisableAction];
    }
    else
    {
        [self.firstcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        self.inTimeText.userInteractionEnabled=NO;
        self.inTimeText.backgroundColor=[UIColor lightGrayColor];
        self.x++;
        self.inTimeText.text=@"";
        self.dayInTimeValue=@"0";
        self.datePickerView1.hidden=TRUE;
    }
}
-(void)dayShiftOutTimeCheckBoxAction
{
    if (self.z%2==0) {
        [self.thirdcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
        self.outTimeText.userInteractionEnabled=YES;
        self.outTimeText.backgroundColor=[UIColor clearColor];
        self.z++;
        self.dayOutTimeValue=@"1";
        //[self checkBoxDoneDisableAction];
    }
    else
    {
        [self.thirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        self.outTimeText.userInteractionEnabled=NO;
        self.outTimeText.backgroundColor=[UIColor lightGrayColor];
        self.z++;
        self.outTimeText.text=@"";
        self.dayOutTimeValue=@"0";
        self.datePickerView2.hidden=TRUE;
    }
}
-(void)swingShiftInTimeCheckBoxAction
{
    if (self.q%2==0) {
        [self.swingsecondcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
        self.swinginTimeText.userInteractionEnabled=YES;
        self.swinginTimeText.backgroundColor=[UIColor clearColor];
        self.q++;
        self.swingInTimeValue=@"1";
       // [self checkBoxDoneDisableAction];
    }
    else
    {
        [self.swingsecondcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        self.swinginTimeText.userInteractionEnabled=NO;
        self.swinginTimeText.backgroundColor=[UIColor lightGrayColor];
        self.swinginTimeText.text=@"";
        self.swingInTimeValue=@"0";
        self.q++;
        self.datePickerView1.hidden=TRUE;
    }

}
-(void)swingShiftOutTimeCheckBoxAction
{
    if (self.r%2==0) {
        [self.swingthirdcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
        self.swingoutTimeText.userInteractionEnabled=YES;
        self.swingoutTimeText.backgroundColor=[UIColor clearColor];
        self.r++;
        self.swingOutTimeValue=@"1";
       // [self checkBoxDoneDisableAction];
    }
    else
    {
        [self.swingthirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        self.swingoutTimeText.userInteractionEnabled=NO;
        self.swingoutTimeText.backgroundColor=[UIColor lightGrayColor];
        self.swingoutTimeText.text=@"";
        self.swingOutTimeValue=@"0";
        self.r++;
        self.datePickerView2.hidden=TRUE;
    }
}
-(void)nightShiftInTimeCheckBoxAction
{
    if (self.j%2==0) {
        [self.nightsecondcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
        self.nightinTimeText.userInteractionEnabled=YES;
        self.nightinTimeText.backgroundColor=[UIColor clearColor];
        self.j++;
        self.nightInTimeValue=@"1";
       // [self checkBoxDoneDisableAction];
    }
    else
    {
        [self.nightsecondcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        self.nightinTimeText.userInteractionEnabled=NO;
        self.nightinTimeText.backgroundColor=[UIColor lightGrayColor];
        self.nightinTimeText.text=@"";
        self.j++;
        self.nightInTimeValue=@"0";
        self.datePickerView1.hidden=TRUE;
    }

}
-(void)nightShiftOutTimeCheckBoxAction
{
    if (self.k%2==0) {
        [self.nightthirdcheck setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
        self.nightoutTimeText.userInteractionEnabled=YES;
        self.nightoutTimeText.backgroundColor=[UIColor clearColor];
        self.k++;
        self.nightOutTimeValue=@"1";
        //[self checkBoxDoneDisableAction];
    }
    else
    {
        [self.nightthirdcheck setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        self.nightoutTimeText.userInteractionEnabled=NO;
        self.nightoutTimeText.backgroundColor=[UIColor lightGrayColor];
        self.nightoutTimeText.text=@"";
        self.nightOutTimeValue=@"0";
        self.k++;
        self.datePickerView2.hidden=TRUE;
    }
}
-(void)alertViewAction
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warnings"
                               message:@"Please enter the Mandatory Fields"
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
//-(void)checkBoxDoneDisableAction
//{
//    
//    if ([self.dayInTimeValue isEqualToString:@"1"])  {
//        if (self.inTimeText.text.length > 0) {
//            self.doneButton.enabled=YES;
//            
//        }
//        else
//        {
//            self.doneButton.enabled=NO;
//        }
//    }
//    
//    if ([self.dayOutTimeValue isEqualToString:@"1"])  {
//        if (self.outTimeText.text.length > 0) {
//            self.doneButton.enabled=YES;
//        }
//        else
//        {
//            self.doneButton.enabled=NO;
//        }
//    }
//    if ([self.swingInTimeValue isEqualToString:@"1"])  {
//        if (self.swinginTimeText.text.length > 0) {
//            self.doneButton.enabled=YES;
//        }
//        else
//        {
//            self.doneButton.enabled=NO;
//        }
//    }
//    if ([self.swingOutTimeValue isEqualToString:@"1"])  {
//        if (self.swingoutTimeText.text.length > 0) {
//            self.doneButton.enabled=YES;
//        }
//        else
//        {
//            self.doneButton.enabled=NO;
//        }
//    }
//    if ([self.nightInTimeValue isEqualToString:@"1"])  {
//        if (self.nightinTimeText.text.length > 0) {
//            self.doneButton.enabled=YES;
//        }
//        else
//        {
//            self.doneButton.enabled=NO;
//        }
//    }
//    if ([self.nightOutTimeValue isEqualToString:@"1"])  {
//        if (self.nightoutTimeText.text.length > 0) {
//            self.doneButton.enabled=YES;
//        }
//        else
//        {
//            self.doneButton.enabled=NO;
//        }
//    }
//}
@end
