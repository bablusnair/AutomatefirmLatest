//
//  advanceGroupClass.m
//  
//
//  Created by leonine on 10/6/15.
//
//

#import "advanceGroupClass.h"
#import "advanceTileClass.h"
#import "AppDelegate.h"
#import "groupcollceioncellclass.h"
#import "advancesettingsviewclass.h"
#import "settingsViewController.h"
@implementation advanceGroupClass
@synthesize s1;
-(void)awakeFromNib
{
    myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewloadfunction) name:@"viewindividualfunction" object:Nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelfunction) name:@"cancelfunction" object:Nil];

    [self.myconnection leaveabbrivationservice:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    [self.mycollectionview registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableall) name:@"enableall" object:Nil];
    

    self.eligibilityString1=self.eligibilityString3=self.eligibilityString4=self.conditionString1=self.conditionString3=@"";
    self.x=0;
    self.y=0;
    s1=0;
    self.flag=1;
    self.selectedflag=1;
    self.z=0;
    self.radioString1=@"1";
    self.radioString2=@"0";
    self.radioString3=@"0";
    self.enableStaus=@"1";
    self.eligibilityText5.text=@"";
    self.selectedDesignation=@"";
//    self.text1=@"";
//    self.text1=@"";
    self.leaveArray=[[NSMutableArray alloc]init];//WithObjects:@"MTRN",@"VACT",@"ETRV",@"STVR",@"ODTY", nil];
    self.limitArray=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
    self.grouparray=[[NSMutableArray alloc]init];
    self.leaveView.hidden=true;
    self.selectedArray=[[NSMutableArray alloc]initWithArray:self.leaveArray];
    //[self.selectedArray addObjectsFromArray:self.leaveArray];
    self.istallmentLimitTableView.hidden=true;
    self.conditionsText2.enabled=NO;
    myappde.warningflag=0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    UISwipeGestureRecognizer *leftSwip1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    
    leftSwip1.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.switchButton addGestureRecognizer:leftSwip1];
    
    
    
    UISwipeGestureRecognizer *rightSwipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    
    rightSwipe1.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.switchButton addGestureRecognizer:rightSwipe1];
   
}
-(void)viewloadfunction
{
   // int idTile=[[NSUserDefaults standardUserDefaults]objectForKey:@"tileId"];
   // if (!([[[NSUserDefaults standardUserDefaults]objectForKey:@"advanceAction"] isEqualToString:@"create"])) {
   self.strId=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"tile"]];

    if (!([myappde.advanceTileIdDict objectForKey:self.strId]==Nil)) {
        advancesettingsviewclass *objj = (advancesettingsviewclass *)self.superview.superview.superview;
        objj.plusButton.userInteractionEnabled=FALSE;

      [[NSUserDefaults standardUserDefaults]setObject:@"update" forKey:@"advanceAction"];      
        [self.myconnection viewIndividualAdvanceRuleTileDetails:[myappde.advanceTileIdDict objectForKey:self.strId]];
    }
    else{
        [self cancelfunction];
    }
    
}
-(void)cancelfunction
{
    self.eligibilityText1.text=@"";
    self.eligibilityText2.text=@"";
    self.eligibilityText3.text=@"";
    self.eligibilityText4.text=@"";
    self.eligibilityText5.text=@"";
    self.conditionsText1.text=@"";
    self.conditionsText2.text=@"";
    self.conditionsText3.text=@"";
    self.radioString1=@"1";
    self.radioString1=@"0";
    self.radioString1=@"0";
    self.enableStaus=@"1";

 [self.checkBoxButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
 [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
 [self.checkBoxButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    [self.grouparray removeAllObjects];
    [self.selectedArray removeAllObjects];
    [self.mycollectionview reloadData];
    [self.exceptLeaveTableView reloadData];
}

#pragma mark CollectionView Delegate
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


#pragma mark tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.exceptLeaveTableView) {
        return self.leaveArray.count;
    }
    else
        return self.limitArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.exceptLeaveTableView) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        UIButton *newRadioButton;
        newRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        newRadioButton.frame = CGRectMake(30, 0, 15, 14.5);
        //[newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
        //[newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateSelected];
        cell.textLabel.text=[self.leaveArray objectAtIndex:indexPath.row];
       // NSMutableDictionary *dict = [self.leaveArray objectAtIndex:indexPath.row];
        //cell.textLabel.text=[dict objectForKey:@"leave_abbrv"];
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        cell.accessoryView = newRadioButton;
        //if (self.selectedflag==1) {
            //for (int i=0; i<self.leaveArray.count; i++) {
        
            //}
        //}
//        if ([self.selectedArray containsObject:[[self.leaveArray objectAtIndex:indexPath.row]objectForKey:@"leave_abbrv"]]) {
         if ([self.selectedArray containsObject:[self.leaveArray objectAtIndex:indexPath.row]]) {
            [newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        }
        else
        {
            [newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
        }
        return  cell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.limitArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize: 12];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.exceptLeaveTableView) {
        myappde.warningflag=1;
        if ([self.selectedArray containsObject:[self.leaveArray objectAtIndex:indexPath.row]]) {
            [self.selectedArray removeObject:[self.leaveArray objectAtIndex:indexPath.row]];
        }
        else
        {
                [self.selectedArray addObject:[self.leaveArray objectAtIndex:indexPath.row]];
        }
        [self.exceptLeaveTableView reloadData];

    }
    else
    {
        myappde.warningflag=1;
        self.eligibilityText2.text=[self.limitArray objectAtIndex:indexPath.row];
        self.istallmentLimitTableView.hidden=true;
    }
    
}

#pragma mark TextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.eligibilityText1) {
        //self.eligibilityText1.text=@"";
        return  YES;
    }
    else if (textField==self.eligibilityText3)
    {
        //self.eligibilityText3.text=@"";
        return YES;
    }
    else if (textField==self.eligibilityText4)
    {
        //self.eligibilityText4.text=@"";
        return YES;
    }
    else if (textField==self.checkBoxText1)
    {
        [self checkBoxAction1:self];
        return  NO;
    }
    else if(textField==self.checkBoxText2)
    {
        [self checkBoxAction2:self];
        return NO;
    }
    else if (textField==self.checkBoxText3)
    {

        [self checkBoxAction3:self];
        return NO;
    }
    else if (textField==self.conditionsText1)
    {
       // self.conditionsText1.text=@"";
        self.conditionsText2.enabled=NO;
        self.conditionsText2.text=@"";
        self.conditionsText2.backgroundColor=[UIColor lightGrayColor];
        return  YES;
    }
    else if (textField==self.conditionsText3)
    {
        //self.conditionsText3.text=@"";
        return YES;
    }
    else if(textField==self.conditionsText2)
    {
        self.leaveView.hidden=false;
        return  NO;
    }
    else if (textField==self.eligibilityText2)
    {
        self.istallmentLimitTableView.hidden=false;
        return NO;
    }
    else
        return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.eligibilityText1) {
        if (![self.eligibilityText1.text isEqualToString:@""]) {
            if(([self.eligibilityText1.text integerValue] >0) && ([self.eligibilityText1.text integerValue] < 101))
            {
                self.eligibilityText1.textColor=[UIColor blackColor];
                self.saveButton.enabled=YES;
            }
            else
            {
                self.eligibilityText1.textColor=[UIColor redColor];
                self.saveButton.enabled=NO;
            }
            if (!(self.eligibilityText1.text.length > 3)) {
                
                if ([self.eligibilityText1.text rangeOfString:@"%"].location == NSNotFound)
                {
                    self.eligibilityString1=self.eligibilityText1.text;
                    NSString *finalText=[NSString stringWithFormat:@"%@%% ",self.eligibilityText1.text];
                    self.eligibilityText1.text=finalText;
                }
            }
        }
        else
        {
            self.saveButton.enabled=YES;
        }
    }
    else if (textField==self.eligibilityText3)
    {
        if (![self.eligibilityText3.text isEqualToString:@""]) {
            
            if (!(self.eligibilityText3.text.length > 3)) {
                
                //Checks whether textfield contains no Character
                if ([_eligibilityText3.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location == NSNotFound) {
                    
                    self.eligibilityString3=self.eligibilityText3.text;
                    NSString *text=self.eligibilityText3.text;
                    NSString *finalText=[NSString stringWithFormat:@"%@ Days",text];
                    self.eligibilityText3.text=finalText;
                }
            }
        }
    }
    else if (textField==self.eligibilityText4)
    {
        if (![self.eligibilityText4.text isEqualToString:@""]) {
            
            if (!(self.eligibilityText4.text.length > 3)) {
                
                if ([_eligibilityText4.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location == NSNotFound) {
                    
                    self.eligibilityString4=self.eligibilityText4.text;
                    NSString *text=self.eligibilityText4.text;
                    NSString *finalText=[NSString stringWithFormat:@"%@ Days",text];
                    self.eligibilityText4.text=finalText;
                }
            }
        }
    }
    else if (textField==self.conditionsText3)
    {
        if (![self.conditionsText3.text isEqualToString:@""]) {
            
            
            if (!(self.conditionsText3.text.length > 3)) {
                
                if ([_conditionsText3.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location == NSNotFound)
                {
                    self.conditionString3=self.conditionsText3.text;
                    NSString *text=self.conditionsText3.text;
                    NSString *finalText=[NSString stringWithFormat:@"%@ Days",text];
                    self.conditionsText3.text=finalText;
                }
            }
        }
    }
    else if (textField==self.conditionsText1)
    {
        if (![self.conditionsText1.text isEqualToString:@""]) {
            
            if (!(self.conditionsText1.text.length > 3)) {
                if ([_conditionsText1.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location == NSNotFound)
                {
                    self.conditionString1=self.conditionsText1.text;
                    NSString *text=self.conditionsText1.text;
                    NSString *finalText=[NSString stringWithFormat:@"%@ Days",text];
                    self.conditionsText1.text=finalText;
                    self.conditionsText2.backgroundColor=[UIColor whiteColor];
                    self.conditionsText2.enabled=YES;
                }
                
            }
        }
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((textField==self.eligibilityText1) || (textField==self.conditionsText3)||(textField==self.eligibilityText3)||(textField==self.eligibilityText4)||(textField==self.conditionsText1)) {
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
        return  NO;
        
    }
    
    if (textField==self.eligibilityText5) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=8) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
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
#pragma mark Switch Button Action
-(IBAction)switchButtonAction:(id)sender
{
    if (self.s1%2==0) {
        [self.switchButton setImage:[UIImage imageNamed:@"button_2.png"] forState:UIControlStateNormal];
        for (UIView *myview in self.scrollView.subviews) {
            myview.userInteractionEnabled=NO;
        }
        self.s1++;
        [self.scrollView setAlpha:0.6];
    }
    else
    {
        [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
        for (UIView *myview in self.scrollView.subviews) {
            myview.userInteractionEnabled=YES;
        }
        self.s1++;
        [self.scrollView setAlpha:1.0];
    }
}
-(void)slideToRightWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    //AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //myappde.warningflag=1;
    [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=YES;
    }
    self.enableStaus=@"1";
    self.s1++;
    [self.scrollView setAlpha:1.0];
}
-(void)slideToLeftWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    //AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //myappde.warningflag=1;
    [self.switchButton setImage:[UIImage imageNamed:@"button_2.png"] forState:UIControlStateNormal];
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=NO;
    }
    self.enableStaus=@"0";
    
    self.s1++;
    [self.scrollView setAlpha:0.6];
}
#pragma mark Button Actions
-(IBAction)leaveDoneButtonAction:(id)sender
{
    if (self.selectedArray.count==0) {
        self.conditionsText2.text=@"";
        self.leaveView.hidden=true;
    }
    else
    {
        if (self.selectedArray.count>1) {
            if (self.selectedArray.count==self.leaveArray.count) {
                self.conditionsText2.text=@"All";
            }
            else
                self.conditionsText2.text=@"Multiple";
        }
        else
        {
            //NSIndexPath *inPath=[self.selectedArray objectAtIndex:0];
            self.conditionsText2.text=[self.selectedArray objectAtIndex:0];//[self.leaveArray objectAtIndex:inPath.row];
        }
        self.leaveView.hidden=true;
    }
}


-(IBAction)checkBoxAction1:(id)sender
{
    myappde.warningflag=1;
    if (self.x%2==0) {
        self.flag=0;
        [self.checkBoxButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.checkBoxButton2.backgroundColor=[UIColor lightGrayColor];
        self.x++;
        self.radioString1=@"0";
        self.radioString2=@"0";
        
    }
    else
    {
        self.checkBoxButton2.userInteractionEnabled=YES;
        self.flag=1;
        self.y=0;
        [self.checkBoxButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.checkBoxButton2.backgroundColor=[UIColor clearColor];
        self.x++;
        self.radioString1=@"1";

    }
}
-(IBAction)checkBoxAction2:(id)sender
{
    myappde.warningflag=1;
    if (self.flag==1) {
        self.checkBoxButton2.userInteractionEnabled=true;
        if (self.y%2==0) {
            [self.checkBoxButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.y++;
            self.radioString2=@"1";

        }
        else
        {
            [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.y++;
            self.radioString2=@"0";

        }
        
    }
    else
    {
        self.checkBoxButton2.userInteractionEnabled=false;
    }
}
-(IBAction)checkBoxAction3:(id)sender
{
    myappde.warningflag=1;
    if (self.z%2==0) {
        [self.checkBoxButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.z++;
        self.radioString3=@"1";

    }
    else
    {
        [self.checkBoxButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.z++;
        self.radioString3=@"0";

    }
}

-(IBAction)valueChangedAction:(id)sender
{
    if ((![self.eligibilityText1.text isEqualToString:@""]) || (![self.eligibilityText3.text isEqualToString:@""]) || (![self.eligibilityText4.text isEqualToString:@""]) || (![self.eligibilityText5.text isEqualToString:@""]) || (![self.conditionsText1.text isEqualToString:@""]) || (![self.conditionsText3.text isEqualToString:@""])) {
        myappde.warningflag=1;
    }
    else
    {
        myappde.warningflag=0;
        
    }

}
-(IBAction)includeDesignationButtonAction:(id)sender
{
    
  //  NSLog(@"%@",self.strId);
    myappde.warningflag=1;
    myappde.advance_tileId=[myappde.advanceTileIdDict objectForKey:self.strId];
   NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"includeDesignationView" owner:self options:nil];
    [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    

    NSLog(@"%@",self.superview.superview);
    
    for (UIView *myview in self.scrollView.subviews) {
        
        
        myview.userInteractionEnabled=NO;
        
        
    }
    
    
    self.switchButton.userInteractionEnabled=FALSE;
    self.saveButton.userInteractionEnabled=FALSE;
    advancesettingsviewclass *objj = (advancesettingsviewclass *)self.superview.superview.superview;
    objj.cancelbutton.userInteractionEnabled=FALSE;
    objj.plusButton.userInteractionEnabled=FALSE;
    objj.donebutton.userInteractionEnabled=FALSE;
    
    advanceTileClass *obhh = (advanceTileClass *)self.superview.superview;
    [obhh disabledfunction];
    
}
-(IBAction)saveButtonAction:(id)sender
{
   
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"tileId"]);
    NSString *paasingleaveString=[self.selectedArray componentsJoinedByString:@"###"];
    self.selectedDesignation=[[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"]componentsJoinedByString:@"###"];
    NSMutableDictionary * dict= [[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"];
    if ((self.eligibilityText1.text.length>0) &&(self.eligibilityText2.text>0)) {
    
    
    if (!([myappde.advanceTileIdDict objectForKey:self.strId]==Nil)) {

    //[self.myconnection updateNewAdvanceRule:self.eligibilityText1.text instalment:self.eligibilityText2.text visaDuration:self.eligibilityText3.text eligibleMonths:self.eligibilityText4.text pendingLoanAmount:self.eligibilityText5.text nextApprovedLeave:self.conditionsText1.text leavesTypeAbrvation:paasingleaveString lastwrkingDay:self.conditionsText3.text radioButton1:self.radioString1 radioButton2:self.radioString2 radioButton3:self.radioString3 ruleId:[[NSUserDefaults standardUserDefaults]objectForKey:@"advance_ruleId"] tileId:[myappde.advanceTileIdDict objectForKey:self.strId] selecetdDesig:selectedDesignation enableStatus:@"1"];
       // myappde.advance_ruleId=[[NSUserDefaults standardUserDefaults]objectForKey:@"advance_ruleId"];
               [self.myconnection updateNewAdvanceRule:self.eligibilityString1 instalment:self.eligibilityText2.text visaDuration:self.eligibilityString3 eligibleMonths:self.eligibilityString4 pendingLoanAmount:self.eligibilityText5.text nextApprovedLeave:self.conditionString1 leavesTypeAbrvation:paasingleaveString lastwrkingDay:self.conditionString3 radioButton1:self.radioString1 radioButton2:self.radioString2 radioButton3:self.radioString3 ruleId:[[NSUserDefaults standardUserDefaults]objectForKey:@"advance_ruleId"] tileId:[myappde.advanceTileIdDict objectForKey:self.strId] selecetdDesig:self.selectedDesignation enableStatus:self.enableStaus abbrevationText:self.conditionsText2.text designationList:dict officeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        

    }
    else{
//        [self.myconnection createNewAdvanceRule:self.eligibilityText1.text instalment:self.eligibilityText2.text visaDuration:self.eligibilityText3.text eligibleMonths:self.eligibilityText4.text pendingLoanAmount:self.eligibilityText5.text nextApprovedLeave:self.conditionsText1.text leavesTypeAbrvation:paasingleaveString lastwrkingDay:self.conditionsText3.text radioButton1:self.radioString1 radioButton2:self.radioString2 radioButton3:self.radioString3 ruleId:[[NSUserDefaults standardUserDefaults]objectForKey:@"advance_ruleId"] tileId:[myappde.advanceTileIdDict objectForKey:self.strId] selecetdDesig:selectedDesignation enableStatus:@"1"];
        [self.myconnection createNewAdvanceRule:self.eligibilityString1 instalment:self.eligibilityText2.text visaDuration:self.eligibilityString3 eligibleMonths:self.eligibilityString4 pendingLoanAmount:self.eligibilityText5.text nextApprovedLeave:self.conditionString1 leavesTypeAbrvation:paasingleaveString lastwrkingDay:self.conditionString3 radioButton1:self.radioString1 radioButton2:self.radioString2 radioButton3:self.radioString3 ruleId:[[NSUserDefaults standardUserDefaults]objectForKey:@"advance_ruleId"] tileId:[myappde.advanceTileIdDict objectForKey:self.strId] selecetdDesig:self.selectedDesignation enableStatus:self.enableStaus abbrevationText:self.conditionsText2.text designationList:dict officeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];


        }
    }
    else{
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Mandatory"
                                   message:[NSString stringWithFormat:@"%@",@"Please Enter The Mandatory Fields"]
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
    myappde.warningflag=0;
    
    //[ob addaccordianview];
}




#pragma mark Functions and Notifications
- (void) keyboardDidShow:(NSNotification *)notification
{
    
    
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height-14, 0.0);
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

-(void)collectionViewReload:(NSMutableArray *)desigArray
{
    self.mycollectionview.hidden=false;
    [self.grouparray removeAllObjects];
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
-(void)enableall
{
    
    
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=YES;
    }
    
    self.switchButton.userInteractionEnabled=TRUE;
    self.saveButton.userInteractionEnabled=TRUE;
    
    advancesettingsviewclass *objj = (advancesettingsviewclass *)self.superview.superview.superview;
    objj.cancelbutton.userInteractionEnabled=TRUE;
    objj.plusButton.userInteractionEnabled=TRUE;
    objj.donebutton.userInteractionEnabled=TRUE;
    
    advanceTileClass *obhh = (advanceTileClass *)self.superview.superview;
    [obhh enabledfunction];
}
#pragma mark Service Response
//leave Abbrivation response
-(void)leaveAbbrivationlist:(NSMutableArray *)responseList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (responseList.count>0) {
            
            [self.leaveArray removeAllObjects];
            for (int i=0; i<[responseList count]; i++) {
                [self.leaveArray addObject:[[responseList objectAtIndex:i]objectForKey:@"leave_abbrv"]];
            }
           // [self.leaveArray addObjectsFromArray:responseList];
            NSLog(@"%@",self.leaveArray);
            [self.exceptLeaveTableView reloadData];
        }
        
    });
    
}
-(void)viewIndividualResponse:(id)responseList
{
   if ([responseList count]>0) {
        
       dispatch_async(dispatch_get_main_queue(), ^{
        
           myappde.advance_ruleId=[[responseList objectAtIndex:0]objectForKey:@"adv_id"];
           myappde.advance_tileId=[[responseList objectAtIndex:0]objectForKey:@"con_id"];
           
           self.eligibilityString1=[[responseList objectAtIndex:0]objectForKey:@"gross_salary"];
           if (self.eligibilityString1.length>0) {
               self.eligibilityText1.text=[NSString stringWithFormat:@"%@%%",[[responseList objectAtIndex:0]objectForKey:@"gross_salary"]];
           }
           
           if ([[responseList objectAtIndex:0]objectForKey:@"insatllment_limit"]!=(id)[NSNull null])
           {
               
               self.eligibilityText2.text=[[responseList objectAtIndex:0]objectForKey:@"insatllment_limit"];
           }
           if ([[responseList objectAtIndex:0]objectForKey:@"duration_of_visa"]!=(id)[NSNull null])
           {
               self.eligibilityString3=[[responseList objectAtIndex:0]objectForKey:@"duration_of_visa"];
               if (self.eligibilityString3.length>0) {
                   self.eligibilityText3.text=[NSString stringWithFormat:@"%@ D",[[responseList objectAtIndex:0]objectForKey:@"duration_of_visa"]];
               }
               
           }
           if ([[responseList objectAtIndex:0]objectForKey:@"eligible_for_advance"]!=(id)[NSNull null])
           {
               self.eligibilityString4=[[responseList objectAtIndex:0]objectForKey:@"eligible_for_advance"];
               if (self.eligibilityString4.length>0) {
                   self.eligibilityText4.text=[NSString stringWithFormat:@"%@ Days",[[responseList objectAtIndex:0]objectForKey:@"eligible_for_advance"]];
               }
               
               
           }
           if ([[responseList objectAtIndex:0]objectForKey:@"pending_loan"]!=(id)[NSNull null])
           {
               
               self.eligibilityText5.text=[[responseList objectAtIndex:0]objectForKey:@"pending_loan"];
           }
           if ([[responseList objectAtIndex:0]objectForKey:@"next_leave_to_approve"]!=(id)[NSNull null])
           {
               self.conditionString3=[[responseList objectAtIndex:0]objectForKey:@"next_leave_to_approve"];
               if (self.conditionString3.length>0) {
                   self.conditionsText1.text=[NSString stringWithFormat:@"%@ Days",[[responseList objectAtIndex:0]objectForKey:@"next_leave_to_approve"]];
               }
               
           }
           if ([[responseList objectAtIndex:0]objectForKey:@"except_leaves_field_value"]!=(id)[NSNull null])
           {
               self.conditionsText2.text=[[responseList objectAtIndex:0]objectForKey:@"except_leaves_field_value"];
           }
           if ([[responseList objectAtIndex:0]objectForKey:@"last_working_day"]!=(id)[NSNull null])
           {
               self.conditionString1=[[responseList objectAtIndex:0]objectForKey:@"last_working_day"];
               if (self.conditionString1.length>0) {
                   self.conditionsText3.text=[NSString stringWithFormat:@"%@ D",[[responseList objectAtIndex:0]objectForKey:@"last_working_day"]];
               }
               
           }
           if ([[responseList objectAtIndex:0]objectForKey:@"advance_online"]!=(id)[NSNull null])
           {
               self.enableStaus=[[responseList objectAtIndex:0]objectForKey:@"enable_status"];
           }
           if ([[responseList objectAtIndex:0]objectForKey:@"advance_online"]!=(id)[NSNull null])
           {
               
               self.radioString1=[[responseList objectAtIndex:0]objectForKey:@"advance_online"];
           }
           if ([[responseList objectAtIndex:0]objectForKey:@"forward_request"]!=(id)[NSNull null])
           {
               self.radioString2=[[responseList objectAtIndex:0]objectForKey:@"forward_request"];
           }
           if ([[responseList objectAtIndex:0]objectForKey:@"requirement_not_met"]!=(id)[NSNull null])
           {
               self.radioString3=[[responseList objectAtIndex:0]objectForKey:@"requirement_not_met"];
           }
           [self.selectedArray removeAllObjects];
           [self.grouparray removeAllObjects];
           if ([[responseList objectAtIndex:0]objectForKey:@"selected_desig"]!=(id)[NSNull null])
           {
               
               [self.grouparray addObjectsFromArray:[[[responseList objectAtIndex:0]objectForKey:@"selected_desig"]componentsSeparatedByString:@"###"]];
           }
           [self.mycollectionview reloadData];
           
           if ([[responseList objectAtIndex:0]objectForKey:@"except_leaves"]!=(id)[NSNull null])
           {
               [self.selectedArray addObjectsFromArray:[[[responseList objectAtIndex:0]objectForKey:@"except_leaves"]componentsSeparatedByString:@"###"]];
               
           }
           [self.exceptLeaveTableView reloadData];
           //self.radioString3=[[responseList objectAtIndex:0]objectForKey:@"requirement_not_met"];
           if (self.radioString2!=(id)[NSNull null])
           {
               if ([self.radioString2 isEqualToString:@"1"]) {
                   [self.checkBoxButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
               }
               else{
                   [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                   
               }
           }
           if (self.radioString1!=(id)[NSNull null])
           {
               if ([self.radioString1 isEqualToString:@"1"]) {
                   [self.checkBoxButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
               }
               else{
                   [self.checkBoxButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                   
               }
           }
           if (self.radioString3!=(id)[NSNull null])
           {
               if ([self.radioString3 isEqualToString:@"1"]) {
                   [self.checkBoxButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
               }
               else{
                   [self.checkBoxButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                   
               }
           }
           NSString *symbolString=@"%";
           NSString *finalText=[NSString stringWithFormat:@"%@ %@ ",self.eligibilityText1.text,symbolString];
           self.eligibilityText1.text=finalText;
           
           
           if (!(self.eligibilityText3.text.length > 2)) {
               NSString *text=self.eligibilityText3.text;
               NSString *finalText=[NSString stringWithFormat:@"%@ M",text];
               self.eligibilityText3.text=finalText;
           }
           if (!(self.eligibilityText3.text.length > 2)) {
               NSString *text=self.eligibilityText3.text;
               NSString *finalText=[NSString stringWithFormat:@"%@ M",text];
               self.eligibilityText3.text=finalText;
           }
           if (!(self.conditionsText1.text.length > 2)) {
               NSString *text=self.conditionsText1.text;
               NSString *finalText=[NSString stringWithFormat:@"%@ M",text];
               self.conditionsText1.text=finalText;
               self.conditionsText2.backgroundColor=[UIColor whiteColor];
               self.conditionsText2.enabled=YES;
               
           }
           //if (![self.conditionsText3.text isEqualToString:@""]) {
           if (!(self.conditionsText3.text.length > 3)) {
               NSString *text=self.conditionsText3.text;
               NSString *finalText=[NSString stringWithFormat:@"%@ Day(s) ",text];
               self.conditionsText3.text=finalText;
           }
           if (!(self.eligibilityText4.text.length > 2)) {
               NSString *text=self.eligibilityText4.text;
               NSString *finalText=[NSString stringWithFormat:@"%@ Month(s) ",text];
               self.eligibilityText4.text=finalText;
           }
    
       });
   
   }
    
}

-(void)createResponse:(id)Response
{
    advanceTileClass *ob = (advanceTileClass *)self.superview.superview;

    if ([Response containsString:@"###"]) {
        
    
    [myappde.advanceTileIdDict setObject:[[Response componentsSeparatedByString:@"###"] objectAtIndex:2] forKey:self.strId];
    NSLog(@"%@",myappde.advanceTileIdDict);
    }
    advancesettingsviewclass *objj = (advancesettingsviewclass *)self.superview.superview.superview;
    objj.plusButton.userInteractionEnabled=TRUE;
    [ob closeTile];
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesig"];
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];

    
}


-(void)showalerviewcontroller:(NSString *)alertMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@" Warning..."
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
@end
