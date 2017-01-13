//
//  addnewbankclass.m
//  Automate Firm
//
//  Created by leonine on 05/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "addnewbankclass.h"
#import "bankcustomcellclass.h"
@implementation addnewbankclass

@synthesize myindex2;

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
//Bank Show //Selection

-(void)awakeFromNib
{
    
    [self.bankcollectionview registerNib:[UINib nibWithNibName:@"bankcustomcell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
    self.myoficeDictionary = [[NSMutableDictionary alloc]init];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"dictionaryKey"];
    self.myoficeDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    self.bankarray = [[NSMutableArray alloc]init];
    self.bankidarray = [[NSMutableArray alloc]init];

    self.selectedarray=[[NSMutableArray alloc] init];
    self.wpscodedictionary=[[NSMutableDictionary alloc] init];


    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"wpsdictionary"]==Nil) {
        
        for (int a=0; a<[[self.myoficeDictionary objectForKey:@"selected_bank"] count]; a++) {
            
            [self.wpscodedictionary setObject:[[[self.myoficeDictionary objectForKey:@"selected_bank"] objectAtIndex:a] objectForKey:@"code"] forKey:[[[self.myoficeDictionary objectForKey:@"selected_bank"] objectAtIndex:a] objectForKey:@"bank_id"]];
            [self.selectedarray addObject:[[[self.myoficeDictionary objectForKey:@"selected_bank"]objectAtIndex:a]objectForKey:@"bank_id"]];
            
        }

    }
    else
    {
        [self.selectedarray removeAllObjects];
        [self.wpscodedictionary removeAllObjects];
        NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"wpsdictionary"];
        [self.wpscodedictionary addEntriesFromDictionary:dict];
        [self.selectedarray addObjectsFromArray:[dict allKeys]];
        
    }
    
    
    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
        return [[self.myoficeDictionary objectForKey:@"available_bank"]count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    

    bankcustomcellclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
    cell.wpstextfield.delegate=self;
    
    cell.bankname.text=[[[self.myoficeDictionary objectForKey:@"available_bank"] objectAtIndex:indexPath.row]objectForKey:@"bank_name"];

    cell.branchname.text=[[[self.myoficeDictionary objectForKey:@"available_bank"] objectAtIndex:indexPath.row]objectForKey:@"bank_branch"];
    cell.selectedbankcellid.text=[[[self.myoficeDictionary objectForKey:@"available_bank"] objectAtIndex:indexPath.row]objectForKey:@"bank_id"];
    
    if ([self.selectedarray containsObject:cell.selectedbankcellid.text])
    {
        
        
        [cell.checkbutton setImage:[UIImage imageNamed:@"check box (tick).png"] forState:UIControlStateNormal];
    
        
                
        cell.wpstextfield.text=[self.wpscodedictionary objectForKey:cell.selectedbankcellid.text];
        cell.wpstextfield.userInteractionEnabled=TRUE;
        cell.wpstextfield.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    else {
        
         [cell.checkbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
         cell.wpstextfield.userInteractionEnabled=FALSE;
         cell.wpstextfield.backgroundColor = [UIColor darkGrayColor];
         cell.wpstextfield.text=@"";
    }
    
    
    
    return cell;
    
    
}


-(IBAction)donebuttonaction:(id)sender
{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.wpscodedictionary forKey:@"wpsdictionary"];
    [self removeFromSuperview];
    
}


-(IBAction)bankcheckbuttonaction:(id)sender
{
    bankcustomcellclass *cell1 = (bankcustomcellclass *)[[sender superview] superview];
    
  //  NSIndexPath *myindex=[self.bankcollectionview indexPathForCell:cell1];
  
    if ([cell1.checkbutton.currentImage isEqual:[UIImage imageNamed:@"check box.png"]]) {
        
        [cell1.checkbutton setImage:[UIImage imageNamed:@"check box (tick).png"] forState:UIControlStateNormal];
        cell1.wpstextfield.backgroundColor = [UIColor lightGrayColor];
        cell1.wpstextfield.userInteractionEnabled=TRUE;
        [self.selectedarray addObject:cell1.selectedbankcellid.text];
        
        
    }
    
    else if([cell1.checkbutton.currentImage isEqual:[UIImage imageNamed:@"check box (tick).png"]])
    {
        
        
        [cell1.checkbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
        
        [self.selectedarray removeObject:cell1.selectedbankcellid.text];
        [self.wpscodedictionary removeObjectForKey:cell1.selectedbankcellid.text];
        cell1.wpstextfield.text = @"";
        cell1.selectedbankcellid.text=@"";
        cell1.wpstextfield.backgroundColor=[UIColor darkGrayColor];
        cell1.wpstextfield.userInteractionEnabled=FALSE;
    
       }
    
  }

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    bankcustomcellclass *cell;
    
    UIView *superview = textField.superview;
    
    while (superview) {
        
        if([superview isKindOfClass:[UICollectionViewCell class]]) {
            
            cell = (bankcustomcellclass *)superview;
            myindex2=[self.bankcollectionview indexPathForCell:cell];
           
            break;
        }
        
        superview = superview.superview;
    }
    
    if(cell == nil)
    {
        NSLog(@"Error...");
    }

    else
    {
        
         CGPoint buttonPosition = [cell.wpstextfield convertPoint:CGPointZero toView:self.bankcollectionview];
        [self.bankcollectionview setContentOffset:CGPointMake(self.bankcollectionview.frame.origin.x-12, buttonPosition.y-18) animated:YES];
        
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.bankcollectionview setContentOffset:CGPointMake(self.bankcollectionview.frame.origin.x-12, 0) animated:YES];
    
    bankcustomcellclass *cell1 = (bankcustomcellclass *)[[textField superview] superview];
    
    if (cell1.wpstextfield.text.length>0) {
        
        [self.wpscodedictionary setObject:cell1.wpstextfield.text forKey:cell1.selectedbankcellid.text];
        
    }
    [self.bankcollectionview reloadData];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    bankcustomcellclass *cell1 = (bankcustomcellclass *)[self.bankcollectionview cellForItemAtIndexPath:myindex2];
    if (textField==cell1.wpstextfield) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=9) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
            
            return NO;
    }
    else
        return YES;
}

@end
