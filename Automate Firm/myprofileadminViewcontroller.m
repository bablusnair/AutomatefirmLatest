//
//  myprofileadminViewcontroller.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 19/01/2017.
//  Copyright © 2017 leonine. All rights reserved.
//

#import "myprofileadminViewcontroller.h"
#import "paymentHistoryTableViewCell.h"
#import "paymethodTablecell.h"
#import "paymentBrowseCollectionCell.h"

@interface myprofileadminViewcontroller ()

@end

@implementation myprofileadminViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.addnewPaymentmethodview.hidden=true;
    self.estDatePicker.backgroundColor=[UIColor lightGrayColor];
    self.dobPicker.backgroundColor=[UIColor lightGrayColor];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.imagearray=[[NSMutableArray alloc] init];
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.estmatedDatetext) {
        self.estDatePicker.hidden=FALSE;
        return  NO;
    }
    if (textField==self.dobtext) {
        self.dobPicker.hidden=FALSE;
        return  NO;
    }
    else{
        self.activeField=textField;

        return  YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)donebutton:(id)sender
{
    self.addnewPaymentmethodview.hidden=true;
}
-(IBAction)cancelbutton:(id)sender
{
    self.addnewPaymentmethodview.hidden=true;
}

-(IBAction)addnewpaymentMethod:(id)sender
{
     self.addnewPaymentmethodview.hidden=false;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView==self.paymentHistroytable) {
        
        return 10;
    }
    
    else if (tableView==self.cartHistroytable)
    {
        
    return 12;
    
    }
    else if (tableView==self.paymentMethodtableview)
    {
        
        return 5;
        
    }
    else
    {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.paymentHistroytable) {
        
        paymentHistoryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"myprofile"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"paymentHistoryTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        return cell;
        
    }
    else if (tableView==self.cartHistroytable)
    {
        paymentHistoryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"myprofile"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"paymentHistoryTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        return cell;
    }
    else if (tableView==self.paymentMethodtableview)
    {
        paymethodTablecell *cell=[tableView dequeueReusableCellWithIdentifier:@"payment"];
        
        if (cell==nil) {
            
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"paymethodTablecell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        return cell;
    }

    else
    {
        return  nil;
    }
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
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

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.scrollView.contentOffset = CGPointMake(0,0);
    return YES;
}

- (IBAction)datePickAction:(id)sender {
    
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    if ( [sender tag]==0) {

    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:self.estDatePicker.date]];
    self.estmatedDatetext.text=str;
        self.estDatePicker.hidden=true;
    }
    else{
        NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:self.dobPicker.date]];
        self.dobtext.text=str;
        self.dobPicker.hidden=true;
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.imagearray count];
    
   }


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"mycell";

    paymentBrowseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.myimgview.image=[self.imagearray objectAtIndex:indexPath.row];
     cell.closebutton.hidden=true;
    UILongPressGestureRecognizer *press=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpress:)];
    [cell addGestureRecognizer:press];
    return cell;

}


-(void)longpress:(UILongPressGestureRecognizer *)guster
{
    
    paymentBrowseCollectionCell *cell0 = (paymentBrowseCollectionCell *)[self.broswecollectionview cellForItemAtIndexPath:self.preindexpath];
     cell0.closebutton.hidden=true;
    
    paymentBrowseCollectionCell *cell = (paymentBrowseCollectionCell *)guster.view;
    cell.closebutton.hidden=false;
    self.myindexpath = [self.broswecollectionview indexPathForCell:cell];
    
    self.preindexpath=self.myindexpath;
    
}

-(IBAction)browseaction:(id)sender
{
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 10; //Set the maximum number of images to select, defaults to 4
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return selected order of images
    elcPicker.imagePickerDelegate = self;
    
    //Present modally
    [self presentViewController:elcPicker animated:YES completion:nil];
    
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
      [self.imagearray removeAllObjects];
    
    for (NSDictionary *dict in info) {
        
        if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
            UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
            [self.imagearray addObject:image];
        }
    }
  
    [self.broswecollectionview reloadData];
    
      [picker dismissViewControllerAnimated:YES completion:Nil];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    
  [picker dismissViewControllerAnimated:YES completion:Nil];
    
}

-(IBAction)browseimagecloseaction:(id)sender
{
    
    [self.imagearray removeObjectAtIndex:self.myindexpath.row];
    
    [self.broswecollectionview reloadData];
}

@end
