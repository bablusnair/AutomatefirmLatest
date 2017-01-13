//
//  expenseReimbursementFormClass.m
//  Automate Firm
//
//  Created by leonine on 9/6/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "expenseReimbursementFormClass.h"
#import "advancedplusCollectionViewCell.h"
#import "documentflowcellclass.h"
#import "ViewController.h"
@implementation expenseReimbursementFormClass
@synthesize categoryArray,mycollectionView,checkBox1,checkBox2,buttontag,cell,clickedCell,colour;

-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    
    self.firstArray=[[NSMutableArray alloc] initWithObjects:@"The govt. attestation document is not attached",@"I request you to pls do the needy",@"Attach the medical report", nil];
    
    self.firstView.hidden=TRUE;
    
    [self.mycollectionView registerNib:[UINib nibWithNibName:@"advancedplusCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"signaturecell"];
    self.categoryArray=[[NSMutableArray alloc]init];
    self.categoryDummyArray=[[NSMutableArray alloc]init];
    self.categoryDummyIDArray=[[NSMutableArray alloc]init];
    self.categoryDummyValueArray=[[NSMutableArray alloc]init];
    self.categoryIDArray=[[NSMutableArray alloc]init];
    self.categoryValueArray=[[NSMutableArray alloc]init];
    self.stamparray=[[NSMutableArray alloc]initWithObjects:@"important-290x100_1.jpg",@"RejectedStamp.jpg",@"urgent-stamp-md.png",@"receivednew.jpeg",@"important-290x100_1.jpg",nil];
    self.stamparray1=[[NSMutableArray alloc]initWithObjects:@"overdue.png",@"final_notice_stamp.png",@"expired.png",@"newconfident.jpeg",@"copy2.jpg",nil];
    self.expenseArray=[[NSMutableArray alloc]init];
    self.expenseIDArray=[[NSMutableArray alloc]init];
    self.expenseNameArray=[[NSMutableArray alloc]init];
    
    self.selectedCategoryIDArray=[[NSMutableArray alloc]init];
    self.expenseCategoryArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.expenseDescriptionArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.expenseLimitArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.expenseRqstAmountArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.expenseApprAmountArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.expenseBillImageArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.expenseRemarksArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.indexPathArray=[[NSMutableArray alloc]init];
    self.approveIndexPathArray=[[NSMutableArray alloc]init];
    self.checkBox1.imageView.image=[UIImage imageNamed:@"checkbox1.png23.png"];
    self.checkBox2.imageView.image=[UIImage imageNamed:@"checkbox1.png23.png"];
    self.buttontag=0;
    self.mytableview.hidden=TRUE;
    self.clickedCell.statusButton1.tag=0;
    self.datePickerView.hidden=TRUE;
    self.categoryTableView.hidden=true;
    
    NSDate *date=[NSDate date];
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd/MMM/yyyy"];
    self.applicationDateLabel.text=[df stringFromDate:date];
    
    //Setting DatePicker Max and Min Date
    [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[UIDatePicker class]]]
     setBackgroundColor:[UIColor clearColor]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];//Max Upto current Year
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];//Setting maximum entry as current date
    [comps setYear:-60];//Minimum upto 60 years back
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [self.datePicker setMaximumDate:maxDate];
    [self.datePicker setMinimumDate:minDate];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(empSelection) name:@"empSelection" object:Nil];
    
    [self formColorSetting];
    for (UIView *view in self.myscrollView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            if (view.tag==100) {
                for (UIView *views in view.subviews) {
                    if (views.tag==100) {
                        for (UIView *allViews in views.subviews) {
                            if ([allViews isKindOfClass:[UIButton class]]) {
                                if (allViews.tag==100) {
                                    allViews.userInteractionEnabled=YES;
                                }
                                else
                                    allViews.userInteractionEnabled=NO;
                            }
                            else
                                allViews.userInteractionEnabled=NO;
                        }
                        
                    }
                }
                
            }
        }
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.firstTableView) {
        
        return self.firstArray.count;
    }
    
    else if(tableView==self.secondTableView)
        return 10;
    else if (tableView==self.mytableview) {
        return self.expenseArray.count;
    }
    else if (tableView==self.categoryTableView)
    {
        return self.categoryArray.count;
    }
    else
        return self.expenseRqstAmountArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.firstTableView) {
        
        documentsRemarksTableCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell1==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"documentsRemarksTableCell" owner:self options:nil];
            cell1=[nib objectAtIndex:0];
        }
        cell1.remarksLabel.text=[self.firstArray objectAtIndex:indexPath.row];
        return cell1;
        
    }
    else if(tableView==self.secondTableView)
    {
        
        documentflowcellclass *cell1=[tableView dequeueReusableCellWithIdentifier:@"simlecell2"];
        if (cell1==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"documentflowtablecell" owner:self options:nil];
            cell1=[nib objectAtIndex:0];
        }
        
        return cell1;
        
        
    }
    if (tableView==self.mytableview) {
         
        
        tableView.layer.borderWidth = 1.0;
        tableView.layer.borderColor = [UIColor blackColor].CGColor;
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.layoutMargins = UIEdgeInsetsZero;
        
        UITableViewCell *cell1=[[UITableViewCell alloc]init];
        cell1.textLabel.text=[self.expenseArray objectAtIndex:indexPath.row];
        cell1.textLabel.font=[UIFont systemFontOfSize:12];
        cell1.separatorInset = UIEdgeInsetsZero;
        cell1.layoutMargins = UIEdgeInsetsZero;
        return cell1;
    }
    else if (tableView==self.categoryTableView)
    {
        tableView.layer.borderWidth = 1.0;
        tableView.layer.borderColor = [UIColor blackColor].CGColor;
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.layoutMargins = UIEdgeInsetsZero;
        
        UITableViewCell *cell1=[[UITableViewCell alloc]init];
        cell1.textLabel.text=[self.categoryArray objectAtIndex:indexPath.row];
        cell1.textLabel.font=[UIFont systemFontOfSize:13];
        cell1.separatorInset = UIEdgeInsetsZero;
        cell1.layoutMargins = UIEdgeInsetsZero;
        return cell1;
    }
    else
    {
        firstTableViewCellClass *cell1=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell1==nil) {
            NSArray *nib=[[ NSBundle mainBundle]loadNibNamed:@"tableviewfirstcell" owner:self options:nil];
            cell1=[nib objectAtIndex:0];
        }
        cell1.numberLabel.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
        cell1.categoryText.text=[self.expenseCategoryArray objectAtIndex:indexPath.row];
        cell1.Description.text=[self.expenseDescriptionArray objectAtIndex:indexPath.row];
        cell1.limitText.text=[self.expenseLimitArray objectAtIndex:indexPath.row];
        cell1.rqstAmount.text=[self.expenseRqstAmountArray objectAtIndex:indexPath.row];
        cell1.approvedAmount.text=[self.expenseApprAmountArray objectAtIndex:indexPath.row];
        cell1.remarkText.text=[self.expenseRemarksArray objectAtIndex:indexPath.row];
        if ([[self.expenseBillImageArray objectAtIndex:indexPath.row]isKindOfClass:[UIImage class]]) {
            cell1.evidenceImageView.image=[self.expenseBillImageArray objectAtIndex:indexPath.row];
        }
        if ([self.indexPathArray containsObject:indexPath]) {
            cell.approvedAmount.userInteractionEnabled=YES;
        }
        else
        {
            cell.approvedAmount.userInteractionEnabled=NO;
        }
        if ([self.approveIndexPathArray containsObject:indexPath]) {
            cell1.approvedAmount.textColor=[UIColor redColor];
        }
        else
        {
            cell1.approvedAmount.textColor=[UIColor blackColor];
        }
        if ([[self.expenseApprAmountArray lastObject]length] > 0) {
            self.plusButton.hidden=false;
        }
        else
        {
            self.plusButton.hidden=true;
        }
        return cell1;
    }
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
    [self.priorityButton1 setImage:[UIImage imageNamed:@"priority icon yellow1.png"] forState:UIControlStateNormal];
    [self.priorityButton2 setImage:[UIImage imageNamed:@"priority icon green unclick1.png"] forState:UIControlStateNormal];
    [self.priorityButton3 setImage:[UIImage imageNamed:@"priority icon red unclick1.png"] forState:UIControlStateNormal];
}
-(IBAction)prioritybutton2action:(id)sender
{
    [self.priorityButton1 setImage:[UIImage imageNamed:@"priority icon yellow unclick1.png"] forState:UIControlStateNormal];
    [self.priorityButton2 setImage:[UIImage imageNamed:@"priority icon green1.png"] forState:UIControlStateNormal];
    [self.priorityButton3 setImage:[UIImage imageNamed:@"priority icon red unclick1.png"] forState:UIControlStateNormal];
}
-(IBAction)prioritybutton3action:(id)sender
{
    [self.priorityButton1 setImage:[UIImage imageNamed:@"priority icon yellow unclick1.png"] forState:UIControlStateNormal];
    [self.priorityButton2 setImage:[UIImage imageNamed:@"priority icon green unclick1.png"] forState:UIControlStateNormal];
    [self.priorityButton3 setImage:[UIImage imageNamed:@"priority icon red1.png"] forState:UIControlStateNormal];
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

- (IBAction)checkBoxAction1:(id)sender {
    [checkBox1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    [checkBox2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    self.declarationText.text=@"I hereby certify that I have received the payment, and all bills presented were genuine";
}

- (IBAction)checkBoxAction2:(id)sender {
    [checkBox2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    [checkBox1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    self.declarationText.text=@"I hereby certify that all the bills presented were genuine";
}
- (IBAction)comboButton:(id)sender {
    self.mytableview.hidden=false;
}
-(IBAction)uploadImage:(id)sender
{
    firstTableViewCellClass *cell1=(firstTableViewCellClass *)[[sender superview]superview];
    self.inpath=[self.expenseTableView indexPathForCell:cell1];
    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
    imgPicker.delegate=self;
    imgPicker.allowsEditing=TRUE;
    imgPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    NSLog(@"%@",self.superview.superview.superview.superview.superview.superview.superview.superview);
    [(ViewController *)[[[[[[[self superview]superview]superview]superview] superview]superview] nextResponder] presentViewController:imgPicker animated:YES completion:nil];
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.expenseBillImageArray replaceObjectAtIndex:self.inpath.row withObject:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.expenseTableView reloadData];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.mytableview) {
        self.expenseType.text=[self.expenseArray objectAtIndex:indexPath.row];
        self.formNameLabel.text=[NSString stringWithFormat:@"EXPENSE REIMBURSEMENT FORM(%@)",[self.expenseNameArray objectAtIndex:indexPath.row]];
        [self.myconnection listingCategoriesExpenseReimbursement:[self.expenseIDArray objectAtIndex:indexPath.row]];
        self.mytableview.hidden=TRUE;
    }
    if (tableView==self.categoryTableView) {
        NSString *selectedCategory=[self.categoryArray objectAtIndex:indexPath.row];
        firstTableViewCellClass *cell1=(firstTableViewCellClass *)[self.expenseTableView cellForRowAtIndexPath:self.inpath];
        if (cell1.categoryText.text.length > 0) {
            
            [self.selectedCategoryIDArray replaceObjectAtIndex:self.inpath.row withObject:[self.categoryIDArray objectAtIndex:indexPath.row]];
            [self.expenseCategoryArray replaceObjectAtIndex:self.inpath.row withObject:selectedCategory];
            [self.expenseLimitArray replaceObjectAtIndex:self.inpath.row withObject:[self.categoryValueArray objectAtIndex:indexPath.row]];
        }
        else
        {
            [self.selectedCategoryIDArray insertObject:[self.categoryIDArray objectAtIndex:indexPath.row] atIndex:self.inpath.row];
            [self.expenseCategoryArray replaceObjectAtIndex:self.inpath.row withObject:selectedCategory];
            [self.expenseLimitArray replaceObjectAtIndex:self.inpath.row withObject:[self.categoryValueArray objectAtIndex:indexPath.row]];
            
            
        }
        
        [self.categoryArray removeObjectAtIndex:indexPath.row];
        [self.categoryIDArray removeObjectAtIndex:indexPath.row];
        [self.categoryValueArray removeObjectAtIndex:indexPath.row];
        
        [self.expenseTableView reloadData];
        [self.categoryTableView reloadData];
        self.categoryTableView.hidden=TRUE;
    }
}

-(IBAction)descriptionEndEditing:(id)sender
{
    firstTableViewCellClass *cell1=(firstTableViewCellClass *)[[sender superview]superview];
    self.inpath=[self.expenseTableView indexPathForCell:cell1];
    if (cell1.Description.text.length > 0) {
        
        [self.expenseDescriptionArray replaceObjectAtIndex:self.inpath.row withObject:cell1.Description.text];
    }
    [self.expenseTableView reloadData];
}
-(IBAction)rqstAmountEndEditing:(id)sender
{
    firstTableViewCellClass *cell1=(firstTableViewCellClass *)[[sender superview]superview];
    self.inpath=[self.expenseTableView indexPathForCell:cell1];
    if (cell1.rqstAmount.text.length > 0) {
        
        [self.indexPathArray addObject:self.inpath];
        [self.expenseRqstAmountArray replaceObjectAtIndex:self.inpath.row withObject:cell1.rqstAmount.text];
        if ([cell1.limitText.text isEqualToString:@"Cover full"]) {
            
            [self.expenseApprAmountArray replaceObjectAtIndex:self.inpath.row withObject:cell1.rqstAmount.text];
        }
        else
        {
            if ([cell1.rqstAmount.text integerValue]>[cell1.limitText.text integerValue]) {
                [self.expenseApprAmountArray replaceObjectAtIndex:self.inpath.row withObject:cell1.limitText.text];
            }
            else
                [self.expenseApprAmountArray replaceObjectAtIndex:self.inpath.row withObject:cell1.rqstAmount.text];
        }
    }
    else
    {
        [self.indexPathArray removeObject:self.inpath];
    }
    [self.expenseTableView reloadData];
}
-(IBAction)apprvAmountEndEditing:(id)sender
{
    firstTableViewCellClass *cell1=(firstTableViewCellClass *)[[sender superview]superview];
    self.inpath=[self.expenseTableView indexPathForCell:cell1];
    if (cell1.approvedAmount.text.length > 0) {
        if (!([cell1.limitText.text isEqualToString:@"Cover full"])) {
            if ([cell1.approvedAmount.text integerValue]>[cell1.limitText.text integerValue]) {
                [self.approveIndexPathArray addObject:self.inpath];
                
            }
            else
            {
                [self.approveIndexPathArray removeObject:self.inpath];
            }
        }
        
        
        
        [self.expenseApprAmountArray replaceObjectAtIndex:self.inpath.row withObject:cell1.approvedAmount.text];
    }
    [self.expenseTableView reloadData];
}
-(IBAction)remarksEndEditing:(id)sender
{
    firstTableViewCellClass *cell1=(firstTableViewCellClass *)[[sender superview]superview];
    self.inpath=[self.expenseTableView indexPathForCell:cell1];
    [self.expenseRemarksArray replaceObjectAtIndex:self.inpath.row withObject:cell1.remarkText.text];
    [self.expenseTableView reloadData];
}
-(IBAction)addNewCell:(id)sender
{
    [self.expenseCategoryArray addObject:@""];
    [self.expenseDescriptionArray addObject:@""];
    [self.expenseLimitArray addObject:@""];
    [self.expenseRqstAmountArray addObject:@""];
    [self.expenseApprAmountArray addObject:@""];
    [self.expenseBillImageArray addObject:@""];
    [self.expenseRemarksArray addObject:@""];
    
    NSArray *visibleItems = [self.expenseTableView indexPathsForVisibleRows];
    [self.expenseTableView reloadData];
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.expenseRqstAmountArray.count - 1 inSection:currentItem.section];
    [self.expenseTableView scrollToRowAtIndexPath:nextItem atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}
-(IBAction)datePickerAction:(id)sender
{
    
    NSDate *myDate = self.datePicker.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    
    self.expensedateText.text=prettyVersion;
    self.datePickerView.hidden=TRUE;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.expensedateText) {
        self.datePickerView.hidden=FALSE;
        
    }
    return NO;
}
-(IBAction)categoryDropDown:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.expenseTableView];
    self.inpath= [self.expenseTableView indexPathForRowAtPoint:buttonPosition];
    firstTableViewCellClass * cell1=(firstTableViewCellClass *)[self.expenseTableView cellForRowAtIndexPath:self.inpath];
    
    if (cell1.categoryText.text.length > 0) {
        
        NSUInteger index = [self.categoryDummyArray indexOfObject:cell1.categoryText.text];
        NSLog(@"%d",index);
        [self.categoryArray insertObject:[self.categoryDummyArray objectAtIndex:index] atIndex:index];
        [self.categoryIDArray insertObject:[self.categoryDummyIDArray objectAtIndex:index] atIndex:index];
        [self.categoryValueArray insertObject:[self.categoryValueArray objectAtIndex:index] atIndex:index];
        
        [self.expenseDescriptionArray replaceObjectAtIndex:self.inpath.row withObject:@""];
        [self.expenseRqstAmountArray replaceObjectAtIndex:self.inpath.row withObject:@""];
        [self.expenseApprAmountArray replaceObjectAtIndex:self.inpath.row withObject:@""];
        [self.expenseBillImageArray replaceObjectAtIndex:self.inpath.row withObject:@""];
        [self.expenseRemarksArray replaceObjectAtIndex:self.inpath.row withObject:@""];
        
        [self.approveIndexPathArray removeObject:self.inpath];
        
        [self.categoryTableView reloadData];
        [self.expenseTableView reloadData];
        
    }
    
    self.activeField=cell1.categoryText;
    CGPoint buttonPosition1 = [self.activeField convertPoint:CGPointZero toView:self];
    self.categoryTableView.hidden=FALSE;

    self.categoryTableView.frame=CGRectMake(self.categoryTableView.frame.origin.x, 566, self.categoryTableView.frame.size.width, self.categoryTableView.frame.size.height);
    
    [cell1.categoryText resignFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView==self.purposeTextView)    {
        if ([text isEqualToString:@""]) {
            return YES;
        }
        if (textView.text.length<=174) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+=|:,.<>/?"];
            unichar c = [text characterAtIndex:0];
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

-(IBAction)employeeSelectionAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"expense" forKey:@"popupType"];
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
    
    for (UIView *view in self.myscrollView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            if (view.tag==100) {
                for (UIView *views in view.subviews) {
                    if (views.tag==100) {
                        for (UIView *allViews in views.subviews) {
                            allViews.userInteractionEnabled=YES;
                        }
                    }
                }
            }
        }
    }
    
    [self.myconnection listingExpenseReimbursementDetails:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] : self.empID];
}

-(void)formColorSetting

{
    colour=[[NSUserDefaults standardUserDefaults]objectForKey:@"color"];
    if ([colour isEqualToString:@"Blue"]) {
        self.image1.image=[UIImage imageNamed:@"office22.png"];
        self.image2.image=[UIImage imageNamed:@"blueExpens.png"];
        self.image5.image=self.image7.image=self.image4.image=self.image3.image=
        [UIImage imageNamed:@"rule.pngwe.png"];
        self.image6.image=[UIImage imageNamed:@"authorizationrfe234.png"];
        self.backImage.image=[UIImage imageNamed:@"main_BG1.png"];
        
    }
    if ([colour isEqualToString:@"Red"]) {
        self.image1.image=[UIImage imageNamed:@"cellerd4.png"];
        self.image2.image=[UIImage imageNamed:@"redExpens.png"];
        self.image5.image=self.image7.image=self.image4.image=self.image3.image=[UIImage imageNamed:@"red grup1.png"];
        self.image6.image=[UIImage imageNamed:@"red-Auth.png"];
        self.backImage.image=[UIImage imageNamed:@"FORMred.png"];
        
    }
    if ([colour isEqualToString:@"Green"]) {
        self.image1.image=[UIImage imageNamed:@"cellgreen4.png"];
        self.image2.image=[UIImage imageNamed:@"greenExpens.png"];
        self.image5.image=self.image7.image=self.image4.image=self.image3.image=[UIImage imageNamed:@"gree grup.png"];
        self.image6.image=[UIImage imageNamed:@"green_Auth.png"];
        self.backImage.image=[UIImage imageNamed:@"FORMgreen.png"];
        
    }
    if ([colour isEqualToString:@"Black"]) {
        self.image1.image=[UIImage imageNamed:@"cellblak.png"];
        self.image2.image=[UIImage imageNamed:@"blackExpens.png"];
        self.image5.image=self.image7.image=self.image4.image=self.image3.image=[UIImage imageNamed:@"bl grup1.png"];
        self.image6.image=[UIImage imageNamed:@"blak_Auth.png"];
        self.backImage.image=[UIImage imageNamed:@"FORMblack.png"];
    }
    if ([colour isEqualToString:@"Orange"]) {
        self.image1.image=[UIImage imageNamed:@"cellorang4.png"];
        self.image2.image=[UIImage imageNamed:@"orangeExpens.png"];
        self.image5.image=self.image7.image=self.image4.image=self.image3.image=[UIImage imageNamed:@"group_box_revised orng.png"];
        self.image6.image=[UIImage imageNamed:@"orange_Auth.png"];
    }
}

//<<<<<--------------------Service Part------------------------->>>

-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.expenseNameArray removeAllObjects];
        [self.expenseIDArray removeAllObjects];
        [self.expenseArray removeAllObjects];
        
        NSMutableDictionary *empDetailsDict=[[responseData objectForKey:@"employee_details"] objectAtIndex:0];
        self.officeNameLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeAbbrv"];
        self.departmentLabel.text=[empDetailsDict objectForKey:@"department_name"];
        self.designationLabel.text=[empDetailsDict objectForKey:@"designation_title"];
        self.nationalityLabel.text=[empDetailsDict objectForKey:@"emp_nationality"];
        self.passportNOLabel.text=[empDetailsDict objectForKey:@"emp_passport_no"];
        self.visaExpiryLabel.text=[empDetailsDict objectForKey:@"emp_visa_expiry"];
        
        if ([[responseData objectForKey:@"employee_nationality"] count]>0) {
            self.nationalityLabel.text=[[[responseData objectForKey:@"employee_nationality"] objectAtIndex:0] objectForKey:@"name"];
        }
        
        NSMutableArray *expenseDeatsilArray=[responseData objectForKey:@"expense_details"];
        for (int i=0; i<expenseDeatsilArray.count; i++) {
            NSMutableDictionary *expenseDict=[expenseDeatsilArray objectAtIndex:i];
            [self.expenseArray addObject:[expenseDict objectForKey:@"expen_abbr"]];
            [self.expenseNameArray addObject:[expenseDict objectForKey:@"expen_name"]];
            [self.expenseIDArray addObject:[expenseDict objectForKey:@"type_id"]];
        }
        [self.mytableview reloadData];
        
        
    });
}
-(void)viewAllResponse:(id)responseList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.categoryArray removeAllObjects];
        [self.categoryDummyArray removeAllObjects];
        [self.categoryIDArray removeAllObjects];
        [self.categoryValueArray removeAllObjects];
        [self.categoryDummyValueArray removeAllObjects];
        [self.categoryDummyIDArray removeAllObjects];
        
        NSLog(@"%@",responseList);
        
        NSMutableArray *category=[responseList objectForKey:@"expense_categories"];
        for (int i=0; i<category.count; i++) {
            NSMutableDictionary *categoryDict=[category objectAtIndex:i];
            [self.categoryArray addObject:[categoryDict objectForKey:@"cat_name"]];
            [self.categoryIDArray addObject:[categoryDict objectForKey:@"id"]];
            [self.categoryValueArray addObject:[categoryDict objectForKey:@"cat_value"]];
        }
        [self.categoryDummyArray addObjectsFromArray:self.categoryArray];
        [self.categoryDummyValueArray addObjectsFromArray:self.categoryValueArray];
        [self.categoryDummyIDArray addObjectsFromArray:self.categoryIDArray];
        [self.categoryTableView reloadData];
    });
}
@end
