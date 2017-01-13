//
//  advanceFormClass.m
//  Automate Firm
//
//  Created by leonine on 6/20/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "advanceFormClass.h"
#import "documentflowcellclass.h"
#import "documentsRemarksTableCell.h"
@implementation advanceFormClass
@synthesize collectionView2,numberArray,x,z,flag,dateflag,presetFlag,colour;


-(void)awakeFromNib
{
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    [[NSUserDefaults standardUserDefaults] setObject:@"ADVC" forKey:@"leavetypename"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadingthecollectionview) name:@"advanceformsign" object:Nil];
    
    [self.collectionView2 registerNib:[UINib nibWithNibName:@"advancedplusCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"signaturecell"];
    self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.installmentDict=[[NSMutableDictionary alloc]init];
    self.installmentValueDict=[[NSMutableDictionary alloc]init];
    
    self.stamparray=[[NSMutableArray alloc]init];
    self.stamparray1=[[NSMutableArray alloc]init];
    
    
    
//    self.stamparray=[[NSMutableArray alloc]initWithObjects:@"important-290x100_1.jpg",@"RejectedStamp.jpg",@"urgent-stamp-md.png",@"receivednew.jpeg",@"important-290x100_1.jpg",nil];
//    self.stamparray1=[[NSMutableArray alloc]initWithObjects:@"overdue.png",@"final_notice_stamp.png",@"expired.png",@"newconfident.jpeg",@"copy2.jpg",nil];
    
    
    
    self.numberArray=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
    
    
    self.installmentArray=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];
    self.installmentTableView.hidden=true;
    self.dateArray=[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    self.kwdArray=[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    self.amountEditedArray=[[NSMutableArray alloc]init];
    self.approvedAmount=@"0";
    self.amount=self.resetFlag=presetFlag=0;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd/MMM/yyyy"];
    self.applicationDate.text=[df stringFromDate:date];
//    [df setDateFormat:@"dd/MM/yyyy"];
//    self.paymentDateText.text=[df stringFromDate:date];
    //Footer view
    self.firstArray=[[NSMutableArray alloc] initWithObjects:@"The govt. attestation document is not attached",@"I request you to pls do the needy",@"Attach the medical report", nil];
    
    self.firstView.hidden=TRUE;
    
    
    self.datePickerView.hidden=TRUE;

    self.x=0;
    self.z=0;
    self.flag=dateflag=0;
    
    [self formColorSetting];
    
    [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[UIDatePicker class]]]
     setBackgroundColor:[UIColor clearColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(empSelection) name:@"empSelection" object:Nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    for (UIView *view in self.myscrollView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            if (view.tag==100) {
                for (UIView *views in view.subviews) {
                    if ([views isKindOfClass:[UIScrollView class]]) {
                        for (UIView *allViews in views.subviews) {
                            if (allViews.tag==100) {
                                for (UIView *myView in allViews.subviews) {
                                    if ([myView isKindOfClass:[UIButton class]]) {
                                        if (myView.tag==100) {
                                            myView.userInteractionEnabled=YES;
                                        }
                                        else
                                            myView.userInteractionEnabled=NO;
                                    }
                                    else
                                        myView.userInteractionEnabled=NO;
                                }
                            }
                            else
                                allViews.userInteractionEnabled=NO;
                        }
                        
                    }
                    else
                        views.userInteractionEnabled=NO;
                }
                
            }
            else
                view.userInteractionEnabled=NO;
            
        }
        
    }
    
    
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    //    NSDictionary* info = [notification userInfo];
    //    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    //    kbRect = [self convertRect:kbRect fromView:nil];
    //
    //    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height+150, 0.0);
    //    self.scrollView.contentInset = contentInsets;
    //    self.scrollView.scrollIndicatorInsets = contentInsets;
    //
    //    CGRect aRect = self.frame;
    //    aRect.size.height -= kbRect.size.height;
    //
    //    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
    //
    //        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    //
    //    }
    
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height+50, 0.0);
    self.myscrollView.contentInset = contentInsets;
    self.myscrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.frame;
    aRect.size.height -= kbRect.size.height;
    
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
        
        [self.myscrollView scrollRectToVisible:self.activeField.frame animated:YES];
        
    }
    
    
}



- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.myscrollView.contentInset = contentInsets;
    self.myscrollView.scrollIndicatorInsets = contentInsets;
}
-(void)reloadingthecollectionview
{
    
    [self.collectionView2 reloadData];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    advancedplusCollectionViewCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"signaturecell" forIndexPath:indexPath];
   // [cell1.stampicon setImage:[UIImage imageNamed:[self.stamparray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
  //  [cell1.stampicon1 setImage:[UIImage imageNamed:[self.stamparray1 objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    
    if ([[appDelegate.advanceformsign_array objectAtIndex:indexPath.row]isKindOfClass:[UIImage class]]) {
        
        cell1.signImg.image=[appDelegate.advanceformsign_array objectAtIndex:indexPath.row];
        cell1.dateLabel.text=@"30/08/2016";
    }
    else
    {
        
        cell1.signImg.image=Nil;
        cell1.dateLabel.text=@"";
    }

    
    return cell1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.firstTableView) {
        
        return self.firstArray.count;
    }
    
    else if(tableView==self.authorityFlowTC)
    {
        return 10;
    }
    
    else if (tableView==self.installmentTableView)
    {
        return self.installmentArray.count;
    }
    
    else
        return self.numberArray.count;
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
    else if(tableView==self.authorityFlowTC)
    {
        
        documentflowcellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"simlecell2"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"documentflowtablecell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        return cell;
        
        
    }

    
    else if (tableView==self.installmentTableView)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.installmentArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return cell;
    }
    else
    {
        
        advancedplustableviewclass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if(cell==nil)
        {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"advancedplustableviewcell" owner:self options:nil];
                cell=[nib objectAtIndex:0];
        }
        

        
        cell.numberLabel.text=[self.numberArray objectAtIndex:indexPath.row];
        cell.dateLabel.text=[self.dateArray objectAtIndex:indexPath.row];
        cell.kwdLabel.text=[self.installmentValueDict objectForKey:cell.dateLabel.text];
        cell.dateLabel.delegate=self;
        cell.kwdLabel.delegate=self;
        if (self.flag==0) {
            cell.dateLabel.userInteractionEnabled=NO;
            cell.kwdLabel.userInteractionEnabled=NO;
        }
        else
        {
            cell.dateLabel.userInteractionEnabled=YES;
            cell.kwdLabel.userInteractionEnabled=YES;
        }
        if ([colour isEqualToString:@"Blue"]) {
            cell.backImage.image=[UIImage imageNamed:@"second_box.png"];
        }
        if ([colour isEqualToString:@"Red"]) {
            cell.backImage.image=[UIImage imageNamed:@"redCell.png"];
        }
        if ([colour isEqualToString:@"Green"]) {
            cell.backImage.image=[UIImage imageNamed:@"greenCell.png"];
        }
        if ([colour isEqualToString:@"Black"]) {
            cell.backImage.image=[UIImage imageNamed:@"blackCell.png"];
        }
        if ([colour isEqualToString:@"Orange"]) {
            cell.backImage.image=[UIImage imageNamed:@"OrangeCelll.png"];
        }

        
        
        
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.installmentTableView)
    {
        
        self.numberInstallment.text=[self.installmentArray objectAtIndex:indexPath.row];
        self.installmentTableView.hidden=true;
        [self installmentTableSetting:self.startDate];
    }
    else
    {
        
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.visaExpiry) {

        [self showAlert:@"Duration for Visa Expiration should be > 3 Months"];
        return NO;
    }
    else if (textField==self.lastWorkingDay)
    {
        [self showAlert:@"Last Working day should be < 45 days to issue advance"];
        return NO;
    }
    else if (textField==self.leaveApplication)
    {
        [self showAlert:@"Time to next approved leave should be >  1 Month(s)  for advance payment request acceptance"];
        return NO;
    }
    else if (textField==self.pendingLoanAmount)
    {
        [self showAlert:@"Pending Loan amounts < KWD 1500 for approval"];
        return NO;
    }
    else if(textField==self.dateJoining)
    {
        
        [self showAlert:@"An employee should complete  25 Days in the firm to be eligible for an advance"];
        return NO;
    }
    else if (textField==self.approvedAmountText)
    {
        return YES;
    }
    
    
    else if(textField==self.numberInstallment)
    {
        
        [self showAlert:@"Max. permitted duration is only 1 Year"];
        return NO;
    }
    else if (textField==self.paymentDateText)
    {
        dateflag=2;
        self.datePickerView.frame=CGRectMake(94, 467, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
        self.datePickerView.hidden=false;
        return  NO;
    }
    else
    {
        return YES;
    }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if((textField==self.requestAmount)||(textField==self.approvedAmountText))
    {
        if (textField==self.requestAmount) {
            if (self.requestAmount.text.length > 0) {
                self.approvedAmount=self.approvedAmountText.text=self.requestAmount.text=[NSString stringWithFormat:@"%.1f",[self.requestAmount.text floatValue]];
                
                self.approvedAmountText.userInteractionEnabled=YES;
                self.approvedAmountText.backgroundColor=[UIColor clearColor];
                self.paymentDateText.text=@"";
                self.paymentDateText.userInteractionEnabled=YES;
                self.paymentDateText.backgroundColor=[UIColor clearColor];
                [self resetInstallmentTable];
            }
            else
            {
                self.approvedAmount=@"";
                self.approvedAmountText.text=@"";
                self.approvedAmountText.userInteractionEnabled=NO;
                self.approvedAmountText.backgroundColor=[UIColor lightGrayColor];
                self.paymentDateText.text=@"";
                self.paymentDateText.userInteractionEnabled=NO;
                self.paymentDateText.backgroundColor=[UIColor lightGrayColor];
                self.dropButton1.userInteractionEnabled=NO;
                
                [self resetInstallmentTable];
            }
            
            
        }
        else if(textField==self.approvedAmountText)
        {
            if (self.approvedAmountText.text.length > 0) {
                self.approvedAmount=self.approvedAmountText.text;
                self.paymentDateText.text=@"";
                self.paymentDateText.userInteractionEnabled=YES;
                self.paymentDateText.backgroundColor=[UIColor clearColor];
                [self resetInstallmentTable];
            }
            else
            {
                self.paymentDateText.text=@"";
                self.paymentDateText.userInteractionEnabled=NO;
                self.paymentDateText.backgroundColor=[UIColor lightGrayColor];
                self.dropButton1.userInteractionEnabled=NO;
                
                [self resetInstallmentTable];
            }
        }
//        if ([self.requestAmount.text floatValue]>[self.approvedAmountText.text floatValue]){
//            self.requestAmount.textColor=[UIColor redColor];
//        }
//        else
//        {
//            self.requestAmount.textColor=[UIColor blackColor];
//        }
    }
    return  YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((textField==self.requestAmount)||(textField==self.approvedAmountText)) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=8) {
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
    else
    {
        return YES;
    }
    return false;
}

-(IBAction)dateEdit:(id)sender
{
    if(self.x%2==0)
    {
        self.flag=1;
        self.installmentTC.userInteractionEnabled=YES;
        [self.tableeditButton setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        self.resetButton.hidden=false;
        self.x++;
        if (presetFlag==1) {
            self.resetButton.hidden=false;
        }
        else
        {
            self.resetButton.hidden=true;
        }
        [self.installmentTC reloadData];
        
    }
    else
    {
        self.flag=0;
        self.installmentTC.userInteractionEnabled=NO;
        self.datePickerView.hidden=TRUE;
        [self.tableeditButton setImage:[UIImage imageNamed:@"blue_pen.png"] forState:UIControlStateNormal];
        self.resetButton.hidden=true;
        self.x++;
        //[self.installmentTC reloadData];
    }
}
-(IBAction)noinstallmentAction:(id)sender
{
    self.installmentTableView.hidden=false;
}
-(IBAction)editButton1:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.installmentTC];
    self.inPath= [self.installmentTC indexPathForRowAtPoint:buttonPosition];
    self.datePickerView.hidden=FALSE;
    self.datePickerView.frame=CGRectMake(self.datePickerView.frame.origin.x, buttonPosition.y+381, self.datePickerView.frame.size.width, self.datePickerView.frame.size.height);
    advancedplustableviewclass *cell=(advancedplustableviewclass *)[self.installmentTC cellForRowAtIndexPath:self.inPath];
    [cell.dateLabel resignFirstResponder];
    dateflag=1;
    
}

-(IBAction)datePickerAction:(id)sender
{
    NSDate *myDate = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    if (dateflag==1) {
        [self.dateArray replaceObjectAtIndex:self.inPath.row withObject:prettyVersion];
        [self.installmentValueDict removeAllObjects];
        for (int i=0; i<self.dateArray.count; i++) {
            [self.installmentValueDict setObject:[self.kwdArray objectAtIndex:i] forKey:[self.dateArray objectAtIndex:i]];
        }
        //Sort dates in ascending order
        
        NSMutableArray *dates=[[NSMutableArray alloc]init];
        for (int i=0; i<self.dateArray.count; i++) {
            if (!([[self.dateArray objectAtIndex:i]isEqualToString:@""])) {
                [dates addObject:[self.dateArray objectAtIndex:i]];
            }
        }
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy"];
        NSArray *sortedArray = [dates sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
            NSDate *d1 = [df dateFromString:(NSString*) obj1];
            NSDate *d2 = [df dateFromString:(NSString*) obj2];
            return [d1 compare: d2];
        }];
        NSLog(@"%@",sortedArray);
        
        self.dateArray=[sortedArray mutableCopy];
        
        for (int i=[self.numberInstallment.text integerValue] ; i<12; i++) {
            [self.dateArray insertObject:@"" atIndex:i];
        }
       
        [self.installmentDict setObject:[self.dateArray mutableCopy]forKey:@"resetDate"];
        [self.installmentDict setObject:[self.kwdArray mutableCopy]forKey:@"resetAmount"];
        
        [self.installmentTC reloadData];
        presetFlag=1;
        if ([self.tableeditButton.currentImage isEqual:[UIImage imageNamed:@"selected.png"]]) {
            self.resetButton.hidden=false;
        }
    }
    else if (dateflag==2)
    {
        
        self.dropButton1.userInteractionEnabled=YES;
        self.startDate=myDate;
        self.paymentDateText.text=prettyVersion;
        [self installmentTableSetting:self.startDate];
    }
    
    self.datePickerView.hidden=TRUE;
}
-(IBAction)editButton2:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.installmentTC];
    self.inPath= [self.installmentTC indexPathForRowAtPoint:buttonPosition];
    advancedplustableviewclass *cell=(advancedplustableviewclass *)[self.installmentTC cellForRowAtIndexPath:self.inPath];
    self.datePickerView.hidden=TRUE;
    self.amount=[cell.kwdLabel.text integerValue];
    
}
-(IBAction)doneKwdAction:(id)sender
{
    self.resetButton.hidden=false;
    advancedplustableviewclass *cell=(advancedplustableviewclass *)[self.installmentTC cellForRowAtIndexPath:self.inPath];
    [cell.kwdLabel resignFirstResponder];
    if ([cell.kwdLabel.text integerValue]>=[self.approvedAmount integerValue]) {
        [self showAlert:@"Invalid Choice"];
        [self.installmentTC reloadData];
    }
    else
    {
        [self.kwdArray replaceObjectAtIndex:self.inPath.row withObject:cell.kwdLabel.text];
        
        [self.installmentTC reloadData];
        
        if (self.app.advanceAmtChangeFlag==1) {
            [self.amountEditedArray addObject:self.inPath];
            self.amount = [cell.kwdLabel.text integerValue] - self.amount;
            self.amount=self.amount/([self.numberInstallment.text integerValue] - [self.amountEditedArray count]);
            self.amount=truncf(self.amount);
            
            self.app.advanceAmtChangeFlag=0;
            
            [self amountChangeAction];
        }
    }
    
    
}
-(IBAction)amountEditingChanged:(id)sender
{
    self.app.advanceAmtChangeFlag=1;
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

//-(IBAction)addnewRemarks:(id)sender
//
//{
//
//    NSInteger row = 0;
//
//    NSInteger section = 0;
//
//    [self.firstArray insertObject:@"" atIndex:row];
//
//    NSIndexPath *myindexpath = [NSIndexPath indexPathForRow:row inSection:section];
//
//    // [selectedarray addObject:myindexpath];
//
//    [self.firstTableView beginUpdates];
//
//
//
//    [self.firstTableView insertRowsAtIndexPaths:@[myindexpath] withRowAnimation:UITableViewRowAnimationTop];
//
//    [self.firstTableView endUpdates];
//
//}
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

-(void)showAlert:(NSString *)alertMsg
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@""
                               message:[NSString stringWithFormat:@"%@",alertMsg]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   
                                               }];
    
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        [(homeViewController *)[self.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}
-(IBAction)employeeSelectionAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"advance" forKey:@"popupType"];
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
    
    
    
    
    [self.myconnection employeeindividualServicedata:self.empID];
    
    for (UIView *view in self.myscrollView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            if (view.tag==100) {
                for (UIView *views in view.subviews) {
                    if ([views isKindOfClass:[UIScrollView class]]) {
                        for (UIView *allViews in views.subviews) {
                            if (allViews.tag==100) {
                                for (UIView *myView in allViews.subviews) {
                                        myView.userInteractionEnabled=YES;
                                    
                                    
                                }
                            }
                            else
                                allViews.userInteractionEnabled=YES;
                        }
                        
                    }
                    else
                        views.userInteractionEnabled=YES;
                }
                
            }
            else
                view.userInteractionEnabled=YES;
        }
        
    }

}
-(void)installmentTableSetting:(NSDate *)date
{
    int count=[self.numberInstallment.text integerValue];
    int installmentAmount=[self.approvedAmount integerValue]/count;
    NSDate *nextdate=self.nextDate= date;
    
    [self.amountEditedArray removeAllObjects];
    
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd/MM/yyyy"];
    [self.dateArray replaceObjectAtIndex:0 withObject:[df stringFromDate:date]];
    [self.kwdArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",installmentAmount]];
    NSArray *paymentdateArray=[self.paymentDateText.text componentsSeparatedByString:@"/"];
    
    for (int i=1; i<count; i++) {
        [self.kwdArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",installmentAmount]];
        
        if ([[paymentdateArray objectAtIndex:0]isEqualToString:@"29"] || [[paymentdateArray objectAtIndex:0]isEqualToString:@"30"] || [[paymentdateArray objectAtIndex:0]isEqualToString:@"31"])
        {
            
            
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *components = [gregorian components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date];
            components.day = 2;
            components.month=components.month+i;
            
            NSDate *date1 = [gregorian dateFromComponents:components];
            nextdate=self.nextDate=date1;
            
            
            NSCalendar *cal = [NSCalendar currentCalendar];
            NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay
                                    inUnit:NSCalendarUnitMonth
                                   forDate:self.nextDate];
            NSUInteger numberOfDaysInMonth = rng.length;
            
            if ([[paymentdateArray objectAtIndex:0]integerValue] <= numberOfDaysInMonth) {
                
                NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                NSDateComponents *components = [gregorian components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date];
                components.day = [[paymentdateArray objectAtIndex:0]integerValue];
                components.month=components.month+i;
                
                NSDate *date1 = [gregorian dateFromComponents:components];
                nextdate=self.nextDate=date1;
                
                NSString *mydate=[df stringFromDate:date1];
                [self.dateArray replaceObjectAtIndex:i withObject:mydate];
            }
            else
            {
                NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                NSDateComponents *components = [gregorian components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date];
                components.day = numberOfDaysInMonth;
                components.month=components.month+i;
                
                NSDate *date1 = [gregorian dateFromComponents:components];
                nextdate=self.nextDate=date1;
                
                NSString *mydate=[df stringFromDate:date1];
                [self.dateArray replaceObjectAtIndex:i withObject:mydate];
            }
            
                
        }
        
        else
        {
           
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *components = [gregorian components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date];
            components.day = [[paymentdateArray objectAtIndex:0]integerValue];
            components.month=components.month+i;
                
                
            NSDate *date1 = [gregorian dateFromComponents:components];
            nextdate=self.nextDate=date1;
        
            NSString *mydate=[df stringFromDate:date1];
            [self.dateArray replaceObjectAtIndex:i withObject:mydate];

            
        }
        [self.installmentTC reloadData];
        
    }
    for (int i=count; i<12; i++) {
        [self.dateArray replaceObjectAtIndex:i withObject:@""];
        [self.kwdArray replaceObjectAtIndex:i withObject:@""];
    }
    float approvedAmount=0;
    for (int i=0; i<self.kwdArray.count; i++) {
        approvedAmount=approvedAmount+[[self.kwdArray objectAtIndex:i] integerValue];
        self.approvedAmountText.text=[NSString stringWithFormat:@"%.1f",approvedAmount];
    }
    [self.installmentValueDict removeAllObjects];
    for (int i=0; i<self.dateArray.count; i++) {
        [self.installmentValueDict setObject:[self.kwdArray objectAtIndex:i] forKey:[self.dateArray objectAtIndex:i]];
    }
    
    
    [self.installmentDict setObject:[self.dateArray mutableCopy] forKey:@"actualDate"];
    [self.installmentDict setObject:[self.kwdArray mutableCopy] forKey:@"actualAmount"];
    
}

-(IBAction)resetButtonAction:(id)sender
{
    if (self.installmentDict.count>0) {
        if (self.resetFlag%2==0) {
            [self.dateArray removeAllObjects];
            [self.kwdArray removeAllObjects];
            NSMutableArray *dateArray=[self.installmentDict objectForKey:@"actualDate"];
            NSMutableArray *amountArray=[self.installmentDict objectForKey:@"actualAmount"];
            [self.dateArray addObjectsFromArray:dateArray];
            [self.kwdArray addObjectsFromArray:amountArray];
            [self.resetButton setImage:[UIImage imageNamed:@"PresetARROW.png"] forState:UIControlStateNormal];
            self.resetFlag++;
        }
        else
        {
            [self.dateArray removeAllObjects];
            [self.kwdArray removeAllObjects];
            NSMutableArray *dateArray=[self.installmentDict objectForKey:@"resetDate"];
            NSMutableArray *amountArray=[self.installmentDict objectForKey:@"resetAmount"];
            [self.dateArray addObjectsFromArray:dateArray];
            [self.kwdArray addObjectsFromArray:amountArray];
            [self.resetButton setImage:[UIImage imageNamed:@"Recent Doc_icon.png"] forState:UIControlStateNormal];
            self.resetFlag++;
        }
        [self.installmentValueDict removeAllObjects];
        for (int i=0; i<self.dateArray.count; i++) {
            [self.installmentValueDict setObject:[self.kwdArray objectAtIndex:i] forKey:[self.dateArray objectAtIndex:i]];
        }
        
        [self.installmentTC reloadData];
    }
    
    
}
-(void)amountChangeAction
{
    NSMutableArray *indexArrayy=[[NSMutableArray alloc]init];
    for (int i=0; i<self.kwdArray.count; i++) {
        if (!([[self.kwdArray objectAtIndex:i]isEqualToString:@""])) {
            
            NSIndexPath *path=[NSIndexPath indexPathForRow:i inSection:0];
            [indexArrayy addObject:path];
        }
    }
    
    for (int i=0; i<indexArrayy.count; i++) {
        
        if (!([self.amountEditedArray containsObject:[indexArrayy objectAtIndex:i]])) {
            if (!([[self.kwdArray objectAtIndex:i]isEqualToString:@""])) {
                int value=[[self.kwdArray objectAtIndex:i] integerValue] - self.amount;
                [self.kwdArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",value]];
                
                
                
                //Approved Amount change
                
                float approvedAmount=0;
                for (int i=0; i<self.kwdArray.count; i++) {
                    approvedAmount=approvedAmount+[[self.kwdArray objectAtIndex:i] integerValue];
                    self.approvedAmountText.text=[NSString stringWithFormat:@"%.1f",approvedAmount];
                }
            }
        }
    }
    [self.installmentValueDict removeAllObjects];
    for (int i=0; i<self.dateArray.count; i++) {
        [self.installmentValueDict setObject:[self.kwdArray objectAtIndex:i] forKey:[self.dateArray objectAtIndex:i]];
    }
    
    presetFlag=1;
    if ([self.tableeditButton.currentImage isEqual:[UIImage imageNamed:@"selected.png"]]) {
        self.resetButton.hidden=false;
    }
    
    [self.installmentDict setObject:[self.dateArray mutableCopy]forKey:@"resetDate"];
    [self.installmentDict setObject:[self.kwdArray mutableCopy]forKey:@"resetAmount"];
    [self.installmentTC reloadData];
}

-(void)resetInstallmentTable
{
    [self.installmentDict removeAllObjects];
    for (int i=0; i<12; i++) {
        [self.kwdArray replaceObjectAtIndex:i withObject:@""];
        [self.dateArray replaceObjectAtIndex:i withObject:@""];
        
    }
    [self.installmentValueDict removeAllObjects];
    for (int i=0; i<self.dateArray.count; i++) {
        [self.installmentValueDict setObject:[self.kwdArray objectAtIndex:i] forKey:[self.dateArray objectAtIndex:i]];
    }
    [self.installmentTC reloadData];
}

-(void)formColorSetting

{
    colour=[[NSUserDefaults standardUserDefaults]objectForKey:@"color"];
    if ([colour isEqualToString:@"Blue"]) {
        self.image1.image=[UIImage imageNamed:@"office22.png"];
        self.image2.image=self.image5.image=self.image7.image=self.image8.image=self.image10.image=self.image12.image=self.image13.image=
        [UIImage imageNamed:@"rule.pngwe.png"];
        self.image3.image=[UIImage imageNamed:@"123.png"];
        self.image4.image=[UIImage imageNamed:@"installments1.png23.png"];
        self.image6.image=self.image9.image=[UIImage imageNamed:@"blue.jpg"];
        self.image11.image=[UIImage imageNamed:@"authorizationrfe234.png"];
        self.backImage.image=[UIImage imageNamed:@"main_BG1.png"];
        
    }
    if ([colour isEqualToString:@"Red"]) {
        self.image1.image=[UIImage imageNamed:@"cellerd4.png"];
        self.image2.image=self.image5.image=self.image7.image=self.image8.image=self.image10.image=self.image12.image=self.image13.image=[UIImage imageNamed:@"red grup1.png"];
        self.image3.image=[UIImage imageNamed:@"123_red.jpg"];
        self.image4.image=[UIImage imageNamed:@"red.jpg"];
        self.image6.image=self.image9.image=[UIImage imageNamed:@"1234_red.jpg"];
        self.image11.image=[UIImage imageNamed:@"red-Auth.png"];
        self.backImage.image=[UIImage imageNamed:@"FORMred.png"];
       
    }
    if ([colour isEqualToString:@"Green"]) {
        self.image1.image=[UIImage imageNamed:@"cellgreen4.png"];
        self.image2.image=self.image5.image=self.image7.image=self.image8.image=self.image10.image=self.image12.image=self.image13.image=[UIImage imageNamed:@"gree grup.png"];
        self.image3.image=[UIImage imageNamed:@"123_green.jpg"];
        self.image4.image=[UIImage imageNamed:@"green.jpg"];
        self.image6.image=self.image9.image=[UIImage imageNamed:@"green_1234.jpg"];
        self.image11.image=[UIImage imageNamed:@"green_Auth.png"];
        self.backImage.image=[UIImage imageNamed:@"FORMgreen.png"];
        
    }
    if ([colour isEqualToString:@"Black"]) {
        self.image1.image=[UIImage imageNamed:@"cellblak.png"];
        self.image2.image=self.image5.image=self.image7.image=self.image8.image=self.image10.image=self.image12.image=self.image13.image=[UIImage imageNamed:@"bl grup1.png"];
        self.image3.image=[UIImage imageNamed:@"123_black.jpg"];
        self.image4.image=[UIImage imageNamed:@"black.jpg"];
        self.image6.image=self.image9.image=[UIImage imageNamed:@"1234_black.jpg"];
        self.image11.image=[UIImage imageNamed:@"blak_Auth.png"];
        self.backImage.image=[UIImage imageNamed:@"FORMblack.png"];
    }
    if ([colour isEqualToString:@"Orange"]) {
        self.image1.image=[UIImage imageNamed:@"cellorang4.png"];
        self.image2.image=self.image5.image=self.image7.image=self.image8.image=self.image10.image=self.image12.image=self.image13.image=[UIImage imageNamed:@"group_box_revised orng.png"];
        self.image3.image=[UIImage imageNamed:@"123_orange.jpg"];
        self.image4.image=[UIImage imageNamed:@"orange.jpg"];
        self.image6.image=self.image9.image=[UIImage imageNamed:@"1234_orange.jpg"];
        self.image11.image=[UIImage imageNamed:@"orange_Auth.png"];
    }
}


-(void)employeeindividualGotreponsedata:(NSMutableDictionary *)idresponsedict
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *empDict=[idresponsedict objectForKey:@"basic_info"];
        
        self.officeLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeAbbrv"];
        
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
        
        if ([[empDict objectForKey:@"emp_gender"]isEqualToString:@"M"]) {
            
            self.employeeApplicableGrossLabel.text=[NSString stringWithFormat:@"%@ (%@) is eligible to receive only 65%% of his  Annual Gross Salary (KWD 200) in total",[empDict objectForKey:@"emp_name"],[empDict objectForKey:@"e_code"]];
        }
        else
        {
            self.employeeApplicableGrossLabel.text=[NSString stringWithFormat:@"%@ (%@) is eligible to receive only 65%% of her  Annual Gross Salary (KWD 200) in total",[empDict objectForKey:@"emp_name"],[empDict objectForKey:@"e_code"]];
        }
        
        
        NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"yyyy-MM-dd"];
        NSString *dojString=[empDict objectForKey:@"emp_date_of_join"];
        NSDate *doj=[dateFormater dateFromString:dojString];
        [dateFormater setDateFormat:@"dd-MM-yyyy"];
        self.dateJoining.text=[dateFormater stringFromDate:doj];
        
        self.categoryLabel.text=[empDict objectForKey:@"cat_name"];
    });
   
    
}

- (IBAction)newEmpSignAction:(id)sender {
    
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"newSignatureView" owner:self options:nil];
    UIView *view=[nib objectAtIndex:0];
    [view setFrame:CGRectMake(160, 482, 591, 299)];
    [self addSubview:view];
    
    
}
@end
