//
//  otherLeaveClass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/31/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "otherLeaveClass.h"
#import "advancedplusCollectionViewCell.h"
#import "earningsTableViewCell.h"

@implementation otherLeaveClass
@synthesize colour;
- (void)drawRect:(CGRect)rect {
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
-(void)awakeFromNib
{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadingthecollectionview) name:@"otherleavenotification" object:Nil];
    
    
    [self.mycollectionView registerNib:[UINib nibWithNibName:@"advancedplusCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"signaturecell"];
   // self.stamparray=[[NSMutableArray alloc]initWithObjects:@"important-290x100_1.jpg",@"RejectedStamp.jpg",@"urgent-stamp-md.png",@"receivednew.jpeg",@"important-290x100_1.jpg",nil];
   // self.stamparray1=[[NSMutableArray alloc]initWithObjects:@"overdue.png",@"final_notice_stamp.png",@"expired.png",@"newconfident.jpeg",@"copy2.jpg",nil];
    
    self.stamparray=[[NSMutableArray alloc]init];
    self.stamparray1=[[NSMutableArray alloc]init];
    
    self.leaveLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveType"];
    self.datePicker1View.hidden=TRUE;
    self.datePicker2View.hidden=TRUE;
    [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[UIDatePicker class]]]setBackgroundColor:nil];
    
    [self formColorSetting];
    
    
}

-(void)reloadingthecollectionview
{
    
    [self.mycollectionView reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    advancedplusCollectionViewCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"signaturecell" forIndexPath:indexPath];
    
   // [cell1.stampicon setImage:[UIImage imageNamed:[self.stamparray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
   // [cell1.stampicon1 setImage:[UIImage imageNamed:[self.stamparray1 objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    
    if ([[appDelegate.otherleave_array objectAtIndex:indexPath.row]isKindOfClass:[UIImage class]]) {
        
        cell1.signImg.image=[appDelegate.otherleave_array objectAtIndex:indexPath.row];
        cell1.dateLabel.text=@"30/08/2016";
    }
    else
    {
        
        cell1.signImg.image=Nil;
        cell1.dateLabel.text=@"";
    }

    
    
    return cell1;
}
-(IBAction)halfdayButtonAction:(id)sender
{
    if (self.x%2==0)
    {
        [self.startRadioButton setImage:[UIImage imageNamed:@"tick_button_a.png"] forState:UIControlStateNormal];
        self.x++;
    }
    else
    {
        [self.startRadioButton setImage:[UIImage imageNamed:@"tick_button_b.png"] forState:UIControlStateNormal];
        self.x++;
    }
}
-(IBAction)halfdayButtonAction1:(id)sender
{
    if (self.y%2==0)
    {
        [self.endradioButton setImage:[UIImage imageNamed:@"tick_button_a.png"] forState:UIControlStateNormal];
        self.y++;
    }
    else
    {
        [self.endradioButton setImage:[UIImage imageNamed:@"tick_button_b.png"] forState:UIControlStateNormal];
        self.y++;
    }
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
    if (textField==self.startDate) {
        self.datePicker1View.hidden=FALSE;
        
        
    }
    else if(textField==self.endDate)
    {
        self.datePicker2View.hidden=FALSE;
    }
        
    else if (textField==self.halfDay1)
    {
        if (self.x%2==0)
        {
            [self.startRadioButton setImage:[UIImage imageNamed:@"tick_button_a.png"] forState:UIControlStateNormal];
            self.x++;
        }
        else
        {
            [self.startRadioButton setImage:[UIImage imageNamed:@"tick_button_b.png"] forState:UIControlStateNormal];
            self.x++;
        }
    }
    else if (textField==self.contactTextField)
    {
        return YES;
    }
    else
    {
        if (self.y%2==0)
        {
            [self.endradioButton setImage:[UIImage imageNamed:@"tick_button_a.png"] forState:UIControlStateNormal];
            self.y++;
        }
        else
        {
            [self.endradioButton setImage:[UIImage imageNamed:@"tick_button_b.png"] forState:UIControlStateNormal];
            self.y++;
        }
        
    }
    return NO;
}
-(IBAction)datePicker1Action:(id)sender
{
    
    NSDate *myDate = self.datePicker1.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    
    self.startDate.text=prettyVersion;
    self.datePicker1View.hidden=TRUE;
    
    
    
    
}
-(IBAction)datePicker2Action:(id)sender
{
    NSDate *myDate = self.datePicker2.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    
    self.endDate.text=prettyVersion;
    self.datePicker2View.hidden=TRUE;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.earningsTC) {
        return 6;
    }
    else
        return 6;
    
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
    else
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
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    // checking for validity of mobileNUmber
    if (textField==self.contactTextField){
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=12) {
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
            return NO;
        
    }
    return false;
}

-(void)formColorSetting
{
    colour=[[NSUserDefaults standardUserDefaults]objectForKey:@"color"];
    if ([colour isEqualToString:@"Blue"]) {
        self.image1.image=self.image3.image=self.image4.image=self.image8.image=self.image9.image=[UIImage imageNamed:@"rule.pngwe.png"];
        
        self.image2.image=[UIImage imageNamed:@"other_leave_newbluypng.png"];
        self.image6.image=self.image5.image=[UIImage imageNamed:@"botton_box_new.png"];
        self.image7.image=[UIImage imageNamed:@"authorizationrfe234.png"];
        
    }
    if ([colour isEqualToString:@"Red"]) {
        
        self.image1.image=self.image3.image=self.image4.image=self.image8.image=self.image9.image=[UIImage imageNamed:@"red grup1.png"];
        
        self.image2.image=[UIImage imageNamed:@"other_leave_red.png"];
        self.image6.image=[UIImage imageNamed:@"cellred2.png"];
        self.image5.image=[UIImage imageNamed:@"cellred2.png"];
        self.image7.image=[UIImage imageNamed:@"red-Auth.png"];
    }
    if ([colour isEqualToString:@"Green"]) {
        self.image1.image=self.image3.image=self.image4.image=self.image8.image=self.image9.image=[UIImage imageNamed:@"gree grup.png"];
        
        self.image2.image=[UIImage imageNamed:@"other_leave_green.png"];
        self.image6.image=self.image5.image=[UIImage imageNamed:@"cellgreen1.png"];
        self.image7.image=[UIImage imageNamed:@"green_Auth.png"];
    }
    if ([colour isEqualToString:@"Black"]) {
        self.image1.image=self.image3.image=self.image4.image=self.image8.image=self.image9.image=[UIImage imageNamed:@"bl grup1.png"];
        
        self.image2.image=[UIImage imageNamed:@"other_leave_black.png"];
        self.image6.image=self.image5.image=[UIImage imageNamed:@"cellblak2.png"];
        self.image7.image=[UIImage imageNamed:@"blak_Auth.png"];
    }
    if ([colour isEqualToString:@"Orange"]) {
        self.image1.image=self.image3.image=self.image4.image=self.image8.image=self.image9.image=[UIImage imageNamed:@"group_box_revised orng.png"];
        
        self.image2.image=[UIImage imageNamed:@"other_leave_orange.png"];
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
