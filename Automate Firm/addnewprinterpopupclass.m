//
//  addnewprinterpopupclass.m
//  Automate Firm
//
//  Created by leonine on 13/01/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "addnewprinterpopupclass.h"
#import "printercellclass.h"
#import "settingsViewController.h"
@implementation addnewprinterpopupclass
@synthesize myindex2,x,editFlag;
- (void)drawRect:(CGRect)rect {
    
    
    self.frame=CGRectMake(30, 50, self.frame.size.width, self.frame.size.height);
    self.backgroundColor=[UIColor whiteColor];
    self.alpha=100;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-500, -300, 1300, 1000)];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    //  self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
    
    
}


-(void)awakeFromNib
{
    
     [self.printercollectionview registerNib:[UINib nibWithNibName:@"printercell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
     self.plusbutton.hidden=TRUE;
    
     self.prnternamearray=[[NSMutableArray alloc] init];
     self.emailarray=[[NSMutableArray alloc] init];
     self.rateaarray=[[NSMutableArray alloc] init];
     self.selectedarray=[[NSMutableArray alloc] init];
    
    self.myoficeDictionary = [[NSMutableDictionary alloc]init];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"dictionaryKey"];
    self.myoficeDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"printerdictionary"]==Nil) {
        
       NSMutableArray *printerarray = [self.myoficeDictionary objectForKey:@"printer"];
        
        if (printerarray.count>0) {
            
            for (int i=0; i<printerarray.count; i++) {
                
                
                NSMutableDictionary *dict = [printerarray objectAtIndex:i];
                [self.prnternamearray addObject:[dict objectForKey:@"name"]];
                NSArray *splitarray = [[dict objectForKey:@"email"] componentsSeparatedByString:@"@"];
                [self.emailarray addObject:[splitarray objectAtIndex:0]];
                [self.rateaarray addObject:[splitarray objectAtIndex:1]];
            }
            
            
        }
        else
        {
            
            self.prnternamearray=[[NSMutableArray alloc] initWithObjects:@"", nil];
            self.emailarray=[[NSMutableArray alloc] initWithObjects:@"", nil];
            self.rateaarray=[[NSMutableArray alloc] initWithObjects:@"", nil];
            
        }
        
        
        
        
    }
    else
    {
           [self.prnternamearray removeAllObjects];
           [self.emailarray removeAllObjects];
           [self.rateaarray removeAllObjects];
        
           NSMutableDictionary *printerdict=[[NSUserDefaults standardUserDefaults] objectForKey:@"printerdictionary"];
        
           [self.prnternamearray addObjectsFromArray:[printerdict objectForKey:@"printername"]];
           [self.emailarray addObjectsFromArray:[printerdict objectForKey:@"emailarray"]];
           [self.rateaarray addObjectsFromArray:[printerdict objectForKey:@"ratearray"]];
        if (!(self.rateaarray.count>0)) {
            self.plusbutton.hidden=FALSE;
        }
    }
    
    
    x=0;
    editFlag=0;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return [self.rateaarray count];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     printercellclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
     cell.namefield.text=[self.prnternamearray objectAtIndex:indexPath.row];
     cell.mailfield.text=[self.emailarray objectAtIndex:indexPath.row];
     cell.ratefield.text=[self.rateaarray objectAtIndex:indexPath.row];
    
  
     cell.namefield.delegate=self;
     cell.mailfield.delegate=self;
     cell.ratefield.delegate=self;
     cell.closebutton.hidden=TRUE;
    
    
    if (x==0) {
        
        
    if ([self.selectedarray containsObject:indexPath]) {
            
            [cell.namefield setUserInteractionEnabled:FALSE];
            [cell.mailfield setUserInteractionEnabled:FALSE];
            [cell.ratefield setUserInteractionEnabled:FALSE];
            
        }
        else
        {
        
        [cell.namefield setUserInteractionEnabled:TRUE];
        [cell.mailfield setUserInteractionEnabled:TRUE];
        [cell.ratefield setUserInteractionEnabled:TRUE];
      
        }
        
    }
    else
    {
        [cell.namefield setUserInteractionEnabled:FALSE];
        [cell.mailfield setUserInteractionEnabled:FALSE];
        [cell.ratefield setUserInteractionEnabled:FALSE];
        
    }
    
    if (indexPath.row==self.rateaarray.count-1) {
        
        if (cell.ratefield.text.length>0) {
            
             self.plusbutton.hidden=FALSE;
            [cell.namefield setUserInteractionEnabled:FALSE];
            [cell.mailfield setUserInteractionEnabled:FALSE];
            [cell.ratefield setUserInteractionEnabled:FALSE];

        }
        else
        {
            
            self.plusbutton.hidden=TRUE;
            
            [cell.namefield setUserInteractionEnabled:TRUE];
            [cell.mailfield setUserInteractionEnabled:TRUE];
            [cell.ratefield setUserInteractionEnabled:TRUE];
  
            
        }
        
    }
    
    
    
    UILongPressGestureRecognizer *press=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressaction:)];
    [cell addGestureRecognizer:press];
     return cell;
    
    
}
-(void)longpressaction:(UILongPressGestureRecognizer *)guster
{
    
    printercellclass *cell = (printercellclass *)guster.view;
    cell.closebutton.hidden=FALSE;
    x=1;
    [cell.namefield setUserInteractionEnabled:TRUE];
    [cell.mailfield setUserInteractionEnabled:TRUE];
    [cell.ratefield setUserInteractionEnabled:TRUE];

    
}
-(IBAction)plusbuttonaction:(id)sender
{
    
    [self.prnternamearray addObject:@""];
    [self.emailarray addObject:@""];
    [self.rateaarray addObject:@""];
    
    
    NSArray *visibleItems = [self.printercollectionview indexPathsForVisibleItems];
    [self.printercollectionview reloadData];
    if (self.rateaarray.count>1) {
        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.rateaarray.count - 1 inSection:currentItem.section];
        [self.printercollectionview scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];

    }
    
    x=0;
    
  
}

-(IBAction)printerclosebuttonaction:(id)sender
{
    printercellclass *cell1 = (printercellclass *)[[sender superview] superview];
    NSIndexPath *myindex=[self.printercollectionview indexPathForCell:cell1];
    [self.prnternamearray removeObjectAtIndex:myindex.row];
    [self.emailarray removeObjectAtIndex:myindex.row];
    [self.rateaarray removeObjectAtIndex:myindex.row];
     x=0;
    [self.printercollectionview reloadData];
    self.plusbutton.hidden=FALSE;
}


-(IBAction)donebuttonaction:(id)sender
{
    
    [self.prnternamearray removeObject:@""];
    [self.emailarray removeObject:@""];
    [self.rateaarray removeObject:@""];
    NSLog(@"%@",self.prnternamearray);
    NSLog(@"%@",self.emailarray);
    NSLog(@"%@",self.rateaarray);
    
    if ((self.prnternamearray.count==self.emailarray.count)&&(self.prnternamearray.count==self.rateaarray.count)){
        NSMutableDictionary *saveprinterdict=[[NSMutableDictionary alloc] init];
        [saveprinterdict setObject:self.prnternamearray forKey:@"printername"];
        [saveprinterdict setObject:self.emailarray forKey:@"emailarray"];
        [saveprinterdict setObject:self.rateaarray forKey:@"ratearray"];
        
        [[NSUserDefaults standardUserDefaults] setObject:saveprinterdict forKey:@"printerdictionary"];
        
        [self removeFromSuperview];
    }
    else{
        [self.prnternamearray addObject:@""];
        [self.emailarray addObject:@""];
        [self.rateaarray addObject:@""];
        [self alertAction];
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    printercellclass *cell = (printercellclass *)[[textField superview] superview];
    if (textField==cell.namefield) {
        
        if (cell.namefield.text.length > 0) {
            editFlag=1;
        }
        else
        {
            editFlag=2;
        }
        
        CGPoint buttonPosition = [cell.namefield convertPoint:CGPointZero toView:self.printercollectionview];
        [self.printercollectionview setContentOffset:CGPointMake(self.printercollectionview.frame.origin.x-20, buttonPosition.y) animated:YES];
        cell.closebutton.hidden=TRUE;
        return  YES;
    }
    else if (textField== cell.mailfield)
    {
        if (!(cell.namefield.text.length > 0)) {
            editFlag=2;
            cell.mailfield.text=@"Enter Name";
            return  NO;
        }
        else
        {
            editFlag=1;
            CGPoint buttonPosition = [cell.mailfield convertPoint:CGPointZero toView:self.printercollectionview];
            [self.printercollectionview setContentOffset:CGPointMake(self.printercollectionview.frame.origin.x-20,buttonPosition.y) animated:YES];
            cell.closebutton.hidden=TRUE;
            return  YES;
        }
    }
    
    else
    {
        if (!(cell.mailfield.text.length > 0)) {
            editFlag=2;
            cell.ratefield.text=@"Enter Email";
            return  NO;
        }
        else
        {
            editFlag=1;
            if ([cell.mailfield.text isEqualToString:@"Enter Name"]) {
                cell.ratefield.text=@"Enter Email";
                return  NO;
            }
            else
            {
                CGPoint buttonPosition = [cell.ratefield convertPoint:CGPointZero toView:self.printercollectionview];
                [self.printercollectionview setContentOffset:CGPointMake(self.printercollectionview.frame.origin.x-20, buttonPosition.y) animated:YES];
                cell.closebutton.hidden=TRUE;
                return  YES;
            }
        }
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    printercellclass *cell1 = (printercellclass *)[[textField superview] superview];
     //CGPoint buttonPosition = [cell1.ratefield convertPoint:CGPointZero toView:self.printercollectionview];
     if (cell1.ratefield.text.length>0)
        {
         [self.printercollectionview setContentOffset:CGPointMake(self.printercollectionview.frame.origin.x-20,0) animated:YES];
        }

}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
   // [self.printercollectionview setContentOffset:CGPointMake(self.printercollectionview.frame.origin.x,0) animated:YES];
    printercellclass *cell1 = (printercellclass *)[[textField superview] superview];
    NSIndexPath *myindex=[self.printercollectionview indexPathForCell:cell1];
    
    if (textField==cell1.namefield) {
        if (cell1.namefield.text.length > 0) {
            if (!(myindex.row + 1 == self.prnternamearray.count)) {
                
                if (editFlag==1) {
                    [self.prnternamearray replaceObjectAtIndex:myindex.row withObject:cell1.namefield.text];
                }
                else
                {
                    [self.prnternamearray insertObject:cell1.namefield.text atIndex:myindex.row];
                }
                
            }
            else
            {
                [self.prnternamearray replaceObjectAtIndex:myindex.row withObject:cell1.namefield.text];
            }
        }
        else
        {
            [self alertAction];
        }
        if ([cell1.mailfield.text isEqualToString:@"Enter Name"]) {
            cell1.mailfield.text=@"";
        }
    }
    
    if (textField==cell1.mailfield) {
        if (cell1.mailfield.text.length>0) {
            if (!(myindex.row + 1 == self.emailarray.count)) {
                
                if (editFlag==1) {
                    [self.emailarray replaceObjectAtIndex:myindex.row withObject:cell1.mailfield.text];
                }
                else
                {
                    [self.emailarray insertObject:cell1.mailfield.text atIndex:myindex.row ];
                }
                
            }
            else
            {
                [self.emailarray replaceObjectAtIndex:myindex.row withObject:cell1.mailfield.text];
            }
        }
        
        else
        {
            [self alertAction];
        }
        if ([cell1.ratefield.text isEqualToString:@"Enter Email"]) {
            cell1.ratefield.text=@"";
        }
    }
    if (textField==cell1.ratefield) {
        if (cell1.ratefield.text.length>0) {
            
            if ([cell1.namefield.text isEqual:@""] || [cell1.mailfield.text isEqual:@""] || [cell1.ratefield.text isEqual:@""])
            {
                        
                NSLog(@"Warning");
            }
            else
            {
                if (!(myindex.row + 1 == self.rateaarray.count)) {
                    if (editFlag==1) {
                        //[self.rateaarray replaceObjectAtIndex:myindex.row withObject:cell1.ratefield.text];
                    //}
                    //else
                    //{
                        [self.rateaarray insertObject:cell1.ratefield.text atIndex:myindex.row ];
                    }
                    
                    
                }
                else
                {
                    [self.rateaarray replaceObjectAtIndex:myindex.row withObject:cell1.ratefield.text];
                            
                    self.plusbutton.hidden=false;
                            
                    [self.printercollectionview reloadData];
                }
                        
                
            }
        }
        else
        {
            [self alertAction];
        }
        NSLog(@"%@",self.prnternamearray);
        NSLog(@"%@",self.emailarray);
        NSLog(@"%@",self.rateaarray);

    }
    return YES;
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
   
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,0);
    
}

-(void)alertAction
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:@"All Fields are Mandatory"
                               preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       [self.printercollectionview reloadData];
                                                   }];
    [alert addAction:cancel];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}
@end
