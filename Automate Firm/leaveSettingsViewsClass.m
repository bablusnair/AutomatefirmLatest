//
//  leaveSettingsViewClass.m
//  bablusdemokpproject
//
//  Created by leonine on 8/20/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "leaveSettingsViewsClass.h"
#import "settingsleaveviewsclass.h"
#import "leaveCustomTableViewCell.h"
#import "groupcollceioncellclass.h"
#import "AppDelegate.h"
#import "paymentViewsClass.h"
@implementation leaveSettingsViewsClass
@synthesize x;
- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
   
}
-(void)awakeFromNib
{
    [self clearAll];
    myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    [self.myconnection leaveabbrivationservice:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];
    
    [self.mycollectionview registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    self.mycollectionview.hidden=TRUE;
    self.grouparray=[[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeyourframe) name:@"hello" object:Nil];
    
    self.x=self.p=self.i=self.j=self.q=self.r=self.s=self.s1=self.s2=self.s3=self.s4=self.s5=self.s6=self.s7=self.s8=self.y=self.z=0;
    
    self.checkFlag=self.checkFlag1=self.selectedFlag=1;
    self.flag=0;
    
    self.firstCheckValue=@"1";
    self.secondCheckValue=@"0";
    self.thirdCheckValue=@"0";
    self.maleCheckValue=@"1";
    self.femaleCheckValue=@"1";
    self.clubCheckValue=@"1";
    
    self.switchValue1=@"0";
    self.switchValue2=@"1";
    self.switchValue3=@"1";
    self.switchValue4=@"1";
    self.switchValue5=@"1";
    self.switchValue6=@"0";
    self.switchValue7=@"0";
    self.switchValue8=@"1";
    
    self.carryForwardDropFlag=@"0";
    
    self.conditionText1.text=self.conditionText2.text=self.conditionText4.text=self.paymentText1.text=self.paymentText2.text=self.paymentText3.text=self.maxConsecutivedaysText.text=@"";
    
    
    self.leavesArray=[[NSMutableArray alloc] initWithObjects:@"MTRN",@"VACT",@"ETRV",@"STVR",@"ODTY", nil];
    self.selectedArray=[[NSMutableArray alloc]init];
    self.weekDropArray=[[NSMutableArray alloc]initWithObjects:@"Quarter",@"Month", nil];
    self.leaveArray=[[NSMutableArray alloc]initWithObjects:@"1st",@"2nd",@"3rd",@"4th",@"5th",@"6th",@"7th",@"8th",@"9th",@"10th",@"11th",@"12th", nil];
    self.monthArray=[[NSMutableArray alloc]initWithObjects:@"Carry forward all unused paid leaves to next year",@"Carry forward certain % of unused leaves to next year",@"Repay remaining fully & half paid leaves at the end of the year and invalidate rest",@"Repay certain  % of fully & half paid leaves at the end of the year and invalidate rest",@"Invalidate all at the end of the year", nil];
    
    self.leaveDict=[[NSMutableDictionary alloc]init];
    self.conditionDict=[[NSMutableDictionary alloc]init];
    self.leaveTileIDArray=[[NSMutableArray alloc]init];
    
    self.dropmandatoryLabel.hidden=true;
    self.dropText.hidden=true;
    self.dropTextImage.hidden=true;
    self.switchPopUpView.hidden=true;
    self.weekDropTableView.hidden=true;
    self.leaveApplicableDropTableView.hidden=true;
    self.carryForwardTC.hidden=true;
    self.leaveView.hidden=true;
      self.modifiedView.hidden=true;
    
    self.conditionText2.enabled=NO;
    self.conditionText3.enabled=NO;
    
    myappde.warningflag=0;
    
    

    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"fullyPaidleaves"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"halfPaidleaves"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"totalLeaves"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"expYear"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.switchButton2.layer addAnimation:transition forKey:nil];
    
    //Long Press gesture
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleaction:)];
    [self.modifyDate addGestureRecognizer:longPress];
     [self addGestureRecognizer:longPress];
    
    
    //to switch sliding-Sliding gesture
    UISwipeGestureRecognizer *leftSwip1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    
    leftSwip1.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.switchButton1 addGestureRecognizer:leftSwip1];
    
    
    
    UISwipeGestureRecognizer *rightSwipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    
    rightSwipe1.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.switchButton1 addGestureRecognizer:rightSwipe1];
    
    
    
    
    UISwipeGestureRecognizer *leftSwip2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    
    leftSwip2.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.switchButton2 addGestureRecognizer:leftSwip2];
    
    
    
    UISwipeGestureRecognizer *rightSwipe2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    
    rightSwipe2.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.switchButton2 addGestureRecognizer:rightSwipe2];

    
    UISwipeGestureRecognizer *leftSwip3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    
    leftSwip3.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.switchButton3 addGestureRecognizer:leftSwip3];
    
    
    
    UISwipeGestureRecognizer *rightSwipe3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    
    rightSwipe3.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.switchButton3 addGestureRecognizer:rightSwipe3];
    
    
    
    UISwipeGestureRecognizer *leftSwip4 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    
    leftSwip4.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.switchButton4 addGestureRecognizer:leftSwip4];
    
    
    
    UISwipeGestureRecognizer *rightSwipe4 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    
    rightSwipe4.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.switchButton4 addGestureRecognizer:rightSwipe4];
    
    
    UISwipeGestureRecognizer *leftSwip5 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    
    leftSwip5.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.switchButton5 addGestureRecognizer:leftSwip5];
    
    
    
    UISwipeGestureRecognizer *rightSwipe5 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    
    rightSwipe5.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.switchButton5 addGestureRecognizer:rightSwipe5];
    
    
    UISwipeGestureRecognizer *leftSwip6 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    
    leftSwip6.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.switchButton6 addGestureRecognizer:leftSwip6];
    
    
    
    UISwipeGestureRecognizer *rightSwipe6 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    
    rightSwipe6.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.switchButton6 addGestureRecognizer:rightSwipe6];
    
    
    UISwipeGestureRecognizer *leftSwip7 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    
    leftSwip7.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.switchButton7 addGestureRecognizer:leftSwip7];
    
    
    
    UISwipeGestureRecognizer *rightSwipe7 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    
    rightSwipe7.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.switchButton7 addGestureRecognizer:rightSwipe7];
    
    UISwipeGestureRecognizer *leftSwip8 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    
    leftSwip8.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.switchButton8 addGestureRecognizer:leftSwip8];
    
    
    
    UISwipeGestureRecognizer *rightSwipe8 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    
    rightSwipe8.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.switchButton8 addGestureRecognizer:rightSwipe8];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewLoad) name:@"viewLoad" object:Nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(discardAction) name:@"discardAction" object:Nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableall) name:@"enableall" object:Nil];
    
}

-(void)viewLoad
{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveAction"]isEqualToString:@"update"]) {
        
        NSString *tileID;
        //[self.leaveTileIDArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"conditionID"]];

        
        int row=myappde.selectedRow;
        
        if(!([[myappde.conditionIDArray objectAtIndex:row] isEqualToString:@"0"]))
        {
            tileID=[myappde.conditionIDArray objectAtIndex:row];
            [self.myconnection individualLeaveConditionView:tileID];
        }
        else
        {
            [self clearAll];
            [self.grouparray removeAllObjects];
            [self.mycollectionview reloadData];
        }
    
    
    //    Abbreviation checking
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"abbrv"]isEqualToString:@"MTRN"]) {
        self.carryForwardDropTextView.text=[self.monthArray objectAtIndex:4];
        [self.femaleCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        [self.maleCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.femaleCheckValue=@"1";
        self.maleCheckValue=@"0";
        self.maleCheckButton.userInteractionEnabled=NO;
        self.femaleCheckButton.userInteractionEnabled=NO;
        self.maleCheckText.userInteractionEnabled=NO;
        self.femaleCheckText.userInteractionEnabled=NO;
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"abbrv"]isEqualToString:@"PATR"])
    {
        self.carryForwardDropTextView.text=[self.monthArray objectAtIndex:4];
        [self.maleCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        [self.femaleCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.maleCheckValue=@"1";
        self.femaleCheckValue=@"0";
        self.maleCheckButton.userInteractionEnabled=NO;
        self.femaleCheckButton.userInteractionEnabled=NO;
        self.maleCheckText.userInteractionEnabled=NO;
        self.femaleCheckText.userInteractionEnabled=NO;
    }
    }
    else{
        int row=myappde.selectedRow;
        
        if([[myappde.conditionIDArray objectAtIndex:row] isEqualToString:@"0"])
        {
            [self clearAll];
            [self.grouparray removeAllObjects];
            [self.mycollectionview reloadData];
                //NSString *tileID=[myappde.conditionIDArray objectAtIndex:row];
                //[self.myconnection individualLeaveConditionView:tileID];
        }
        else
        {
            NSString *tileID=[myappde.conditionIDArray objectAtIndex:row];
            [self.myconnection individualLeaveConditionView:tileID];
        }
    }
    
}
-(void)discardAction
{
//    int row=myappde.selectedRow;
//    
//    if([[myappde.conditionIDArray objectAtIndex:row] isEqualToString:@"0"])
//    {
//        [self clearAll];
//        //NSString *tileID=[myappde.conditionIDArray objectAtIndex:row];
//        //[self.myconnection individualLeaveConditionView:tileID];
//    }
}
-(IBAction)groupselectionaction:(id)sender
{
    myappde.action=@"designation";
    myappde.warningflag=1;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"includeDesignationView" owner:self options:nil];
    [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    
    
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=NO;
    }
    self.switchButton8.userInteractionEnabled=FALSE;
    self.saveButton.userInteractionEnabled=FALSE;
    
    AccordionView *obhh = (AccordionView *)self.superview.superview;
    [obhh disabledfunction];
}
-(void)enableall
{
    
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=YES;
    }
    
    self.switchButton8.userInteractionEnabled=TRUE;
    self.saveButton.userInteractionEnabled=TRUE;
    
    
    
    AccordionView *obhh = (AccordionView *)self.superview.superview;
    [obhh enabledFunction];
    
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
    if (tableView==self.weekDropTableView) {
        return self.weekDropArray.count;
    }
    else if(tableView==self.leaveApplicableDropTableView)
    {
        return self.leaveArray.count;
    }
    if (tableView==self.exceptLeaveTableView) {
        return self.leavesArray.count;
    }
    else
    {
        return  self.monthArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.carryForwardTC) {
        leaveCustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"leaveCustomTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.myLabel.text=[self.monthArray objectAtIndex:indexPath.row];
        return  cell;
    }
    if (tableView==self.exceptLeaveTableView) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        UIButton *newRadioButton;
        newRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        newRadioButton.frame = CGRectMake(30, 0, 15, 14.5);
        newRadioButton.userInteractionEnabled=NO;
        cell.textLabel.text=[self.leavesArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        cell.accessoryView = newRadioButton;
        if ([self.selectedArray containsObject:[self.leavesArray objectAtIndex:indexPath.row]]) {
            [newRadioButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        }
        else
        {
            [newRadioButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        }
        return  cell;
    }

    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        if (tableView==self.weekDropTableView) {
            cell.textLabel.text=[self.weekDropArray objectAtIndex:indexPath.row];
        }
        else if (tableView==self.leaveApplicableDropTableView)
        {
            cell.textLabel.text=[self.leaveArray objectAtIndex:indexPath.row];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.weekDropTableView)
    {
        myappde.warningflag=1;
        self.conditionText3.text=[self.weekDropArray objectAtIndex:indexPath.row];
        self.weekDropTableView.hidden=true;
    }
    else if (tableView==self.leaveApplicableDropTableView)
    {
        myappde.warningflag=1;
        self.conditionText5.text=[self.leaveArray objectAtIndex:indexPath.row];
        self.leaveApplicableDropTableView.hidden=true;
    }
    else if (tableView==self.carryForwardTC)
    {
        if ((indexPath.row==1)||(indexPath.row==3)) {
            self.flag=1;
            self.carryForwardDropFlag=@"1";
            self.switchPopUpView.hidden=false;
        }
        else
        {
            self.dropmandatoryLabel.hidden=true;
            self.dropText.hidden=true;
            self.dropText.text=@"";
            self.carryForwardDropFlag=@"0";
            self.dropTextImage.hidden=true;
        }
        myappde.warningflag=1;
        self.carryForwardDropTextView.text=[self.monthArray objectAtIndex:indexPath.row];
        self.carryForwardTC.hidden=true;
    }
    else if (tableView==self.exceptLeaveTableView) {
        self.selectedFlag=0;
        if ([self.selectedArray containsObject:[self.leavesArray objectAtIndex:indexPath.row]]) {
            [self.selectedArray removeObject:[self.leavesArray objectAtIndex:indexPath.row]];
        }
        else
        {
            [self.selectedArray addObject:[self.leavesArray objectAtIndex:indexPath.row]];
        }
        myappde.warningflag=1;
        [self.exceptLeaveTableView reloadData];
        
    }

    
}
-(IBAction)leaveDoneButtonAction:(id)sender
{
    if (self.selectedArray.count==0) {
        self.leavesText.text=@"";
        [self.checkButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.leavesText.backgroundColor=[UIColor lightGrayColor];
        self.leavesText.placeholder=@"";
        self.leaveView.hidden=true;
        self.checkFlag=0;
        self.clubCheckValue=@"0";
        self.s++;
    }
    else
    {
        if (self.selectedArray.count>1) {
            if (self.selectedArray.count == self.leavesArray.count) {
                self.leavesText.text=@"        All";
            }
            else
                self.leavesText.text=@"   Multiple";
        }
        else
        {
            self.leavesText.text=[NSString stringWithFormat:@"    %@",[self.selectedArray objectAtIndex:0]];
        }
        [self.checkButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.leavesText.backgroundColor=[UIColor clearColor];
        self.leaveView.hidden=true;
        self.s++;
    }
}

-(IBAction)advancedAction:(id)sender
{
    if (self.x%2==0) {
        if (self.paymentText3.text.length > 0) {
            NSString *myString=[NSString stringWithFormat:@"%@###%@###%@",self.paymentText1.text,self.paymentText2.text,self.paymentText3.text];
            [[NSUserDefaults standardUserDefaults]setObject:myString forKey:@"paymentValue"];
            NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"paymentViews" owner:self options:nil];
            [self.paymentStructureView addSubview:[array objectAtIndex:0]];
            self.x++;
        }
        else
        {
            
        }
        
    }
    else
    {
        
        for (UIView *myview in self.paymentStructureView.subviews) {
            if (myview.tag==100)
            {
                [myview removeFromSuperview];
                self.x++;
            }
        }
    }
    
}
-(IBAction)checkButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    myappde.warningflag=1;
    if (button.tag==1) {
        if (self.p%2==0) {
            [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            [self.switchButton7 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
            [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.q=0;
            self.checkButton2.backgroundColor=[UIColor lightGrayColor];
            self.checkButton2.userInteractionEnabled=false;
            self.checkBoxText2.userInteractionEnabled=false;
            self.p++;
            self.firstCheckValue=@"0";
            self.secondCheckValue=@"0";
            self.switchValue7=@"0";
        }
        else
        {
            [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.checkButton2.backgroundColor=[UIColor clearColor];
            self.checkButton2.userInteractionEnabled=true;
            self.checkBoxText2.userInteractionEnabled=true;
            self.p++;
            self.firstCheckValue=@"1";
        }
    }
    else if (button.tag==2)
    {
        if (self.q%2==0) {
            [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.q++;
            self.secondCheckValue=@"1";
        }
        else
        {
            [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.q++;
            self.secondCheckValue=@"0";
        }

    }
    else if (button.tag==3)
    {
        if (self.r%2==0) {
            [self.checkButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.r++;
            self.thirdCheckValue=@"1";
        }
        else
        {
            [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.r++;
            self.thirdCheckValue=@"0";
        }

    }
    else
    {
        if (self.s%2==0) {
            [self.checkButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.leavesText.backgroundColor=[UIColor lightGrayColor];
            self.leavesText.enabled=NO;
            self.leavesText.text=@"";
            self.checkFlag=0;
            self.s++;
            self.clubCheckValue=@"0";
        }
        else
        {
            [self.checkButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.leavesText.backgroundColor=[UIColor clearColor];
            self.leavesText.enabled=YES;
            self.checkFlag=1;
            self.s++;
             self.clubCheckValue=@"1";
        }

    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField==self.conditionText1) {
        return YES;
    }
    else if (textField==self. conditionText2)
    {
        self.conditionText3.backgroundColor=[UIColor lightGrayColor];
        self.conditionText3.text=@"";
        self.conditionText3.enabled=NO;
        self.saveButton.enabled=NO;
        return YES;
    }
    else if (textField==self.conditionText3) {
        self.weekDropTableView.hidden=false;
        return  NO;
    }
    else if (textField==self.conditionText5)
    {
        self.leaveApplicableDropTableView.hidden=false;
        return  NO;
    }
    else if (textField==self.checkBoxText1)
    {
        myappde.warningflag=1;
        if (self.p%2==0) {
            [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            [self.switchButton7 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
            [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.q=0;
            self.checkButton2.backgroundColor=[UIColor lightGrayColor];
            self.checkButton2.userInteractionEnabled=false;
            self.checkBoxText2.userInteractionEnabled=false;
            self.p++;
            self.firstCheckValue=@"0";
            self.secondCheckValue=@"0";
            self.switchValue7=@"0";
        }
        else
        {
            [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.checkButton2.backgroundColor=[UIColor clearColor];
            self.checkButton2.userInteractionEnabled=true;
            self.checkBoxText2.userInteractionEnabled=true;
            self.p++;
            self.firstCheckValue=@"1";
        }
        return  NO;

    }
    else if (textField==self.checkBoxText2)
    {
        myappde.warningflag=1;
        if (self.q%2==0) {
            [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.q++;
            self.secondCheckValue=@"1";
        }
        else
        {
            [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.q++;
            self.secondCheckValue=@"0";
        }

        return  NO;

    }
    else if (textField==self.checkBoxText3)
    {
        myappde.warningflag=1;
        if (self.r%2==0) {
            [self.checkButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.r++;
            self.thirdCheckValue=@"1";
        }
        else
        {
            [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.r++;
            self.thirdCheckValue=@"0";
        }
        return  NO;

    }
    else if (textField==self.checkBoxText4)
    {
        myappde.warningflag=1;
        if (self.s%2==0) {
            [self.checkButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.checkFlag=0;
            self.leavesText.backgroundColor=[UIColor lightGrayColor];
            self.leavesText.enabled=NO;
            self.leavesText.text=@"";
            self.s++;
        }
        else
        {
            [self.checkButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.leavesText.backgroundColor=[UIColor clearColor];
            self.leavesText.enabled=YES;
            self.checkFlag=1;
            self.s++;
        }

        return  NO;
    }
    else if (textField==self.maleCheckText)
    {
        myappde.warningflag=1;
        if (self.y%2==0) {
            if (self.z%2==0) {
                [self.maleCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.y++;
                self.maleCheckValue=@"0";
            }
            
        }
        else
        {
            [self.maleCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.y++;
            self.maleCheckValue=@"1";
        }
        return  NO;
    }
    else if (textField==self.femaleCheckText)
    {
        myappde.warningflag=1;
        if (self.z%2==0) {
            if (self.y%2==0) {
                [self.femaleCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.z++;
                self.femaleCheckValue=@"0";
            }
            
        }
        else
        {
            [self.femaleCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.z++;
            self.femaleCheckValue=@"1";
        }
        return  NO;
    }
    else if (textField==self.leavesText)
    {
        if (self.checkFlag==1) {
            self.leaveView.hidden=false;
        }
        
        return  NO;
    }
    else if (textField==self.checkBoxText11)
    {
        myappde.warningflag=1;
        [self.chechBox1 setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        [self.chechBox2 setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
        
        return  NO;
    }
    else if (textField==self.checkBoxText22)
    {
        myappde.warningflag=1;
        [self.chechBox2 setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        [self.chechBox1 setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
        return  NO;
    }
    else if (textField==self.paymentText1)
    {
        if (self.paymentText1.text.length > 0) {
            self.paymentText2.text=@"";
            self.paymentText3.text=@"";
            self.paymentText2.backgroundColor=[UIColor lightGrayColor];
            self.paymentText3.backgroundColor=[UIColor lightGrayColor];
            self.paymentText2.userInteractionEnabled=NO;
            self.paymentText3.userInteractionEnabled=NO;
        }
        return  YES;
    }
    else if (textField==self.paymentText2)
    {
        if (self.paymentText2.text.length > 0) {
            self.paymentText3.text=@"";
            self.paymentText3.backgroundColor=[UIColor lightGrayColor];
            self.paymentText3.userInteractionEnabled=NO;
        }
        return  YES;
    }

    else
        return YES;
}
-(IBAction)applyTocheckAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    myappde.warningflag=1;
    if (button.tag==1) {
        if (self.y%2==0) {
            if (self.z%2==0) {
                [self.maleCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.y++;
                self.maleCheckValue=@"0";
            }
            
        }
        else
        {
            [self.maleCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.y++;
            self.maleCheckValue=@"1";
        }
    }
    else
    {
        if (self.z%2==0) {
            if (self.y%2==0) {
                [self.femaleCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.z++;
                self.femaleCheckValue=@"0";
            }
            
        }
        else
        {
            [self.femaleCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.z++;
            self.femaleCheckValue=@"1";
        }

    }
}
-(IBAction)checkBoxAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    myappde.warningflag=1;
    if (button.tag==1) {
        [self.chechBox1 setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        [self.chechBox2 setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
        
        
    }
    else
    {
        [self.chechBox2 setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        [self.chechBox1 setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];

    }
}
-(IBAction)switchButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        myappde.warningflag=1;
        if (self.s1%2==0) {
            self.switchPopUpView.hidden=false;
            self.flag=2;
            self.s1++;
            self.switchValue1=@"1";
        }
        else
        {
            [self.switchButton1 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
            self.flag=0;
            self.s1++;
            self.switchValue1=@"0";
        }
        
    }
    if (button.tag==2) {
        myappde.warningflag=1;
        if (self.s2%2==0) {
            [self.switchButton2 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];

            self.s2++;
            self.switchValue2=@"0";
        }
        else
        {
            [self.switchButton2 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
            self.s2++;
            self.switchValue2=@"1";
        }
        
    }

    if (button.tag==3) {
        myappde.warningflag=1;
        if (self.s3%2==0) {
            [self.switchButton3 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
            self.s3++;
            self.switchValue3=@"0";
        }
        else
        {
            [self.switchButton3 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
            self.s3++;
            self.switchValue3=@"1";
        }
        
    }

    if (button.tag==4) {
        myappde.warningflag=1;
        if (self.s4%2==0) {
            [self.switchButton4 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
            self.s4++;
            self.switchValue4=@"0";
        }
        else
        {
            [self.switchButton4 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
            self.s4++;
            self.switchValue4=@"1";
        }
        
    }

    if (button.tag==5) {
        myappde.warningflag=1;
        if (self.s5%2==0) {
            [self.switchButton5 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
            self.s5++;
            self.switchValue5=@"0";
        }
        else
        {
            [self.switchButton5 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
            self.s5++;
            self.switchValue5=@"1";
        }
        
    }

    if (button.tag==6) {
        myappde.warningflag=1;
        if (self.s6%2==0) {
            [self.switchButton6 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
            self.s6++;
            self.switchValue6=@"1";
        }
        else
        {
            [self.switchButton6 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
            self.s6++;
            self.switchValue6=@"0";
        }
        
    }

    if (button.tag==7) {
        myappde.warningflag=1;
        if (self.s7%2==0) {
            [self.switchButton7 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
            [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.s7++;
            self.switchValue7=@"1";
            self.firstCheckValue=@"1";
        }
        else
        {
            [self.switchButton7 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
            self.s7++;
            self.switchValue7=@"0";
        }
        
    }
    if (button.tag==8) {
        myappde.warningflag=1;
        if (self.s8%2==0) {
            [self.switchButton8 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
            for (UIView *myview in self.scrollView.subviews) {
                if ([myview isKindOfClass:[UIButton class]]) {
                    if([myview viewWithTag:8])
                    {
                        myview.userInteractionEnabled=YES;
                    }
                    else
                    {
                        myview.userInteractionEnabled=NO;
                    }
                }
                else
                {
                    myview.userInteractionEnabled=NO;
                }
            }
            [self.scrollView setAlpha:0.6];
            self.s8++;
            self.switchValue8=@"0";
        }
        else
        {
            [self.switchButton8 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
            for (UIView *myview in self.scrollView.subviews) {
                myview.userInteractionEnabled=YES;
            }
            [self.scrollView setAlpha:1.0];
            self.s8++;
            self.switchValue8=@"1";
        }
    }

}
-(IBAction)popUpDoneAction:(id)sender
{
    if (self.flag==1) {
        self.dropmandatoryLabel.hidden=false;
        self.dropText.hidden=false;
        self.dropTextImage.hidden=false;

    }
    else
    {
        [self.switchButton1 setImage:[UIImage imageNamed:@"button_1.png"] forState:UIControlStateNormal];
    }
    self.switchPopUpView.hidden=true;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView==self.carryForwardDropTextView) {
        self.carryForwardTC.hidden=false;
    }
    return  NO;
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string

{
    if ((textField==self.conditionText1)||(textField==self.conditionText2)||(textField==self.paymentText1)||(textField==self.paymentText2)||(textField==self.paymentText3)) {
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
            return YES;
        }
            
    }
    else if (textField==self.conditionText4) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=1) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
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
    else if ((textField==self.maxConsecutivedaysText) || (textField=self.dropText))
    {
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
            return YES;
        }
            
    }

    else
    {
        return YES;
    }
    return false;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField==self.conditionText1)
    {
        if (![self.conditionText1.text isEqualToString:@""]) {
            self.conditionText2.backgroundColor=[UIColor clearColor];
            self.conditionText2.enabled=YES;
        }
    }
        
    if (textField==self.conditionText2) {
        NSString *text=self.conditionText2.text;
        if (![text isEqualToString:@""]) {
            if (text.length>3) {
                
            }
            else
            {
                NSString *finalText=[NSString stringWithFormat:@"%@ Day(s)",text];
                self.conditionText2.text=finalText;
            }
            self.conditionText3.text=@"Month";
            self.conditionText3.enabled=YES;
            self.conditionText3.backgroundColor=[UIColor clearColor];
            self.saveButton.enabled=YES;

        }
        else
        {
            self.conditionText2.text=@"";
        }
    }
    else if (textField==self.maxConsecutivedaysText)
    {
        if (![self.maxConsecutivedaysText.text isEqualToString:@""]) {
            if (!(self.maxConsecutivedaysText.text.length > 3)) {
                NSString *text=self.maxConsecutivedaysText.text;
                NSString *finalText=[NSString stringWithFormat:@"%@ Day(s)",text];
                self.maxConsecutivedaysText.text=finalText;
            }
        }
    }
    else if (textField==self.paymentText1)
    {
        if (![self.paymentText1.text isEqualToString:@""]) {
            if (!(self.paymentText1.text.length > 3)) {
                NSString *text=self.paymentText1.text;
                NSString *finalText=[NSString stringWithFormat:@"%@ Day(s)",text];
                self.paymentText1.text=finalText;
                self.paymentText2.backgroundColor=[UIColor clearColor];
                self.paymentText2.userInteractionEnabled=YES;
            }
        }
    }
    else if (textField==self.paymentText2)
    {
        if (![self.paymentText2.text isEqualToString:@""]) {
            if (!(self.paymentText2.text.length > 3)) {
                NSString *text=self.paymentText2.text;
                NSString *finalText=[NSString stringWithFormat:@"%@ Day(s)",text];
                self.paymentText2.text=finalText;
                self.paymentText3.backgroundColor=[UIColor clearColor];
                self.paymentText3.userInteractionEnabled=YES;
            }
        }
    }
    else if (textField==self.paymentText3)
    {
        if (![self.paymentText3.text isEqualToString:@""]) {
            int value=[self.paymentText1.text intValue] + [self.paymentText2.text intValue];
            if ([self.paymentText3.text intValue]>= value) {
                self.paymentText3.textColor=[UIColor blackColor];
                self.saveButton.enabled=YES;
            }
            else
            {
                self.paymentText3.textColor=[UIColor redColor];
                self.saveButton.enabled=NO;
            }
            
            if (!(self.paymentText3.text.length > 3)) {
            
                NSString *text=self.paymentText3.text;
                NSString *finalText=[NSString stringWithFormat:@"%@ Day(s)",text];
                self.paymentText3.text=finalText;
            }
        }
    }
    else if (textField==self.conditionText4)
    {
        if (![self.conditionText4.text isEqualToString:@""]) {
            if ([self.conditionText4.text integerValue] > 31) {
                self.conditionText4.textColor=[UIColor redColor];
                self.saveButton.enabled=NO;
            }
            else
            {
                self.conditionText4.textColor=[UIColor blackColor];
                self.saveButton.enabled=YES;
            }
            if (!(self.conditionText4.text.length > 3)) {
                NSString *text=self.conditionText4.text;
                NSString *finalText=[NSString stringWithFormat:@"%@ Day(s)",text];
                self.conditionText4.text=finalText;
            }
        }
        

    }
    else if (textField==self.dropText)
    {
        if (![self.dropText.text isEqualToString:@""]) {
            if (([self.dropText.text integerValue] >1 ) && ([self.dropText.text integerValue] < 101)) {
                self.dropText.textColor=[UIColor blackColor];
                self.saveButton.enabled=YES;
            }
            else
            {
                self.dropText.textColor=[UIColor redColor];
                self.saveButton.enabled=NO;
            }
            if (!(self.dropText.text.length > 3)) {
                NSString *symbol=@"%";
                NSString *myString=[NSString stringWithFormat:@"%@ %@",self.dropText.text,symbol];
                self.dropText.text=myString;
            }
        }
    }
    
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (textField==self.conditionText1) {
        self.conditionText1.text=@"";
        self.conditionText2.backgroundColor=[UIColor lightGrayColor];
        self.conditionText3.backgroundColor=[UIColor lightGrayColor];
        self.conditionText3.text=@"";
        self.conditionText2.text=@"";
        self.conditionText2.enabled=NO;
        self.conditionText3.enabled=NO;
        self.saveButton.enabled=NO;
    }
    return  NO;
}

-(IBAction)saveButtonAction:(id)sender
{
    myappde.warningflag=0;
    myappde.designationFlag=0;
    
    NSMutableDictionary *leaveDetailsDict=[[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveDict"]];
    
    if (([[leaveDetailsDict objectForKey:@"leaveName"]length] > 0) && ([[leaveDetailsDict objectForKey:@"abbreviation"]length] > 0) && (self.conditionText4.text.length > 0) && (self.paymentText3.text.length > 0)) {
        
        if ([self.carryForwardDropFlag isEqualToString:@"1"]) {
            if (self.dropText.text.length > 0) {
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveAction"]isEqualToString:@"update"]) {
                    [self updateAction];
                }
                else
                {
                    [self saveAction];
                }
            }
            else
            {
                [self alertShow:@"Must enter all the mandatory field"];
            }
        }
        else
        {
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveAction"]isEqualToString:@"update"]) {
                [self updateAction];
            }
            else
            {
                [self saveAction];
            }

        }
        
        
        }
    else
    {
        [self alertShow:@"Must Enter All the Mandatory Field, Leave name and Abbrv. is also Mandatory"];
    }
    
    
    
    
    
    
    
     
//    for (UIView *myview in self.paymentStructureView.subviews) {
//        if (myview.tag==100) {
//            paymentViewsClass *obj=(paymentViewsClass *)myview;
//            NSLog(@"%@",obj.paymentText2.text);
//            
//        }
//    }
    
   

}

-(void)saveAction
{
    [myappde.conditionIDArray addObject:@"0"];
    AccordionView *ob = (AccordionView *)self.superview.superview;
    
    [ob addaccordianview];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"conditionAction"]isEqualToString:@"save"]) {
        
        NSMutableDictionary *leaveDetailsDict=[[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveDict"]];
        [leaveDetailsDict setObject:myappde.ruleID forKey:@"leave_id"];
        [leaveDetailsDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] forKey:@"office_id"];
        
        [self.leaveDict setObject:leaveDetailsDict forKey:@"leave_details"];
        
        NSString *selected=[self.selectedArray componentsJoinedByString:@"###"];
        
        NSString *designationList=@"";
        if (self.grouparray.count > 0) {
            designationList=[self.grouparray componentsJoinedByString:@"###"];
        }
        else
        {
            designationList=@"";
        }
        
        NSString *tileID;
        int row=myappde.selectedRow;
        tileID=[myappde.conditionIDArray objectAtIndex:row];
       

        NSMutableDictionary *conditionDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.conditionText1.text,@"leave_attendance_based_paid_leaves",self.conditionText2.text,@"leave_attendance_based_since_present",self.conditionText3.text,@"leave_attendance_based_drop_value",self.conditionText4.text,@"leave_max_per_month",self.conditionText5.text,@"leave_appl_month_of_join_date",self.self.paymentText1.text,@"leave_fully_paid_days",self.paymentText2.text,@"leave_half_paid_days",self.paymentText3.text,@"leave_max_quota_of_year",self.firstCheckValue,@"leave_allow_emp_req_online",self.secondCheckValue,@"leave_allow_emp_req",self.thirdCheckValue,@"leave_allow_deleg_req",self.dropText.text,@"leave_carry_fwd_perc",self.carryForwardDropTextView.text,@"leave_carry_fwd_option",self.maleCheckValue,@"leave_app_to_male",self.femaleCheckValue,@"leave_app_to_female",self.maxConsecutivedaysText.text,@"leave_max_consecutive",self.switchValue1,@"leave_pro_rate_leave",self.switchValue2,@"leave_holiday_interference",self.switchValue3,@"leave_off_day_interference",self.switchValue4,@"leave_permit_half_day_req",self.switchValue5,@"leave_appl_for_prev_days",self.switchValue6,@"leave_paid_redemption_delegate",self.switchValue7,@"leave_paid_redemption_emp",self.clubCheckValue,@"leave_club_with",selected,@"leave_club_with_value",self.switchValue8,@"leave_condition_status",[[NSUserDefaults standardUserDefaults]objectForKey:@"fullyPaidleaves"],@"leave_then_fully_paid_days",[[NSUserDefaults standardUserDefaults]objectForKey:@"halfPaidleaves"],@"leave_then_half_paid_days",[[NSUserDefaults standardUserDefaults]objectForKey:@"totalLeaves"],@"leave_then_max_quota_of_year",[[NSUserDefaults standardUserDefaults]objectForKey:@"expYear"],@"leave_exp_year",designationList,@"selected_designations",tileID,@"condition_id", nil];
        
        [self.leaveDict setObject:conditionDetailsDict forKey:@"conditional_details"];
        
        
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] count] > 0) {
            [self.leaveDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] forKey:@"designation_list"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
        }
        
        else
        {
            [self.leaveDict setObject:@"" forKey:@"designation_list"];
        }
        
        
        [self.myconnection leaveSaveNewTile:self.leaveDict];
        myappde.conditionCount++;
        
        
        //To be Noted
        
        //NSMutableArray *tileIDArray=[[NSMutableArray alloc]init];
        //[tileIDArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"conditionID"]];
        //[tileIDArray addObject:@"0"];
        //[[NSUserDefaults standardUserDefaults]setObject:tileIDArray forKey:@"conditionID"];
        
    }
    else
    {
        NSMutableDictionary *leaveDetailsDict=[[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveDict"]];
        [leaveDetailsDict setObject:myappde.ruleID forKey:@"leave_id"];
        [leaveDetailsDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] forKey:@"office_id"];
        
        [self.leaveDict setObject:leaveDetailsDict forKey:@"leave_details"];
        
        NSString *selected=[self.selectedArray componentsJoinedByString:@"###"];
        
        NSString *designationList=@"";
        if (self.grouparray.count > 0) {
            designationList=[self.grouparray componentsJoinedByString:@"###"];
        }
        else
        {
            designationList=@"";
        }
        
        NSString *tileID;
        int row=myappde.selectedRow;
        tileID=[myappde.conditionIDArray objectAtIndex:row];
        
        
        NSMutableDictionary *conditionDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.conditionText1.text,@"leave_attendance_based_paid_leaves",self.conditionText2.text,@"leave_attendance_based_since_present",self.conditionText3.text,@"leave_attendance_based_drop_value",self.conditionText4.text,@"leave_max_per_month",self.conditionText5.text,@"leave_appl_month_of_join_date",self.self.paymentText1.text,@"leave_fully_paid_days",self.paymentText2.text,@"leave_half_paid_days",self.paymentText3.text,@"leave_max_quota_of_year",self.firstCheckValue,@"leave_allow_emp_req_online",self.secondCheckValue,@"leave_allow_emp_req",self.thirdCheckValue,@"leave_allow_deleg_req",self.dropText.text,@"leave_carry_fwd_perc",self.carryForwardDropTextView.text,@"leave_carry_fwd_option",self.maleCheckValue,@"leave_app_to_male",self.femaleCheckValue,@"leave_app_to_female",self.maxConsecutivedaysText.text,@"leave_max_consecutive",self.switchValue1,@"leave_pro_rate_leave",self.switchValue2,@"leave_holiday_interference",self.switchValue3,@"leave_off_day_interference",self.switchValue4,@"leave_permit_half_day_req",self.switchValue5,@"leave_appl_for_prev_days",self.switchValue6,@"leave_paid_redemption_delegate",self.switchValue7,@"leave_paid_redemption_emp",self.clubCheckValue,@"leave_club_with",selected,@"leave_club_with_value",self.switchValue8,@"leave_condition_status",[[NSUserDefaults standardUserDefaults]objectForKey:@"fullyPaidleaves"],@"leave_then_fully_paid_days",[[NSUserDefaults standardUserDefaults]objectForKey:@"halfPaidleaves"],@"leave_then_half_paid_days",[[NSUserDefaults standardUserDefaults]objectForKey:@"totalLeaves"],@"leave_then_max_quota_of_year",[[NSUserDefaults standardUserDefaults]objectForKey:@"expYear"],@"leave_exp_year",designationList,@"selected_designations",tileID,@"condition_id", nil];
        
        [self.leaveDict setObject:conditionDetailsDict forKey:@"conditional_details"];
        
        
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] count] > 0) {
            [self.leaveDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] forKey:@"designation_list"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
        }
        else
        {
            [self.leaveDict setObject:@"" forKey:@"designation_list"];
        }
        
        [self.myconnection updateLeaveSettings:self.leaveDict];
    }
    
    
    
    
}
-(void)updateAction
{
    //Save inside update
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"conditionAction"]isEqualToString:@"save"]) {
        
        NSMutableDictionary *leaveDetailsDict=[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveDict"];
        
        [self.leaveDict setObject:leaveDetailsDict forKey:@"leave_details"];
        
        NSString *selected=[self.selectedArray componentsJoinedByString:@"###"];
        
        NSString *designationList=@"";
        if (self.grouparray.count > 0) {
            designationList=[self.grouparray componentsJoinedByString:@"###"];
        }
        else
        {
            designationList=@"";
        }
        
        NSMutableDictionary *conditionDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.conditionText1.text,@"leave_attendance_based_paid_leaves",self.conditionText2.text,@"leave_attendance_based_since_present",self.conditionText3.text,@"leave_attendance_based_drop_value",self.conditionText4.text,@"leave_max_per_month",self.conditionText5.text,@"leave_appl_month_of_join_date",self.self.paymentText1.text,@"leave_fully_paid_days",self.paymentText2.text,@"leave_half_paid_days",self.paymentText3.text,@"leave_max_quota_of_year",self.firstCheckValue,@"leave_allow_emp_req_online",self.secondCheckValue,@"leave_allow_emp_req",self.thirdCheckValue,@"leave_allow_deleg_req",self.dropText.text,@"leave_carry_fwd_perc",self.carryForwardDropTextView.text,@"leave_carry_fwd_option",self.maleCheckValue,@"leave_app_to_male",self.femaleCheckValue,@"leave_app_to_female",self.maxConsecutivedaysText.text,@"leave_max_consecutive",self.switchValue1,@"leave_pro_rate_leave",self.switchValue2,@"leave_holiday_interference",self.switchValue3,@"leave_off_day_interference",self.switchValue4,@"leave_permit_half_day_req",self.switchValue5,@"leave_appl_for_prev_days",self.switchValue6,@"leave_paid_redemption_delegate",self.switchValue7,@"leave_paid_redemption_emp",self.clubCheckValue,@"leave_club_with",selected,@"leave_club_with_value",self.switchValue8,@"leave_condition_status",[[NSUserDefaults standardUserDefaults]objectForKey:@"fullyPaidleaves"],@"leave_then_fully_paid_days",[[NSUserDefaults standardUserDefaults]objectForKey:@"halfPaidleaves"],@"leave_then_half_paid_days",[[NSUserDefaults standardUserDefaults]objectForKey:@"totalLeaves"],@"leave_then_max_quota_of_year",[[NSUserDefaults standardUserDefaults]objectForKey:@"expYear"],@"leave_exp_year",designationList,@"selected_designations", nil];
        
        [self.leaveDict setObject:conditionDetailsDict forKey:@"conditional_details"];
        
        
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] count] > 0) {
            [self.leaveDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] forKey:@"designation_list"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
        }
        else
        {
            [self.leaveDict setObject:@"" forKey:@"designation_list"];
        }
        
        [self.myconnection leaveSaveNewTile:self.leaveDict];
        
        //To be Noted
        
        //NSMutableArray *tileIDArray=[[NSMutableArray alloc]init];
        //[tileIDArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"conditionID"]];
        //[tileIDArray addObject:@"0"];
        //[[NSUserDefaults standardUserDefaults]setObject:tileIDArray forKey:@"conditionID"];
        
    }
    
    //Update inside update
    
    else
    {
        NSMutableDictionary *leaveDetailsDict=[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveDict"];
        
        [self.leaveDict setObject:leaveDetailsDict forKey:@"leave_details"];
        
        NSString *selected=[self.selectedArray componentsJoinedByString:@"###"];
        NSString *tileID;
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveAction"]isEqualToString:@"update"]) {
            //NSMutableArray *tileIDArray=[[NSMutableArray alloc]init];
            //[tileIDArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"conditionID"]];
            int row=myappde.selectedRow;
            tileID=[myappde.conditionIDArray objectAtIndex:row];
        }
        
        NSString *designationList=@"";
        if (self.grouparray.count > 0) {
            designationList=[self.grouparray componentsJoinedByString:@"###"];
        }
        else
        {
            designationList=@"";
        }
        
        
        
        NSMutableDictionary *conditionDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.conditionText1.text,@"leave_attendance_based_paid_leaves",self.conditionText2.text,@"leave_attendance_based_since_present",self.conditionText3.text,@"leave_attendance_based_drop_value",self.conditionText4.text,@"leave_max_per_month",self.conditionText5.text,@"leave_appl_month_of_join_date",self.self.paymentText1.text,@"leave_fully_paid_days",self.paymentText2.text,@"leave_half_paid_days",self.paymentText3.text,@"leave_max_quota_of_year",self.firstCheckValue,@"leave_allow_emp_req_online",self.secondCheckValue,@"leave_allow_emp_req",self.thirdCheckValue,@"leave_allow_deleg_req",self.dropText.text,@"leave_carry_fwd_perc",self.carryForwardDropTextView.text,@"leave_carry_fwd_option",self.maleCheckValue,@"leave_app_to_male",self.femaleCheckValue,@"leave_app_to_female",self.maxConsecutivedaysText.text,@"leave_max_consecutive",self.switchValue1,@"leave_pro_rate_leave",self.switchValue2,@"leave_holiday_interference",self.switchValue3,@"leave_off_day_interference",self.switchValue4,@"leave_permit_half_day_req",self.switchValue5,@"leave_appl_for_prev_days",self.switchValue6,@"leave_paid_redemption_delegate",self.switchValue7,@"leave_paid_redemption_emp",self.clubCheckValue,@"leave_club_with",selected,@"leave_club_with_value",self.switchValue8,@"leave_condition_status",[[NSUserDefaults standardUserDefaults]objectForKey:@"fullyPaidleaves"],@"leave_then_fully_paid_days",[[NSUserDefaults standardUserDefaults]objectForKey:@"halfPaidleaves"],@"leave_then_half_paid_days",[[NSUserDefaults standardUserDefaults]objectForKey:@"totalLeaves"],@"leave_then_max_quota_of_year",[[NSUserDefaults standardUserDefaults]objectForKey:@"expYear"],@"leave_exp_year",tileID,@"condition_id",designationList,@"selected_designations", nil];
        
        [self.leaveDict setObject:conditionDetailsDict forKey:@"conditional_details"];
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] count] > 0) {
            [self.leaveDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] forKey:@"designation_list"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
        }
        else
        {
            [self.leaveDict setObject:@"" forKey:@"designation_list"];
        }
        
        [self.myconnection updateLeaveSettings:self.leaveDict];
    }
}
-(void)changeyourframe
{
    
    NSString *action=[[NSUserDefaults standardUserDefaults]objectForKey:@"radioButtonSelection"];
    
    if ([action isEqualToString:@"3"]) {
        self.firstView.hidden=false;
        if ((self.conditionText1.text.length > 0) && (self.conditionText2.text.length > 0) && (self.conditionText3.text .length > 0)) {
            self.saveButton.enabled=YES;
        }
        else
            self.saveButton.enabled=NO;
        self.secondView.frame=CGRectMake(0, 64, self.secondView.frame.size.width, self.secondView.frame.size.height);
    }
    else
    {
        
        self.firstView.hidden=true;
        self.saveButton.enabled=YES;
       self.secondView.frame=CGRectMake(0, 32, self.secondView.frame.size.width, self.secondView.frame.size.height);
        
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

-(IBAction)popupButtonAction:(id)sender
{
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=NO;
    }
    self.switchButton8.userInteractionEnabled=FALSE;
    self.saveButton.userInteractionEnabled=FALSE;
    
    AccordionView *obhh = (AccordionView *)self.superview.superview;
    [obhh disabledfunction];
    
    myappde.action=@"popup";
    self.saveButton.enabled=NO;
    
    
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"carryforwardPopUpView" owner:self options:nil];
        [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    }
    else if (button.tag==2)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"proratePopUpView" owner:self options:nil];
        [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    }
    else if (button.tag==3)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"holidayPopUpView" owner:self options:nil];
        [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
        
    }
    else if (button.tag==4)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"offdayIneterferenceView" owner:self options:nil];
        [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    }
    else if (button.tag==5)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"applyforPreviousdaysPopupView" owner:self options:nil];
        [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    }
    else if (button.tag==6)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"paidLeavePopupView" owner:self options:nil];
        [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    }
    else if (button.tag==7)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"clubPopupView" owner:self options:nil];
        [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    }
    
}
-(void)willRemoveSubview:(UIView *)subview
{
    settingsleaveviewsclass *ob = (settingsleaveviewsclass *)self.superview.superview.superview;
    [ob enabledabledradiobuttons];
    self.saveButton.enabled=YES;
}
-(void)slideToRightWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer.view.tag==1) {
        myappde.warningflag=1;
        self.switchPopUpView.hidden=false;
        self.s1++;
        self.switchValue1=@"1";
    }
    else if (gestureRecognizer.view.tag==2) {
        myappde.warningflag=1;
        [self.switchButton2 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
        self.s2++;
        self.switchValue2=@"1";
    }
    else if (gestureRecognizer.view.tag==3) {
        myappde.warningflag=1;
        [self.switchButton3 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
        self.s3++;
        self.switchValue3=@"1";
    }
    else if (gestureRecognizer.view.tag==4) {
        myappde.warningflag=1;
        [self.switchButton4 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
        self.s4++;
        self.switchValue4=@"1";
    }
    else if (gestureRecognizer.view.tag==5) {
        myappde.warningflag=1;
        [self.switchButton5 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
        self.s5++;
        self.switchValue5=@"1";
    }
    else if (gestureRecognizer.view.tag==6) {
        myappde.warningflag=1;
        [self.switchButton6 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
        self.s6++;
        self.switchValue6=@"1";
    }
    else if (gestureRecognizer.view.tag==7) {
        myappde.warningflag=1;
        [self.switchButton7 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
        [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.firstCheckValue=@"1";
        self.s7++;
        self.switchValue7=@"1";
    }
    else if (gestureRecognizer.view.tag==8) {
        
        [self.switchButton8 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
        for (UIView *myview in self.scrollView.subviews) {
            myview.userInteractionEnabled=YES;
        }
        self.s8++;
        [self.scrollView setAlpha:1.0];
        self.switchValue7=@"1";
    }
    
   
    
}



-(void)slideToLeftWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    
    if (gestureRecognizer.view.tag==1) {
        myappde.warningflag=1;
        [self.switchButton1 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        self.s1++;
    }
    else if (gestureRecognizer.view.tag==2) {
        myappde.warningflag=1;
        [self.switchButton2 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        self.s2++;
    }
    else if (gestureRecognizer.view.tag==3) {
        myappde.warningflag=1;
        [self.switchButton3 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        self.s3++;
    }
    else if (gestureRecognizer.view.tag==4) {
        myappde.warningflag=1;
        [self.switchButton4 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        self.s4++;
    }
    else if (gestureRecognizer.view.tag==5) {
        myappde.warningflag=1;
        [self.switchButton5 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        self.s5++;
    }
    else if (gestureRecognizer.view.tag==6) {
        myappde.warningflag=1;
        [self.switchButton6 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        self.s6++;
    }
    else if (gestureRecognizer.view.tag==7) {
        myappde.warningflag=1;
        [self.switchButton7 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        self.s7++;
    }
    else if (gestureRecognizer.view.tag==8) {
        
        [self.switchButton8 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        
        for (UIView *myview in self.scrollView.subviews) {
            if ([myview isKindOfClass:[UIButton class]]) {
                if([myview viewWithTag:8])
                {
                    myview.userInteractionEnabled=YES;
                }
                else
                {
                    if ([myview viewWithTag:100]) {
                        myview.userInteractionEnabled=YES;
                    }
                    else
                        myview.userInteractionEnabled=NO;
                }
            }
            else
            {
                myview.userInteractionEnabled=NO;
            }
        }
        self.s8++;
        [self.scrollView setAlpha:0.6];
    }
}
-(IBAction)valueChangedAction:(id)sender
{
    if (![self.conditionText1.text isEqualToString:@""]) {
        myappde.warningflag=1;
    }
    else
    {
        myappde.warningflag=0;
    }
    self.conditionText2.backgroundColor=[UIColor lightGrayColor];
    self.conditionText3.backgroundColor=[UIColor lightGrayColor];
    self.conditionText3.text=@"";
    self.conditionText2.text=@"";
    self.conditionText2.enabled=NO;
    self.conditionText3.enabled=NO;
    self.saveButton.enabled=NO;
}
-(IBAction)valueChangedAction1:(id)sender
{
    if ((![self.conditionText2.text isEqualToString:@""]) || (![self.conditionText4.text isEqualToString:@""]) || (![self.paymentText1.text isEqualToString:@""]) || (![self.paymentText2.text isEqualToString:@""]) || (![self.paymentText3.text isEqualToString:@""]) || (![self.maxConsecutivedaysText.text isEqualToString:@""]) || (![self.dropText.text isEqualToString:@""])) {
        myappde.warningflag=1;
    }
    else
    {
        myappde.warningflag=0;

    }

}
-(void)collectionViewReload:(NSMutableArray *)desigArray
{
    [self.grouparray removeAllObjects];
    self.mycollectionview.hidden=false;
    [self.grouparray addObjectsFromArray:desigArray];
    [self.mycollectionview reloadData];
}
-(IBAction)removegroupfromcollectionview:(id)sender
{
    groupcollceioncellclass *clickedCell = (groupcollceioncellclass *)[[sender superview] superview];
    self.indexpath = [self.mycollectionview indexPathForCell:clickedCell];
    [self.grouparray removeObjectAtIndex:self.indexpath.row];
    [self.mycollectionview reloadData];
}
- (void)handleaction:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.modifiedView.hidden=false;
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        self.modifiedView.hidden=true;
    }
}
-(void)clearAll
{
    self.conditionText1.text=@"";
    self.conditionText2.text=@"";
    self.conditionText3.text=@"";
    self.conditionText4.text=@"";
    self.conditionText5.text=@"1st";
    self.paymentText1.text=@"";
    self.paymentText2.text=@"";
    self.paymentText2.backgroundColor=[UIColor lightGrayColor];
    self.paymentText2.userInteractionEnabled=NO;
    self.paymentText3.text=@"";
    self.paymentText3.backgroundColor=[UIColor lightGrayColor];
    self.paymentText3.userInteractionEnabled=NO;
    self.dropText.text=@"";
    self.maxConsecutivedaysText.text=@"";
    
    [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    [self.checkButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    self.p=self.q=self.r=self.s=self.y=self.z=0;
    
    [self.maleCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    [self.femaleCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    [self.switchButton1 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
    [self.switchButton2 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
    [self.switchButton3 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
    [self.switchButton4 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
    [self.switchButton5 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
    [self.switchButton6 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
    [self.switchButton7 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
    [self.switchButton8 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
    self.s1=self.s2=self.s3=self.s4=self.s5=self.s6=self.s7=self.s8=0;
    
    [self.selectedArray removeAllObjects];
    [self.selectedArray addObjectsFromArray:self.leavesArray];
    
    [self.grouparray removeAllObjects];
    
    
    
}



//<<---------------------------------Response Part---------------------------------->>

-(void)serviceGotResponse:(id)responseData
{
    if ([responseData count] > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableDictionary *leaveDict=[responseData objectAtIndex:0];
            if ([leaveDict objectForKey:@"leave_attendance_based_paid_leaves"]!=(id)[NSNull null])
            {
                self.conditionText1.text=[leaveDict objectForKey:@"leave_attendance_based_paid_leaves"];
            }
            if ([leaveDict objectForKey:@"leave_attendance_based_since_present"]!=(id)[NSNull null])
            {
                 self.conditionText2.text=[leaveDict objectForKey:@"leave_attendance_based_since_present"];
                self.conditionText2.backgroundColor=[UIColor clearColor];
                self.conditionText2.userInteractionEnabled=YES;
                self.saveButton.enabled=YES;
            }
            if ([leaveDict objectForKey:@"leave_attendance_based_drop_value"]!=(id)[NSNull null])
            {
                self.conditionText3.text=[leaveDict objectForKey:@"leave_attendance_based_drop_value"];
                self.conditionText3.backgroundColor=[UIColor clearColor];
                self.conditionText3.userInteractionEnabled=YES;
            }
            if ([leaveDict objectForKey:@"leave_max_per_month"]!=(id)[NSNull null])
            {
                self.conditionText4.text=[leaveDict objectForKey:@"leave_max_per_month"];
            }
            if ([leaveDict objectForKey:@"leave_appl_month_of_join_date"]!=(id)[NSNull null])
            {
                self.conditionText5.text=[leaveDict objectForKey:@"leave_appl_month_of_join_date"];
            }
            if ([leaveDict objectForKey:@"leave_fully_paid_days"]!=(id)[NSNull null])
            {
                self.paymentText1.text=[leaveDict objectForKey:@"leave_fully_paid_days"];
            }
            if ([leaveDict objectForKey:@"leave_half_paid_days"]!=(id)[NSNull null])
            {
                self.paymentText2.text=[leaveDict objectForKey:@"leave_half_paid_days"];
            }
            if ([leaveDict objectForKey:@"leave_max_quota_of_year"]!=(id)[NSNull null])
            {
                self.paymentText3.text=[leaveDict objectForKey:@"leave_max_quota_of_year"];
            }
            self.paymentText2.userInteractionEnabled=YES;
            self.paymentText2.backgroundColor=[UIColor clearColor];
            self.paymentText3.userInteractionEnabled=YES;
            self.paymentText3.backgroundColor=[UIColor clearColor];
            if ([[leaveDict objectForKey:@"leave_allow_emp_req_online"]isEqualToString:@"1"]) {
                [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.firstCheckValue=@"1";
                self.p=0;
                
            }
            else
            {
                [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                [self.switchButton7 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
                [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.firstCheckValue=@"0";
                self.secondCheckValue=@"0";
                self.switchValue7=@"0";
                self.p=1;
            }
            if ([[leaveDict objectForKey:@"leave_allow_emp_req"]isEqualToString:@"1"]) {
                [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.q=1;
                self.secondCheckValue=@"1";
            }
            else
            {
                [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.secondCheckValue=@"0";
                self.q=0;
            }
            if ([[leaveDict objectForKey:@"leave_allow_deleg_req"]isEqualToString:@"1"]) {
                [self.checkButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.r=1;
                self.thirdCheckValue=@"1";
            }
            else
            {
                [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.thirdCheckValue=@"0";
                self.r=0;
            }
            if ([leaveDict objectForKey:@"leave_carry_fwd_perc"]!=(id)[NSNull null])
            {
                self.dropText.text=[leaveDict objectForKey:@"leave_carry_fwd_perc"];
            }
            if(self.dropText.text.length > 0)
            {
                self.dropText.hidden=false;
            }
            self.carryForwardDropTextView.text=[leaveDict objectForKey:@"leave_carry_fwd_option"];
            if (([[leaveDict objectForKey:@"leave_carry_fwd_option"]isEqualToString:@"Carry forward certain % of unused leaves to next year"]) || ([[leaveDict objectForKey:@"leave_carry_fwd_option"]isEqualToString:@"Repay certain  % of fully & half paid leaves at the end of the year and invalidate rest"])) {
                self.dropText.hidden=false;
                self.dropTextImage.hidden=false;
                self.dropmandatoryLabel.hidden=false;
                self.carryForwardDropFlag=@"1";
            }
            else
            {
                self.dropText.hidden=true;
                self.dropTextImage.hidden=true;
                self.dropmandatoryLabel.hidden=true;
                self.carryForwardDropFlag=@"0";
            }
            if ([[leaveDict objectForKey:@"leave_app_to_male"]isEqualToString:@"1"]) {
                [self.maleCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.maleCheckValue=@"1";
                self.y=0;
            }
            else
            {
                [self.maleCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.maleCheckValue=@"0";
                self.y=1;
            }
            if ([[leaveDict objectForKey:@"leave_app_to_female"]isEqualToString:@"1"]) {
                [self.femaleCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.femaleCheckValue=@"1";
                self.z=0;
            }
            else
            {
                [self.femaleCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.femaleCheckValue=@"0";
                self.z=1;
            }
            self.maxConsecutivedaysText.text=[leaveDict objectForKey:@"leave_max_consecutive"];
            if ([[leaveDict objectForKey:@"leave_pro_rate_leave"]isEqualToString:@"1"]) {
                [self.switchButton1 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
                self.s1=1;
                self.switchValue1=@"1";
            }
            else
            {
                [self.switchButton1 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
                self.switchValue1=@"0";
                self.s1=0;
            }
            if ([[leaveDict objectForKey:@"leave_holiday_interference"]isEqualToString:@"1"]) {
                [self.switchButton2 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
                self.switchValue2=@"1";
                self.s2=0;
            }
            else
            {
                [self.switchButton2 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
                self.switchValue2=@"0";
                self.s2=1;
            }
            if ([[leaveDict objectForKey:@"leave_off_day_interference"]isEqualToString:@"1"]) {
                [self.switchButton3 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
                self.switchValue3=@"1";
                self.s3=0;
            }
            else
            {
                [self.switchButton3 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
                self.switchValue3=@"0";
                self.s3=1;
            }
            if ([[leaveDict objectForKey:@"leave_permit_half_day_req"]isEqualToString:@"1"]) {
                [self.switchButton4 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
                self.switchValue4=@"1";
                self.s4=0;
            }
            else
            {
                [self.switchButton4 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
                self.switchValue4=@"0";
                self.s4=1;
            }
            if ([[leaveDict objectForKey:@"leave_appl_for_prev_days"]isEqualToString:@"1"]) {
                [self.switchButton5 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
                self.switchValue5=@"1";
                self.s5=0;
            }
            else
            {
                [self.switchButton5 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
                self.switchValue5=@"0";
                self.s5=1;
            }
            if ([[leaveDict objectForKey:@"leave_paid_redemption_delegate"]isEqualToString:@"1"]) {
                [self.switchButton6 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
                self.s6=1;
                self.switchValue6=@"1";
            }
            else
            {
                [self.switchButton6 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
                self.switchValue6=@"0";
                self.s6=0;
            }
            if ([[leaveDict objectForKey:@"leave_paid_redemption_emp"]isEqualToString:@"1"]) {
                [self.switchButton7 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
                self.s7=1;
                self.switchValue7=@"1";
            }
            else
            {
                [self.switchButton7 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
                self.switchValue7=@"0";
                self.s7=0;
            }
            
            [self.selectedArray removeAllObjects];
            if ([leaveDict objectForKey:@"leave_club_with_value"]!=(id)[NSNull null])
            {
                if (!([[leaveDict objectForKey:@"leave_club_with_value"]isEqualToString:@""]))
                {
                    [self.selectedArray addObjectsFromArray:[[leaveDict objectForKey:@"leave_club_with_value"]componentsSeparatedByString:@"###"]];
                    
                    if (self.selectedArray.count==0) {
                        self.leavesText.text=@"";
                        self.leavesText.placeholder=@"";
                    }
                    else
                    {
                        if (self.selectedArray.count>1) {
                            if (self.selectedArray.count == self.leavesArray.count) {
                                self.leavesText.text=@"        All";
                            }
                            else
                                self.leavesText.text=@"   Multiple";
                        }
                        else
                        {
                            self.leavesText.text=[NSString stringWithFormat:@"    %@",[self.selectedArray objectAtIndex:0]];
                        }
                    }
                    [self.exceptLeaveTableView reloadData];
                }
                
            }
            if ([[leaveDict objectForKey:@"leave_club_with"]isEqualToString:@"1"]) {
                [self.checkButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:    UIControlStateNormal];
                self.checkFlag=1;
                self.clubCheckValue=@"1";
                self.s=0;
            }
            else
            {
                [self.checkButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.leavesText.backgroundColor=[UIColor lightGrayColor];
                self.leavesText.enabled=NO;
                self.leavesText.text=@"";
                self.checkFlag=0;
                self.s=1;
                self.clubCheckValue=@"0";
                [self.selectedArray addObjectsFromArray:self.leavesArray];
            }
            
            if ([[leaveDict objectForKey:@"leave_condition_status"]isEqualToString:@"1"]) {
                [self.switchButton8 setImage:[UIImage imageNamed:@"button_2 (1).png"] forState: UIControlStateNormal];
                self.switchValue8=@"1";
                self.s8=0;
            }
            else
            {
                [self.switchButton8 setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
                for (UIView *myview in self.scrollView.subviews) {
                    if ([myview isKindOfClass:[UIButton class]]) {
                        if([myview viewWithTag:8])
                        {
                            myview.userInteractionEnabled=YES;
                        }
                        else
                        {
                            myview.userInteractionEnabled=NO;
                        }
                    }
                    else
                    {
                        myview.userInteractionEnabled=NO;
                    }
                }
                [self.scrollView setAlpha:0.6];
                self.switchValue8=@"0";
                self.s8=1;
            }
            [self.grouparray removeAllObjects];
            
            if ([leaveDict objectForKey:@"selected_designations"]!=(id)[NSNull null])
            {
                if (!([[leaveDict objectForKey:@"selected_designations"]isEqualToString:@""])) {
                    [self.grouparray addObjectsFromArray:[[leaveDict objectForKey:@"selected_designations"]componentsSeparatedByString:@"###"]];
                    [self.mycollectionview reloadData];
                    self.mycollectionview.hidden=false;
                }
                else
                {
                    [self.grouparray removeAllObjects];
                    [self.mycollectionview reloadData];
                }
            }
            else
            {
                [self.grouparray removeAllObjects];
                [self.mycollectionview reloadData];
            }
            NSString *payAdvanced=[NSString stringWithFormat: @"%@###%@###%@###%@",[leaveDict objectForKey:@"leave_then_fully_paid_days"],[leaveDict objectForKey:@"leave_then_half_paid_days"],[leaveDict objectForKey:@"leave_then_max_quota_of_year"],[leaveDict objectForKey:@"leave_exp_year"]];
            [[NSUserDefaults standardUserDefaults]setObject:payAdvanced forKey:@"paymentAdvanced"];
        });
    }
    
}


-(void)showalerviewcontroller:(NSString *)errorMessage
{
    AccordionView *ob = (AccordionView *)self.superview.superview;
    
    [ob closeTile];
    
}
-(void)alertShow:(NSString *)alertMessage
{
    NSLog(@"%@",self.superview.superview.superview.superview.superview.superview.superview);
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warnings"
                               message:[NSString stringWithFormat:@"%@",alertMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}
-(void)leaveAbbrivationlist:(NSMutableArray *)responseList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.leavesArray removeAllObjects];
        for (int i=0; i<responseList.count; i++) {
            NSMutableDictionary *myDict=[responseList objectAtIndex:i];
            [self.leavesArray addObject:[myDict objectForKey:@"leave_abbrv"]];
        }
        [self.selectedArray addObjectsFromArray:self.leavesArray];
        [self.exceptLeaveTableView reloadData];
    });
    
    
}
@end
