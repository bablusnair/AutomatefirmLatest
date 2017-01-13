//
//  paternityLeaveClass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/22/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//
#import "advancedplusCollectionViewCell.h"
#import "paternityLeaveClass.h"
#import "earningsTableViewCell.h"
@implementation paternityLeaveClass
@synthesize colour;
- (void)drawRect:(CGRect)rect {
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
-(void)awakeFromNib
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadingthecollectionview) name:@"reloadingthecollectionview" object:Nil];
    
    [self.mycollectionView registerNib:[UINib nibWithNibName:@"advancedplusCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"signaturecell"];
    self.stamparray=[[NSMutableArray alloc]init];
    self.stamparray1=[[NSMutableArray alloc]init];
    
    //self.stamparray=[[NSMutableArray alloc]initWithObjects:@"important-290x100_1.jpg",@"RejectedStamp.jpg",@"urgent-stamp-md.png",@"receivednew.jpeg",@"important-290x100_1.jpg",nil];
  //  self.stamparray1=[[NSMutableArray alloc]initWithObjects:@"overdue.png",@"final_notice_stamp.png",@"expired.png",@"newconfident.jpeg",@"copy2.jpg",nil];
    
    
    self.chldrensArray=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    self.childrensTC.hidden=TRUE;
    self.datePicker1View.hidden=TRUE;
    self.datePicker2View.hidden=TRUE;
    self.datePicker3View.hidden=TRUE;
    
    [[UITableView appearanceWhenContainedIn:[UIDatePicker class], nil] setBackgroundColor:nil];
    
    [self formColorSetting];
    
}

-(void)reloadingthecollectionview
{
    
    [self.mycollectionView reloadData];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//     AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    advancedplusCollectionViewCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"signaturecell" forIndexPath:indexPath];
    
  //  [cell1.stampicon setImage:[UIImage imageNamed:[self.stamparray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
 //   [cell1.stampicon1 setImage:[UIImage imageNamed:[self.stamparray1 objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
   
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    
    if ([[appDelegate.petennityleavesignaturearray objectAtIndex:indexPath.row]isKindOfClass:[UIImage class]]) {
        
        cell1.signImg.image=[appDelegate.petennityleavesignaturearray objectAtIndex:indexPath.row];
        cell1.dateLabel.text=@"30/08/2016";
    }
    else
    {
        
        cell1.signImg.image=Nil;
        cell1.dateLabel.text=@"";
    }
    
    return cell1;
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
    if (tableView==self.earningsTC) {
        return 6;
    }
    else if(tableView==self.deductionsTC)
        return 6;
    else
        return self.chldrensArray.count;
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
    else if(tableView==self.deductionsTC)
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
        cell.textLabel.text=[self.chldrensArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.childrensLabel.text=[self.chldrensArray objectAtIndex:indexPath.row];
    self.childrensTC.hidden=TRUE;
}
-(IBAction)childrensDropDown:(id)sender
{
    self.childrensTC.hidden=FALSE;
}
-(IBAction)uploadDocument:(id)sender
{
    
    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
    imgPicker.delegate=self;
    imgPicker.allowsEditing=TRUE;
    imgPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    NSLog(@"%@",self.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview);
    [(ViewController *)[self.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:imgPicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
    //    //self.myimgviews.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
    
    else
        
    self.datePicker3View.hidden=FALSE;
    
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
-(IBAction)datePicker3Action:(id)sender
{
    NSDate *myDate = self.datePicker3.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    
    self.EDDText.text=prettyVersion;
    self.datePicker3View.hidden=TRUE;
}

-(void)formColorSetting
{
    colour=[[NSUserDefaults standardUserDefaults]objectForKey:@"color"];
    
    if ([colour isEqualToString:@"Blue"]) {
        
        self.image1.image=self.image3.image=self.image7.image=self.image8.image=[UIImage imageNamed:@"rule.pngwe.png"];
        
        self.image2.image=[UIImage imageNamed:@"blr2.png"];
        self.image4.image=self.image5.image=[UIImage imageNamed:@"botton_box_new.png"];
        self.image6.image=[UIImage imageNamed:@"authorizationrfe234.png"];
        
    }
    if ([colour isEqualToString:@"Red"]) {
        
        self.image1.image=self.image3.image=self.image7.image=self.image8.image=[UIImage imageNamed:@"red grup1.png"];
        
        self.image2.image=[UIImage imageNamed:@"redr2.png"];
        self.image4.image=self.image5.image=[UIImage imageNamed:@"cellred2.png"];
        self.image6.image=[UIImage imageNamed:@"red-Auth.png"];
    }
    if ([colour isEqualToString:@"Green"]) {
        
        self.image1.image=self.image3.image=self.image7.image=self.image8.image=[UIImage imageNamed:@"gree grup.png"];
        
        self.image2.image=[UIImage imageNamed:@"rgree2.png"];
        self.image4.image=self.image5.image=[UIImage imageNamed:@"cellgreen1.png"];
        self.image6.image=[UIImage imageNamed:@"green_Auth.png"];
    }
    if ([colour isEqualToString:@"Black"]) {
        
        self.image1.image=self.image3.image=self.image7.image=self.image8.image=[UIImage imageNamed:@"bl grup1.png"];
        
        self.image2.image=[UIImage imageNamed:@"blar2.png"];
        self.image4.image=self.image5.image=[UIImage imageNamed:@"cellblak2.png"];
        self.image6.image=[UIImage imageNamed:@"blak_Auth.png"];
    }
    
    if ([colour isEqualToString:@"Orange"]) {
        
        self.image1.image=self.image3.image=self.image7.image=self.image8.image=[UIImage imageNamed:@"group_box_revised orng.png"];
        
        self.image2.image=[UIImage imageNamed:@"orang2.png"];
        self.image4.image=self.image5.image=[UIImage imageNamed:@"cellorang2.png"];
        self.image6.image=[UIImage imageNamed:@"orang_Auth.png"];
        
    }
    
    
    [self.earningsTC reloadData];
    [self.deductionsTC reloadData];
    
}

- (IBAction)newEmpSignAction:(id)sender {
    
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"newSignatureView" owner:self options:nil];
    UIView *view=[nib objectAtIndex:0];
    [view setFrame:CGRectMake(160, 462, 591, 299)];
    [self addSubview:view];
    
    
}


@end
