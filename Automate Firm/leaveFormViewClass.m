//
//  leaveFormViewClass.m
//  Automate Firm
//
//  Created by leonine on 6/16/16.
//  Copyright © 2016 leonine. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>
#import "leaveFormViewClass.h"
#import "documentflowcellclass.h"
#import "documentsRemarksTableCell.h"
#import "paternityLeaveClass.h"
#import "maternityLeaveViewClass.h"
#import "vacationLeave.h"
#import "otherLeaveClass.h"
#import "evidenceCollectionViewCell.h"
#import "leaveTypeCollectionViewCell.h"
#import <CoreText/CoreText.h>
@implementation leaveFormViewClass
@synthesize formNumber,actionFlag,row;
-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(evidencesignature) name:@"evidencesignature" object:Nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"VACT" forKey:@"leavetypename"];
    
    [self.evidenceCollectionView registerNib:[UINib nibWithNibName:@"evidenceCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"evidenceCell"];
    [self.leaveTypeCV registerNib:[UINib nibWithNibName:@"leaveTypeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"leaveCell"];
    self.firstArray=[[NSMutableArray alloc] initWithObjects:@"The govt. attestation document is not attached",@"I request you to pls do the needy",@"Attach the medical report", nil];
    
    self.firstView.hidden=TRUE;
    
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"vacationLeave" owner:self options:nil];
    [self.myview addSubview:[nib objectAtIndex:0]];
    self.othersArray=[[NSMutableArray alloc] initWithObjects:@"VACT",@"EMGT",@"SICK",@"PATR",@"MATR",@"ODTY",@"LEV1",@"LEV2",@"LEV3",@"LEV4",@"LEV5",@"LEV6",@"LEV7", nil];
    self.evidenceArray=[[NSMutableArray alloc]init];
    
    formNumber=1;row=self.selectedRow=0;
    
    if (self.evidenceArray.count > 0) {
        [self initializeTimer];
    }
    else
    {
        self.rightButtonView.hidden=true;
    }
    [self formColorSetting];
    
}

-(void)evidencesignature
{
     AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    evidenceCollectionViewCell *cell =(evidenceCollectionViewCell *)[self.evidenceCollectionView cellForItemAtIndexPath:appDelegate.signatureindex];
    cell.signatureimg.image=appDelegate.sigimg;
    
}
-(void)initializeTimer
{
    //For Blink Effect
    
    self.timer = [NSTimer
                  scheduledTimerWithTimeInterval:(NSTimeInterval)(0.40)
                  target:self
                  selector:@selector(blink)
                  userInfo:nil
                  repeats:TRUE];
    self.blinkStatus = NO;
    self.rightButtonView.hidden=false;
}
-(void)blink{
    if(self.blinkStatus == NO){
        self.rightButton.hidden=true;
        self.blinkStatus = YES;
    }else {
        self.rightButton.hidden=false;
        self.blinkStatus = NO;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==self.evidenceCollectionView) {
        return self.evidenceArray.count;
    }
    else
        return self.othersArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.evidenceCollectionView) {
        evidenceCollectionViewCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"evidenceCell" forIndexPath:indexPath];
        cell1.backImage.image=[self.evidenceArray objectAtIndex:indexPath.row];
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(cellLongPress:)];
        [cell1 addGestureRecognizer:lpgr];
        return cell1;
    }
    else
    {
        leaveTypeCollectionViewCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"leaveCell" forIndexPath:indexPath];
        
        cell1.leaveLabel.text=[self.othersArray objectAtIndex:indexPath.row];
        
        if (indexPath.row==self.selectedRow) {
           
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:cell1.leaveLabel.text];
            [attString addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                              value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                              range:(NSRange){0,[attString length]}];
            cell1.leaveLabel.attributedText = attString;
        }
        
        
        return cell1;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.leaveTypeCV) {
        for (UIView *view in self.myview.subviews) {
            if ([view isKindOfClass:[paternityLeaveClass class]] || [view isKindOfClass:[maternityLeaveViewClass class]] || [view isKindOfClass:[vacationLeave class]]|| [view isKindOfClass:[otherLeaveClass class]] || [view isKindOfClass:[maternityLeaveViewClass class]] ) {
                [view removeFromSuperview];
            }
        }
        self.selectedRow=indexPath.row;
        if (indexPath.row==0) {
            AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [appDelegate.vact_emrc_sickleavearray removeAllObjects];
            
            for (int i=0; i<5; i++) {
                
                [appDelegate.vact_emrc_sickleavearray insertObject:@"" atIndex:i];
            }
            
            
            [self vacationSickEmergencyLeaveAction];
        }
        if (indexPath.row==1) {
            
            AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [appDelegate.vact_emrc_sickleavearray removeAllObjects];
            
            for (int i=0; i<5; i++) {
                
                [appDelegate.vact_emrc_sickleavearray insertObject:@"" atIndex:i];
            }

            [self vacationSickEmergencyLeaveAction];
        }
        if (indexPath.row==2) {
            
            AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [appDelegate.vact_emrc_sickleavearray removeAllObjects];
            
            for (int i=0; i<5; i++) {
                
                [appDelegate.vact_emrc_sickleavearray insertObject:@"" atIndex:i];
            }

            [self vacationSickEmergencyLeaveAction];
        }
        if (indexPath.row==3) {
            
            AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [appDelegate.petennityleavesignaturearray removeAllObjects];
            
            for (int i=0; i<5; i++) {
                
                [appDelegate.petennityleavesignaturearray insertObject:@"" atIndex:i];
            }

             [self paternityLeaveAction];
        }
        if (indexPath.row==4) {
            
            AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [appDelegate.maternityleavearray removeAllObjects];
            
            for (int i=0; i<5; i++) {
                
                [appDelegate.maternityleavearray insertObject:@"" atIndex:i];
            }

            [self maternityLeaveAction];
        }
        if (indexPath.row==6) {
            
        }
        if (indexPath.row>6) {
            
            AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [appDelegate.otherleave_array removeAllObjects];
            
            for (int i=0; i<5; i++) {
                
                [appDelegate.otherleave_array insertObject:@"" atIndex:i];
            }

            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"otherLeaveView" owner:self options:nil];
            [self.myview addSubview:[nib objectAtIndex:0]];
        }
        
        leaveTypeCollectionViewCell *cell1 =(leaveTypeCollectionViewCell *)[self.leaveTypeCV cellForItemAtIndexPath:indexPath];
        
        [[NSUserDefaults standardUserDefaults] setObject:cell1.leaveLabel.text forKey:@"leavetypename"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.leaveTypeCV reloadData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.firstTableView) {
        
        return self.firstArray.count;
    }
    else
        return 10;
    
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
    else
    {
        documentflowcellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"simlecell2"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"documentflowtablecell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        return cell;
        
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)cellLongPress:UILongPressGestureRecognizer
{
    evidenceCollectionViewCell *cell=(evidenceCollectionViewCell *)[UILongPressGestureRecognizer view];
    cell.deleteButton.hidden=false;
    self.inPath=[self.evidenceCollectionView indexPathForCell:cell];
}
-(IBAction)evidenceDeleteAction:(id)sender
{
    [self.evidenceArray removeObjectAtIndex:self.inPath.row];
    [self.evidenceCollectionView reloadData];
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

//Leave


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField==self.visaExpiry) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Duration for Visa Expiration should be > 3 months" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    return NO;
}
-(void)vacationSickEmergencyLeaveAction
{
    for (UIView *view in self.myview.subviews) {
        if ([view isKindOfClass:[paternityLeaveClass class]] || [view isKindOfClass:[maternityLeaveViewClass class]] || [view isKindOfClass:[vacationLeave class]]|| [view isKindOfClass:[otherLeaveClass class]]) {
            [view removeFromSuperview];
        }
    }
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"vacationLeave" owner:self options:nil];
    [self.myview addSubview:[nib objectAtIndex:0]];
}
-(void)paternityLeaveAction
{
    for (UIView *view in self.myview.subviews) {
        if ([view isKindOfClass:[paternityLeaveClass class]] || [view isKindOfClass:[maternityLeaveViewClass class]] || [view isKindOfClass:[vacationLeave class]]|| [view isKindOfClass:[otherLeaveClass class]]) {
            [view removeFromSuperview];
        }
    }
    
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"paternityLeave" owner:self options:nil];
    [self.myview addSubview:[nib objectAtIndex:0]];
}
-(void)maternityLeaveAction
{
    for (UIView *view in self.myview.subviews) {
        if ([view isKindOfClass:[paternityLeaveClass class]] || [view isKindOfClass:[maternityLeaveViewClass class]] || [view isKindOfClass:[vacationLeave class]]|| [view isKindOfClass:[otherLeaveClass class]]) {
            [view removeFromSuperview];
        }
    }
   
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"maternityLeaveView" owner:self options:nil];
    [self.myview addSubview:[nib objectAtIndex:0]];
}
-(IBAction)leaveRedemAction:(id)sender{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        [self.leaveRedemScroll setContentOffset:CGPointMake(349, 0) animated:YES];
    }
    else
    {
        [self.leaveRedemScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
-(IBAction)employeeSelectionAction:(id)sender
{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"employeeSelectionView" owner:self options:nil];
    [self.superview.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    
    
}

-(IBAction)evidenceMoveAction:(id)sender
{
    
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        if ((formNumber==1)&&(self.evidenceArray.count > 0)) {
            [self.evidenceScrollView setContentOffset:CGPointMake(855, 0)];
            self.leftButtonView.hidden=false;
            formNumber++;
            if (self.evidenceArray.count<2) {
                self.rightButtonView.hidden=true;
                [self invalidateTimer];
            }
        }
        
        else if (formNumber==2)//&& (self.evidenceArray.count>1))
        {
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:1 inSection:0] ;
            [self.evidenceCollectionView scrollToItemAtIndexPath:myIP atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
            formNumber++;
            if (self.evidenceArray.count<3) {
                self.rightButtonView.hidden=true;
                [self invalidateTimer];
            }
        }
        else if (formNumber==3)//&&(self.evidenceArray.count>2))
        {
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:2 inSection:0] ;
            [self.evidenceCollectionView scrollToItemAtIndexPath:myIP atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
            formNumber++;
            if (self.evidenceArray.count<4) {
                self.rightButtonView.hidden=true;
                [self invalidateTimer];
            }
        }
        else if (formNumber==4)//&&(self.evidenceArray.count>3))
        {
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:3 inSection:0] ;
            [self.evidenceCollectionView scrollToItemAtIndexPath:myIP atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
            formNumber++;
            if (self.evidenceArray.count<5) {
                self.rightButtonView.hidden=true;
                [self invalidateTimer];
            }
        }
        else if (formNumber==5)//&&(self.evidenceArray.count>4))
        {
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:4 inSection:0] ;
            [self.evidenceCollectionView scrollToItemAtIndexPath:myIP atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
            formNumber++;
            if (self.evidenceArray.count<6) {
                self.rightButtonView.hidden=true;
                [self invalidateTimer];
            }
        }
        else if (formNumber==6)//&&(self.evidenceArray.count>5))
        {
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:5 inSection:0] ;
            [self.evidenceCollectionView scrollToItemAtIndexPath:myIP atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
            formNumber++;
        }
        [self.evidenceCollectionView reloadData];
        
    }
    else
    {
        if(self.evidenceArray.count > 0)
        {
            [self initializeTimer];
        }
        
        switch (formNumber) {
            case 2:
                [self.evidenceScrollView setContentOffset:CGPointMake(0, 0)];
                self.leftButtonView.hidden=true;
                formNumber--;
                break;
            case 3:
            {
                NSIndexPath *myIP = [NSIndexPath indexPathForRow:0 inSection:0] ;
                [self.evidenceCollectionView scrollToItemAtIndexPath:myIP atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
                formNumber--;
                break;
            }
            case 4:
            {
                NSIndexPath *myIP = [NSIndexPath indexPathForRow:1 inSection:0] ;
                [self.evidenceCollectionView scrollToItemAtIndexPath:myIP atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
                formNumber--;
                break;
            }
            case 5:
            {
                NSIndexPath *myIP = [NSIndexPath indexPathForRow:2 inSection:0] ;
                [self.evidenceCollectionView scrollToItemAtIndexPath:myIP atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
                formNumber--;
                break;
            }
            case 6:
            {
                NSIndexPath *myIP = [NSIndexPath indexPathForRow:3 inSection:0] ;
                [self.evidenceCollectionView scrollToItemAtIndexPath:myIP atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
                formNumber--;
                break;
            }
            case 7:
            {
                NSIndexPath *myIP = [NSIndexPath indexPathForRow:4 inSection:0] ;
                [self.evidenceCollectionView scrollToItemAtIndexPath:myIP atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
                formNumber--;
                break;
            }
            default:
                break;
        }
        [self.evidenceCollectionView reloadData];
    }
}
-(void)invalidateTimer
{
    if (self.blinkStatus==NO) {
        [self.timer invalidate];
    }
}
-(IBAction)uploadEvidence:(id)sender
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
    
    CGRect frame=CGRectMake(730, 200, 0, 0);
    
    alert.popoverPresentationController.sourceView = self;
    alert.popoverPresentationController.sourceRect = frame;
    
    
    [(ViewController *)[self.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    
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
    [(ViewController *)[self.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:picker animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    [self.evidenceArray insertObject:chosenImage atIndex:row];
    [self.evidenceCollectionView reloadData];
    row++;
    [self initializeTimer];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)formColorSetting
{
    NSString *color=[[NSUserDefaults standardUserDefaults]objectForKey:@"color"];
    if ([color isEqualToString:@"Blue"]) {
        self.image1.image=[UIImage imageNamed:@"office22.png"];
        self.image2.image=[UIImage imageNamed:@"rule.pngwe.png"];
        self.image3.image=[UIImage imageNamed:@"blur.png"];
        self.image4.image=self.image5.image=[UIImage imageNamed:@"blur.png"];
        self.backImage.image=[UIImage imageNamed:@"main_BG1.png"];
    }
    if ([color isEqualToString:@"Red"]) {
        self.image1.image=[UIImage imageNamed:@"cellerd4.png"];
        self.image2.image=[UIImage imageNamed:@"red grup1.png"];
        self.image3.image=[UIImage imageNamed:@"cellred.png"];
        self.image4.image=self.image5.image=[UIImage imageNamed:@"cellred.png"];
        self.backImage.image=[UIImage imageNamed:@"FORMred.png"];
    }
    if ([color isEqualToString:@"Green"]) {
        self.image1.image=[UIImage imageNamed:@"cellgreen4.png"];
        self.image2.image=[UIImage imageNamed:@"gree grup.png"];
        self.image3.image=[UIImage imageNamed:@"cellgreen2.png"];
        self.image4.image=self.image5.image=[UIImage imageNamed:@"cellgreen2.png"];
        self.backImage.image=[UIImage imageNamed:@"FORMgreen.png"];
    }
    if ([color isEqualToString:@"Black"]) {
        self.image1.image=[UIImage imageNamed:@"cellblak.png"];
        self.image2.image=[UIImage imageNamed:@"bl grup1.png"];
        self.image3.image=[UIImage imageNamed:@"cellblak4.png"];
        self.image4.image=self.image5.image=[UIImage imageNamed:@"cellblak4.png"];
        self.backImage.image=[UIImage imageNamed:@"FORMblack.png"];
    }
    if ([color isEqualToString:@"Orange"]) {
        self.image1.image=[UIImage imageNamed:@"cellorang4.png"];
        self.image2.image=[UIImage imageNamed:@"group_box_revised orng.png"];
        self.image3.image=[UIImage imageNamed:@"cellorang3.png"];
        self.image4.image=self.image5.image=[UIImage imageNamed:@"cellorang3.png"];
        self.backImage.image=[UIImage imageNamed:@"FORMred.png"];
    }

}

-(IBAction)signbuttonaction:(id)sender
{
    evidenceCollectionViewCell *cell1 =(evidenceCollectionViewCell *)[[sender superview] superview];
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    appDelegate.signatureindex=[self.evidenceCollectionView indexPathForCell:cell1];

    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"evidencesignatureview" owner:self options:nil];
    
    [self addSubview:[nib objectAtIndex:0]];
    
}


@end
