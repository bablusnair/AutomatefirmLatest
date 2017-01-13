//
//  incometaxViewClass.m
//  Automate Firm
//
//  Created by leonine on 12/3/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "incometaxViewClass.h"
#import "taxfirstcellclass.h"
#import "taxsecondcellclass.h"
#import "otherSurchargesTableViewCell.h"
#import "instancetaxview.h"
#import "otherSurchargesCell.h"
#import "settingsViewController.h"

@implementation incometaxViewClass
@synthesize x,y,amount,netamount,myindex2,amountFlag,taxFlag,activeField;
-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    self.taxarray1=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4", nil];
    self.zeroarray=[[NSMutableArray alloc] initWithObjects:@"0",@"",@"",@"", nil];
    self.amountarray=[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"", nil];
    self.percentagetaxarray=[[NSMutableArray alloc]  initWithObjects:@"",@"",@"",@"", nil];
     [self.checkboxbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
 //   self.selectedarray=[[NSMutableArray alloc]  initWithObjects:@"",@"",@"",@"", nil];
      self.taxrangeRedarray=[[NSMutableArray alloc] init];
      self.selectedarray=[[NSMutableArray alloc] init];
  //  self.taxarray2=[[NSMutableArray alloc] init];
  
    self.abovebgflag=0;
    self.s1=1;
    self.resetflag=0;
    self.sur_selectedarray=[[NSMutableArray alloc] init];

    
    self.otherNametextSelectedarray=[[NSMutableArray alloc] init];
    
    
    self.sur_selectedarray2=[[NSMutableArray alloc] init];
    
    self.abovefieldmandtory.hidden=TRUE;
    
    self.subchargerangeRedarray=[[NSMutableArray alloc] init];
    
    
    self.amountdropdownArray=[[NSMutableArray alloc] init];
    
    
    self.amountfieldSelectedarray=[[NSMutableArray alloc] init];
    
    self.otherChargesArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    self.otherChargesTaxArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    self.otherChargesAmountArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    
    
    
    
    self.otherInstanceRangeArray=[[NSMutableArray alloc]initWithObjects:@"",@"", nil];
    self.otherInstanceTaxableAmountArray=[[NSMutableArray alloc]initWithObjects:@"",@"", nil];
    self.otherInstanceTaxArray=[[NSMutableArray alloc]initWithObjects:@"",@"", nil];
    self.otherInstanceTaxAmtArray=[[NSMutableArray alloc]initWithObjects:@"",@"", nil];
    
    
    
    self.otherchargeArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    self.otherTaxArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    self.otherAmountArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    
    
//    self.amountErrorIndexArray=[[NSMutableArray alloc]init];
//    self.taxErrorIndexArray=[[NSMutableArray alloc]init];
    
    
    self.globalstring=@"2";
    self.lastglobalstring=@"";
    
    x=0;
    y=0;
    amount=0;
    netamount=0;
    amountFlag=0;
    taxFlag=0;
    self.amountdropTC.hidden=true;
    
    
    
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


    
    self.aboveNumberlabel.hidden=TRUE;
    self.aboveResultvalue.hidden=TRUE;
    
    self.forinstanceaboveAmtvalue.hidden=TRUE;
    self.forinstanceaboveTaxvalue.hidden=TRUE;
    
    self.instancenotapplicable1.hidden=TRUE;
    self.instancenotapplicable2.hidden=TRUE;
    self.abovelabel.hidden=TRUE;
    
    
    NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.amountfieldSelectedarray addObject:myindexPath];
    [self.otherNametextSelectedarray addObject:myindexPath];
    

    self.sendabovepercentagevalue=@"";
    self.aboveTaxtextfield.text=@"";
    self.aboveResultvalue.text=@"";
    self.deductincometaxfromalarystring=@"1";
    self.nodeductincometaxfromalarystring=@"0";
    self.checkboxstringvalue=@"0";
    self.swichbuttonstringvalue=@"1";
    
    
    
    
   [self.myconnection displayincomeTaxservice:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    [super awakeFromNib];

}


-(void)slideToRightWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    //AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //myappde.warningflag=1;
    [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
//    for (UIView *myview in self.scrollView.subviews) {
//        myview.userInteractionEnabled=YES;
//    }
    self.mytableview.userInteractionEnabled=YES;
    self.aboveTaxtextfield.userInteractionEnabled=YES;
    self.otherSurchargesTC.userInteractionEnabled=YES;
    self.radiobuttonfirst.userInteractionEnabled=YES;
    self.radiobuttonsecond.userInteractionEnabled=YES;
    self.instancetableview.userInteractionEnabled=YES;
    self.otherChargesDisplayTC.userInteractionEnabled=YES;
    self.checkboxbutton.userInteractionEnabled=YES;

    self.swichbuttonstringvalue=@"1";
    self.s1++;
   // [self.scrollView setAlpha:1.0];
    [self.mytableview setAlpha:1.0];
    [self.instancetableview setAlpha:1.0];
    [self.otherChargesDisplayTC setAlpha:1.0];
    [self.otherSurchargesTC setAlpha:1.0];

    
}
-(void)slideToLeftWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    //AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //myappde.warningflag=1;
    
    [self.switchButton setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
    
//    for (UIView *myview in self.scrollView.subviews) {
//        myview.userInteractionEnabled=NO;
//    }
    self.mytableview.userInteractionEnabled=NO;
    self.aboveTaxtextfield.userInteractionEnabled=NO;
    self.otherSurchargesTC.userInteractionEnabled=NO;
    self.radiobuttonfirst.userInteractionEnabled=NO;
    self.radiobuttonsecond.userInteractionEnabled=NO;
    self.instancetableview.userInteractionEnabled=NO;
    self.otherChargesDisplayTC.userInteractionEnabled=NO;
    self.checkboxbutton.userInteractionEnabled=NO;

    self.swichbuttonstringvalue=@"0";
    //[self setBackgroundColor:[UIColor lightGrayColor]];
    self.s1++;
  //  [self.scrollView setAlpha:0.6];
    [self.mytableview setAlpha:0.6];
    [self.instancetableview setAlpha:0.6];
    [self.otherChargesDisplayTC setAlpha:0.6];
    [self.otherSurchargesTC setAlpha:0.6];
//    [self.doneButton setAlpha:1.0];
//    [self.switchButton setAlpha:1.0];
//    [self.cancl setAlpha:1.0];


    
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
    
    if (CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
        
        CGPoint buttonPosition = [self.activeField convertPoint:CGPointZero toView:self];
       
         self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,buttonPosition.y-100);
        
    }
}



- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
     self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,0);
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.mytableview) {
      
        return [self.taxarray1 count];
      
    }
    else if(tableView==self.otherSurchargesTC)
    {
        return  self.otherChargesArray.count;
    }
    else if(tableView==self.amountdropTC)
    {
        return  self.amountdropdownArray.count;
    }
    else if(tableView==self.instancetableview)
    {
    
     return self.otherInstanceRangeArray.count;
        
    }
    else
    {
        return  self.otherchargeArray.count;
    }
        

    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.mytableview) {
     
            static NSString *simpleTableIdentifier = @"simplecell";
            taxfirstcellclass  *cell = (taxfirstcellclass *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"taxfirstcell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
            }
        
        
            cell.numberlabel.text=[self.taxarray1 objectAtIndex:indexPath.row];
            cell.zerolabel.text=[self.zeroarray objectAtIndex:indexPath.row];
            cell.amounttext.text=[self.amountarray objectAtIndex:indexPath.row];
            cell.taxtextfield.text=[self.percentagetaxarray objectAtIndex:indexPath.row];

    
            
            cell.amounttext.delegate=self;
            cell.taxtextfield.delegate=self;
        
        
        if ([self.amountfieldSelectedarray containsObject:indexPath]) {
            
            
            cell.amounttext.userInteractionEnabled=TRUE;
            cell.amountbgView.backgroundColor=[UIColor whiteColor];
            
        }
        
        else{
            
            
            cell.amounttext.userInteractionEnabled=FALSE;
            cell.amountbgView.backgroundColor=[UIColor lightGrayColor];
            
        }

        
        
        
        
    
           if ([self.selectedarray containsObject:indexPath]) {
               
               
               cell.taxtextfield.userInteractionEnabled=TRUE;
               cell.taxview.backgroundColor=[UIColor whiteColor];
        
           }
    
           else{
               
    
            cell.taxtextfield.userInteractionEnabled=FALSE;
            cell.taxview.backgroundColor=[UIColor lightGrayColor];
    
           }
    
    
        if ([self.taxrangeRedarray containsObject:indexPath]) {
         
           
            cell.taxtextfield.textColor=[UIColor redColor];
        }
        else
        {
        
         cell.taxtextfield.textColor=[UIColor blackColor];
        
        }
    
    
       return cell;
    }
    
       else if(tableView==self.otherSurchargesTC)
        {
            otherSurchargesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell==nil) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"otherSurchargesTableViewCell" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            cell.nameText.delegate=self;
            cell.taxText.delegate=self;
            cell.amountText.delegate=self;
            
            cell.nameText.text=[self.otherChargesArray objectAtIndex:indexPath.row];
            cell.taxText.text=[self.otherChargesTaxArray objectAtIndex: indexPath.row];
            cell.amountText.text=[self.otherChargesAmountArray objectAtIndex:indexPath.row];
            
            
            
            
            if ([self.otherNametextSelectedarray containsObject:indexPath]) {
                
                
                cell.nameText.userInteractionEnabled=TRUE;
                cell.namefieldbgView.backgroundColor=[UIColor whiteColor];
                
            }
            
            else{
                
                
                cell.nameText.userInteractionEnabled=FALSE;
                cell.namefieldbgView.backgroundColor=[UIColor lightGrayColor];
                
                
            }

            
        
            
            if ([self.sur_selectedarray containsObject:indexPath]) {
                
                if (cell.nameText.text>0&&[cell.taxText.text isEqualToString:@""]) {
                    
                    cell.mandatorystar1.hidden=FALSE;
                    cell.taxText.userInteractionEnabled=TRUE;
                    cell.taxbgview.backgroundColor=[UIColor whiteColor];
                }
                else
                {
                    cell.mandatorystar1.hidden=TRUE;
                    cell.taxText.userInteractionEnabled=TRUE;
                    cell.taxbgview.backgroundColor=[UIColor whiteColor];
                    
                }
                
             
            }
            else
            {
                
                cell.mandatorystar1.hidden=TRUE;
                cell.taxText.userInteractionEnabled=FALSE;
                cell.taxbgview.backgroundColor=[UIColor lightGrayColor];
             

                
                
            }
            
            if ([self.sur_selectedarray2 containsObject:indexPath]) {
                
                   if (cell.taxText.text>0 && [cell.amountText.text isEqualToString:@""]) {
                       
                        cell.mandatorystar2.hidden=FALSE;
                        cell.mandatorystar1.hidden=TRUE;
                       cell.amountText.userInteractionEnabled=TRUE;
                       cell.amountbgview.backgroundColor=[UIColor whiteColor];
                   }
                else
                {
                     cell.mandatorystar2.hidden=TRUE;
                    cell.amountText.userInteractionEnabled=TRUE;
                    cell.amountbgview.backgroundColor=[UIColor whiteColor];
                    
                }
              
                
            }
            else
            {
                
                cell.mandatorystar2.hidden=TRUE;
                cell.amountText.userInteractionEnabled=FALSE;
                cell.amountbgview.backgroundColor=[UIColor lightGrayColor];
                
                
                
            }

            
            if ([self.subchargerangeRedarray containsObject:indexPath]) {
                
                
                cell.taxText.textColor=[UIColor redColor];
            }
            else
            {
                
                cell.taxText.textColor=[UIColor blackColor];
                
            }
            

    
            return  cell;
        }
    
       else if(tableView==self.amountdropTC)
        {
            UITableViewCell *cell=[[UITableViewCell alloc]init];
            cell.textLabel.text=[self.amountdropdownArray objectAtIndex:indexPath.row];
            cell.textLabel.font=[UIFont systemFontOfSize:12];
            return  cell;
        }
        else if(tableView==self.instancetableview)
        {
    
            instancetaxview *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
            if (cell==nil) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"instancetaxview" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            cell.rangeLabel.text=[self.otherInstanceRangeArray objectAtIndex:indexPath.row];
            cell.taxableAmountLabel.text=[self.otherInstanceTaxableAmountArray objectAtIndex:indexPath.row];
            cell.taxLabel.text=[self.otherInstanceTaxArray objectAtIndex: indexPath.row];
            cell.taxAmtLabel.text=[self.otherInstanceTaxAmtArray objectAtIndex: indexPath.row];
            return cell;
            
        }

        else
        {
            otherSurchargesCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell==nil) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"otherSurchargesCell" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            cell.surchargeLabel.text=[self.otherchargeArray objectAtIndex:indexPath.row];
            cell.taxLabel.text=[self.otherTaxArray objectAtIndex: indexPath.row];
            cell.amntLabel.text=[self.otherAmountArray objectAtIndex: indexPath.row];
            return  cell;
        }
    

}

-(IBAction)amountFieldEndediting:(id)sender
{
    
     taxfirstcellclass *cell=(taxfirstcellclass *)[[[sender superview] superview]superview];
   
    if (cell.amounttext.text.length>0) {
    
        //cell.taxtextfield.userInteractionEnabled=TRUE;
        //cell.taxview.backgroundColor=[UIColor whiteColor];
         self.aboveTaxtextfield.text=@"";
      
        
        if (self.abovebgflag==1) {
            
            self.aboveTaxtextfield.userInteractionEnabled=TRUE;
            self.abovebackgdView.backgroundColor=[UIColor whiteColor];
            self.abovefieldmandtory.hidden=FALSE;
        }
        else
        {
            self.aboveTaxtextfield.userInteractionEnabled=FALSE;
            self.abovebackgdView.backgroundColor=[UIColor lightGrayColor];
               self.abovefieldmandtory.hidden=TRUE;
        }
     
        
        if (cell.taxtextfield.text.length>0) {
            
              cell.mandatorystar.hidden=TRUE;
        }
        else
        {
              cell.mandatorystar.hidden=FALSE;
        }
        
      
        
      
        if([cell.amounttext.text integerValue] <= [cell.zerolabel.text integerValue])
        {
            
            cell.amounttext.textColor=[UIColor redColor];
            
            cell.taxtextfield.userInteractionEnabled=FALSE;
            cell.taxview.backgroundColor=[UIColor lightGrayColor];
           // self.abovefieldmandtory.hidden=TRUE;
            cell.mandatorystar.hidden=TRUE;
        }
        else
        {
            
             cell.amounttext.textColor=[UIColor blackColor];
            
            cell.taxtextfield.userInteractionEnabled=TRUE;
            cell.taxview.backgroundColor=[UIColor whiteColor];
            //self.abovefieldmandtory.hidden=FALSE;
            cell.mandatorystar.hidden=FALSE;
        }
        
        
        
    }


}

-(IBAction)taxFieldEndediting:(id)sender
{
    
    taxfirstcellclass *cell=(taxfirstcellclass *)[[[sender superview] superview] superview];
    NSIndexPath *myindex = [self.mytableview indexPathForCell:cell];
    
    if (self.taxarray1.count == myindex.row+1) {
        
        if (cell.taxtextfield.text.length>0) {
            
            if ((!([cell.taxtextfield.text integerValue] < 0)) && ([cell.taxtextfield.text integerValue]<101)) {
                
                self.aboveNumberlabel.hidden=FALSE;
                self.aboveResultvalue.hidden=FALSE;
                self.abovelabel.hidden=FALSE;
                
                NSString *string=@"%";
                [self.amountarray replaceObjectAtIndex:myindex.row withObject:[NSString stringWithFormat:@"%@",cell.amounttext.text]];
                [self.percentagetaxarray replaceObjectAtIndex:myindex.row withObject:[NSString stringWithFormat:@"%@ %@",cell.taxtextfield.text,string]];
                [self.taxarray1 addObject:[NSString stringWithFormat:@"%lu",self.taxarray1.count+1]];
                
                [self.amountarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                
                [self.zeroarray addObject:[NSString stringWithFormat:@"%lu",[cell.amounttext.text integerValue]+1]];
                
                self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",self.taxarray1.count+1];
                int value=0;
                
                for (int i=0; i<[self.amountarray count]; i++) {
                    
                    
                    if ([[self.amountarray objectAtIndex:i]isEqualToString:@""]) {
                        
                        
                        value=i;
                        break;
                    }
                    
                    
                }
                
                self.aboveResultvalue.text=[self.amountarray objectAtIndex:value-1];

                self.aboveTaxtextfield.userInteractionEnabled=TRUE;
                self.abovebackgdView.backgroundColor=[UIColor whiteColor];
                self.abovefieldmandtory.hidden=FALSE;
                [self.selectedarray addObject:myindex];
                //  [self.mytableview reloadData];

                
                [self.taxrangeRedarray removeObject:myindex];
                
                NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:myindex.row+1 inSection:0];
                [self.amountfieldSelectedarray addObject:myindexPath];

                
                NSArray *visibleItems = [self.mytableview indexPathsForVisibleRows];
                [self.mytableview reloadData];
                NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
                NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.taxarray1.count - 1 inSection:currentItem.section];
                [self.mytableview scrollToRowAtIndexPath:nextItem atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                

                
            }
            else
            {
                [self.taxrangeRedarray addObject:myindex];
                
                cell.taxtextfield.textColor =[UIColor redColor];

            }
            

            

            
        }
                
    }
    else
    {
        
        
        if (cell.taxtextfield.text.length>0) {
            
            
            
            
            
             if ((!([cell.taxtextfield.text integerValue] < 0)) && ([cell.taxtextfield.text integerValue]<101)) {
            
                 
                 
                 self.aboveNumberlabel.hidden=FALSE;
                 self.aboveResultvalue.hidden=FALSE;
                 self.abovelabel.hidden=FALSE;
                 
                 [self.zeroarray replaceObjectAtIndex:myindex.row+1 withObject:[NSString stringWithFormat:@"%lu",[cell.amounttext.text integerValue]+1]];
                 [self.amountarray replaceObjectAtIndex:myindex.row withObject:[NSString stringWithFormat:@"%@",cell.amounttext.text]];
                 
                 
                 
                 if (![cell.taxtextfield.text containsString:@"%"]) {
                     
                     NSString *string=@"%";
                     [self.percentagetaxarray replaceObjectAtIndex:myindex.row withObject:[NSString stringWithFormat:@"%@ %@",cell.taxtextfield.text,string]];
                     
                 }
                 
                 self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",self.taxarray1.count+1];
              
                 
                 int value=0;
                 
                   for (int i=0; i<[self.amountarray count]; i++) {
                     
                     
                     if ([[self.amountarray objectAtIndex:i]isEqualToString:@""]) {
                         
                         
                         value=i;
                         break;
                     }
                     
                     
                 }
                 
                self.aboveResultvalue.text=[self.amountarray objectAtIndex:value-1];
                 
                 self.aboveTaxtextfield.userInteractionEnabled=TRUE;
                 self.abovebackgdView.backgroundColor=[UIColor whiteColor];
                   self.abovefieldmandtory.hidden=FALSE;
                 [self.selectedarray addObject:myindex];
                 
                 
               [self.taxrangeRedarray removeObject:myindex];
                 
                 NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:myindex.row+1 inSection:0];
                 [self.amountfieldSelectedarray addObject:myindexPath];
                 
                   [self.mytableview reloadData];
            }
            else
            {
                  [self.taxrangeRedarray addObject:myindex];
                  cell.taxtextfield.textColor =[UIColor redColor];
            }
            
            
          
            
         
        }
        
       
        
    }
    

}

-(IBAction)abovetaxbegineditingfunction:(id)sender
{
     if (self.aboveTaxtextfield.text.length>0) {
    
         
         UIAlertController *alert= [UIAlertController
                                    alertControllerWithTitle:@"Reset"
                                    message:@"Do U Want to Reset the Amount?"
                                    preferredStyle:UIAlertControllerStyleAlert];
         
         UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * action){
                                                        
                                                        [self resetfunction];
                                                        
                                                    }];
         
         UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * action){
                                                        
                                                        
                                                        
                                                    }];


         
         [alert addAction:ok];
         [alert addAction:cancel];
         
        
         
         [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        

    
         
     }
    
}


-(IBAction)aboveTaxtextfieldEndediting:(id)sender
{
    
      if (self.aboveTaxtextfield.text.length>0) {
          
          self.abovefieldmandtory.hidden=TRUE;
          self.sendabovepercentagevalue=self.aboveTaxtextfield.text;
         
          //self.instancenotapplicable1.text=@"N/A";     //temperory
          //self.instancenotapplicable2.text=@"N/A";
          
          NSString * mystring;
          if (![self.aboveTaxtextfield.text containsString:@"%"]) {
              
              NSString *string=@"%";
              mystring=self.aboveTaxtextfield.text;
              NSString * datastring = [NSString stringWithFormat:@"%@ %@",self.aboveTaxtextfield.text,string];
              self.aboveTaxtextfield.text=datastring;
          }
          else
          {
              mystring=self.aboveTaxtextfield.text;
          }
          self.abovetaxsavedstring=self.aboveTaxtextfield.text;
          NSLog(@"%@",self.amountarray);
          NSLog(@"%@",self.zeroarray);
          
          
             [self.otherInstanceRangeArray removeAllObjects];
             [self.otherInstanceTaxArray removeAllObjects];
             [self.otherInstanceTaxableAmountArray removeAllObjects];
             [self.otherInstanceTaxAmtArray removeAllObjects];
          
          
          if ((!([mystring integerValue] < 0)) && ([mystring integerValue]<101)) {
              
              self.aboveTaxtextfield.textColor=[UIColor blackColor];
              
              self.forinstanceaboveAmtvalue.hidden=FALSE;
              self.forinstanceaboveTaxvalue.hidden=FALSE;
              
              self.instancenotapplicable1.hidden=FALSE;
              self.instancenotapplicable2.hidden=FALSE;
              
              
              NSLog(@"%@",self.amountarray);
              
              [self.amountdropdownArray removeAllObjects];
              [self.amountdropdownArray addObject:@"0"];
              
              for (int i=0; i<[self.amountarray count]; i++) {
                  
                  
                  if (![[self.amountarray objectAtIndex:i] isEqualToString:@""]) {
                      
                      [self.amountdropdownArray addObject:[self.amountarray objectAtIndex:i]];
                      
                  }
                  
                  
              }
              
              [self.amountdropTC reloadData];
              
              [self.amountarray insertObject:@"0" atIndex:0];
              // [self.amountarray removeLastObject];
              
              for (int i=0; i<[self.amountarray count]-1; i++) {
                  
                  if (![[self.amountarray objectAtIndex:i+1]isEqualToString:@""]) {
                      
                      [self.otherInstanceRangeArray addObject:[NSString stringWithFormat:@"%@-%@",[self.amountarray objectAtIndex:i],[self.amountarray objectAtIndex:i+1]]];
                  }
                  
                  
                  
              }
              
              
              for (int i=0; i<self.self.amountarray.count-1; i++) {
                  
                  
                  if (![[self.amountarray objectAtIndex:i+1]isEqualToString:@""]) {
                      
                      [self.otherInstanceTaxableAmountArray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray objectAtIndex:i+1] integerValue]-[[self.amountarray objectAtIndex:i] integerValue]]];
                      
                  }
                  
              }
              
              //[self.percentagetaxarray removeLastObject];
              [self.otherInstanceTaxArray addObjectsFromArray:self.percentagetaxarray];
              
              
              
              self.instancenotapplicable1.text=@" 100";
              
              float tax=[self.aboveTaxtextfield.text floatValue];
              float tax1=tax/100;
              
              float taxableAmount= 100 * tax1;
              
              self.instancenotapplicable2.text=[NSString stringWithFormat:@"%.f",taxableAmount];
              
              amount+=taxableAmount;
              
              for (int i=0; i < self.otherInstanceTaxableAmountArray.count ; i++) {
                  
                  float tax=[[self. otherInstanceTaxArray objectAtIndex:i]floatValue];
                  float tax1=tax/100;
                  //   NSLog(@"%.2f",tax1);
                  float taxableAmount=[[self.otherInstanceTaxableAmountArray objectAtIndex:i] integerValue] * tax1;
                  [self.otherInstanceTaxAmtArray addObject:[NSString stringWithFormat:@"%.f",taxableAmount]];
                  amount+=[[self.otherInstanceTaxAmtArray objectAtIndex:i] integerValue];
                  self.grosspayableAmountLabel.text=[NSString stringWithFormat:@"%ld", (long)amount ];
                  
                  
              }
              
              
              
              [self.instancetableview reloadData];
              
              // [self.percentagetaxarray addObject:@""];
              [self.amountarray removeObjectAtIndex:0];
              // [self.amountarray addObject:@""];
              
              self.annualIncomeAmtLabel.text=[NSString stringWithFormat:@"Annual Income is %ld",[self.aboveResultvalue.text integerValue]+100];
            //  [[NSUserDefaults standardUserDefaults] setObject:self.aboveResultvalue.text forKey:@"resultvalue"];
            //  [[NSUserDefaults standardUserDefaults] synchronize];
              
              self.forinstanceaboveAmtvalue.text=[NSString stringWithFormat:@"Above %ld",[self.aboveResultvalue.text integerValue]];
              self.forinstanceaboveTaxvalue.text=self.aboveTaxtextfield.text;
              
              
              


          }
          else
          {
              self.aboveTaxtextfield.textColor=[UIColor redColor];
              [self.otherInstanceRangeArray removeAllObjects];
              [self.otherInstanceTaxArray removeAllObjects];
              [self.otherInstanceTaxableAmountArray removeAllObjects];
              [self.otherInstanceTaxAmtArray removeAllObjects];
              self.forinstanceaboveAmtvalue.text=@"";
              self.forinstanceaboveTaxvalue.text=@"";
              self.instancenotapplicable1.text=@"";
              self.instancenotapplicable2.text=@"";
              
              [self.otherInstanceRangeArray addObject:@""];
              [self.otherInstanceRangeArray addObject:@""];
              
              [self.otherInstanceTaxArray addObject:@""];
              [self.otherInstanceTaxArray addObject:@""];
              
              [self.otherInstanceTaxableAmountArray addObject:@""];
              [self.otherInstanceTaxableAmountArray addObject:@""];
              
              [self.otherInstanceTaxAmtArray addObject:@""];
              [self.otherInstanceTaxAmtArray addObject:@""];
            

              
              [self.instancetableview reloadData];

          }
          
          
    }
    
    
    
}



-(IBAction)firsttaxcelWhenchanged:(id)sender
{
    
    if (self.otherInstanceRangeArray.count>0&&![self.otherInstanceRangeArray containsObject:@""]) {
        
        self.aboveTaxtextfield.text=@"";
        self.grosspayableAmountLabel.text=@"";
        self.netpayableAmountLabel.text=@"";
        amount=0;
        [self.otherInstanceRangeArray removeAllObjects];
        [self.otherInstanceTaxArray removeAllObjects];
        [self.otherInstanceTaxableAmountArray removeAllObjects];
        [self.otherInstanceTaxAmtArray removeAllObjects];
        
        [self.otherInstanceRangeArray addObject:@""];
        [self.otherInstanceRangeArray addObject:@""];
        
        [self.otherInstanceTaxArray addObject:@""];
        [self.otherInstanceTaxArray addObject:@""];
        
        [self.otherInstanceTaxableAmountArray addObject:@""];
        [self.otherInstanceTaxableAmountArray addObject:@""];
        
        [self.otherInstanceTaxAmtArray addObject:@""];
        [self.otherInstanceTaxAmtArray addObject:@""];
        

        self.forinstanceaboveAmtvalue.text=@"";
        self.forinstanceaboveTaxvalue.text=@"";
        self.instancenotapplicable1.text=@"";
        self.instancenotapplicable2.text=@"";
        
        //self.aboveResultvalue.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"resultvalue"];
        self.annualIncomeAmtLabel.text=@"";
        
  
        [self.instancetableview reloadData];
        [self resetfunction];
        
    
        
}
    
    
    
}



-(void)resetfunction
{
    amount=0;
    self.annualIncomeAmtLabel.text=@"";
    self.grosspayableAmountLabel.text=@"";
    self.netpayableAmountLabel.text=@"";
    
   // [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"resultvalue"];
  //  [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.amountdropdownArray removeAllObjects];
    [self.amountdropTC reloadData];

    [self.otherInstanceRangeArray removeAllObjects];
    [self.otherInstanceTaxArray removeAllObjects];
    [self.otherInstanceTaxableAmountArray removeAllObjects];
    [self.otherInstanceTaxAmtArray removeAllObjects];
    
    [self.otherInstanceRangeArray addObject:@""];
    [self.otherInstanceRangeArray addObject:@""];
    
    [self.otherInstanceTaxArray addObject:@""];
    [self.otherInstanceTaxArray addObject:@""];
    
    [self.otherInstanceTaxableAmountArray addObject:@""];
    [self.otherInstanceTaxableAmountArray addObject:@""];
    
    [self.otherInstanceTaxAmtArray addObject:@""];
    [self.otherInstanceTaxAmtArray addObject:@""];
    
    
    [self.instancetableview reloadData];
    
    
    [self.otherChargesArray removeAllObjects];
    [self.otherChargesTaxArray removeAllObjects];
    [self.otherChargesAmountArray removeAllObjects];
    
    [self.otherChargesArray addObject:@""];
    [self.otherChargesArray addObject:@""];
    [self.otherChargesArray addObject:@""];
    [self.otherChargesArray addObject:@""];
    
    
    [self.otherChargesTaxArray addObject:@""];
    [self.otherChargesTaxArray addObject:@""];
    [self.otherChargesTaxArray addObject:@""];
    [self.otherChargesTaxArray addObject:@""];
    
    
    
    [self.otherChargesAmountArray addObject:@""];
    [self.otherChargesAmountArray addObject:@""];
    [self.otherChargesAmountArray addObject:@""];
    [self.otherChargesAmountArray addObject:@""];
    
    [self.sur_selectedarray removeAllObjects];
    [self.sur_selectedarray2 removeAllObjects];
    [self.otherNametextSelectedarray removeAllObjects];
    [self.subchargerangeRedarray removeAllObjects];
    
    
    NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.otherNametextSelectedarray addObject:myindexPath1];
    
    [self.otherSurchargesTC reloadData];
    
    
    [self.otherchargeArray removeAllObjects];
    [self.otherTaxArray removeAllObjects];
    [self.otherAmountArray removeAllObjects];
    
    [self.otherchargeArray addObject:@""];
    [self.otherchargeArray addObject:@""];
    [self.otherchargeArray addObject:@""];
    [self.otherchargeArray addObject:@""];

    
    [self.otherTaxArray addObject:@""];
    [self.otherTaxArray addObject:@""];
    [self.otherTaxArray addObject:@""];
     [self.otherTaxArray addObject:@""];
    
    [self.otherAmountArray addObject:@""];
    [self.otherAmountArray addObject:@""];
    [self.otherAmountArray addObject:@""];
    [self.otherAmountArray addObject:@""];
    
    [self.otherChargesDisplayTC reloadData];
    
    
    
    
    self.aboveTaxtextfield.userInteractionEnabled=TRUE;
    self.abovebackgdView.backgroundColor=[UIColor whiteColor];
    self.abovefieldmandtory.hidden=FALSE;
    
    self.forinstanceaboveAmtvalue.hidden=TRUE;
    self.forinstanceaboveTaxvalue.hidden=TRUE;
    
    self.instancenotapplicable1.hidden=TRUE;
    self.instancenotapplicable2.hidden=TRUE;

    
    
//    if ([[self.amountarray objectAtIndex:0]isEqualToString:@""]) {
//        
//        self.abovelabel.hidden=TRUE;
//    }
//    else
//    {
//         self.abovelabel.hidden=FALSE;
//        
//    }
    
    self.aboveTaxtextfield.text=@"";
    self.abovetaxsavedstring=@"";
    
}



-(void)percentageremovefunction
{
    
     [self.percentagetaxarray removeObjectAtIndex:self.storingIndevalue.row];
    
}









-(IBAction)editingChangedAmounttextfield:(id)sender
{
     taxfirstcellclass *cell=(taxfirstcellclass *)[[[sender superview] superview] superview];
  
    if (cell.amounttext.text.length>0) {
        
       // cell.amounttext.userInteractionEnabled=FALSE;
        
        NSString *storestring = cell.amounttext.text;
        
        
        
                        UIAlertController *alert= [UIAlertController
                                                   alertControllerWithTitle:@"Reset"
                                                   message:@"Do U Want to Reset the Amount?"
                                                   preferredStyle:UIAlertControllerStyleAlert];
        
                        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action){
        
                                                                    
                                                                       [self resetfunction];
                                                                       
                                                                       self.abovelabel.hidden=FALSE;
                                                                       self.aboveNumberlabel.hidden=FALSE;
                                                                     
        
                                                                NSIndexPath *myindex = [self.mytableview indexPathForCell:cell];
                                                                NSLog(@"%lu",myindex.row);
        
                                                                         NSMutableArray *store_taxarray=[[NSMutableArray alloc] init];
                                                                         NSMutableArray *store_zeroarray=[[NSMutableArray alloc] init];
                                                                         NSMutableArray *store_amountarray=[[NSMutableArray alloc] init];
                                                                      //   NSMutableArray *store_percentagearray=[[NSMutableArray alloc] init];
                                                                        // NSMutableArray *store_indexpatharray=[[NSMutableArray alloc] init];
                                                                    //    [self.selectedarray addObject:@""];
        
                                                                    for (NSUInteger i=myindex.row; i<self.taxarray1.count; i++) {
        
                                                                         [store_taxarray addObject:[self.taxarray1 objectAtIndex:i]];
                                                                         [store_zeroarray addObject:[self.zeroarray objectAtIndex:i]];
                                                                         [store_amountarray addObject:[self.amountarray objectAtIndex:i]];
                                                                         //[store_percentagearray addObject:[self.percentagetaxarray objectAtIndex:i]];
                                                                        // [store_indexpatharray addObject:[self.selectedarray objectAtIndex:i]];
                                                                    }
                                                                      //
                                                                       [self.taxarray1 removeObjectsInArray:store_taxarray];
                                                                       [self.zeroarray removeObjectsInArray:store_zeroarray];
                                                                       [self.amountarray removeObjectsInArray:store_amountarray];
                                                                      // [self.percentagetaxarray removeObjectsInArray:store_percentagearray];
                                                                    //   [self.selectedarray removeObjectsInArray:store_indexpatharray];
                                                                       
                                                                       self.storingIndevalue=myindex;
                                                                       
                                                                       NSUInteger count = [self.percentagetaxarray count]-myindex.row;
                                                                       
                                                                       for (int i=0; i<count; i++) {
                                                                           
                                                                          
                                                                           [self percentageremovefunction];
                                                                       }
                                                                       
                                                                       
                                                                       
                                                                
        
                                                                       NSLog(@"%@",self.taxarray1);
                                                                       NSLog(@"%@",self.amountarray);
                                                                       NSLog(@"%@",self.percentagetaxarray);
                                                                       NSLog(@"%@",self.zeroarray);
                                                                       NSLog(@"%@",self.selectedarray);
        
                                                                       [self.selectedarray removeAllObjects];
                                                                       
                                                                       [self.amountfieldSelectedarray removeAllObjects];
        
                                                                       if(self.taxarray1.count<5)
                                                                       {
                                                                           if (self.taxarray1.count==1) {
                                                                               
                                                                            
        
                                                                               [self.taxarray1 addObject:@"2"];
                                                                               [self.taxarray1 addObject:@"3"];
                                                                               [self.taxarray1 addObject:@"4"];
                                                                               [self.zeroarray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray objectAtIndex:0] integerValue]+1]];
                                                                               [self.zeroarray addObject:@""];
                                                                               [self.zeroarray addObject:@""];
                                                                               [self.amountarray addObject:@""];
                                                                               [self.amountarray addObject:@""];
                                                                               [self.amountarray addObject:@""];
                                                                               [self.percentagetaxarray addObject:@""];
                                                                               [self.percentagetaxarray addObject:@""];
                                                                               [self.percentagetaxarray addObject:@""];
        
        
                                                                               self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
                                                                               self.aboveResultvalue.text=[self.amountarray objectAtIndex:0];
                                                                               self.aboveTaxtextfield.text=@"";
                                                                              NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                                                                               NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
                                                                              [self.selectedarray addObject:myindexPath];
                                                                               
                                                                               [self.amountfieldSelectedarray addObject:myindexPath];
                                                                               [self.amountfieldSelectedarray addObject:myindexPath1];
                                                                               
                                                                               
                                                                               
                                                                               
        
                                                                           }
                                                                           else if (self.taxarray1.count==2)
                                                                           {
        
                                                                               [self.taxarray1 addObject:@"3"];
                                                                               [self.taxarray1 addObject:@"4"];
                                                                               [self.zeroarray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray objectAtIndex:1] integerValue]+1]];
                                                                               [self.zeroarray addObject:@""];
                                                                               [self.amountarray addObject:@""];
                                                                               [self.amountarray addObject:@""];
                                                                               [self.percentagetaxarray addObject:@""];
                                                                               [self.percentagetaxarray addObject:@""];
        
                                                                               self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
                                                                               self.aboveResultvalue.text=[self.amountarray objectAtIndex:1];
                                                                               self.aboveTaxtextfield.text=@"";
        
                                                                              NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
                                                                              NSIndexPath *myindexPath2 = [NSIndexPath indexPathForRow:1 inSection:0];
                                                                               NSIndexPath *myindexPath3 = [NSIndexPath indexPathForRow:2 inSection:0];
                                                                               
                                                                              [self.selectedarray addObject:myindexPath1];
                                                                              [self.selectedarray addObject:myindexPath2];
                                                                               
                                                                               
                                                                               
                                                                               [self.amountfieldSelectedarray addObject:myindexPath1];
                                                                               [self.amountfieldSelectedarray addObject:myindexPath2];
                                                                               [self.amountfieldSelectedarray addObject:myindexPath3];


        
        
                                                                           }
                                                                           else if (self.taxarray1.count==3)
                                                                           {
        
                                                                               [self.taxarray1 addObject:@"4"];
                                                                               [self.zeroarray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray objectAtIndex:2] integerValue]+1]];
                                                                               [self.amountarray addObject:@""];
                                                                               [self.percentagetaxarray addObject:@""];
        
                                                                               self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
                                                                               self.aboveResultvalue.text=[self.amountarray objectAtIndex:2];
                                                                               self.aboveTaxtextfield.text=@"";
                                                                               
        
                                                                               NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
                                                                               NSIndexPath *myindexPath2 = [NSIndexPath indexPathForRow:1 inSection:0];
                                                                               NSIndexPath *myindexPath3 = [NSIndexPath indexPathForRow:2 inSection:0];
                                                                                NSIndexPath *myindexPath4 = [NSIndexPath indexPathForRow:3 inSection:0];
                                                                               
                                                                               
                                                                               [self.selectedarray addObject:myindexPath1];
                                                                               [self.selectedarray addObject:myindexPath2];
                                                                               [self.selectedarray addObject:myindexPath3];
                                                                               
                                                                               
                                                                               
                                                                               [self.amountfieldSelectedarray addObject:myindexPath1];
                                                                               [self.amountfieldSelectedarray addObject:myindexPath2];
                                                                               [self.amountfieldSelectedarray addObject:myindexPath3];
                                                                               [self.amountfieldSelectedarray addObject:myindexPath4];
                                                                               

                                                                               

        
        
        
                                                                           }
        
                                                                           else if (self.taxarray1.count==4)
                                                                           {
        
                                                                               [self.taxarray1 addObject:@"5"];
                                                                               [self.zeroarray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray objectAtIndex:3] integerValue]+1]];
                                                                               [self.amountarray addObject:@""];
                                                                               [self.percentagetaxarray addObject:@""];
        
                                                                               self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
                                                                               self.aboveResultvalue.text=[self.amountarray objectAtIndex:3];
                                                                               self.aboveTaxtextfield.text=@"";
        
        //                                                                       NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:4 inSection:0];
        //                                                                       [self.selectedarray addObject:myindexPath];
                                                                               
                                                                               
                                                                               
                                                                               NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
                                                                               NSIndexPath *myindexPath2 = [NSIndexPath indexPathForRow:1 inSection:0];
                                                                               NSIndexPath *myindexPath3 = [NSIndexPath indexPathForRow:2 inSection:0];
                                                                               NSIndexPath *myindexPath4 = [NSIndexPath indexPathForRow:3 inSection:0];
                                                                                NSIndexPath *myindexPath5 = [NSIndexPath indexPathForRow:4 inSection:0];
                                                                               
                                                                               
                                                                               [self.selectedarray addObject:myindexPath1];
                                                                               [self.selectedarray addObject:myindexPath2];
                                                                               [self.selectedarray addObject:myindexPath3];
                                                                               [self.selectedarray addObject:myindexPath4];
                                                                               
                                                                               
                                                                               [self.amountfieldSelectedarray addObject:myindexPath1];
                                                                               [self.amountfieldSelectedarray addObject:myindexPath2];
                                                                               [self.amountfieldSelectedarray addObject:myindexPath3];
                                                                               [self.amountfieldSelectedarray addObject:myindexPath4];
                                                                               [self.amountfieldSelectedarray addObject:myindexPath5];
                                                                              
                                                                               

        
                                                                           }
                                                                           else if (self.taxarray1.count==0)
                                                                           {
                                                                               self.abovefieldmandtory.hidden=FALSE;
                                                                               
                                                                               self.abovelabel.hidden=TRUE;
                                                                               self.aboveNumberlabel.hidden=TRUE;
        
                                                                               [self.taxarray1 addObject:@"1"];
                                                                               [self.taxarray1 addObject:@"2"];
                                                                               [self.taxarray1 addObject:@"3"];
                                                                               [self.taxarray1 addObject:@"4"];
                                                                               [self.zeroarray addObject:@"0"];
                                                                               [self.zeroarray addObject:@""];
                                                                               [self.zeroarray addObject:@""];
                                                                               [self.zeroarray addObject:@""];
                                                                               [self.amountarray addObject:@""];
                                                                               [self.amountarray addObject:@""];
                                                                               [self.amountarray addObject:@""];
                                                                               [self.amountarray addObject:@""];
                                                                               [self.percentagetaxarray addObject:@""];
                                                                               [self.percentagetaxarray addObject:@""];
                                                                               [self.percentagetaxarray addObject:@""];
                                                                               [self.percentagetaxarray addObject:@""];
        
        
                                                                               self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
                                                                               self.aboveResultvalue.text=@"";
                                                                               self.aboveTaxtextfield.text=@"";
                                                                               
                                                                               
                                                                                NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
                                                                                 [self.amountfieldSelectedarray addObject:myindexPath1];
                                                                               
                                                                               self.abovefieldmandtory.hidden=TRUE;
        
        
                                                                           }
        
                                                                       }
                                                                       else
                                                                       {
                                                                           
                                                                           
        
        
                                                                [self.taxarray1 addObject:[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1]];
                                                                            NSString *storedvalue=[self.amountarray lastObject];
                                                                            [self.zeroarray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray lastObject] integerValue]+1]];
                                                                            [self.amountarray addObject:@""];
                                                                            [self.percentagetaxarray addObject:@""];
        
        
                                                                           self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
                                                                           self.aboveResultvalue.text=storedvalue;
                                                                           self.aboveTaxtextfield.text=@"";
                                                                           
                                                                           
                                                                           for (int i=0; i<self.taxarray1.count-1; i++) {
                                                                               
                                                                              NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:i inSection:0];
                                                                              [self.selectedarray addObject:myindexPath1];
                                                                               
                                                                           }
                                                                           
                                                                           for (int i=0; i<self.taxarray1.count+1; i++) {
                                                                               
                                                                               NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:i inSection:0];
                                                                               [self.amountfieldSelectedarray addObject:myindexPath1];
                                                                               
                                                                           }

        
                                                                       }
        
        
        
                                                                       NSLog(@"%@",self.taxarray1);
                                                                       NSLog(@"%@",self.amountarray);
                                                                       NSLog(@"%@",self.percentagetaxarray);
                                                                       NSLog(@"%@",self.zeroarray);
                                                                       
                                                                       
                                                                       
                                                                       
                                                                       
                                                                       
        
         
                                                                        [self.mytableview reloadData];
                                                                       
                                                                       
                                                                       
                                                                       //Do Some action here
                                                                   }];
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                                 {
                                                    self.abovefieldmandtory.hidden=FALSE;
                                                     cell.amounttext.text=storestring;
                                                    // cell.mandatorystar.hidden=TRUE;
                                                   [cell.amounttext resignFirstResponder];
                                                     self.abovebgflag=1;
                                                     
                                                     self.aboveTaxtextfield.userInteractionEnabled=TRUE;
                                                     self.abovebackgdView.backgroundColor=[UIColor whiteColor];
                                                     
                                                     self.aboveTaxtextfield.text = self.abovetaxsavedstring;
        
                                                 }];
                        
                        
                        [alert addAction:ok];
                        [alert addAction:cancel];
                        
                    //    dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
                        //});

        
    }
      
}



//-(IBAction)surchargeeditingChangedAmountfield:(id)sender
//{
//    
//    otherSurchargesTableViewCell *cell=[(otherSurchargesTableViewCell *)[[sender superview]superview] superview];
//    [cell.amountText resignFirstResponder];
//    
//         self.inPath=[self.otherSurchargesTC indexPathForCell:cell];
//    
//            if (cell.taxText.text.length > 0) {
//                
//                self.activeField=Nil;
//                self.amountdropTC.hidden=FALSE;
//                [self.amountdropTC reloadData];
//                if (self.inPath.row==0) {
//                    self.amountdropTC.frame=CGRectMake(196, 380, self.amountdropTC.frame.size.width, self.amountdropTC.frame.size.height);
//                }
//                else if (self.inPath.row==1)
//                {
//                    self.amountdropTC.frame=CGRectMake(196, 400, self.amountdropTC.frame.size.width, self.amountdropTC.frame.size.height);
//                }
//                else if (self.inPath.row==2)
//                {
//                    self.amountdropTC.frame=CGRectMake(196, 420, self.amountdropTC.frame.size.width, self.amountdropTC.frame.size.height);
//                }
//                else
//                {
//                    self.amountdropTC.frame=CGRectMake(196, 440, self.amountdropTC.frame.size.width, self.amountdropTC.frame.size.height);
//                }
//                self.amountdropTC.hidden=false;
//          
//            }
//
//    
//    
//    
//}

-(IBAction)other_nameBeginedit:(id)sender
{
    
    otherSurchargesTableViewCell *cell = (otherSurchargesTableViewCell *)[[[sender superview]superview] superview];
    
    self.activeField=cell.nameText;
    
     CGPoint buttonPosition = [self.activeField convertPoint:CGPointZero toView:self];
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,buttonPosition.y-100);
    
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
 
    self.activeField=textField;
    
     otherSurchargesTableViewCell *cell = (otherSurchargesTableViewCell *)[[[textField superview]superview] superview];
    
  
    
       if ([cell isKindOfClass:[otherSurchargesTableViewCell class]]) {
           
        [cell.amountText resignFirstResponder];
    
             self.inPath=[self.otherSurchargesTC indexPathForCell:cell];
           
                if (textField==cell.amountText)
                {
    
                if (cell.taxText.text.length > 0) {
    
                    self.activeField=Nil;
                    self.amountdropTC.hidden=FALSE;
                    [self.amountdropTC reloadData];
                    if (self.inPath.row==0) {
                        self.amountdropTC.frame=CGRectMake(196, 380, self.amountdropTC.frame.size.width, self.amountdropTC.frame.size.height);
                    }
                    else if (self.inPath.row==1)
                    {
                        self.amountdropTC.frame=CGRectMake(196, 420, self.amountdropTC.frame.size.width, self.amountdropTC.frame.size.height);
                    }
                    else
                    {
                        self.amountdropTC.frame=CGRectMake(196, 450, self.amountdropTC.frame.size.width, self.amountdropTC.frame.size.height);
                    }
                    self.amountdropTC.hidden=false;
                     return NO;
                   }
                    else
                    {
                        
                        return YES;
                    }
               
                }
           
           
           
           else
           {
               return YES;
           }
           
         }
    if (textField==self.checkboxtext) {
        [self incometaxcheckboxaction:self.checkboxtext];
        return  NO;
    }
    if (textField==self.checktext) {
          [self radiobuttonaction:self.checktext];
        return  NO;
    }
    if (textField==self.checktext2) {
          [self radiobuttonaction:self.checktext2];
        return  NO;
    }
    else
    {
        
        return YES;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.amountdropTC) {
    
        
           //  NSString *string=@"%";
        
            otherSurchargesTableViewCell *cell=(otherSurchargesTableViewCell *)[self.otherSurchargesTC cellForRowAtIndexPath:self.inPath];
            [self.otherChargesAmountArray replaceObjectAtIndex:self.inPath.row withObject:[self.amountdropdownArray objectAtIndex:indexPath.row]];
            [self.otherChargesArray replaceObjectAtIndex:self.inPath.row withObject:cell.nameText.text];
            [self.otherChargesTaxArray replaceObjectAtIndex:self.inPath.row withObject:cell.taxText.text];
            self.amountdropTC.hidden=TRUE;
            [self.sur_selectedarray addObject:self.inPath];
        
        
   //   if (self.resetflag==0) {
             
        
      //  }
        
//        
//        if (self.otherChargesArray.count==1) {
//            
//            NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//           
//           [self.selectedarray addObject:myindexPath];
//            
//           
//            
//            
//        }
//        
//       else if (self.otherChargesArray.count==2) {
//           
//           
//           
//        }
//        
//       else if (self.otherChargesArray.count==3) {
//           
//           
//           
//           
//       }
//        
//        
//        
        
        
     
        
        
           if (self.otherChargesArray.count>=4) {
            
               if (![self.otherChargesAmountArray containsObject:@""]) {
                   
                   [self.otherChargesAmountArray addObject:@""];
                   [self.otherChargesArray addObject:@""];
                   [self.otherChargesTaxArray addObject:@""];
                   NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:[self.otherChargesArray count]-1 inSection:0];
                   
                   [self.otherNametextSelectedarray addObject:myindexPath];

               }
               else
               {
                    [self.otherNametextSelectedarray removeAllObjects];
                   
                 //  NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:self.inPath.row+1 inSection:0];
                   
                 //  [self.otherNametextSelectedarray addObject:myindexPath];
                   
                   int value=0;
                   
                   for (int i=0; i<[self.otherChargesArray count]; i++) {
                       
                       if ([[self.otherChargesArray objectAtIndex:i]isEqualToString:@""]) {
                           
                           value=i;
                           break;
                           
                       }
                       else
                       {
                           NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:i inSection:0];
                           
                           [self.otherNametextSelectedarray addObject:myindexPath];
                           
                       }
                       
                   }
                   

                  NSIndexPath *myindexPath2 = [NSIndexPath indexPathForRow:value inSection:0];
                  [self.otherNametextSelectedarray addObject:myindexPath2];
                   
                   
               }
               
               
               
               
//               else
//               {
//                   if (self.resetflag==1) {
//                       
//                       NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:[self.otherChargesArray count]-1 inSection:0];
//                       [self.otherNametextSelectedarray addObject:myindexPath];
//                       
////                       for (int i=self.inPath.row+1; i<[self.otherChargesArray count]-1; i++) {
////                           
////                           NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:i inSection:0];
////                           [self.otherNametextSelectedarray addObject:myindexPath];
////                       }
//                       
//                    
//                       self.resetflag=0;
//                   }
//                   
//               }
               
               
           }
            
        NSArray *visibleItems = [self.otherSurchargesTC indexPathsForVisibleRows];
        [self.otherSurchargesTC reloadData];
        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.otherChargesArray.count - 1 inSection:currentItem.section];
        [self.otherSurchargesTC scrollToRowAtIndexPath:nextItem atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        
        
          [self.otherchargeArray removeAllObjects];
          [self.otherTaxArray removeAllObjects];
          [self.otherAmountArray removeAllObjects];
        
        [self calculationfunction];
        
       // [self.otherchargeArray addObjectsFromArray:self.otherChargesArray];
        
        
//                netamount=0;
//        
//                for (int i=0; i<self.otherChargesTaxArray.count; i++) {
//                    
//                   if (![[self.otherChargesTaxArray objectAtIndex:i]isEqualToString:@""]) {
//                    
//                    [self.otherchargeArray addObject:[self.otherChargesArray objectAtIndex:i]];
//                       
//                    float tax=[[self.otherChargesTaxArray objectAtIndex:i] floatValue];
//                    tax=tax/100;
//                    [self.otherTaxArray addObject:[NSString stringWithFormat:@"%d * %.2f",amount,tax]];
//                    int amount1=amount * tax;
//                    [self.otherAmountArray addObject:[NSString stringWithFormat:@"%d",amount1]];
//                    netamount+=[[self.otherAmountArray objectAtIndex:i] integerValue];
//                       
//                     
//                     }
//                    
//                    
//                }
        
            if (self.otherchargeArray.count==1) {
                
                 [self.otherchargeArray addObject:@""];
                 [self.otherchargeArray addObject:@""];
                 [self.otherchargeArray addObject:@""];
                
                 [self.otherTaxArray addObject:@""];
                 [self.otherTaxArray addObject:@""];
                 [self.otherTaxArray addObject:@""];
                
                [self.otherAmountArray addObject:@""];
                [self.otherAmountArray addObject:@""];
                [self.otherAmountArray addObject:@""];
             }
        
            else  if (self.otherchargeArray.count==2) {
            
                [self.otherchargeArray addObject:@""];
                [self.otherchargeArray addObject:@""];
                
                [self.otherTaxArray addObject:@""];
                [self.otherTaxArray addObject:@""];
                
                
                [self.otherAmountArray addObject:@""];
                [self.otherAmountArray addObject:@""];

                

            }
            else  if (self.otherchargeArray.count==3) {
                
                [self.otherchargeArray addObject:@""];
                
                [self.otherTaxArray addObject:@""];
                
                [self.otherAmountArray addObject:@""];
               

            }

        
        
        
              //  netamount+=amount;
               // self.netpayableAmountLabel.text=[NSString stringWithFormat:@"%d",netamount ];
        
                [self.otherChargesDisplayTC reloadData];
        
        
        
      //[self.otherSurchargesTC reloadData];
        
    }
    
    
}



-(void)calculationfunction
{
    
    netamount=0;
    
    for (int i=0; i<self.otherChargesTaxArray.count; i++) {
        
        if (![[self.otherChargesTaxArray objectAtIndex:i]isEqualToString:@""]) {
            
            [self.otherchargeArray addObject:[self.otherChargesArray objectAtIndex:i]];
            
            float tax=[[self.otherChargesTaxArray objectAtIndex:i] floatValue];
            tax=tax/100;
            [self.otherTaxArray addObject:[NSString stringWithFormat:@"%ld * %.2f",amount,tax]];
            int amount1=amount * tax;
            [self.otherAmountArray addObject:[NSString stringWithFormat:@"%d",amount1]];
            netamount+=[[self.otherAmountArray objectAtIndex:i] integerValue];
            
            
        }
        
        
    }
    netamount+=amount;
    self.netpayableAmountLabel.text=[NSString stringWithFormat:@"%ld",netamount ];
    
}



-(IBAction)surchargeEndnamefield:(id)sender
{
    
    otherSurchargesTableViewCell *cell = (otherSurchargesTableViewCell *)[[[sender superview]superview] superview];
     NSIndexPath *myindex = [self.otherSurchargesTC indexPathForCell:cell];
    
    if (cell.nameText.text.length>0) {
        
        cell.taxText.userInteractionEnabled=TRUE;
        cell.taxbgview.backgroundColor=[UIColor whiteColor];
        
      
       [self.otherChargesArray replaceObjectAtIndex:myindex.row withObject:cell.nameText.text];
       [self.sur_selectedarray addObject:myindex];
      // [self.sur_selectedarray2 removeObject:myindex];
       [self.otherSurchargesTC reloadData];
      
    // [self.otherchargeArray removeAllObjects];
        
        
        
        
        if (cell.amountText.text.length>0) {
            
            
//            for (int i=0; i<self.otherChargesTaxArray.count; i++) {
//                
//                [self.otherchargeArray addObject:[self.otherChargesArray objectAtIndex:i]];
//                
//            }
            
               [self.otherchargeArray replaceObjectAtIndex:myindex.row withObject:cell.nameText.text];
            
            
            [self.otherChargesDisplayTC reloadData];

            
        }

    }
    
    
}
-(IBAction)surchargeEndtaxfield:(id)sender
{
    
    otherSurchargesTableViewCell *cell = (otherSurchargesTableViewCell *)[[[sender superview]superview] superview];
    NSIndexPath *myindex = [self.otherSurchargesTC indexPathForCell:cell];
    if (cell.taxText.text.length>0) {
        
        
        if ((!([cell.taxText.text integerValue] < 0)) && ([cell.taxText.text integerValue]<101)) {
            
            
            [self.otherChargesTaxArray replaceObjectAtIndex:myindex.row withObject:cell.taxText.text];
            
            cell.amountText.userInteractionEnabled=TRUE;
            cell.amountbgview.backgroundColor=[UIColor whiteColor];
            cell.mandatorystar1.hidden=TRUE;
            cell.mandatorystar2.hidden=FALSE;
            
           // NSString *string=@"%";
           // cell.taxText.text=[NSString stringWithFormat:@"%@ %@",cell.taxText.text,string];
            
            if (![cell.taxText.text containsString:@"%"]) {
                
                NSString *string=@"%";
                [self.otherChargesTaxArray replaceObjectAtIndex:myindex.row withObject:[NSString stringWithFormat:@"%@ %@",cell.taxText.text,string]];
                cell.taxText.text=[NSString stringWithFormat:@"%@ %@",cell.taxText.text,string];
                
            }

            
            
            
            [self.subchargerangeRedarray removeObject:myindex];
            
            [self.sur_selectedarray2 addObject:myindex];
            //[self.otherSurchargesTC reloadData];
        }
        
        else
        {
            [self.subchargerangeRedarray addObject:myindex];
            cell.taxText.textColor=[UIColor redColor];
            cell.amountText.userInteractionEnabled=FALSE;
            cell.amountbgview.backgroundColor=[UIColor lightGrayColor];
            cell.amountText.text=@"";
        }
        // [self.sur_selectedarray2 addObject:myindex];
       //  [self.otherSurchargesTC reloadData];

        
    }

}




//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    otherSurchargesTableViewCell *cell=(otherSurchargesTableViewCell *)[[textField superview]superview];
//    self.inPath=[self.otherSurchargesTC indexPathForCell:cell];
//    if (textField==cell.nameText) {
//
//    }
//    else if(textField==cell.taxText)
//    {
//        if (cell.taxText.text.length > 0) {
//            if (cell.taxText.text.length < 3) {
//                cell.taxText.text=[NSString stringWithFormat:@"%@%%",cell.taxText.text];
//            }
//        }
//    }
//
//    return YES;
//}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    
    taxfirstcellclass *cell=(taxfirstcellclass *)[[[textField superview] superview]superview];
    
    taxfirstcellclass *cell1=(taxfirstcellclass *)[[[textField superview] superview] superview];
    
    otherSurchargesTableViewCell *cell2=(otherSurchargesTableViewCell *)[[textField superview] superview];
    
    otherSurchargesTableViewCell *cell3=(otherSurchargesTableViewCell *)[[[textField superview] superview] superview];
  
    if ([cell isKindOfClass:[taxfirstcellclass class]]) {
        
         if ((textField==cell.amounttext) || (textField==cell.taxtextfield)) {
             
             if ([string isEqualToString:@""]) {
                 
                 
                 return YES;
             }
             else
             {
                 
                             NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
                             unichar c = [string characterAtIndex:0];
                             if ([myCharSet characterIsMember:c])
                             {
                                 return YES;
                             }
                             else{
                                 
                                 return NO;
                             }

                 
                 
             }
             
             
             
         }
        
        
        
        
        
        
    }
    else if ([cell1 isKindOfClass:[taxfirstcellclass class]])
    {
        
        
        
        if ((textField==cell1.amounttext) || (textField==cell1.taxtextfield)) {
            
            if ([string isEqualToString:@""]) {
                
                
                return YES;
            }
            else
            {
                
                NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
                unichar c = [string characterAtIndex:0];
                if ([myCharSet characterIsMember:c])
                {
                    return YES;
                }
                else{
                    
                    return NO;
                }
                
                
                
            }
            
            
            
        }
        
        
        
    
        
    }
    else if ([cell2 isKindOfClass:[otherSurchargesTableViewCell class]])
    {
        if (textField==cell2.nameText) {
            if ([string isEqualToString:@""]) {
                return YES;
            }
            if (textField.text.length<=44) {
                NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
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
        
        
    }
    
    else if ([cell2 isKindOfClass:[otherSurchargesTableViewCell class]])
    {
        
             if (textField==cell3.taxText)
               {
        
                if ([string isEqualToString:@""]) {
        
        
                    return YES;
                }
                else
                {
        
                    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
                    unichar c = [string characterAtIndex:0];
                    if ([myCharSet characterIsMember:c])
                    {
                        return YES;
                    }
                    else{
        
                        return NO;
                    }
                    
                    
                    
                }
                
        
                
        }

    }
    else if (textField==self.aboveTaxtextfield)
    {
        
        
        if ([string isEqualToString:@""]) {
            
            
            return YES;
        }
        else
        {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                
                return NO;
            }
            
            
            
        }

         
         
         
    }
    
    
    
    return YES;
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField=textField;
    self.abovebgflag=0;
    
    
    otherSurchargesTableViewCell *cell1=(otherSurchargesTableViewCell *)[[[textField superview] superview] superview];
    
    
    taxfirstcellclass *cell=(taxfirstcellclass *)[[[textField superview] superview] superview];
    
    if ([cell isKindOfClass:[taxfirstcellclass class]]) {
   
         cell.taxtextfield.textColor=[UIColor blackColor];
    }
    
  //  taxfirstcellclass *cell=(taxfirstcellclass *)[[[textField superview] superview] superview];
    
    if ([cell1 isKindOfClass:[otherSurchargesTableViewCell class]]) {
        
        cell1.taxText.textColor=[UIColor blackColor];
    }

    
    
}




-(IBAction)doneButtonAction:(id)sender
{
    
    
     NSLog(@"%@",self.zeroarray);
     NSLog(@"%@",self.amountarray);
     NSLog(@"%@",self.percentagetaxarray);
    
    
    
     NSLog(@"%@",self.otherChargesArray);
     NSLog(@"%@",self.otherChargesTaxArray);
     NSLog(@"%@",self.otherChargesAmountArray);
    
    
    
    NSLog(@"%@",self.otherInstanceRangeArray);
    NSLog(@"%@",self.otherInstanceTaxableAmountArray);
    NSLog(@"%@",self.otherInstanceTaxArray);
    NSLog(@"%@",self.otherInstanceTaxAmtArray);
    
    
    
    NSLog(@"%@",self.otherchargeArray);
    NSLog(@"%@",self.otherTaxArray);
    NSLog(@"%@",self.otherAmountArray);
    
    
    
    
    
    if (self.aboveResultvalue.text.length>0) {
        
        if (self.aboveTaxtextfield.text.length>0) {
            
            
            [self.otherchargeArray removeObject:@""];
            [self.otherChargesArray removeObject:@""];
            
            
            [self.otherChargesTaxArray removeObject:@""];
            [self.otherChargesAmountArray removeObject:@""];
            [self.otherTaxArray removeObject:@""];
            [self.otherAmountArray removeObject:@""];
            [self.zeroarray removeObject:@""];
            [self.amountarray removeObject:@""];
            [self.percentagetaxarray removeObject:@""];
            
            
            
            NSMutableArray *perctaray=[[NSMutableArray alloc]init];
            NSMutableArray *percntage2aray=[[NSMutableArray alloc]init];
            for (int i=0; i<[self.percentagetaxarray count]; i++) {
                
                [perctaray addObject:[[[self.percentagetaxarray objectAtIndex:i]componentsSeparatedByString:@" %"] objectAtIndex:0]];
            }
            for (int i=0; i<[self.otherChargesTaxArray count]; i++) {
                
                [percntage2aray addObject:[[[self.otherChargesTaxArray objectAtIndex:i]componentsSeparatedByString:@" %"] objectAtIndex:0]];
            }
            
            [self.zeroarray removeLastObject];
            
            
            
            
            NSMutableDictionary *incometaxdict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:self.zeroarray,@"start",self.amountarray,@"limit",perctaray,@"percent", nil];
            
            
            
            
            
            
            NSMutableDictionary *othertaxdict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:self.otherChargesArray,@"name",percntage2aray,@"rate",self.otherChargesAmountArray,@"amount", nil];
            
            
            NSString *newString;
            
            NSString *str1 = self.aboveTaxtextfield.text;
            NSRange range = [str1 rangeOfString:@"%"];
            if (range.location != NSNotFound) {
                newString= [str1 substringToIndex:range.location];
                NSLog(@"%@",newString);
            } else {
                NSLog(@"%% is not found");
            }
            
            
            
            
            NSMutableDictionary *senddictionary=[[NSMutableDictionary alloc] initWithObjectsAndKeys:incometaxdict,@"incometax",othertaxdict,@"surcharge",newString,@"above_Taxvalue",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"office_id",self.deductincometaxfromalarystring,@"deduct_salary",self.nodeductincometaxfromalarystring,@"nodeduct_incometax",self.checkboxstringvalue,@"approve",self.swichbuttonstringvalue,@"enable", nil];
            
            
            
            [self.myconnection createtax:senddictionary];
            

            
        }
        else
        {
            
                    UIAlertController *alert= [UIAlertController
                                               alertControllerWithTitle:@"Warning!"
                                               message:@"Please Enter the Mandatory Field"
                                               preferredStyle:UIAlertControllerStyleAlert];
            
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action){
            
            
                                                               }];
            
                    [alert addAction:ok];
            
            
            
                    [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
                

            
        }
        
        
    }
    else
    {
        
        
        [self.otherchargeArray removeObject:@""];
        [self.otherChargesArray removeObject:@""];
        
        
        [self.otherChargesTaxArray removeObject:@""];
        [self.otherChargesAmountArray removeObject:@""];
        [self.otherTaxArray removeObject:@""];
        [self.otherAmountArray removeObject:@""];
        [self.zeroarray removeObject:@""];
        [self.amountarray removeObject:@""];
        [self.percentagetaxarray removeObject:@""];
        
        
        
        NSMutableArray *perctaray=[[NSMutableArray alloc]init];
        NSMutableArray *percntage2aray=[[NSMutableArray alloc]init];
        for (int i=0; i<[self.percentagetaxarray count]; i++) {
            
            [perctaray addObject:[[[self.percentagetaxarray objectAtIndex:i]componentsSeparatedByString:@" %"] objectAtIndex:0]];
        }
        for (int i=0; i<[self.otherChargesTaxArray count]; i++) {
            
            [percntage2aray addObject:[[[self.otherChargesTaxArray objectAtIndex:i]componentsSeparatedByString:@" %"] objectAtIndex:0]];
        }
        
        [self.zeroarray removeLastObject];
        
        
        
        
        NSMutableDictionary *incometaxdict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:self.zeroarray,@"start",self.amountarray,@"limit",perctaray,@"percent", nil];
        
        
        
        
        
        
        NSMutableDictionary *othertaxdict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:self.otherChargesArray,@"name",percntage2aray,@"rate",self.otherChargesAmountArray,@"amount", nil];
        
        
        NSString *newString;
        
        NSString *str1 = self.aboveTaxtextfield.text;
        NSRange range = [str1 rangeOfString:@"%"];
        if (range.location != NSNotFound) {
            newString= [str1 substringToIndex:range.location];
            NSLog(@"%@",newString);
        } else {
            NSLog(@"%% is not found");
        }
        
        
        
        
        NSMutableDictionary *senddictionary=[[NSMutableDictionary alloc] initWithObjectsAndKeys:incometaxdict,@"incometax",othertaxdict,@"surcharge",newString,@"above_Taxvalue",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"office_id",self.deductincometaxfromalarystring,@"deduct_salary",self.nodeductincometaxfromalarystring,@"nodeduct_incometax",self.checkboxstringvalue,@"approve",self.swichbuttonstringvalue,@"enable", nil];
        
        
        
        [self.myconnection createtax:senddictionary];
        
        
        
    }
    
    
    
    
    
    
    //}
//    else
//    {
//        UIAlertController *alert= [UIAlertController
//                                   alertControllerWithTitle:@"Warning"
//                                   message:@"Please Enter the values"
//                                   preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                   handler:^(UIAlertAction * action){
//                                                       
//                                                       
//                                                   }];
//        
//        [alert addAction:ok];
//        
//        
//
//        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
//    
//        
//    }
//    
    
    
   
    
    
}



-(IBAction)cancelButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}



-(IBAction)editingforothersurtaxField:(id)sender
{
     otherSurchargesTableViewCell *cell1=(otherSurchargesTableViewCell *)[[[sender superview] superview] superview];
    
    if (cell1.taxText.text.length>0) {
        
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Reset"
                                   message:@"Do U Want to Reset the Amount?"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                          
                                                       
                                                       self.resetflag=1;
                                                       
                                         cell1.taxText.text=@"";
                                         cell1.nameText.text=@"";
                                         cell1.amountText.text=@"";
                                                       
                                NSIndexPath *myindex = [self.otherSurchargesTC indexPathForCell:cell1];
                                                       
                                                   
                              //  [self.otherChargesArray replaceObjectAtIndex:myindex.row withObject:cell1.nameText.text];
                                [self.otherChargesTaxArray replaceObjectAtIndex:myindex.row withObject:cell1.taxText.text];
                                [self.otherChargesAmountArray replaceObjectAtIndex:myindex.row withObject:cell1.amountText.text];
                                                       
                                
                                                       
                                                       
                                [self.otherchargeArray replaceObjectAtIndex:myindex.row withObject:cell1.nameText.text];
                                [self.otherTaxArray replaceObjectAtIndex:myindex.row withObject:cell1.taxText.text];
                                [self.otherAmountArray replaceObjectAtIndex:myindex.row withObject:cell1.amountText.text];
                                   
                              
                                                       
                                [self.otherChargesDisplayTC reloadData];
                                                       
                                [self calculationfunction];
                                                       
//                                [self.otherChargesArray removeLastObject];
//                                [self.otherChargesTaxArray removeLastObject];
//                                [self.otherChargesAmountArray removeLastObject];
                                                       
                              //  NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:[self.otherChargesArray count]-1 inSection:0];
                                                       
                                                       
                            //    [self.otherNametextSelectedarray removeObject:myindexPath];
                                                       
                                                       
                                                       
                           //     [self.sur_selectedarray removeObjectAtIndex:[self.otherChargesArray count]-1];
                                                       
                                                       
                                [self.otherNametextSelectedarray removeAllObjects];
                                                       
                                for (int i=0; i<[self.otherChargesArray count]; i++) {
                                    
                                    if (![[self.otherChargesArray objectAtIndex:i]isEqualToString:@""]) {
                                        
                                          NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:i inSection:0];
                                        [self.otherNametextSelectedarray addObject:myindexPath];
                                        
                                    }
                                    
                                    
                                    
                                }
                                                       
                                            
                                [self.sur_selectedarray2 removeObject:myindex];
                                                       
                                [self.otherSurchargesTC reloadData];
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       //Do Some action here
                                                   }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                 {
                                     
                                    
                                 
                                 }];
        
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        //    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        
        //});
        
        
    }


}

-(IBAction)radiobuttonaction:(id)sender
{
    
    UIButton *mybutton = (UIButton *)sender;
    UITextField*myfield=(UITextField *)sender;
    
    if (mybutton.tag==1||myfield.tag==1) {
        
        [self.radiobuttonfirst setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radiobuttonsecond setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.checkboxbutton.hidden=FALSE;
        self.incometaxdeductlabel.text=@"Deduct Only if employee approves from portal";
        
         self.deductincometaxfromalarystring=@"1";
        
        [self.checkboxbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
         self.checkboxstringvalue=@"0";
        self.nodeductincometaxfromalarystring=@"0";
        
    }
    else
    {
        [self.radiobuttonfirst setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        [self.radiobuttonsecond setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        self.checkboxbutton.hidden=TRUE;
        self.incometaxdeductlabel.text=@"Only notifies income tax amount on salary slip every month";
        
        self.deductincometaxfromalarystring=@"0";
        
         self.checkboxstringvalue=@"0";
        self.nodeductincometaxfromalarystring=@"1";
        
    }
    
   
    
}

-(IBAction)incometaxcheckboxaction:(id)sender
{
    if ([self.checkboxbutton.currentImage isEqual:[UIImage imageNamed:@"check box.png"]]) {
        
         [self.checkboxbutton setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
        
        
         self.checkboxstringvalue=@"1";
        
    }
    else
    {
         [self.checkboxbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
         self.checkboxstringvalue=@"0";
    }
    
    
}


-(IBAction)switchbuttonaction:(id)sender
{
    if (self.s1%2==0) {
        
        [self.switchButton setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        
        self.mytableview.userInteractionEnabled=NO;
        self.aboveTaxtextfield.userInteractionEnabled=NO;
        self.otherSurchargesTC.userInteractionEnabled=NO;
        self.radiobuttonfirst.userInteractionEnabled=NO;
        self.radiobuttonsecond.userInteractionEnabled=NO;
        self.instancetableview.userInteractionEnabled=NO;
        self.otherChargesDisplayTC.userInteractionEnabled=NO;
        self.checkboxbutton.userInteractionEnabled=NO;
        self.checkboxtext.userInteractionEnabled=NO;
        self.checktext2.userInteractionEnabled=NO;
        self.checktext.userInteractionEnabled=NO;
        self.checkboxtext.userInteractionEnabled=NO;
        self.checktext2.userInteractionEnabled=NO;
        self.checktext.userInteractionEnabled=NO;



               self.s1++;
      //  [self.scrollView setAlpha:0.6];//off
        [self.mytableview setAlpha:0.6];
        [self.instancetableview setAlpha:0.6];
        [self.otherChargesDisplayTC setAlpha:0.6];
        [self.otherSurchargesTC setAlpha:0.6];
        

//        [self.doneButton setAlpha:1.0];
//        [self.switchButton setAlpha:1.0];
//        [self.cancl setAlpha:1.0];
//        

        self.swichbuttonstringvalue=@"0";
        
        
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
        
        self.mytableview.userInteractionEnabled=YES;
        self.aboveTaxtextfield.userInteractionEnabled=YES;
        self.otherSurchargesTC.userInteractionEnabled=YES;
        self.radiobuttonfirst.userInteractionEnabled=YES;
        self.radiobuttonsecond.userInteractionEnabled=YES;
        self.instancetableview.userInteractionEnabled=YES;
        self.otherChargesDisplayTC.userInteractionEnabled=YES;
        self.checkboxbutton.userInteractionEnabled=YES;

        self.s1++;
       // [self.scrollView setAlpha:1.0];
        [self.mytableview setAlpha:1.0];
        [self.instancetableview setAlpha:1.0];
        [self.otherChargesDisplayTC setAlpha:1.0];
        [self.otherSurchargesTC setAlpha:1.0];

        
        self.swichbuttonstringvalue=@"1";
        
    }

    
    
}

-(void)createdIncometax:(NSString *)dictreponse
{
    
    if ([dictreponse isEqualToString:@"1"]) {
        
       
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Success"
                                       message:@"Successfully Updated"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           
                                                           
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
                                                           [self removeFromSuperview];
                                                           
                                                           
                                                       }];
            
            
            [alert addAction:ok];
            
            
            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
            
            
            
            
            
            
        });
    
    
     
    }
    else
    {
        
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Error"
                                   message:@"Updation Unsuccessful"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       

        
                                                     
      
                                                  }];
        
        [alert addAction:ok];
       
        
        //    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        

    
   
    });
    
  }
    
}

-(void)displayincometaxResponse:(NSMutableDictionary *)displayresponsedict
{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
    
    

    NSMutableArray *checkarray = [displayresponsedict objectForKey:@"income_data"];
    
    if ([checkarray count]>0) {
        
        
        
        NSMutableArray *taxdetailsmainarray = [displayresponsedict objectForKey:@"tax_details"];
        
        
        
        
        [self.taxarray1 removeAllObjects];
        [self.zeroarray removeAllObjects];
        [self.amountarray removeAllObjects];
        [self.percentagetaxarray removeAllObjects];
        [self.selectedarray removeAllObjects];
        [self.amountfieldSelectedarray removeAllObjects];
        [self.taxrangeRedarray removeAllObjects];
        
        
        
        
        
        
        
         NSMutableArray *checkarray1 = [displayresponsedict objectForKey:@"income_data"];
        
         NSMutableDictionary *dictioanry = [checkarray1 objectAtIndex:0];
         NSString *string=@"%";
         self.aboveTaxtextfield.text=[NSString stringWithFormat:@"%@%@",[dictioanry objectForKey:@"above_tax"],string];
         self.aboveTaxtextfield.userInteractionEnabled=TRUE;
         self.abovebackgdView.backgroundColor=[UIColor whiteColor];
         self.abovelabel.hidden=FALSE;
         self.aboveNumberlabel.hidden=FALSE;
         self.aboveResultvalue.hidden=FALSE;
        
        if ([[dictioanry objectForKey:@"deduct_salary"]isEqualToString:@"1"]) {
            
            
            [self.radiobuttonfirst setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            [self.radiobuttonsecond setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            self.checkboxbutton.hidden=FALSE;
            self.incometaxdeductlabel.text=@"Deduct Only if employee approves from portal";
            
            self.deductincometaxfromalarystring=@"1";
            
            
            
            if ([[dictioanry objectForKey:@"employee_approve"]isEqualToString:@"1"]) {
                  
                [self.checkboxbutton setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
                self.checkboxstringvalue=@"1";
            }
            else
            {
                
                [self.checkboxbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
                self.checkboxstringvalue=@"0";
            }
            
          
            self.nodeductincometaxfromalarystring=@"0";
        }
        else
        {
            
            
            [self.radiobuttonfirst setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            [self.radiobuttonsecond setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            self.checkboxbutton.hidden=TRUE;
            self.incometaxdeductlabel.text=@"Only notifies income tax amount on salary slip every month";
            
            self.deductincometaxfromalarystring=@"0";
            
            self.checkboxstringvalue=@"0";
              self.nodeductincometaxfromalarystring=@"1";

            
            
        }
        
        
        
        if ([[dictioanry objectForKey:@"disable_deduction"]isEqualToString:@"1"]) {
            
            
            [self.radiobuttonfirst setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            [self.radiobuttonsecond setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            self.checkboxbutton.hidden=TRUE;
            self.incometaxdeductlabel.text=@"Only notifies income tax amount on salary slip every month";
            
            self.deductincometaxfromalarystring=@"0";
            
            self.checkboxstringvalue=@"0";
            self.nodeductincometaxfromalarystring=@"1";
            

            
        }
        else
        {
            
            
            [self.radiobuttonfirst setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            [self.radiobuttonsecond setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            self.checkboxbutton.hidden=FALSE;
            self.incometaxdeductlabel.text=@"Deduct Only if employee approves from portal";
            
            self.deductincometaxfromalarystring=@"1";
            
            if ([[dictioanry objectForKey:@"employee_approve"]isEqualToString:@"1"]) {
                
                [self.checkboxbutton setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
                self.checkboxstringvalue=@"1";
            }
            else
            {
                
                [self.checkboxbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
                self.checkboxstringvalue=@"0";
            }
            
            self.nodeductincometaxfromalarystring=@"0";

            
            
        }
        
        
        
        if ([[dictioanry objectForKey:@"enable"]isEqualToString:@"1"]) {
            
          
            [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
            //        self.switchButton.imageView.animationImages =
            //        [NSArray arrayWithObjects:
            //         [UIImage imageNamed:@"button_2 (1).png"],[UIImage imageNamed:@"button_2 (1).png"],
            //         nil];
            //        self.switchButton.imageView.animationDuration = 0.5; //whatever you want (in seconds)
            //        [self.switchButton.imageView startAnimating];
            //
            
            // [self.switchButton setImage:[UIImage animatedImageNamed:@"button_2 (1).png" duration:0.5] forState:UIControlStateNormal];
            
            self.mytableview.userInteractionEnabled=YES;
            self.aboveTaxtextfield.userInteractionEnabled=YES;
            self.otherSurchargesTC.userInteractionEnabled=YES;
            self.radiobuttonfirst.userInteractionEnabled=YES;
            self.radiobuttonsecond.userInteractionEnabled=YES;
            self.instancetableview.userInteractionEnabled=YES;
            self.otherChargesDisplayTC.userInteractionEnabled=YES;
            self.checkboxbutton.userInteractionEnabled=YES;
            
          //  self.s1++;
            // [self.scrollView setAlpha:1.0];
            [self.mytableview setAlpha:1.0];
            [self.instancetableview setAlpha:1.0];
            [self.otherChargesDisplayTC setAlpha:1.0];
            [self.otherSurchargesTC setAlpha:1.0];
            
            
            self.swichbuttonstringvalue=@"1";
            self.s1=0;
            
            
        }
        else
        {
            self.s1=1;
            
            [self.switchButton setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
            
            self.mytableview.userInteractionEnabled=NO;
            self.aboveTaxtextfield.userInteractionEnabled=NO;
            self.otherSurchargesTC.userInteractionEnabled=NO;
            self.radiobuttonfirst.userInteractionEnabled=NO;
            self.radiobuttonsecond.userInteractionEnabled=NO;
            self.instancetableview.userInteractionEnabled=NO;
            self.otherChargesDisplayTC.userInteractionEnabled=NO;
            self.checkboxbutton.userInteractionEnabled=NO;
            self.checkboxtext.userInteractionEnabled=NO;
            self.checktext2.userInteractionEnabled=NO;
            self.checktext.userInteractionEnabled=NO;
            self.checkboxtext.userInteractionEnabled=NO;
            self.checktext2.userInteractionEnabled=NO;
            self.checktext.userInteractionEnabled=NO;
            
            
            
            //self.s1++;
            //  [self.scrollView setAlpha:0.6];//off
            [self.mytableview setAlpha:0.6];
            [self.instancetableview setAlpha:0.6];
            [self.otherChargesDisplayTC setAlpha:0.6];
            [self.otherSurchargesTC setAlpha:0.6];
            
            
            //        [self.doneButton setAlpha:1.0];
            //        [self.switchButton setAlpha:1.0];
            //        [self.cancl setAlpha:1.0];
            //        
            
            self.swichbuttonstringvalue=@"0";

            
            
        }

        
        
    
        
        
        if (taxdetailsmainarray.count<5)
        {
            if (taxdetailsmainarray.count==1) {
                
                
                for (int i=0; i<[taxdetailsmainarray count]; i++) {
                    
                    NSString *str=@"%";
                    NSMutableDictionary *mydict = [taxdetailsmainarray objectAtIndex:i];
                    
                    [self.taxarray1 addObject:[NSString stringWithFormat:@"%i",i+1]];
                    [self.zeroarray addObject:[mydict objectForKey:@"begin"]];
                    [self.amountarray addObject:[mydict objectForKey:@"end"]];
                    [self.percentagetaxarray addObject:[NSString stringWithFormat:@"%@%@",[mydict objectForKey:@"tax"],str]];
                    
                    
                    
                }

                [self.taxarray1 addObject:@"2"];
                [self.taxarray1 addObject:@"3"];
                [self.taxarray1 addObject:@"4"];
                
                [self.zeroarray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray objectAtIndex:0] integerValue]+1]];
                [self.zeroarray addObject:@""];
                [self.zeroarray addObject:@""];
                [self.amountarray addObject:@""];
                [self.amountarray addObject:@""];
                [self.amountarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                
                
                self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
                self.aboveResultvalue.text=[self.amountarray objectAtIndex:0];
               // self.aboveTaxtextfield.text=@"";
                NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
                [self.selectedarray addObject:myindexPath];
                
                [self.amountfieldSelectedarray addObject:myindexPath];
                [self.amountfieldSelectedarray addObject:myindexPath1];
                
                
                
                
                
            }
            else if (taxdetailsmainarray.count==2)
            {
                
                
                for (int i=0; i<[taxdetailsmainarray count]; i++) {
                    
                    NSString *str=@"%";
                    NSMutableDictionary *mydict = [taxdetailsmainarray objectAtIndex:i];
                    
                    [self.taxarray1 addObject:[NSString stringWithFormat:@"%i",i+1]];
                    [self.zeroarray addObject:[mydict objectForKey:@"begin"]];
                    [self.amountarray addObject:[mydict objectForKey:@"end"]];
                    [self.percentagetaxarray addObject:[NSString stringWithFormat:@"%@%@",[mydict objectForKey:@"tax"],str]];
                    
                    
                    
                }

                
                [self.taxarray1 addObject:@"3"];
                [self.taxarray1 addObject:@"4"];
                [self.zeroarray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray objectAtIndex:1] integerValue]+1]];
                [self.zeroarray addObject:@""];
                [self.amountarray addObject:@""];
                [self.amountarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                
                self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
                self.aboveResultvalue.text=[self.amountarray objectAtIndex:1];
              //  self.aboveTaxtextfield.text=@"";
                
                NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
                NSIndexPath *myindexPath2 = [NSIndexPath indexPathForRow:1 inSection:0];
                NSIndexPath *myindexPath3 = [NSIndexPath indexPathForRow:2 inSection:0];
                
                [self.selectedarray addObject:myindexPath1];
                [self.selectedarray addObject:myindexPath2];
                
                
                
                [self.amountfieldSelectedarray addObject:myindexPath1];
                [self.amountfieldSelectedarray addObject:myindexPath2];
                [self.amountfieldSelectedarray addObject:myindexPath3];
                
                
                
                
            }
            else if (taxdetailsmainarray.count==3)
            {
                
                
                for (int i=0; i<[taxdetailsmainarray count]; i++) {
                    
                    NSString *str=@"%";
                    NSMutableDictionary *mydict = [taxdetailsmainarray objectAtIndex:i];
                    
                    [self.taxarray1 addObject:[NSString stringWithFormat:@"%i",i+1]];
                    [self.zeroarray addObject:[mydict objectForKey:@"begin"]];
                    [self.amountarray addObject:[mydict objectForKey:@"end"]];
                    [self.percentagetaxarray addObject:[NSString stringWithFormat:@"%@%@",[mydict objectForKey:@"tax"],str]];
                    
                    
                    
                }

                
                [self.taxarray1 addObject:@"4"];
                [self.zeroarray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray objectAtIndex:2] integerValue]+1]];
                [self.amountarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                
                self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
                self.aboveResultvalue.text=[self.amountarray objectAtIndex:2];
               // self.aboveTaxtextfield.text=@"";
                
                
                NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
                NSIndexPath *myindexPath2 = [NSIndexPath indexPathForRow:1 inSection:0];
                NSIndexPath *myindexPath3 = [NSIndexPath indexPathForRow:2 inSection:0];
                NSIndexPath *myindexPath4 = [NSIndexPath indexPathForRow:3 inSection:0];
                
                
                [self.selectedarray addObject:myindexPath1];
                [self.selectedarray addObject:myindexPath2];
                [self.selectedarray addObject:myindexPath3];
                
                
                
                [self.amountfieldSelectedarray addObject:myindexPath1];
                [self.amountfieldSelectedarray addObject:myindexPath2];
                [self.amountfieldSelectedarray addObject:myindexPath3];
                [self.amountfieldSelectedarray addObject:myindexPath4];
                
                
            
                
                
            }
            
            else if (taxdetailsmainarray.count==4)
            {
                
                for (int i=0; i<[taxdetailsmainarray count]; i++) {
                    
                    NSString *str=@"%";
                    NSMutableDictionary *mydict = [taxdetailsmainarray objectAtIndex:i];
                    
                    [self.taxarray1 addObject:[NSString stringWithFormat:@"%i",i+1]];
                    [self.zeroarray addObject:[mydict objectForKey:@"begin"]];
                    [self.amountarray addObject:[mydict objectForKey:@"end"]];
                    [self.percentagetaxarray addObject:[NSString stringWithFormat:@"%@%@",[mydict objectForKey:@"tax"],str]];
                    
                    
                    
                }

                
                [self.taxarray1 addObject:@"5"];
                [self.zeroarray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray objectAtIndex:3] integerValue]+1]];
                [self.amountarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                
                self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
                self.aboveResultvalue.text=[self.amountarray objectAtIndex:3];
                //self.aboveTaxtextfield.text=@"";
                
                //                                                                       NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:4 inSection:0];
                //                                                                       [self.selectedarray addObject:myindexPath];
                
                
                
                NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
                NSIndexPath *myindexPath2 = [NSIndexPath indexPathForRow:1 inSection:0];
                NSIndexPath *myindexPath3 = [NSIndexPath indexPathForRow:2 inSection:0];
                NSIndexPath *myindexPath4 = [NSIndexPath indexPathForRow:3 inSection:0];
                NSIndexPath *myindexPath5 = [NSIndexPath indexPathForRow:4 inSection:0];
                
                
                [self.selectedarray addObject:myindexPath1];
                [self.selectedarray addObject:myindexPath2];
                [self.selectedarray addObject:myindexPath3];
                [self.selectedarray addObject:myindexPath4];
                
                
                [self.amountfieldSelectedarray addObject:myindexPath1];
                [self.amountfieldSelectedarray addObject:myindexPath2];
                [self.amountfieldSelectedarray addObject:myindexPath3];
                [self.amountfieldSelectedarray addObject:myindexPath4];
                [self.amountfieldSelectedarray addObject:myindexPath5];
                
                
                
                
            }
            else if (taxdetailsmainarray.count==0)
            {
                
                [self.taxarray1 addObject:@"1"];
                [self.taxarray1 addObject:@"2"];
                [self.taxarray1 addObject:@"3"];
                [self.taxarray1 addObject:@"4"];
                [self.zeroarray addObject:@"0"];
                [self.zeroarray addObject:@""];
                [self.zeroarray addObject:@""];
                [self.zeroarray addObject:@""];
                [self.amountarray addObject:@""];
                [self.amountarray addObject:@""];
                [self.amountarray addObject:@""];
                [self.amountarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                [self.percentagetaxarray addObject:@""];
                
                
                self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
                self.aboveResultvalue.text=@"";
               // self.aboveTaxtextfield.text=@"";
                
                
                NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.amountfieldSelectedarray addObject:myindexPath1];
                
                
            }
            
        }
        else
        {
            
            
            
            for (int i=0; i<[taxdetailsmainarray count]; i++) {
                
                NSString *str=@"%";
                NSMutableDictionary *mydict = [taxdetailsmainarray objectAtIndex:i];
                
                [self.taxarray1 addObject:[NSString stringWithFormat:@"%i",i+1]];
                [self.zeroarray addObject:[mydict objectForKey:@"begin"]];
                [self.amountarray addObject:[mydict objectForKey:@"end"]];
                [self.percentagetaxarray addObject:[NSString stringWithFormat:@"%@%@",[mydict objectForKey:@"tax"],str]];
                
                
                
            }

            
            
            [self.taxarray1 addObject:[NSString stringWithFormat:@"%lu",[taxdetailsmainarray count]+1]];
            NSString *storedvalue=[self.amountarray lastObject];
            [self.zeroarray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray lastObject] integerValue]+1]];
            [self.amountarray addObject:@""];
            [self.percentagetaxarray addObject:@""];
            
            
            self.aboveNumberlabel.text=[NSString stringWithFormat:@"%lu",[self.taxarray1 count]+1];
            self.aboveResultvalue.text=storedvalue;
           // self.aboveTaxtextfield.text=@"";
            
            
            for (int i=0; i<self.taxarray1.count-1; i++) {
                
                NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:i inSection:0];
                [self.selectedarray addObject:myindexPath1];
                
            }
            
            for (int i=0; i<self.taxarray1.count+1; i++) {
                
                NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:i inSection:0];
                [self.amountfieldSelectedarray addObject:myindexPath1];
                
            }
            
            
        }

        

        
        [self.mytableview reloadData];
        
        
        
        [self.otherInstanceRangeArray removeAllObjects];
        [self.otherInstanceTaxArray removeAllObjects];
        [self.otherInstanceTaxableAmountArray removeAllObjects];
        [self.otherInstanceTaxAmtArray removeAllObjects];
        
        amount=0;
        
        self.instancenotapplicable1.hidden=FALSE;
        self.instancenotapplicable2.hidden=FALSE;
        self.forinstanceaboveAmtvalue.hidden=FALSE;
        self.forinstanceaboveTaxvalue.hidden=FALSE;
        
        
        
        [self.amountdropdownArray removeAllObjects];
        [self.amountdropdownArray addObject:@"0"];
        
        for (int i=0; i<[self.amountarray count]; i++) {
            
            
            if (![[self.amountarray objectAtIndex:i] isEqualToString:@""]) {
                
                [self.amountdropdownArray addObject:[self.amountarray objectAtIndex:i]];
                
            }
            
            
        }
        
        [self.amountdropTC reloadData];
        
        
        
        
        
        [self.amountarray insertObject:@"0" atIndex:0];
        // [self.amountarray removeLastObject];
        
        for (int i=0; i<[self.amountarray count]-1; i++) {
            
            if (![[self.amountarray objectAtIndex:i+1]isEqualToString:@""]) {
                
                [self.otherInstanceRangeArray addObject:[NSString stringWithFormat:@"%@-%@",[self.amountarray objectAtIndex:i],[self.amountarray objectAtIndex:i+1]]];
            }
            
            
            
        }
        
        
        for (int i=0; i<self.self.amountarray.count-1; i++) {
            
            
            if (![[self.amountarray objectAtIndex:i+1]isEqualToString:@""]) {
                
                [self.otherInstanceTaxableAmountArray addObject:[NSString stringWithFormat:@"%lu",[[self.amountarray objectAtIndex:i+1] integerValue]-[[self.amountarray objectAtIndex:i] integerValue]]];
                
            }
            
        }
        
        //[self.percentagetaxarray removeLastObject];
        [self.otherInstanceTaxArray addObjectsFromArray:self.percentagetaxarray];
        
        
        
        self.instancenotapplicable1.text=@" 100";
        
        float tax=[self.aboveTaxtextfield.text floatValue];
        float tax1=tax/100;
        
        float taxableAmount= 100 * tax1;
        
        self.instancenotapplicable2.text=[NSString stringWithFormat:@"%.f",taxableAmount];
        
        amount+=taxableAmount;
        
        for (int i=0; i < self.otherInstanceTaxableAmountArray.count ; i++) {
            
            float tax=[[self. otherInstanceTaxArray objectAtIndex:i]floatValue];
            float tax1=tax/100;
            //   NSLog(@"%.2f",tax1);
            float taxableAmount=[[self.otherInstanceTaxableAmountArray objectAtIndex:i] integerValue] * tax1;
            [self.otherInstanceTaxAmtArray addObject:[NSString stringWithFormat:@"%.f",taxableAmount]];
            amount+=[[self.otherInstanceTaxAmtArray objectAtIndex:i] integerValue];
            self.grosspayableAmountLabel.text=[NSString stringWithFormat:@"%ld", amount ];
            
            
        }
        
        
        
        [self.instancetableview reloadData];
        
        // [self.percentagetaxarray addObject:@""];
        [self.amountarray removeObjectAtIndex:0];
        // [self.amountarray addObject:@""];
        
        self.annualIncomeAmtLabel.text=[NSString stringWithFormat:@"Annual Income is %ld",[self.aboveResultvalue.text integerValue]+100];
        //  [[NSUserDefaults standardUserDefaults] setObject:self.aboveResultvalue.text forKey:@"resultvalue"];
        //  [[NSUserDefaults standardUserDefaults] synchronize];
        
        self.forinstanceaboveAmtvalue.text=[NSString stringWithFormat:@"Above %ld",[self.aboveResultvalue.text integerValue]];
        self.forinstanceaboveTaxvalue.text=self.aboveTaxtextfield.text;
        
        
        
        
        NSMutableArray *surchargedetailsmainarray = [displayresponsedict objectForKey:@"surcharge"];
        if (surchargedetailsmainarray.count>0) {
            
            
            [self.otherChargesArray removeAllObjects];
            [self.otherChargesTaxArray removeAllObjects];
            [self.otherChargesAmountArray removeAllObjects];
            
            [self.otherNametextSelectedarray removeAllObjects];
            [self.sur_selectedarray removeAllObjects];
            [self.sur_selectedarray2 removeAllObjects];
            [self.subchargerangeRedarray removeAllObjects];
            
            
            
            if (surchargedetailsmainarray.count>0) {
                
                if (surchargedetailsmainarray.count<5) {
                    
                    if (surchargedetailsmainarray.count==1) {
                        
                        for (int i=0; i<[surchargedetailsmainarray count]; i++) {
                            
                            NSString *str=@"%";
                            NSMutableDictionary *mydict = [surchargedetailsmainarray objectAtIndex:i];
                            
                            [self.otherChargesArray addObject:[mydict objectForKey:@"name"]];
                            [self.otherChargesTaxArray addObject:[NSString stringWithFormat:@"%@%@",[mydict objectForKey:@"percent"],str]];
                            [self.otherChargesAmountArray addObject:[mydict objectForKey:@"above"]];
                            
                            
                        }
                        
                        
                        NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                        NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
                        [self.otherNametextSelectedarray addObject:myindexPath];
                        [self.otherNametextSelectedarray addObject:myindexPath1];
                        
                        [self.sur_selectedarray addObject:myindexPath];
                        [self.sur_selectedarray2 addObject:myindexPath];
                        
                        [self.otherChargesArray addObject:@""];
                        [self.otherChargesArray addObject:@""];
                        [self.otherChargesArray addObject:@""];
                        
                        [self.otherChargesTaxArray addObject:@""];
                        [self.otherChargesTaxArray addObject:@""];
                        [self.otherChargesTaxArray addObject:@""];
                        
                        [self.otherChargesAmountArray addObject:@""];
                        [self.otherChargesAmountArray addObject:@""];
                        [self.otherChargesAmountArray addObject:@""];
                        
                        
                    }
                    else if (surchargedetailsmainarray.count==2) {
                        
                        
                        for (int i=0; i<[surchargedetailsmainarray count]; i++) {
                            
                            NSString *str=@"%";
                            NSMutableDictionary *mydict = [surchargedetailsmainarray objectAtIndex:i];
                            
                            [self.otherChargesArray addObject:[mydict objectForKey:@"name"]];
                            [self.otherChargesTaxArray addObject:[NSString stringWithFormat:@"%@%@",[mydict objectForKey:@"percent"],str]];
                            [self.otherChargesAmountArray addObject:[mydict objectForKey:@"above"]];
                            
                            
                        }
                        
                        
                        NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                        NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
                        NSIndexPath *myindexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
                        
                        [self.otherNametextSelectedarray addObject:myindexPath];
                        [self.otherNametextSelectedarray addObject:myindexPath1];
                        [self.otherNametextSelectedarray addObject:myindexPath2];
                        
                        
                        [self.sur_selectedarray addObject:myindexPath];
                        [self.sur_selectedarray addObject:myindexPath1];
                        
                        
                        [self.sur_selectedarray2 addObject:myindexPath];
                        [self.sur_selectedarray2 addObject:myindexPath1];
                        
                        [self.otherChargesArray addObject:@""];
                        [self.otherChargesArray addObject:@""];
                        
                        [self.otherChargesTaxArray addObject:@""];
                        [self.otherChargesTaxArray addObject:@""];
                        
                        [self.otherChargesAmountArray addObject:@""];
                        [self.otherChargesAmountArray addObject:@""];
                        
                        
                        
                        
                        
                    }
                    else if (surchargedetailsmainarray.count==3) {
                        
                        
                        for (int i=0; i<[surchargedetailsmainarray count]; i++) {
                            
                            NSString *str=@"%";
                            NSMutableDictionary *mydict = [surchargedetailsmainarray objectAtIndex:i];
                            
                            [self.otherChargesArray addObject:[mydict objectForKey:@"name"]];
                            [self.otherChargesTaxArray addObject:[NSString stringWithFormat:@"%@%@",[mydict objectForKey:@"percent"],str]];
                            [self.otherChargesAmountArray addObject:[mydict objectForKey:@"above"]];
                            
                            
                        }
                        
                        
                        NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                        NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
                        NSIndexPath *myindexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
                        NSIndexPath *myindexPath3 = [NSIndexPath indexPathForRow:3 inSection:0];
                        
                        [self.otherNametextSelectedarray addObject:myindexPath];
                        [self.otherNametextSelectedarray addObject:myindexPath1];
                        [self.otherNametextSelectedarray addObject:myindexPath2];
                        [self.otherNametextSelectedarray addObject:myindexPath3];
                        
                        
                        
                        [self.sur_selectedarray addObject:myindexPath];
                        [self.sur_selectedarray addObject:myindexPath1];
                        [self.sur_selectedarray addObject:myindexPath2];
                        
                        
                        [self.sur_selectedarray2 addObject:myindexPath];
                        [self.sur_selectedarray2 addObject:myindexPath1];
                        [self.sur_selectedarray2 addObject:myindexPath2];
                        
                        
                        
                        
                        [self.otherChargesArray addObject:@""];
                        
                        
                        [self.otherChargesTaxArray addObject:@""];
                        
                        
                        [self.otherChargesAmountArray addObject:@""];
                        
                        
                        
                        
                        
                    }
                    else if (surchargedetailsmainarray.count==4) {
                        
                        
                        for (int i=0; i<[surchargedetailsmainarray count]; i++) {
                            
                            NSString *str=@"%";
                            NSMutableDictionary *mydict = [surchargedetailsmainarray objectAtIndex:i];
                            
                            [self.otherChargesArray addObject:[mydict objectForKey:@"name"]];
                            [self.otherChargesTaxArray addObject:[NSString stringWithFormat:@"%@%@",[mydict objectForKey:@"percent"],str]];
                            [self.otherChargesAmountArray addObject:[mydict objectForKey:@"above"]];
                            
                            
                        }
                        
                        NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                        NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
                        NSIndexPath *myindexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
                        NSIndexPath *myindexPath3 = [NSIndexPath indexPathForRow:3 inSection:0];
                        NSIndexPath *myindexPath4 = [NSIndexPath indexPathForRow:4 inSection:0];
                        
                        [self.otherNametextSelectedarray addObject:myindexPath];
                        [self.otherNametextSelectedarray addObject:myindexPath1];
                        [self.otherNametextSelectedarray addObject:myindexPath2];
                        [self.otherNametextSelectedarray addObject:myindexPath3];
                        [self.otherNametextSelectedarray addObject:myindexPath4];
                        
                        
                        
                        
                        [self.sur_selectedarray addObject:myindexPath];
                        [self.sur_selectedarray addObject:myindexPath1];
                        [self.sur_selectedarray addObject:myindexPath2];
                        [self.sur_selectedarray addObject:myindexPath3];
                        
                        
                        
                        
                        [self.sur_selectedarray2 addObject:myindexPath];
                        [self.sur_selectedarray2 addObject:myindexPath1];
                        [self.sur_selectedarray2 addObject:myindexPath2];
                        [self.sur_selectedarray2 addObject:myindexPath3];
                        
                        
                        
                        
                        
                        
                        [self.otherChargesArray addObject:@""];
                        
                        
                        [self.otherChargesTaxArray addObject:@""];
                        
                        
                        [self.otherChargesAmountArray addObject:@""];
                        
                        
                        
                        
                    }
                    
                }
                else
                {
                    
                    
                    for (int i=0; i<[surchargedetailsmainarray count]; i++) {
                        
                        NSString *str=@"%";
                        NSMutableDictionary *mydict = [surchargedetailsmainarray objectAtIndex:i];
                        
                        [self.otherChargesArray addObject:[mydict objectForKey:@"name"]];
                        [self.otherChargesTaxArray addObject:[NSString stringWithFormat:@"%@%@",[mydict objectForKey:@"percent"],str]];
                        [self.otherChargesAmountArray addObject:[mydict objectForKey:@"above"]];
                        
                        NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        
                        [self.otherNametextSelectedarray addObject:myindexPath];
                        [self.sur_selectedarray addObject:myindexPath];
                        [self.sur_selectedarray2 addObject:myindexPath];
                        
                    }
                    
                    NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:[surchargedetailsmainarray count] inSection:0];
                    
                    [self.otherNametextSelectedarray addObject:myindexPath1];
                    
                    
                    
                    [self.otherChargesArray addObject:@""];
                    
                    
                    [self.otherChargesTaxArray addObject:@""];
                    
                    
                    [self.otherChargesAmountArray addObject:@""];
                    
                    
                    
                }
                
                
                [self.otherSurchargesTC reloadData];
                
                [self.otherchargeArray removeAllObjects];
                [self.otherTaxArray removeAllObjects];
                [self.otherAmountArray removeAllObjects];
                
                [self calculationfunction];
                
                
                
                
                if (self.otherchargeArray.count==1) {
                    
                    [self.otherchargeArray addObject:@""];
                    [self.otherchargeArray addObject:@""];
                    [self.otherchargeArray addObject:@""];
                    
                    [self.otherTaxArray addObject:@""];
                    [self.otherTaxArray addObject:@""];
                    [self.otherTaxArray addObject:@""];
                    
                    [self.otherAmountArray addObject:@""];
                    [self.otherAmountArray addObject:@""];
                    [self.otherAmountArray addObject:@""];
                }
                
                else  if (self.otherchargeArray.count==2) {
                    
                    [self.otherchargeArray addObject:@""];
                    [self.otherchargeArray addObject:@""];
                    
                    [self.otherTaxArray addObject:@""];
                    [self.otherTaxArray addObject:@""];
                    
                    
                    [self.otherAmountArray addObject:@""];
                    [self.otherAmountArray addObject:@""];
                    
                    
                    
                }
                else  if (self.otherchargeArray.count==3) {
                    
                    [self.otherchargeArray addObject:@""];
                    
                    [self.otherTaxArray addObject:@""];
                    
                    [self.otherAmountArray addObject:@""];
                    
                    
                }
                
                
                
                [self.otherChargesDisplayTC reloadData];
                
            }

            
        }
        else
        {
           
            if (![self.otherChargesTaxArray containsObject:@""]) {
                
                
                
                [self.otherChargesArray addObject:@""];
                [self.otherChargesArray addObject:@""];
                [self.otherChargesArray addObject:@""];
                [self.otherChargesArray addObject:@""];
                
                
                [self.otherChargesTaxArray addObject:@""];
                [self.otherChargesTaxArray addObject:@""];
                [self.otherChargesTaxArray addObject:@""];
                [self.otherChargesTaxArray addObject:@""];
                
                
                
                [self.otherChargesAmountArray addObject:@""];
                [self.otherChargesAmountArray addObject:@""];
                [self.otherChargesAmountArray addObject:@""];
                [self.otherChargesAmountArray addObject:@""];
                
                [self.sur_selectedarray removeAllObjects];
                [self.sur_selectedarray2 removeAllObjects];
                [self.otherNametextSelectedarray removeAllObjects];
                [self.subchargerangeRedarray removeAllObjects];
                
                
                NSIndexPath *myindexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.otherNametextSelectedarray addObject:myindexPath1];
                
                [self.otherSurchargesTC reloadData];
                
                
                [self.otherchargeArray removeAllObjects];
                [self.otherTaxArray removeAllObjects];
                [self.otherAmountArray removeAllObjects];
                
                [self.otherchargeArray addObject:@""];
                [self.otherchargeArray addObject:@""];
                [self.otherchargeArray addObject:@""];
                [self.otherchargeArray addObject:@""];
                
                
                [self.otherTaxArray addObject:@""];
                [self.otherTaxArray addObject:@""];
                [self.otherTaxArray addObject:@""];
                [self.otherTaxArray addObject:@""];
                
                [self.otherAmountArray addObject:@""];
                [self.otherAmountArray addObject:@""];
                [self.otherAmountArray addObject:@""];
                [self.otherAmountArray addObject:@""];
                
                [self.otherChargesDisplayTC reloadData];
                
                
            }
            
        }
        
    }
    
    });
    
}

@end
