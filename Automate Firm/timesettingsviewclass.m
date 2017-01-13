//
//  timesettingsviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 21/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "timesettingsviewclass.h"
#import "groupcollceioncellclass.h"
#import "attendancesettingsviewclass.h"
#import "settingsViewController.h"
@implementation timesettingsviewclass
@synthesize indexpath,ServiceStr;
-(void)awakeFromNib
{
    
    
    self.myconnection=[[connectionclass alloc] init];
    self.myconnection.mydelegate=self;
    
    appObj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    objTime=[[timeConditionsClass alloc]init];

    NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:@"Timeaction"];
    if ([str isEqualToString:@"update"]) {
        [self.myconnection updatesettingsviewrule:[[NSUserDefaults standardUserDefaults]objectForKey:@"timeruleid"] : [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];
        [appObj hudStart:self];
    }
    
    ServiceStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"Timeaction" ];
    
    [self.mycollectionview registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
    
    self.grouparray=[[NSMutableArray alloc] init];
    self.numberArray=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    self.weekSelectionArray=[[NSMutableArray alloc] initWithObjects:@"Week",@"Month",nil];
    self.halfdaySelectionArray=[[NSMutableArray alloc] initWithObjects:@"Leave",@"Half Day",nil];
    self.groupIDArray=[[NSMutableArray alloc]init];
    self.graceTimeText.backgroundColor=[UIColor lightGrayColor];
    self.x=0;
    self.y=0;self.z=0;
    self.a=0;self.b=0;self.c=0;
    self.d=0;self.e=0;self.p=0;self.q=0;
    self.r=0;self.flag=0;self.flagValue=0;
    
    self.workingText1.tag=1;
    
    self.mycollectionview.hidden=TRUE;
    self.datePickerView.hidden=TRUE;
    self.weekSelectionTC.hidden=true;
    self.halfDaySelectionTC.hidden=true;
    self.daySelectionTC.hidden=true;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    //For service
    self.workhoursfirstcheckbuttonvalue  = @"1";
    self.workhoursecondcheckbuttonvalue = @"1";
    self.workhoursthirdcheckbuttonvalue  = @"1";
    self.workhoursfourthcheckbuttonvalue  = @"1";
    self.workhoursfifthcheckbuttonvalue  = @"0";
    self.latearrivalvalueoption=@"3";
    self.workingdetailsfirstcheckbuttonvalue=@"0";
    self.workingdetailssecondcheckbuttonvalue=@"0";
    self.workingdetailsthirdcheckbuttonvalue=@"0";
    self.penaltyfirstcheckbuttonvalue=@"1";
    self.penaltysecondcheckbuttonvalue=@"1";
    self.penaltythirdcheckbuttonvalue=@"1";
    self.gracetimecheckbuttonvalue=@"0";
    self.graceTimeValue=@"";
    self.workingDetailsValue=@"";
    self.graceManadtory.hidden=true;
    self.workingHourMandatory.hidden=true;
    self.latearrivalWeekText.enabled=NO;
    self.latearrivalhalfdayText.enabled=NO;
    self.latearrivalDayText.enabled=NO;
}
-(IBAction)groupselectionaction:(id)sender
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"grouppopupview" owner:self options:nil];
    [self addSubview:[nib objectAtIndex:0]];
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
    if (tableView==self.weekSelectionTC) {
        return self.weekSelectionArray.count;
    }
    else if (tableView==self.halfDaySelectionTC) {
        return self.halfdaySelectionArray.count;
    }
    else
        return self.numberArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    if (tableView==self.weekSelectionTC) {
        cell.textLabel.text=[self.weekSelectionArray objectAtIndex:indexPath.row];
    }
    else if (tableView==self.halfDaySelectionTC)
    {
        cell.textLabel.text=[self.halfdaySelectionArray objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text=[self.numberArray objectAtIndex:indexPath.row];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.weekSelectionTC) {
        self.latearrivalWeekText.text=[self.weekSelectionArray objectAtIndex:indexPath.row];
        self.latearrivalhalfdayText.backgroundColor=[UIColor clearColor];
        self.latearrivalhalfdayText.enabled=YES;
        self.weekSelectionTC.hidden=true;
    }
    else if (tableView==self.halfDaySelectionTC) {
        self.latearrivalhalfdayText.text=[self.halfdaySelectionArray objectAtIndex:indexPath.row];
        self.latearrivalDayText.backgroundColor=[UIColor clearColor];
        self.latearrivalDayText.enabled=true;
        self.halfDaySelectionTC.hidden=true;
    }
    else
    {
        self.latearrivalDayText.text=[self.numberArray objectAtIndex:indexPath.row];
        self.doneButton.enabled=YES;
        self.daySelectionTC.hidden=true;
    }
}
-(void)willRemoveSubview:(UIView *)subview
{
    self.mycollectionview.hidden=FALSE;
    NSMutableArray *selectedGropupArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
    NSMutableArray *selectedGroupIdArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedGroupsID"];
    [self.grouparray removeAllObjects];
    [self.groupIDArray removeAllObjects];
    [self.grouparray addObjectsFromArray:selectedGropupArray];
    [self.groupIDArray addObjectsFromArray:selectedGroupIdArray];
    [self.mycollectionview reloadData];
}
-(IBAction)removegroupfromcollectionview:(id)sender
{
    groupcollceioncellclass *clickedCell = (groupcollceioncellclass *)[[sender superview] superview];
    indexpath = [self.mycollectionview indexPathForCell:clickedCell];
    [self.grouparray removeObjectAtIndex:indexpath.row];
    [self.mycollectionview reloadData];
}
-(IBAction)timecheckBoxAction:(id)sender
{
    if (self.x%2==0) {
        [self.timeallowedButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.graceTimeText.backgroundColor=[UIColor whiteColor];
        self.graceTimeText.tag=2;
        self.x++;
        self.gracetimecheckbuttonvalue=@"1";
        self.graceManadtory.hidden=false;
    }
    else
    {
        [self.timeallowedButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.graceTimeText.backgroundColor=[UIColor lightGrayColor];
        self.graceTimeText.text=@"";
        self.graceTimeText.tag=1;
        self.x++;
        self.gracetimecheckbuttonvalue=@"0";
        self.graceTimeValue=@"";
        self.graceManadtory.hidden=true;
        self.datePickerView.hidden=TRUE;

    }
}
-(IBAction)workingcheckBox:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        if (self.y%2==0) {
            [self.workingCheckBox1Button setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.workingText1.tag=2;
            self.workingText1.text=@"";
            self.y++;
            self.workingText1.backgroundColor=[UIColor clearColor];
            self.workingdetailsfirstcheckbuttonvalue=@"1";
            self.workingHourMandatory.hidden=false;
        }
        else
        {
            [self.workingCheckBox1Button setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.workingText1.text=@"";
            self.workingText1.tag=1;
            self.y++;
            self.workingText1.backgroundColor=[UIColor lightGrayColor];
            self.workingdetailsfirstcheckbuttonvalue=@"0";
            self.workingDetailsValue=@"";
            self.workingHourMandatory.hidden=true;
            self.datePickerView.hidden=TRUE;
        }

    }else if(button.tag==2)
    {
        if (self.z%2==0) {
            
            [self.workingCheckBox2Button setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal ];
            self.z++;
            self.workingdetailssecondcheckbuttonvalue=@"1";

        }
        else
        {
            [self.workingCheckBox2Button setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.z++;
            self.workingdetailssecondcheckbuttonvalue=@"0";
        }
    }
    else
    {
        if (self.f%2==0) {
            
            [self.workingCheckBox3Button setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal ];
            self.f++;
            self.workingdetailsthirdcheckbuttonvalue=@"1";
            
        }
        else
        {
            [self.workingCheckBox3Button setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.f++;
            self.workingdetailsthirdcheckbuttonvalue=@"0";
        }

    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.graceTimeText) {
        if (self.graceTimeText.tag==2) {
            self.flag=1;
            self.datePickerView.frame=CGRectMake(74, 268, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
            return  NO;
        }
        else{
            return  NO;
        }
    }
    if (textField==self.workingText1) {
        if (self.workingText1.tag==2) {
            self.flag=2;
            self.datePickerView.frame=CGRectMake(408, 238, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
            self.datePickerView.hidden=FALSE;
            return NO;
        }
        else
            return NO;
    }
    
    if (textField==self.workingText3)
    {
        if (self.f%2==0) {
            
            [self.workingCheckBox3Button setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal ];
            self.f++;
            self.workingdetailsthirdcheckbuttonvalue=@"1";
            
        }
        else
        {
            [self.workingCheckBox3Button setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.f++;
            self.workingdetailsthirdcheckbuttonvalue=@"0";
        }

        return NO;
    }
    if (textField==self.gracetimeapplicableText) {
        if (self.x%2==0) {
            [self.timeallowedButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.graceTimeText.backgroundColor=[UIColor whiteColor];
            self.graceTimeText.tag=2;
            self.x++;
            self.gracetimecheckbuttonvalue=@"1";
            self.graceManadtory.hidden=false;
        }
        else
        {
            [self.timeallowedButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.graceTimeText.backgroundColor=[UIColor lightGrayColor];
            self.graceTimeText.text=@"";
            self.graceTimeText.tag=1;
            self.x++;
            self.gracetimecheckbuttonvalue=@"0";
            self.graceTimeValue=@"";
            self.graceManadtory.hidden=true;
            self.datePickerView.hidden=TRUE;
        }
        return NO;
    }
    if (textField==self.lateArrivaltext1) {
        self.flagValue=2;
        [self.lateArrivalCheckBox3 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        
        self.latearrivalHoursText.backgroundColor=[UIColor clearColor];
        
        self.latearrivalvalueoption=@"1";
        self.doneButton.enabled=NO;
        
        
      
        return NO;
    }
    if (textField==self.lateArrivaltext2) {
        self.flagValue=1;
        self.latearrivalHoursText.text=@"";
        self.latearrivalWeekText.text=@"";
        self.latearrivalDayText.text=@"";
        self.latearrivalhalfdayText.text=@"";
        self.latearrivalHoursText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalWeekText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalhalfdayText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalDayText.backgroundColor=[UIColor lightGrayColor];
        [self.lateArrivalCheckBox2 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        
         self.latearrivalvalueoption=@"2";
        self.doneButton.enabled=YES;
        return NO;
    }
    if (textField==self.lateArrivaltext3) {
        self.flagValue=1;
        self.latearrivalHoursText.text=@"";
        self.latearrivalWeekText.text=@"";
        self.latearrivalDayText.text=@"";
        self.latearrivalhalfdayText.text=@"";
        self.latearrivalHoursText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalWeekText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalhalfdayText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalDayText.backgroundColor=[UIColor lightGrayColor];
        [self.lateArrivalCheckBox1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        
        self.latearrivalvalueoption=@"3";
        self.doneButton.enabled=YES;
        
       
        return NO;
    }
    if (textField==self.workingDetailsTex1) {
        if (self.y%2==0) {
            [self.workingCheckBox1Button setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.workingText1.tag=2;
            self.workingText1.text=@"";
            self.y++;
            self.workingText1.backgroundColor=[UIColor clearColor];
            self.workingdetailsfirstcheckbuttonvalue=@"1";
            self.workingHourMandatory.hidden=false;
        }
        else
        {
            [self.workingCheckBox1Button setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.workingText1.text=@"";
            self.workingText1.tag=1;
            self.y++;
            self.workingText1.backgroundColor=[UIColor lightGrayColor];
            self.workingdetailsfirstcheckbuttonvalue=@"0";
            self.workingDetailsValue=@"";
            self.workingHourMandatory.hidden=true;
            self.datePickerView.hidden=TRUE;
        }


        return NO;
    }
    if (textField==self.workingDetailsTex2)
    {
        if (self.z%2==0) {
            
            [self.workingCheckBox2Button setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal ];
            self.z++;
            self.workingdetailssecondcheckbuttonvalue=@"1";
            
        }
        else
        {
            [self.workingCheckBox2Button setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.z++;
            self.workingdetailssecondcheckbuttonvalue=@"0";
        }

        return NO;
    }
    if (textField==self.workingHoursText1) {
        if (self.a%2==0) {
            [self.workingHourCheckButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.a++;
            self.workhoursfirstcheckbuttonvalue=@"0";
            
        }
        else
        {
            [self.workingHourCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.a++;
            self.workhoursfirstcheckbuttonvalue=@"1";
        }
        return NO;
    }
    if (textField==self.workingHoursText2) {
        if (self.b%2==0) {
            [self.workingHourCheckButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.b++;
            self.workhoursecondcheckbuttonvalue=@"0";
        }
        else
        {
            [self.workingHourCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.b++;
            self.workhoursecondcheckbuttonvalue=@"1";
        }
        return NO;
    }
    if (textField==self.workingHoursText3) {
        if (self.c%2==0) {
            [self.workingHourCheckButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.c++;
            self.workhoursthirdcheckbuttonvalue=@"0";
            

        }
        else
        {
            [self.workingHourCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.c++;
            self.workhoursthirdcheckbuttonvalue=@"1";
        }
        return NO;
    }
    if (textField==self.workingHoursText4) {
        if (self.d%2==0) {
            [self.workingHourCheckButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.d++;
            self.workhoursfourthcheckbuttonvalue=@"0";
            
        }
        else
        {
            [self.workingHourCheckButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.d++;
            self.workhoursfourthcheckbuttonvalue=@"1";
        }
        return NO;
    }
    if (textField==self.workingHoursText5) {
        if (self.e%2==0) {
            [self.workingHourCheckButton5 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.e++;
            self.workhoursfifthcheckbuttonvalue=@"1";
        }
        else
        {
            [self.workingHourCheckButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.e++;
            self.workhoursfifthcheckbuttonvalue=@"0";
        }
        return NO;
    }
    if (textField==self.penalitiesText1) {
        if (self.p%2==0) {
            [self.penalityCheckButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.penaltyfirstcheckbuttonvalue=@"0";
            
            self.p++;
        }
        else
        {
            [self.penalityCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.p++;
            self.penaltyfirstcheckbuttonvalue=@"1";
        }

        return  NO;
    }
    if (textField==self.penalitiesText2) {
        if (self.q%2==0) {
            [self.penalityCheckButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.q++;
            self.penaltysecondcheckbuttonvalue=@"0";
            
        }
        else
        {
            [self.penalityCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.q++;
            self.penaltysecondcheckbuttonvalue=@"1";
        }
        return  NO;
    }
    if (textField==self.penalitiesText3) {
        if (self.r%2==0) {
            [self.penalityCheckButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.r++;
            self.penaltythirdcheckbuttonvalue=@"0";
        }
        else
        {
            [self.penalityCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.r++;
            self.penaltythirdcheckbuttonvalue=@"1";
        }

        return  NO;
    }
    if (textField==self.latearrivalWeekText) {
        if (self.flagValue==2) {
            self.weekSelectionTC.hidden=false;
        }
        return NO;
    }
    if (textField==self.latearrivalhalfdayText) {
        if (self.flagValue==2) {
            self.halfDaySelectionTC.hidden=false;
        }
        return NO;
    }
    if (textField==self.latearrivalDayText) {
        if (self.flagValue==2) {
            self.daySelectionTC.hidden=false;
        }
        return NO;
    }
    if (textField==self.latearrivalHoursText) {
        if (self.flagValue==2) {
            self.latearrivalHoursText.text=@"";
            self.latearrivalWeekText.text=@"";
            self.latearrivalWeekText.backgroundColor=[UIColor lightGrayColor];
            self.latearrivalhalfdayText.text=@"";
            self.latearrivalhalfdayText.backgroundColor=[UIColor lightGrayColor];
            self.latearrivalDayText.text=@"";
            self.latearrivalDayText.backgroundColor=[UIColor lightGrayColor];
            self.doneButton.enabled=NO;
            self.latearrivalWeekText.enabled=NO;
            self.latearrivalhalfdayText.enabled=NO;
            self.latearrivalDayText.enabled=NO;
            return YES;
        }
        else
            return  NO;
    }
    else
        return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.latearrivalHoursText) {
        if (self.latearrivalHoursText.text.length > 0) {
            self.self.latearrivalWeekText.backgroundColor=[UIColor clearColor];
            self.latearrivalWeekText.enabled=YES;
        }
    }
    return  YES;
}
-(IBAction)doneTimerAction:(id)sender
{
    NSDate *myDate = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    NSArray *timeArray=[prettyVersion componentsSeparatedByString:@":"];
    NSString *selectedTime=[NSString stringWithFormat:@"%@Hrs %@Mins",[timeArray objectAtIndex:0],[timeArray objectAtIndex:1]];
    if (self.flag==1) {
        self.graceTimeValue=prettyVersion;
        self.graceTimeText.text=selectedTime;
    }
    if (self.flag==2) {
        self.workingText1.text=selectedTime;
        self.workingDetailsValue=prettyVersion;
    }
    self.datePickerView.hidden=TRUE;
}
-(IBAction)lateArrivalCheckBoxAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        self.flagValue=1;
        self.latearrivalHoursText.text=@"";
        self.latearrivalWeekText.text=@"";
        self.latearrivalDayText.text=@"";
        self.latearrivalhalfdayText.text=@"";
        [self.lateArrivalCheckBox1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        
        self.latearrivalHoursText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalWeekText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalhalfdayText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalDayText.backgroundColor=[UIColor lightGrayColor];
        
         self.latearrivalvalueoption=@"3";
        self.doneButton.enabled=YES;
        
    }
    else if (button.tag==2)
    {
        self.flagValue=1;
        self.latearrivalHoursText.text=@"";
        self.latearrivalWeekText.text=@"";
        self.latearrivalDayText.text=@"";
        self.latearrivalhalfdayText.text=@"";
        [self.lateArrivalCheckBox2 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
      
        self.latearrivalHoursText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalWeekText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalhalfdayText.backgroundColor=[UIColor lightGrayColor];
        self.latearrivalDayText.backgroundColor=[UIColor lightGrayColor];
        
         self.latearrivalvalueoption=@"2";
        self.doneButton.enabled=YES;

        }
    else
    {
        self.flagValue=2;
        [self.lateArrivalCheckBox3 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.lateArrivalCheckBox1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.latearrivalHoursText.backgroundColor=[UIColor clearColor];
        
        
        self.latearrivalvalueoption=@"1";
        self.doneButton.enabled=NO;
    }
}
-(IBAction)workingcheckButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        if (self.a%2==0) {
            [self.workingHourCheckButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.a++;
            self.workhoursfirstcheckbuttonvalue=@"0";
          
        }
        else
        {
            [self.workingHourCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.a++;
                self.workhoursfirstcheckbuttonvalue=@"1";
            
        }
    }
    if (button.tag==2) {
        if (self.b%2==0) {
            [self.workingHourCheckButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.b++;
             self.workhoursecondcheckbuttonvalue=@"0";
        }
        else
        {
            [self.workingHourCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.b++;
            self.workhoursecondcheckbuttonvalue=@"1";
        }

        
    }
    if (button.tag==3) {
        if (self.c%2==0) {
            [self.workingHourCheckButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.c++;
            self.workhoursthirdcheckbuttonvalue=@"0";
        }
        else
        {
            [self.workingHourCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.c++;
            self.workhoursthirdcheckbuttonvalue=@"1";
        }

    }
    if (button.tag==4) {
        if (self.d%2==0) {
            [self.workingHourCheckButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.d++;
            self.workhoursfourthcheckbuttonvalue=@"0";
        }
        else
        {
            [self.workingHourCheckButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.d++;
             self.workhoursfourthcheckbuttonvalue=@"1";
            
        }

    }
    if (button.tag==5) {
        if (self.e%2==0) {
            [self.workingHourCheckButton5 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.e++;
             self.workhoursfifthcheckbuttonvalue=@"1";
        }
        else
        {
            [self.workingHourCheckButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.e++;
             self.workhoursfifthcheckbuttonvalue=@"0";
        }

    }
}
-(IBAction)penalityCheckButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        if (self.p%2==0) {
            [self.penalityCheckButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.p++;
            self.penaltyfirstcheckbuttonvalue=@"0";
            
        }
        else
        {
            [self.penalityCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.p++;
            self.penaltyfirstcheckbuttonvalue=@"1";
           
        }
    }
    if (button.tag==2) {
        if (self.q%2==0) {
            [self.penalityCheckButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.q++;
             self.penaltysecondcheckbuttonvalue=@"0";
        }
        else
        {
            [self.penalityCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.q++;
            self.penaltysecondcheckbuttonvalue=@"1";
        }
        
        
    }
    if (button.tag==3) {
        if (self.r%2==0) {
            [self.penalityCheckButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.r++;
             self.penaltythirdcheckbuttonvalue=@"0";
        }
        else
        {
            [self.penalityCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.r++;
            self.penaltythirdcheckbuttonvalue=@"1";
        }
        
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    if (textField==self.latearrivalHoursText) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=2) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        return  NO;
        
    }
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
            return YES;
        }
    }
    else if (textField==self.timeruletextfield)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=49) {
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
    else
    {
        return YES;
    }
    return false;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView==self.descriptiontextview) {
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




-(IBAction)donebuttonaction:(id)sender
{
    if((self.timeruletextfield.text.length>0)&&(self.abbrbText.text.length>0))
    {
        if (([self.gracetimecheckbuttonvalue integerValue]==0) && ([self.workingdetailsfirstcheckbuttonvalue integerValue]==0)) {
            [self saveAction:ServiceStr];
        }
        else if (([self.gracetimecheckbuttonvalue intValue]==1)&&([self.workingdetailsfirstcheckbuttonvalue intValue]==1))
        {
            if ((self.graceTimeText.text.length > 0)&&(self.workingText1.text.length > 0)) {
                [self saveAction:ServiceStr];
            }
            else
            {
                [self alertAction];
            }
            
        }
        else if((([self.gracetimecheckbuttonvalue integerValue]==1) && (self.graceTimeText.text.length > 0)) || (([self.workingdetailsfirstcheckbuttonvalue integerValue]==1) &&(self.workingText1.text.length> 0)))
        {
            [self saveAction:ServiceStr];
        }
        
        else
        {
            [self alertAction];
        }
        
        
    }
    else
    {
        
        [self alertAction];
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
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [appObj hudStart:self];
    });
    
    if ([action isEqualToString:@"create"]) {
        
        [self.myconnection createnewTimerule:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]:self.timeruletextfield.text abbrv:self.abbrbText.text descripton:self.descriptiontextview.text checkgracetime:self.gracetimecheckbuttonvalue checkgracetimetextvalue:self.graceTimeValue workfirstdetails:self.workingdetailsfirstcheckbuttonvalue workfirstdetailstextvalue:self.workingDetailsValue worksecondetails:self.workingdetailssecondcheckbuttonvalue workthirddetails:self.workingdetailsthirdcheckbuttonvalue latearrivaloption:self.latearrivalvalueoption latearrivalvalue1:self.latearrivalHoursText.text latearrivalvalue2:self.latearrivalWeekText.text latearrivalvalue3:self.latearrivalhalfdayText.text latearrivalvalue4:self.latearrivalDayText.text firstpenalty:self.penaltyfirstcheckbuttonvalue secondpenalty:self.penaltysecondcheckbuttonvalue  thirdpenalty:self.penaltythirdcheckbuttonvalue workhoursfirst:self.workhoursfirstcheckbuttonvalue workhourssecond:self.workhoursecondcheckbuttonvalue workhoursthird:self.workhoursthirdcheckbuttonvalue workhoursfourth:self.workhoursfourthcheckbuttonvalue workhoursfifth:self.workhoursfifthcheckbuttonvalue timestatusflag:@"C" createdby:@"Bablu" :designationList : [[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"]];
        
        
    }
    else
    {
        [self.myconnection updateTimerule:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]:[[NSUserDefaults standardUserDefaults]objectForKey:@"timeruleid"] rulename:self.timeruletextfield.text abbrv:self.abbrbText.text descripton:self.descriptiontextview.text checkgracetime:self.gracetimecheckbuttonvalue checkgracetimetextvalue:self.graceTimeValue workfirstdetails:self.workingdetailsfirstcheckbuttonvalue workfirstdetailstextvalue:self.workingDetailsValue worksecondetails:self.workingdetailssecondcheckbuttonvalue workthirddetails:self.workingdetailsthirdcheckbuttonvalue latearrivaloption:self.latearrivalvalueoption latearrivalvalue1:self.latearrivalHoursText.text latearrivalvalue2:self.latearrivalWeekText.text latearrivalvalue3:self.latearrivalhalfdayText.text latearrivalvalue4:self.latearrivalDayText.text firstpenalty:self.penaltyfirstcheckbuttonvalue secondpenalty:self.penaltysecondcheckbuttonvalue  thirdpenalty:self.penaltythirdcheckbuttonvalue workhoursfirst:self.workhoursfirstcheckbuttonvalue workhourssecond:self.workhoursecondcheckbuttonvalue workhoursthird:self.workhoursthirdcheckbuttonvalue workhoursfourth:self.workhoursfourthcheckbuttonvalue workhoursfifth:self.workhoursfifthcheckbuttonvalue timestatusflag:@"C" createdby:@"Bablu" :designationList : [[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"]];
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];

}
-(void)alertAction
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:@"Mandatory Field Required"
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
-(IBAction)cancelbuttonaction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"close" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
    
}

//Got response when new time rule is saved to server
-(void)initiallyruleviewresponse:(NSMutableArray *)viewrulearray
{
    
    if ([viewrulearray count]>0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            attendancesettingsviewclass *ob = (attendancesettingsviewclass *)self.superview.superview;
        
            [ob initiallyruleviewresponse:viewrulearray];
        
            [self removeFromSuperview];
        });
        
        
    }
    else
    {
//        UIAlertController *alert= [UIAlertController
//                                   alertControllerWithTitle:@"Error"
//                                   message:@"Server Timed Out"
//                                   preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                   handler:^(UIAlertAction * action){
//                                                       //Do Some action here
//                                                   }];
//        [alert addAction:ok];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
//        });
       
        [self showalerviewcontroller:@"Connection Failed"];
    }
    
    
}

//Got response when individual rule view is selected
-(void)updateruleviewresponse:(NSMutableArray *)updateruleArray
{
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *selectedRuleDict=[updateruleArray objectAtIndex:0];
        self.timeruletextfield.text=[selectedRuleDict objectForKey:@"time_rule_name"];
        self.abbrbText.text=[selectedRuleDict objectForKey:@"time_abbr"];
        self.descriptiontextview.text=[selectedRuleDict objectForKey:@"description"];
        
        self.graceTimeValue=[selectedRuleDict objectForKey:@"grace_time"];
        if (!([self.graceTimeValue isEqualToString:@""])) {
            NSArray *graceArray=[self.graceTimeValue componentsSeparatedByString:@":"];
            self.graceTimeText.text=[NSString stringWithFormat:@"%@Hrs %@Mins",[graceArray objectAtIndex:0],[graceArray objectAtIndex:1]];
        }
        else
        {
            self.graceTimeText.text=@"";
        }
       
        self.latearrivalHoursText.text=[selectedRuleDict objectForKey:@"hours"];
        self.latearrivalWeekText.text=[selectedRuleDict objectForKey:@"week"];
        self.latearrivalhalfdayText.text=[selectedRuleDict objectForKey:@"mark"];
        self.latearrivalDayText.text=[selectedRuleDict objectForKey:@"day"];
        self.workingDetailsValue=[selectedRuleDict objectForKey:@"calculate_absent_value"];
        if (!([self.workingDetailsValue isEqualToString:@""])) {
            NSArray *workingArray=[self.workingDetailsValue componentsSeparatedByString:@":"];
            self.workingText1.text=[NSString stringWithFormat:@"%@Hrs %@Mins",[workingArray objectAtIndex:0],[workingArray objectAtIndex:1]];
            self.gracetimecheckbuttonvalue=[selectedRuleDict objectForKey:@"grace_time_status"];
        }
        else
        {
            self.workingText1.text=@"";
        }
        
        if ([[selectedRuleDict objectForKey:@"grace_time_status"] isEqualToString:@"0"]) {
            [self.timeallowedButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.x=0;
            
        }
        else
        {
            [self.timeallowedButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.graceTimeText.backgroundColor=[UIColor clearColor];
            self.graceTimeText.tag=2;
            self.x=1;
        }
        
        self.workingdetailsfirstcheckbuttonvalue=[selectedRuleDict objectForKey:@"calculate_absent_status"];
        
        if ([[selectedRuleDict objectForKey:@"calculate_absent_status"] isEqualToString:@"0"]) {
            [self.workingCheckBox1Button setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.y=0;
            
        }
        else
        {
            [self.workingCheckBox1Button setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.workingText1.tag=2;
            self.workingText1.backgroundColor=[UIColor clearColor];
            self.y=1;
        }
        
        self.workingdetailssecondcheckbuttonvalue=[selectedRuleDict objectForKey:@"ignore_checkout_status"];
        
        if ([[selectedRuleDict objectForKey:@"ignore_checkout_status"] isEqualToString:@"0"]) {
            [self.workingCheckBox2Button setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.z=0;
        }
        else
        {
            [self.workingCheckBox2Button setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.z=1;
        }
        
        self.workingdetailsthirdcheckbuttonvalue=[selectedRuleDict objectForKey:@"adjust_late_overtime"];
        
        if ([[selectedRuleDict objectForKey:@"adjust_late_overtime"] isEqualToString:@"0"]) {
            [self.workingCheckBox3Button setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.f=0;
        }
        else
        {
            [self.workingCheckBox3Button setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.f=1;
        }
        
        self.latearrivalvalueoption=[selectedRuleDict objectForKey:@"late_arrival_option"];
        
        
        if ([[selectedRuleDict objectForKey:@"late_arrival_option"] isEqualToString:@"1"]) {
            [self.lateArrivalCheckBox3 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            [self.lateArrivalCheckBox1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            [self.lateArrivalCheckBox2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            
            self.flagValue=2;
            self.latearrivalHoursText.backgroundColor=[UIColor clearColor];
            self.latearrivalHoursText.enabled=YES;
            self.latearrivalWeekText.backgroundColor=[UIColor clearColor];
            self.latearrivalWeekText.enabled=YES;
            self.latearrivalhalfdayText.backgroundColor=[UIColor clearColor];
            self.latearrivalhalfdayText.enabled=YES;
            self.latearrivalDayText.backgroundColor=[UIColor clearColor];
            self.latearrivalDayText.enabled=YES;
            
            
        }
        else if([[selectedRuleDict objectForKey:@"late_arrival_option"] isEqualToString:@"2"])
        {
            [self.lateArrivalCheckBox2 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            [self.lateArrivalCheckBox1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            [self.lateArrivalCheckBox3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.lateArrivalCheckBox1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            [self.lateArrivalCheckBox2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            [self.lateArrivalCheckBox3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            
        }
        
        self.penaltyfirstcheckbuttonvalue=[selectedRuleDict objectForKey:@"penalties_late_duration"];
        
        if ([[selectedRuleDict objectForKey:@"penalties_late_duration"] isEqualToString:@"0"]) {
            [self.penalityCheckButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.p=1;
            
        }
        else
        {
            [self.penalityCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.p=0;
        }
        
        self.penaltysecondcheckbuttonvalue=[selectedRuleDict objectForKey:@"penalties_break_duration"];
        
        if ([[selectedRuleDict objectForKey:@"penalties_break_duration"] isEqualToString:@"0"]) {
            [self.penalityCheckButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.q=1;
            
        }
        else
        {
            [self.penalityCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.q=0;
        }
        
        self.penaltythirdcheckbuttonvalue=[selectedRuleDict objectForKey:@"penalties_exit_duration"];
        
        if ([[selectedRuleDict objectForKey:@"penalties_exit_duration"] isEqualToString:@"0"]) {
            [self.penalityCheckButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.r=1;
            
        }
        else
        {
            [self.penalityCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.r=0;
        }
        
        self.workhoursfirstcheckbuttonvalue=[selectedRuleDict objectForKey:@"deduct_late_working_hours"];
        
        if ([[selectedRuleDict objectForKey:@"deduct_late_working_hours"] isEqualToString:@"0"]) {
            [self.workingHourCheckButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.a=1;
            
        }
        else
        {
            [self.workingHourCheckButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.a=0;
        }
        
        self.workhoursecondcheckbuttonvalue=[selectedRuleDict objectForKey:@"include_break_working"];
        
        if ([[selectedRuleDict objectForKey:@"include_break_working"] isEqualToString:@"0"]) {
            [self.workingHourCheckButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.b=1;
            
        }
        else
        {
            [self.workingHourCheckButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.b=0;
        }
        
        self.workhoursthirdcheckbuttonvalue=[selectedRuleDict objectForKey:@"deduct_prolonged_working"];
        
        if ([[selectedRuleDict objectForKey:@"deduct_prolonged_working"] isEqualToString:@"0"]) {
            [self.workingHourCheckButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.c=1;
            
        }
        else
        {
            [self.workingHourCheckButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.c=0;
        }
        
        self.workhoursfourthcheckbuttonvalue=[selectedRuleDict objectForKey:@"deduct_early_exit_working"];
        
        if ([[selectedRuleDict objectForKey:@"deduct_early_exit_working"] isEqualToString:@"0"]) {
            [self.workingHourCheckButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.d=1;
        }
        else
        {
            [self.workingHourCheckButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.d=0;
        }
        
        self.workhoursfifthcheckbuttonvalue=[selectedRuleDict objectForKey:@"on_duty_working_hours"];
        
        if ([[selectedRuleDict objectForKey:@"on_duty_working_hours"] isEqualToString:@"0"]) {
            [self.workingHourCheckButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.e=0;
            
        }
        else
        {
            [self.workingHourCheckButton5 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.e=1;
        }
        
        
        
        [self.grouparray removeAllObjects];
        
        
//        NSString *mystring=[[updateruleArray objectAtIndex:0]objectForKey:@"desi_details"];
//        if (!([mystring isEqualToString:@""])) {
//            NSArray *desigArray=[mystring componentsSeparatedByString:@"###"];
//            [self.grouparray addObjectsFromArray:desigArray];
//            self.mycollectionview.hidden=FALSE;
//            [self.mycollectionview reloadData];
//            
//        }
        
        NSString *mystring=[[updateruleArray objectAtIndex:0]objectForKey:@"desi_details"];
        
        if ([[updateruleArray objectAtIndex:0]objectForKey:@"desi_details"]!=(id)[NSNull null])
        {
            NSArray *desigArray=[mystring componentsSeparatedByString:@"###"];
            [self.grouparray addObjectsFromArray:desigArray];
            self.mycollectionview.hidden=FALSE;
            [self.mycollectionview reloadData];
            
        }

        [appObj hudStop];
        
    });
    
    
    
    
}


//Got response when no network is available
-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Error"
                               message:[NSString stringWithFormat:@"%@",errorMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   [appObj hudStop];
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
   

}


-(void)passingarraydesignation:(NSString *)responsestring
{
    
    NSLog(@"%@",responsestring);
    
}

@end
