//
//  vacationLeave.m
//  bablusdemokpproject
//
//  Created by leonine on 7/23/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "vacationLeave.h"
#import "advancedplusCollectionViewCell.h"
#import "ViewController.h"
#import "earningsTableViewCell.h"
#import "AppDelegate.h"
@implementation vacationLeave
@synthesize actionFlag,colour;
- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
-(void)awakeFromNib
{
 
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadingthecollectionview) name:@"vactemergsickleave" object:Nil];

    
    
    [self.mycollectionView registerNib:[UINib nibWithNibName:@"advancedplusCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"signaturecell"];
    [self.uploadCollectionView registerNib:[UINib nibWithNibName:@"uploadCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"uploadImage"];
    
    self.stamparray=[[NSMutableArray alloc]init];
    self.stamparray1=[[NSMutableArray alloc]init];
    

//    self.stamparray=[[NSMutableArray alloc]initWithObjects:@"important-290x100_1.jpg",@"RejectedStamp.jpg",@"urgent-stamp-md.png",@"receivednew.jpeg",@"important-290x100_1.jpg",nil];
//    self.stamparray1=[[NSMutableArray alloc]initWithObjects:@"overdue.png",@"final_notice_stamp.png",@"expired.png",@"newconfident.jpeg",@"copy2.jpg",nil];
    
    self.economyArray=[[NSMutableArray alloc]initWithObjects:@"Economy",@"Business",@"First", nil];
    self.companyArray=[[NSMutableArray alloc]initWithObjects:@"Company",@"Self Paid", nil];
    self.uploadEvidenceArray=[[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"add.png"],[UIImage imageNamed:@"add.png"], nil];
    self.mytablebiew1.hidden=TRUE;
    self.mytablebiew2.hidden=TRUE;
    self.datePicker1View.hidden=TRUE;
    self.datePicker2View.hidden=TRUE;
    self.row=0;
    
    [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[UIDatePicker class]]]
     setBackgroundColor:[UIColor clearColor]];
    
    [self formColorSetting];
}

-(void)reloadingthecollectionview
{
    
    [self.mycollectionView reloadData];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==self.uploadCollectionView) {
        return  2;
    }
    else
    {
        return 5;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.uploadCollectionView) {
        uploadCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"uploadImage" forIndexPath:indexPath];
       
        cell.backImage.image=[self.uploadEvidenceArray objectAtIndex:indexPath.row];
        cell.deleteButton.hidden=true;
        UILongPressGestureRecognizer *press=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deletetile:)];
        [cell addGestureRecognizer:press];
        
        return  cell;
    }
    else
    {
        advancedplusCollectionViewCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"signaturecell" forIndexPath:indexPath];
       // [cell1.stampicon setImage:[UIImage imageNamed:[self.stamparray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
       // [cell1.stampicon1 setImage:[UIImage imageNamed:[self.stamparray1 objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
        
        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        
        
        if ([[appDelegate.vact_emrc_sickleavearray objectAtIndex:indexPath.row]isKindOfClass:[UIImage class]]) {
            
            cell1.signImg.image=[appDelegate.vact_emrc_sickleavearray objectAtIndex:indexPath.row];
            cell1.dateLabel.text=@"30/08/2016";
        }
        else
        {
            
            cell1.signImg.image=Nil;
            cell1.dateLabel.text=@"";
        }

        
        return cell1;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.uploadCollectionView) {
        if ([[self.uploadEvidenceArray objectAtIndex:0]isEqual:[UIImage imageNamed:@"add.png"]]) {
            self.row=0;
        }
        else
        {
            self.row=indexPath.row;
        }
        [self uploadDocument:self];
    }
}
-(void)deletetile:(UILongPressGestureRecognizer *)press
{
    uploadCollectionViewCell *cell=(uploadCollectionViewCell *)press.view;
    self.inPath=[self.uploadCollectionView indexPathForCell:cell];
    if(!([cell.backImage.image isEqual:[UIImage imageNamed:@"add.png"]]))
    {
        cell.deleteButton.hidden=false;
    }
}
-(IBAction)deleteEvidence:(id)sender
{
    if (self.inPath.row==0) {
        [self.uploadEvidenceArray removeObjectAtIndex:self.inPath.row];
        [self.uploadEvidenceArray addObject:[UIImage imageNamed:@"add.png"]];
    }
    else
        [self.uploadEvidenceArray replaceObjectAtIndex:self.inPath.row withObject:[UIImage imageNamed:@"add.png"]];
    NSMutableArray *dummyArray=[[NSMutableArray alloc]initWithArray:self.uploadEvidenceArray];
    [dummyArray removeObject:[UIImage imageNamed:@"add.png"]];
    if (dummyArray.count==0) {
        self.uploadButton.hidden=false;
        self.uploadCollectionView.hidden=true;
        self.row=0;
    }
    [self.uploadCollectionView reloadData];
}
-(IBAction)authorisationButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        [self.approvedradioButton setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        [self.deniedradioButton setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.deniedradioButton setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        [self.approvedradioButton setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.mytablebiew1) {
        return self.economyArray.count;
    }
    else if (tableView==self.earningsTC)
    {
        return 6;
    }
    else if (tableView==self.deductionsTC)
    {
        return 6;
    }
    else
    {
        return self.companyArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.earningsTC) {
        earningsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"earningsTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
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
    else if (tableView==self.deductionsTC)
    {
        earningsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"earningsTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
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
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        if (tableView==self.mytablebiew1) {
            cell.textLabel.text=[self.economyArray objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text=[self.companyArray objectAtIndex:indexPath.row];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.mytablebiew1) {
        self.economyText.text=[self.economyArray objectAtIndex:indexPath.row];
        
        self.mytablebiew1.hidden=TRUE;
    }
    else
    {
        self.companyText.text=[self.companyArray objectAtIndex:indexPath.row];
        self.mytablebiew2.hidden=TRUE;
    }
}
-(IBAction)drop1ButtonAction:(id)sender
{
    self.mytablebiew1.hidden=FALSE;
}
-(IBAction)drop2ButtonAction:(id)sender
{
    self.mytablebiew2.hidden=FALSE;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.startDateText) {
        self.datePicker1View.hidden=FALSE;
        
    }
    else if(textField==self.returnDateText)
    {
        self.datePicker2View.hidden=FALSE;
    }
    else if (textField==self.economyText)
    {
        self.mytablebiew1.hidden=FALSE;
    }
    else if (textField==self.approveRadio)
    {
        [self.approvedradioButton setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        [self.deniedradioButton setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
        
    }
    else if (textField==self.denyRadio)
    {
        [self.deniedradioButton setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        [self.approvedradioButton setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
    }
    else if ((textField==self.contactNumberText1)||(textField==self.contactNumberText2)||(textField==self.ticketCost))
        return YES;
    else
    {
        self.mytablebiew2.hidden=FALSE;
    }
    
    return NO;
}
-(IBAction)datePicker1Action:(id)sender
{
    
    NSDate *myDate = self.datePicker1.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    
    self.startDateText.text=prettyVersion;
    self.datePicker1View.hidden=TRUE;
    
    
    
    
}
-(IBAction)datePicker2Action:(id)sender
{
    NSDate *myDate = self.datePicker2.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    
    self.returnDateText.text=prettyVersion;
    self.datePicker2View.hidden=TRUE;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    // checking for validity of mobileNUmber
    if ((textField==self.contactNumberText1)||(textField==self.contactNumberText2)||(textField==self.ticketCost)) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=12)
        {

            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789+-"];
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
            return NO;
        }
        
    }
    else
        return false;
}

-(IBAction)uploadDocument:(id)sender
{
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
    
    [(ViewController *)[self.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];

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
    [(ViewController *)[self.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:picker animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    [self.uploadEvidenceArray replaceObjectAtIndex:self.row withObject:chosenImage];
    self.uploadCollectionView.hidden=false;
    self.uploadButton.hidden=true;
    [self.uploadCollectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


-(void)formColorSetting
{
    colour=[[NSUserDefaults standardUserDefaults]objectForKey:@"color"];
    if ([colour isEqualToString:@"Blue"]) {
        self.image1.image=self.image4.image=self.image8.image=self.image9.image=[UIImage imageNamed:@"rule.pngwe.png"];
        
        self.image2.image=[UIImage imageNamed:@"group_box_revised2.png"];
        self.image3.image=[UIImage imageNamed:@"group_box_revised3.png"];
        self.image6.image=self.image5.image=[UIImage imageNamed:@"botton_box_new.png"];
        self.image7.image=[UIImage imageNamed:@"authorizationrfe234.png"];
        
    }
    if ([colour isEqualToString:@"Red"]) {
        
        self.image1.image=self.image4.image=self.image8.image=self.image9.image=[UIImage imageNamed:@"red grup1.png"];
        
        self.image2.image=[UIImage imageNamed:@"red grup2.png"];
        self.image3.image=[UIImage imageNamed:@"red grup3.png"];
        self.image6.image=self.image5.image=[UIImage imageNamed:@"cellred2.png"];
        self.image7.image=[UIImage imageNamed:@"red-Auth.png"];
        
        
    }
    if ([colour isEqualToString:@"Green"]) {
        
        self.image1.image=self.image4.image=self.image8.image=self.image9.image=[UIImage imageNamed:@"gree grup.png"];
        
        self.image2.image=[UIImage imageNamed:@"gree grup2.png"];
        self.image3.image=[UIImage imageNamed:@"grupgreen3.png"];
        self.image6.image=self.image5.image=[UIImage imageNamed:@"cellgreen1.png"];
        self.image7.image=[UIImage imageNamed:@"green_Auth.png"];
    }
    if ([colour isEqualToString:@"Black"]) {

        self.image1.image=self.image4.image=self.image8.image=self.image9.image=[UIImage imageNamed:@"bl grup1.png"];
        
        self.image2.image=[UIImage imageNamed:@"bl grup3.png"];
        self.image3.image=[UIImage imageNamed:@"bl grup.png"];
        self.image6.image=self.image5.image=[UIImage imageNamed:@"cellblak2.png"];
        self.image7.image=[UIImage imageNamed:@"blak_Auth.png"];
    }
    if ([colour isEqualToString:@"Orange"]) {
        
        self.image1.image=self.image4.image=self.image8.image=self.image9.image=[UIImage imageNamed:@"group_box_revised orng.png"];
        
        self.image2.image=[UIImage imageNamed:@"group_box_revisedorg2.png"];
        self.image3.image=[UIImage imageNamed:@"group_box_revisedorg3.png"];
        self.image6.image=self.image5.image=[UIImage imageNamed:@"cellorang2.png"];
        self.image7.image=[UIImage imageNamed:@"orang_Auth.png"];
    }
    [self.earningsTC reloadData];
    [self.deductionsTC reloadData];
}
- (IBAction)newEmpSignAction:(id)sender {
    
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"newSignatureView" owner:self options:nil];
    UIView *view=[nib objectAtIndex:0];
    [view setFrame:CGRectMake(160, 482, 591, 299)];
    [self addSubview:view];
    
    
}
@end
