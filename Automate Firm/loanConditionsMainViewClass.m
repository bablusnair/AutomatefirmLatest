//
//  loanConditionsMainViewClass.m
//  Automate Firm
//
//  Created by leonine on 11/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "loanConditionsMainViewClass.h"
#import "loanTileClass.h"
#import "AppDelegate.h"
#import "groupcollceioncellclass.h"
#import "settingsViewController.h"
#import "loansettingsviewclass.h"
@implementation loanConditionsMainViewClass
@synthesize s1,x,y,z,flag;
-(void)awakeFromNib
{
    
    [super awakeFromNib];
        
    self.myconnection=[[connectionclass alloc] init];
    self.myconnection.mydelegate=self;
    
    
    self.switchButtonstring=@"1";
    self.checkbuttonstring1=@"1";
    self.checkbuttonstring2=@"0";
    self.checkbuttonstring3=@"0";
    
    
    
    self.maxLoanAmount.text=self.pendingLoanAmount.text=self.exceptleavestring=self.service_eligiblemonthtext=self.service_lastworkingdaytext= self.service_nextapprovedtext=self.service_visaexpirationtext=self.interestString=@"";
    
     AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
       [self.mycollectionview registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
    
    self.grouparray=[[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(groupsarrayaction) name:@"grouparray" object:Nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updationloandetails) name:@"loaddetails" object:Nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableall) name:@"enableall" object:Nil];

    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loanfirstlookaction) name:@"initialdiscards" object:Nil];
    
    
    
    self.x=0;
    self.y=0;
    self.z=0;
    self.flag=1;
    s1=0;
    self.maxDurationTC.hidden=true;
    self.leaveView.hidden=true;
    self.exceptLeaveText.userInteractionEnabled=NO;
    self.maxDurationArray=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    self.leaveArray=[[NSMutableArray alloc] init];
    self.selectedArray=[[NSMutableArray alloc]initWithArray:self.leaveArray];
    
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
    
   
    myappde.warningflag=0;
    
    [self.myconnection leaveabbrivationservice:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];

    self.clickincludedesignationforupdation=0;
    
}

#pragma mark Functions and Notifications
-(void)loanfirstlookaction
{
    self.annualInterestText.text=@"";
    self.maxDurationText.text=@"";
    self.maxLoanAmount.text=@"";
    self.pendingLoanAmount.text=@"";
    self.loanEligibilityText.text=@"";
    self.lastWorkingText.text=@"";
    self.visaExpirationText.text=@"";
    self.exceptLeaveText.text=@"";
    self.nextApproveLeaveDaysText.text=@"";
    self.switchButtonstring=@"1";
    self.checkbuttonstring1=@"1";
    self.checkbuttonstring2=@"0";
    self.checkbuttonstring3=@"0";
    self.service_eligiblemonthtext=@"";
    self.service_lastworkingdaytext=@"";
    self.service_nextapprovedtext=@"";
    self.service_visaexpirationtext=@"";
   
    [self.checkBoxButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    
    
    [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
    
    [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    
    
    [self.checkBoxButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];

    
    [self.grouparray removeAllObjects];
    [self.selectedArray removeAllObjects];
    [self.exceptLeaveTableView reloadData];
    [self.mycollectionview reloadData];
    
   // AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
   // myappde.warningflag=0;
}



-(void)updationloandetails
{
      AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
//      NSLog(@"%i",myappde.myselectedTag);
//      NSLog(@"%@",myappde.loan_idstring);
//      NSLog(@"%@",myappde.loantileid_array);
//      NSLog(@"%@",[myappde.loantileid_array objectAtIndex:myappde.myselectedTag]);
//      NSLog(@"%@",myappde.loanupdate_dictionary);
    
    if ([myappde.loantileid_array count]>myappde.myselectedTag) {
        
       myappde.designation_tile = [myappde.loantileid_array objectAtIndex:myappde.myselectedTag];
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (myappde.loanupdate_dictionary.count>0) {
                
                NSMutableArray *myarray = [myappde.loanupdate_dictionary objectForKey:@"loan_condition_details"];
                
                if (myarray.count>0) {
                    
                    
                    NSMutableDictionary *mydict=[myarray objectAtIndex:myappde.myselectedTag];
                    
                    NSString *symbolString=@"%";
                    self.annualInterestText.text=[NSString stringWithFormat:@"%@ %@",[mydict objectForKey:@"annual_interest_rate"],symbolString];
                    
                    NSString *str1=[mydict objectForKey:@"max_duration"];
                    
                    if (str1.length>0) {
                        
                        self.maxDurationText.text=[NSString stringWithFormat:@"%@ years",[mydict objectForKey:@"max_duration"]];
                        self.service_maxdurationtext=[mydict objectForKey:@"max_duration"];
                    }
                    else{
                        
                        self.service_maxdurationtext=@"";
                        self.maxDurationText.text=@"";
                    }
                    
                    
                    NSString *str22=[mydict objectForKey:@"max_unit"];
                    
                    if (str22.length>0) {
                        
                        self.maxLoanAmount.text=[mydict objectForKey:@"max_unit"];
                        
                    }
                    
                    else
                    {
                        self.maxLoanAmount.text=@"";
                        
                    }
                    
                    
                    NSString *str2=[mydict objectForKey:@"pending_loan"];
                    
                    if (str2.length>0) {
                        
                        self.pendingLoanAmount.text=[mydict objectForKey:@"pending_loan"];
                    }
                    else{
                        
                        self.pendingLoanAmount.text=@"";
                    }
                    
                    NSString *str3=[mydict objectForKey:@"complete_amount"];
                    
                    if (str3.length>0) {
                        
                        self.loanEligibilityText.text=[NSString stringWithFormat:@"%@ Months",[mydict objectForKey:@"complete_amount"]];
                         self.service_eligiblemonthtext=[mydict objectForKey:@"complete_amount"];
                    }
                    else{
                        
                        self.service_eligiblemonthtext=@"";
                        self.loanEligibilityText.text=@"";
                    }
                    
                    NSString *str4=[mydict objectForKey:@"last_working_day"];
                    
                    if (str4.length>0) {
                        
                        
                        self.lastWorkingText.text= [NSString stringWithFormat:@"%@ Days",[mydict objectForKey:@"last_working_day"]];
                        
                        self.service_lastworkingdaytext=[mydict objectForKey:@"last_working_day"];
                        
                    }
                    else{
                        
                        self.service_lastworkingdaytext=@"";
                        self.lastWorkingText.text=@"";
                    }
                    
                    
                    NSString *str5=[mydict objectForKey:@"visa_expiration"];
                    
                    if (str5.length>0) {
                        
                        self.visaExpirationText.text=[NSString stringWithFormat:@"%@ Months",[mydict objectForKey:@"visa_expiration"]];
                        
                       self.service_visaexpirationtext=[mydict objectForKey:@"visa_expiration"];
                    }
                    else{
                        
                        self.visaExpirationText.text=@"";
                        self.service_visaexpirationtext=@"";
                    }
                    
                    NSString *str7=[mydict objectForKey:@"next_approved_leave"];
                    
                    if (str7.length>0) {
                        
                        self.exceptLeaveText.userInteractionEnabled=YES;
                        self.exceptLeaveText.backgroundColor=[UIColor whiteColor];
                        
                        self.nextApproveLeaveDaysText.text= [NSString stringWithFormat:@"%@ Days",[mydict objectForKey:@"next_approved_leave"]];
                        self.service_nextapprovedtext=[mydict objectForKey:@"next_approved_leave"];
                    }
                    
                    else{
                        
                        self.exceptLeaveText.userInteractionEnabled=NO;
                        self.exceptLeaveText.backgroundColor=[UIColor lightGrayColor];
                        
                        self.nextApproveLeaveDaysText.text=@"";
                        self.service_nextapprovedtext=@"";
                    }
                    
                    NSString *str8=[mydict objectForKey:@"except_for_leaves"];
                    
                    if (str8.length>0) {
                        
                        self.exceptleavestring=[mydict objectForKey:@"except_for_leaves"];
                        
                        NSRange range = [ self.exceptleavestring rangeOfString:@"#"];
                        if (range.location != NSNotFound)
                        {
                            
                            
                            NSArray *myarray = [self.exceptleavestring componentsSeparatedByString:@"###"];
                            
                            [self.selectedArray removeAllObjects];
                            [self.selectedArray addObjectsFromArray:myarray];
                            [self.exceptLeaveTableView reloadData];
                            
                        }
                        else
                        {
                            
                            
                            [self.selectedArray removeAllObjects];
                            [self.selectedArray addObject:self.exceptleavestring];
                            [self.exceptLeaveTableView reloadData];
                            
                            
                        }
                    }
                    
                    else{
                        
                        self.exceptleavestring=@"";
                        [self.selectedArray removeAllObjects];
                        [self.exceptLeaveTableView reloadData];
                    }
                    
                    
                    if (self.selectedArray.count==0) {
                        self.exceptLeaveText.text=@"";
                        self.exceptleavestring=@"";
                        //self.leaveView.hidden=true;
                        
                    }
                    else
                    {
                        if (self.selectedArray.count>1) {
                            
                            if (self.selectedArray.count==self.leaveArray.count) {
                                self.exceptLeaveText.text=@"All";
                            }
                            else
                                self.exceptLeaveText.text=@"Multiple";
                        }
                        else
                        {
                            //NSIndexPath *inPath=[self.selectedArray objectAtIndex:0];
                            self.exceptLeaveText.text=[self.selectedArray objectAtIndex:0];//[self.leaveArray objectAtIndex:inPath.row];
                        }
                        //self.leaveView.hidden=true;
                        
                        
                    }
                    
                    
                    NSString *str9=[mydict objectForKey:@"request_online"];
                    
                    if ([str9 isEqualToString:@"1"]) {
                        
                        [self.checkBoxButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                        
                        self.checkbuttonstring1=@"1";
                    }
                    else
                    {
                        [self.checkBoxButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                        
                        self.checkbuttonstring1=@"0";
                        self.checkbuttonstring2=@"0";
                        
                    }
                    
                    
                    NSString *str10=[mydict objectForKey:@"request_forward"];
                    
                    if ([str10 isEqualToString:@"1"]) {
                        
                        [self.checkBoxButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                        
                        self.checkbuttonstring1=@"1";
                        self.checkbuttonstring2=@"1";
                    }
                    else
                    {
                        [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                        
                        self.checkbuttonstring2=@"0";
                        
                    }
                    
                    NSString *str11=[mydict objectForKey:@"request_approve"];
                    
                    if ([str11 isEqualToString:@"1"]) {
                        
                        [self.checkBoxButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                        
                        self.checkbuttonstring3=@"1";
                        
                    }
                    else
                    {
                        [self.checkBoxButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                        
                        self.checkbuttonstring3=@"0";
                        
                    }
                    
                    
                    NSString *str12=[mydict objectForKey:@"checkbox_enable"];
                    
                    if ([str12 isEqualToString:@"1"]) {
                        
                        [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
                        for (UIView *myview in self.scrollView.subviews) {
                            myview.userInteractionEnabled=YES;
                        }
                        [self.scrollView setAlpha:1.0];
                        
                        self.switchButtonstring=@"1";
                        
                    }
                    else
                    {
                        [self.switchButton setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
                        for (UIView *myview in self.scrollView.subviews) {
                            myview.userInteractionEnabled=NO;
                        }
                        [self.scrollView setAlpha:0.6];//off
                        self.switchButtonstring=@"0";
                        
                        
                    }
                    
                    
                    NSString *groupstring=[mydict objectForKey:@"designationstring"];
                    if (groupstring.length>0) {
                        
                        NSArray *array=[groupstring componentsSeparatedByString:@"###"];
                        [self.grouparray removeAllObjects];
                        [self.grouparray addObjectsFromArray:array];
                        [self.mycollectionview reloadData];
                        
                    }
                    else
                    {
                        
                        [self.grouparray removeAllObjects];
                        [self.mycollectionview reloadData];
                        
                    }
                    
                }
                
                
            }
            
            
            
        });

    }
    else
    {
        
        myappde.designation_tile=@"0";
        [self loanfirstlookaction];
    }

}


-(void)groupsarrayaction
{
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
   // NSLog(@"%d",myappde.myselectedTag);
    
   // [self.grouparray removeAllObjects];
   // [self.grouparray addObjectsFromArray:[myappde.appde_locgroupdictionary objectForKey:[NSString stringWithFormat:@"%d",myappde.myselectedTag]]];
    
  
    
    if ([myappde.loantileid_array count]>myappde.myselectedTag) {
        
        myappde.designation_tile = [myappde.loantileid_array objectAtIndex:myappde.myselectedTag];
    }
    else
    {
        
        myappde.designation_tile=@"0";
    }
    
    
    if (![myappde.designation_tile isEqualToString:@"0"]) {
        
        
        
        [self.myconnection loanindividualtileservices:myappde.loan_idstring tileid:myappde.designation_tile];
        
    }
    else
    {
        
        [self loanfirstlookaction];
    }
    
    
   // [self.mycollectionview reloadData];
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height-40, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.frame;
    aRect.size.height -= kbRect.size.height;
    
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
        
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
        AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSLog(@"%@",myappde.designation_tile);
        
        
    }
    
}
- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    loanTileClass *ob = (loanTileClass *)self.superview.superview;
    [ob.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)enableall
{
    
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=YES;
    }
    
    self.switchButton.userInteractionEnabled=TRUE;
    self.saveButton.userInteractionEnabled=TRUE;
    
    loansettingsviewclass *objj = (loansettingsviewclass *)self.superview.superview.superview;
    objj.cancelbutton.userInteractionEnabled=TRUE;
    
    loanTileClass *obhh = (loanTileClass *)self.superview.superview;
    [obhh enabledfunction];
    
}


-(void)collectionViewReload:(NSMutableArray *)desigArray
{
    self.mycollectionview.hidden=false;
    [self.grouparray removeAllObjects];
    [self.grouparray addObjectsFromArray:desigArray];
    [self.mycollectionview reloadData];
}
#pragma mark Switch Action

-(IBAction)switchButtonAction:(id)sender
{
    if (self.s1%2==0) {
        
        [self.switchButton setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        
        //        self.switchButton.imageView.animationImages =
        //        [NSArray arrayWithObjects:[UIImage imageNamed:@"button_1 (1).png"],[UIImage imageNamed:@"button_1 (1).png"],
        //         nil];
        //
        //        self.switchButton.imageView.animationDuration = 0.5; //whatever you want (in seconds)
        //      [self.switchButton.imageView startAnimating];
        //
        
        //  [self.switchButton setImage:[UIImage animatedImageNamed:@"button_1 (1).png" duration:0.8] forState:UIControlStateNormal];
        for (UIView *myview in self.scrollView.subviews) {
            myview.userInteractionEnabled=NO;
        }
        self.s1++;
        [self.scrollView setAlpha:0.6];//off
        self.switchButtonstring=@"0";
        
    }
    else
    {
        [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
        //        self.switchButton.imageView.animationImages =
        //        [NSArray arrayWithObjects:
        //         [UIImage imageNamed:@"button_2 (1).png"],[UIImage imageNamed:@"button_2 (1).png"],
        //         nil];
        //        self.switchButton.imageView.animationDuration = 0.5; //whatever you want (in seconds)
        //        [self.switchButton.imageView startAnimating];
        //
        
        // [self.switchButton setImage:[UIImage animatedImageNamed:@"button_2 (1).png" duration:0.5] forState:UIControlStateNormal];
        
        for (UIView *myview in self.scrollView.subviews) {
            myview.userInteractionEnabled=YES;
        }
        self.s1++;
        [self.scrollView setAlpha:1.0];
        
        self.switchButtonstring=@"1";
        
    }
    
}
-(void)slideToRightWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    //AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //myappde.warningflag=1;
    [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=YES;
    }
    self.switchButtonstring=@"1";
    self.s1++;
    [self.scrollView setAlpha:1.0];
}
-(void)slideToLeftWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    //AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //myappde.warningflag=1;
    
    [self.switchButton setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
    
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=NO;
    }
     self.switchButtonstring=@"0";
    //[self setBackgroundColor:[UIColor lightGrayColor]];
    self.s1++;
    [self.scrollView setAlpha:0.6];
    
}
#pragma mark collectionView Delegates
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

#pragma mark tableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.maxDurationTC) {
        return self.maxDurationArray.count;
    }
    else
        return self.leaveArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.maxDurationTC) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.maxDurationArray objectAtIndex: indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return  cell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        UIButton *newRadioButton;
        newRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        newRadioButton.frame = CGRectMake(30, 0, 15, 14.5);
        //[newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
        //[newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateSelected];
        
        NSMutableDictionary *dict = [self.leaveArray objectAtIndex:indexPath.row];
        cell.textLabel.text=[dict objectForKey:@"leave_abbrv"];
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        cell.accessoryView = newRadioButton;
        //if (self.selectedflag==1) {
        //for (int i=0; i<self.leaveArray.count; i++) {
        
        //}
        //}
         NSString *abrbevstring =[[self.leaveArray objectAtIndex:indexPath.row] objectForKey:@"leave_abbrv"];
        if ([self.selectedArray containsObject:abrbevstring]) {
            [newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        }
        else
        {
            [newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
        }
        return  cell;
    }
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    myappde.warningflag=1;
    if (tableView==self.maxDurationTC) {
        
         self.service_maxdurationtext = [self.maxDurationArray objectAtIndex:indexPath.row];
        
        self.maxDurationText.text=[NSString stringWithFormat:@"%@ Years",[self.maxDurationArray objectAtIndex:indexPath.row]];
        self.maxDurationTC.hidden=true;
    }
    else if (tableView==self.exceptLeaveTableView)
    {
        NSString *abrbevstring =[[self.leaveArray objectAtIndex:indexPath.row] objectForKey:@"leave_abbrv"];
        
        
        self.exceptLeaveText.text=abrbevstring;
        
        if ([self.selectedArray containsObject:abrbevstring]) {
            [self.selectedArray removeObject:abrbevstring];
        }
        else
        {
            [self.selectedArray addObject:abrbevstring];
        }
        [self.exceptLeaveTableView reloadData];
    }
}

#pragma mark textField Delegates
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    loanTileClass *obhh = (loanTileClass *)self.superview.superview;
    [obhh scrollwholeview];
    
    if (textField==self.maxDurationText)
    {
        self.maxDurationTC.hidden=false;
        return  NO;
    }
    else if (textField==self.exceptLeaveText)
    {
        self.leaveView.hidden=false;
        return  NO;
    }
    else if (textField==self.checkBoxText1){
        AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        myappde.warningflag=1;
        if (self.x%2==0) {
            self.flag=0;
            [self.checkBoxButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.checkbuttonstring1=@"0";
            self.checkbuttonstring2=@"0";
            self.x++;
        }
        else
        {
            //self.checkBoxButton2.userInteractionEnabled=YES;
            self.flag=1;
            self.y=0;
            [self.checkBoxButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.checkbuttonstring1=@"1";
      
            self.x++;
        }
        return  NO;
    }
    else if(textField==self.checkBoxText2)
    {
        AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        myappde.warningflag=1;
        if (self.flag==1) {
            self.checkBoxButton2.userInteractionEnabled=true;
            if (self.y%2==0) {
                [self.checkBoxButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                 self.checkbuttonstring2=@"1";
                self.y++;
            }
            else
            {
                [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                 self.checkbuttonstring2=@"0";
                self.y++;
            }
            
        }
        else
        {   self.checkbuttonstring2=@"0";
            self.checkBoxButton2.userInteractionEnabled=false;
        }
        return NO;
    }
    else if (textField==self.checkBoxText3)
    {
        AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        myappde.warningflag=1;
        if (self.z%2==0) {
            [self.checkBoxButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.checkbuttonstring3=@"1";
            self.z++;
        }
        else
        {
            [self.checkBoxButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.checkbuttonstring3=@"0";
            self.z++;
        }
        return NO;
    }

    else
    {
        return YES;
    }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.annualInterestText) {
        if (![self.annualInterestText.text isEqualToString:@""]) {
            if (([self.annualInterestText.text integerValue] > 0) && ([self.annualInterestText.text integerValue] < 101)) {
                self.annualInterestText.textColor=[UIColor blackColor];
                self.saveButton.enabled=YES;
            }
            else
            {
                self.annualInterestText.textColor=[UIColor redColor];
                self.saveButton.enabled=NO;
            }
            if (!(self.annualInterestText.text.length > 3)) {
                if ([self.annualInterestText.text rangeOfString:@"%"].location == NSNotFound)
                {
                    self.interestString=self.annualInterestText.text;
                    NSString *finalText=[NSString stringWithFormat:@"%@%%",self.annualInterestText.text];
                    self.annualInterestText.text=finalText;
                }
                
            }
            
        }
    }
    else if (textField==self.loanEligibilityText)
    {
        if (![self.loanEligibilityText.text isEqualToString:@""]) {
            if (!(self.loanEligibilityText.text.length > 3)) {
                
                //Checks whether textfield contains no Character
                if ([_loanEligibilityText.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location == NSNotFound)
                {
                    self.service_eligiblemonthtext = self.loanEligibilityText.text;
                                        NSString *finalString=[NSString stringWithFormat:@"%@ Days",self.loanEligibilityText.text];
                    self.loanEligibilityText.text=finalString;
                }
            }
        }
    }
    else if (textField==self.visaExpirationText)
    {
        if (![self.visaExpirationText.text isEqualToString:@""]) {
            if (!(self.visaExpirationText.text.length > 3)) {
                if ([_visaExpirationText.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location == NSNotFound)
                {
                    self.service_visaexpirationtext = self.visaExpirationText.text;
                    NSString *finalString=[NSString stringWithFormat:@"%@ Days",self.visaExpirationText.text];
                    self.visaExpirationText.text=finalString;
                }
            }
        }
    }
    else if (textField==self.nextApproveLeaveDaysText)
    {
        if (![self.nextApproveLeaveDaysText.text isEqualToString:@""]) {
            self.exceptLeaveText.userInteractionEnabled=YES;
            self.exceptLeaveText.backgroundColor=[UIColor whiteColor];
            if (!(self.nextApproveLeaveDaysText.text.length > 3))
            {
                if ([_nextApproveLeaveDaysText.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location == NSNotFound)
                {
                    self.service_nextapprovedtext = self.nextApproveLeaveDaysText.text;
                    NSString *finalString=[NSString stringWithFormat:@"%@ Days",self.nextApproveLeaveDaysText.text];
                    self.nextApproveLeaveDaysText.text=finalString;
                }
            }
        }
        else
        {
            self.exceptLeaveText.userInteractionEnabled=NO;
            self.exceptLeaveText.backgroundColor=[UIColor lightGrayColor];
            self.exceptLeaveText.text=@"";
        }
    }
    else if (textField==self.lastWorkingText)
    {
        if (![self.lastWorkingText.text isEqualToString:@""]) {
            if (!(self.lastWorkingText.text.length > 3)) {
                if ([_lastWorkingText.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location == NSNotFound)
                {
                    self.service_lastworkingdaytext = self.lastWorkingText.text;
                    NSString *finalString=[NSString stringWithFormat:@"%@ Days",self.lastWorkingText.text];
                    self.lastWorkingText.text=finalString;
                }
            }
        }
    }

    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((textField==self.annualInterestText) || (textField==self.nextApproveLeaveDaysText) || (textField==self.lastWorkingText)||(textField==self.loanEligibilityText) || (textField==self.visaExpirationText))
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
        return  NO;
    }
    else if ((textField==self.maxLoanAmount) || (textField==self.pendingLoanAmount))
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=8) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
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
#pragma mark Button Actions
-(IBAction)leaveDoneButtonAction:(id)sender
{
    if (self.selectedArray.count==0) {
        
        self.exceptLeaveText.text=@"";
        self.exceptleavestring=@"";
        self.leaveView.hidden=true;
    }
    else
    {
        if (self.selectedArray.count>1) {
            if (self.selectedArray.count==self.leaveArray.count) {
                
                self.exceptLeaveText.text=@"All";
            }
            else
                self.exceptLeaveText.text=@"Multiple";
        }
        else
        {
            //NSIndexPath *inPath=[self.selectedArray objectAtIndex:0];
            self.exceptLeaveText.text=[self.selectedArray objectAtIndex:0];//[self.leaveArray objectAtIndex:inPath.row];
        }
        self.leaveView.hidden=true;
    }
}
-(IBAction)checkBoxAction1:(id)sender
{
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    myappde.warningflag=1;
    if (self.x%2==0) {
        self.flag=0;
        [self.checkBoxButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.checkbuttonstring1=@"0";
         self.checkbuttonstring2=@"0";
        self.x++;
    }
    else
    {
        self.checkBoxButton2.userInteractionEnabled=YES;
        self.flag=1;
        self.y=0;
        [self.checkBoxButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
         self.checkbuttonstring1=@"1";
        self.x++;
    }
}
-(IBAction)checkBoxAction2:(id)sender
{
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    myappde.warningflag=1;
    if (self.flag==1) {
        self.checkBoxButton2.userInteractionEnabled=true;
        if (self.y%2==0) {
            [self.checkBoxButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            
            self.checkbuttonstring2=@"1";
            self.y++;
        }
        else
        {
            [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                 self.checkbuttonstring2=@"0";
            self.y++;
        }
    }
    else
    {   self.checkbuttonstring2=@"0";
        self.checkBoxButton2.userInteractionEnabled=false;
    }
}

-(IBAction)checkBoxAction3:(id)sender
{
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    myappde.warningflag=1;
    if (self.z%2==0) {
        [self.checkBoxButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
             self.checkbuttonstring3=@"1";
        self.z++;
    }
    else
    {
        [self.checkBoxButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
             self.checkbuttonstring3=@"0";
        self.z++;
    }
}

-(IBAction)saveButtonAction:(id)sender
{
    NSString *loanstring = [[NSUserDefaults standardUserDefaults] objectForKey:@"loantype"];
    NSString *abbrevstring = [[NSUserDefaults standardUserDefaults] objectForKey:@"abbrevation"];
    
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    myappde.warningflag=0;
    myappde.designationFlag=0;
    
    NSString *designationList=@"";
    if (self.grouparray.count > 0) {
        designationList=[self.grouparray componentsJoinedByString:@"###"];
    }
    
    
    self.exceptleavestring = [self.selectedArray componentsJoinedByString:@"###"];
    
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"loanAction"]isEqualToString:@"create"]) {
    

        if (loanstring.length>0 && abbrevstring.length>0 && self.annualInterestText.text.length>0 && self.maxDurationText.text.length>0) {
        
            if ([myappde.loan_idstring isEqualToString:@"0"]) {
            
                self.tile_idstring=@"0";
            
                NSMutableDictionary *senddict=[[NSMutableDictionary alloc] init];
            
                if (myappde.includedesignationflag==0) {
                    
                    [senddict removeAllObjects];
                    senddict=[myappde.appde_localdict objectForKey:[NSString stringWithFormat:@"%d",myappde.myselectedTag]];
                
                }
                else
                {
                    if (self.grouparray.count>0) {
                    
                        [senddict removeAllObjects];
                        senddict=[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedDesignation"];
                }
            }
            
            [self.myconnection createingloanTile:[[NSUserDefaults standardUserDefaults] objectForKey:@"loantype"] abbrevation:[[NSUserDefaults standardUserDefaults] objectForKey:@"abbrevation"] description:[[NSUserDefaults standardUserDefaults] objectForKey:@"description"] annualinterestrate:self.interestString maxduration:self.service_maxdurationtext maximumlimit:self.maxLoanAmount.text pendingloanamount:self.pendingLoanAmount.text loanmonth:self.service_eligiblemonthtext lastworkingday:self.service_lastworkingdaytext visaduration:self.service_visaexpirationtext numberofleavedays:self.service_nextapprovedtext exceptforleave:self.exceptleavestring allowbuttonstring1:self.checkbuttonstring1 allowbuttonstring2:self.checkbuttonstring2 allowbuttonstring3:self.checkbuttonstring3 swichvalue:self.switchButtonstring loanruleid:myappde.loan_idstring loantileid:self.tile_idstring officeid:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] selecteddesignationstring:designationList maindesignationdictionary:senddict];
            
            
            
            }
            else
            {
                // AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
            
                NSLog(@"%i",myappde.myselectedTag);
            
                if ([myappde.loantileid_array count]>myappde.myselectedTag) {
                
                    self.tile_idstring = [myappde.loantileid_array objectAtIndex:myappde.myselectedTag];
                }
                else
                {
                
                    self.tile_idstring=@"0";
                }
            
                NSMutableDictionary *senddict=[[NSMutableDictionary alloc] init];
            
                if (myappde.includedesignationflag==0) {
                
                    [senddict removeAllObjects];
                    senddict=[myappde.appde_localdict objectForKey:[NSString stringWithFormat:@"%d",myappde.myselectedTag]];
                }
                else
                {
                    if (self.grouparray.count>0) {
                    
                        [senddict removeAllObjects];
                        senddict=[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedDesignation"];
                    
                    }
                
                
                }
            
            
            [self.myconnection secondtimecreateloanTile:[[NSUserDefaults standardUserDefaults] objectForKey:@"loantype"] abbrevation:[[NSUserDefaults standardUserDefaults] objectForKey:@"abbrevation"] description:[[NSUserDefaults standardUserDefaults] objectForKey:@"description"] annualinterestrate:self.interestString maxduration:self.service_maxdurationtext maximumlimit:self.maxLoanAmount.text pendingloanamount:self.pendingLoanAmount.text loanmonth:self.service_eligiblemonthtext lastworkingday:self.service_lastworkingdaytext visaduration:self.service_visaexpirationtext numberofleavedays:self.service_nextapprovedtext exceptforleave:self.exceptleavestring allowbuttonstring1:self.checkbuttonstring1 allowbuttonstring2:self.checkbuttonstring2 allowbuttonstring3:self.checkbuttonstring3 swichvalue:self.switchButtonstring loanruleid:myappde.loan_idstring loantileid:self.tile_idstring officeid:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] selecteddesignationstring:designationList maindesignationdictionary:senddict];
            
            
            }
        
        myappde.includedesignationflag=0;
    
        }
    
        else
        {
        
            UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Mandatory"
                                   message:[NSString stringWithFormat:@"Please Enter The Mandatory Fields, Loan Name and Abbreviation are also Mandatory"]
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
      
      
    }
    
    else
    {
        if (loanstring.length>0 && abbrevstring.length>0 && self.annualInterestText.text.length>0 && self.maxDurationText.text.length>0) {
        
            [self.myconnection updationofloanTile:[[NSUserDefaults standardUserDefaults] objectForKey:@"loantype"] abbrevation:[[NSUserDefaults standardUserDefaults] objectForKey:@"abbrevation"] description:[[NSUserDefaults standardUserDefaults] objectForKey:@"description"] annualinterestrate:self.interestString maxduration:self.service_maxdurationtext maximumlimit:self.maxLoanAmount.text pendingloanamount:self.pendingLoanAmount.text loanmonth:self.service_eligiblemonthtext lastworkingday:self.service_lastworkingdaytext visaduration:self.service_visaexpirationtext numberofleavedays:self.service_nextapprovedtext exceptforleave:self.exceptleavestring allowbuttonstring1:self.checkbuttonstring1 allowbuttonstring2:self.checkbuttonstring2 allowbuttonstring3:self.checkbuttonstring3 swichvalue:self.switchButtonstring loanruleid:myappde.loan_idstring loantileid:myappde.designation_tile officeid:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] selecteddesignationstring:designationList maindesignationdictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedDesignation"] clickdesignationflag:self.clickincludedesignationforupdation];
        
        }
        else
        {
        
        
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
    }
}

-(IBAction)valueChanged:(id)sender
{
    if ((![self.annualInterestText.text isEqualToString:@""]) || (![self.maxLoanAmount.text isEqualToString:@""]) || (![self.pendingLoanAmount.text isEqualToString:@""]) || (![self.loanEligibilityText.text isEqualToString:@""]) || (![self.lastWorkingText.text isEqualToString:@""]) || (![self.visaExpirationText.text isEqualToString:@""]) || (![self.nextApproveLeaveDaysText.text isEqualToString:@""])) {
        AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        myappde.warningflag=1;
    }
    else
    {
        AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        myappde.warningflag=0;
        
    }

}
-(IBAction)includeDesignationButtonAction:(id)sender
{
    
     AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
     myappde.warningflag=1;
     myappde.includedesignationflag=1;
    self.clickincludedesignationforupdation=1;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"includeDesignationView" owner:self options:nil];
    [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    
    NSLog(@"%@",self.superview.superview.superview);
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"disableall" object:Nil];
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=NO;
    }
    self.switchButton.userInteractionEnabled=FALSE;
    self.saveButton.userInteractionEnabled=FALSE;

    loanTileClass *obhh = (loanTileClass *)self.superview.superview;
    [obhh disabledfunction];
    loansettingsviewclass *objj = (loansettingsviewclass *)self.superview.superview.superview;
     objj.cancelbutton.userInteractionEnabled=FALSE;
}

#pragma mark Service Response
-(void)leaveAbbrivationlist:(NSMutableArray *)responseList
{
      dispatch_async(dispatch_get_main_queue(), ^{
        
          if (responseList.count>0) {
              
              [self.leaveArray removeAllObjects];
              [self.leaveArray addObjectsFromArray:responseList];
              [self.exceptLeaveTableView reloadData];
          }

    });

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

-(void)created_loanresponse:(NSString *)loanresponsestring
{
    
    if (![loanresponsestring isEqualToString:@"duplicate data"]) {
        
        if (![loanresponsestring isEqualToString:@"0"]) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
                
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"selectedDesignation"]!=nil) {
                    
                    
                    [myappde.appde_localdict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedDesignation"] forKey:[NSString stringWithFormat:@"%d",myappde.myselectedTag]];
                    
                    
                    
                }
                
                
                if (self.grouparray.count>0) {
                    
                    
                    
                    [myappde.appde_locgroupdictionary setObject:[self.grouparray copy] forKey:[NSString stringWithFormat:@"%d",myappde.myselectedTag]];
                    
                }
                
                
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"officeDetails"];
                
                
                NSArray *myarray = [loanresponsestring componentsSeparatedByString:@"###"];
                
                
                if (myarray.count>0) {
                    
                     myappde.loan_idstring=[myarray objectAtIndex:1];
                    
                    if (![myappde.loantileid_array containsObject:[myarray objectAtIndex:0]]) {
                        
                        [myappde.loantileid_array addObject:[myarray objectAtIndex:0]];
                    }
                    

                }
                
               
            
                loanTileClass *ob = (loanTileClass *)self.superview.superview;
                
                [ob addaccordianview];
                
                loansettingsviewclass *obj = (loansettingsviewclass *)self.superview.superview.superview;
                [obj enableddonebutton];
                
            });
            
        }
        else
        {
            
            
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Failed"
                                       message:[NSString stringWithFormat:@"%@",@"Loan Rule insertion failed"]
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
        
        
    }
    else
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Duplicate"
                                   message:[NSString stringWithFormat:@"%@",@"Enter Duplicate Entry"]
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
}

-(void)updationofloanResponse:(NSMutableDictionary *)updatedloanresponse
{
    
    
    if (updatedloanresponse.count>0) {
        
        AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        [myappde.loanupdate_dictionary removeAllObjects];
        [myappde.loanupdate_dictionary addEntriesFromDictionary:updatedloanresponse];
        
        
        NSMutableArray *myarray = [updatedloanresponse objectForKey:@"loan_details"];
        
        if (myarray.count>0) {
            
            NSMutableDictionary *dict = [myarray objectAtIndex:0];
            myappde.loan_idstring=[dict objectForKey:@"loan_id"];
            
        }
        
         NSMutableArray *fortileidarray = [updatedloanresponse objectForKey:@"loan_condition_details"];
         [myappde.loantileid_array removeAllObjects];
         for (int i=0; i<fortileidarray.count; i++) {
            
            NSMutableDictionary *mydict= [fortileidarray objectAtIndex:i];
            [myappde.loantileid_array addObject:[mydict objectForKey:@"id"]];
            
         }
        loanTileClass *ob = (loanTileClass *)self.superview.superview;
        
        [ob closeTile];


        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"officeDetails"];
        
             
      
    }
}

-(void)indiviualLoanServiceresponse:(NSMutableArray *)responsedata
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (responsedata.count>0) {
            
            NSMutableDictionary *mydict=[responsedata objectAtIndex:0];
            
            self.interestString=[mydict objectForKey:@"annual_interest_rate"];
            if (self.interestString.length>0) {
                self.annualInterestText.text=[NSString stringWithFormat:@"%@%%",[mydict objectForKey:@"annual_interest_rate"]];
            }
            self.service_maxdurationtext=[mydict objectForKey:@"max_duration"];
            if (self.service_maxdurationtext.length>0)
            {
                self.maxDurationText.text=[NSString stringWithFormat:@"%@ years",[mydict objectForKey:@"max_duration"]];
                
            }
//            else{
//                    
//                self.service_maxdurationtext=@"";
//                self.maxDurationText.text=@"";
//            }
            
            self.maxLoanAmount.text=[mydict objectForKey:@"max_unit"];
            
            self.pendingLoanAmount.text=[mydict objectForKey:@"pending_loan"];
            
                
            self.service_eligiblemonthtext=[mydict objectForKey:@"complete_amount"];
            if (self.service_eligiblemonthtext.length>0)
            {
                self.loanEligibilityText.text=[NSString stringWithFormat:@"%@ Days",[mydict objectForKey:@"complete_amount"]];
            }
//            else
//            {
//                self.service_eligiblemonthtext=@"";
//                self.loanEligibilityText.text=@"";
//            }
            
            self.service_lastworkingdaytext=[mydict objectForKey:@"last_working_day"];
            if (self.service_lastworkingdaytext.length>0)
            {
                self.lastWorkingText.text= [NSString stringWithFormat:@"%@ Days",[mydict objectForKey:@"last_working_day"]];
            }
//                else{
//                    
//                    self.service_lastworkingdaytext=@"";
//                    self.lastWorkingText.text=@"";
//                }
            
            self.service_visaexpirationtext=[mydict objectForKey:@"visa_expiration"];
            if (self.service_visaexpirationtext.length>0)
            {
                self.visaExpirationText.text=[NSString stringWithFormat:@"%@ Days",[mydict objectForKey:@"visa_expiration"]];
            }
//                else{
//                    
//                    self.visaExpirationText.text=@"";
//                    self.service_visaexpirationtext=@"";
//                }
            
            self.service_nextapprovedtext=[mydict objectForKey:@"next_approved_leave"];
            if (self.service_nextapprovedtext.length>0)
            {
                self.exceptLeaveText.userInteractionEnabled=YES;
                self.exceptLeaveText.backgroundColor=[UIColor whiteColor];
                self.nextApproveLeaveDaysText.text= [NSString stringWithFormat:@"%@ Days",[mydict objectForKey:@"next_approved_leave"]];
            }
            else
            {
                self.exceptLeaveText.userInteractionEnabled=NO;
                self.exceptLeaveText.backgroundColor=[UIColor lightGrayColor];
                self.nextApproveLeaveDaysText.text=@"";
                self.service_nextapprovedtext=@"";
            }
                
            NSString *str8=[mydict objectForKey:@"except_for_leaves"];
            if (str8.length>0) {
                self.exceptleavestring=[mydict objectForKey:@"except_for_leaves"];
                NSRange range = [ self.exceptleavestring rangeOfString:@"#"];
                if (range.location != NSNotFound)
                {
                    NSArray *myarray = [self.exceptleavestring componentsSeparatedByString:@"###"];
                        
                    [self.selectedArray removeAllObjects];
                    [self.selectedArray addObjectsFromArray:myarray];
                    [self.exceptLeaveTableView reloadData];
                        
                }
                else
                {
                    [self.selectedArray removeAllObjects];
                    [self.selectedArray addObject:self.exceptleavestring];
                    [self.exceptLeaveTableView reloadData];
                    }
                }
            else
            {
                self.exceptleavestring=@"";
                [self.selectedArray removeAllObjects];
                [self.exceptLeaveTableView reloadData];
            }
            
            if (self.selectedArray.count==0) {
                self.exceptLeaveText.text=@"";
                self.exceptleavestring=@"";
                    //self.leaveView.hidden=true;
            }
            else
            {
                if (self.selectedArray.count>1) {
                        
                    if (self.selectedArray.count==self.leaveArray.count) {
                        self.exceptLeaveText.text=@"All";
                    }
                    else
                        self.exceptLeaveText.text=@"Multiple";
                }
                else
                {
                    //NSIndexPath *inPath=[self.selectedArray objectAtIndex:0];
                    self.exceptLeaveText.text=[self.selectedArray objectAtIndex:0];//[self.leaveArray objectAtIndex:inPath.row];
                }
                    //self.leaveView.hidden=true;
            }
                
            NSString *str9=[mydict objectForKey:@"request_online"];
            if ([str9 isEqualToString:@"1"]) {
                [self.checkBoxButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                    
                self.checkbuttonstring1=@"1";
            }
            else
            {
                [self.checkBoxButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                    
                self.checkbuttonstring1=@"0";
                self.checkbuttonstring2=@"0";
                    
            }
            
            NSString *str10=[mydict objectForKey:@"request_forward"];
                
            if ([str10 isEqualToString:@"1"]) {
                    
                [self.checkBoxButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                    
                self.checkbuttonstring1=@"1";
                self.checkbuttonstring2=@"1";
            }
            else
            {
                [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                    
                self.checkbuttonstring2=@"0";
                    
            }
                
            NSString *str11=[mydict objectForKey:@"request_approve"];
            if ([str11 isEqualToString:@"1"]) {
                [self.checkBoxButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.checkbuttonstring3=@"1";
            }
            else
            {
                [self.checkBoxButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.checkbuttonstring3=@"0";
            }
            NSString *str12=[mydict objectForKey:@"checkbox_enable"];
            if ([str12 isEqualToString:@"1"]) {
                [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
                for (UIView *myview in self.scrollView.subviews) {
                    myview.userInteractionEnabled=YES;
                }
                [self.scrollView setAlpha:1.0];
                self.switchButtonstring=@"1";
            }
            else
            {
                [self.switchButton setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
                for (UIView *myview in self.scrollView.subviews) {
                    myview.userInteractionEnabled=NO;
                }
                [self.scrollView setAlpha:0.6];//off
                self.switchButtonstring=@"0";
            }
            
            NSString *groupstring=[mydict objectForKey:@"designationstring"];
            if (groupstring.length>0)
            {
                NSArray *array=[groupstring componentsSeparatedByString:@"###"];
                [self.grouparray removeAllObjects];
                [self.grouparray addObjectsFromArray:array];
                [self.mycollectionview reloadData];
            }
            else
            {
                [self.grouparray removeAllObjects];
                [self.mycollectionview reloadData];
            }
        }
    });
}

@end
