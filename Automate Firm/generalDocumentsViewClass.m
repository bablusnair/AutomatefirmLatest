//
//  generalDocumentsViewClass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 27/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "generalDocumentsViewClass.h"
#import "documentCollectionViewCell.h"
#import "documentPlusCollectionViewCell.h"
#import "generalsettingsmainclass.h"
#import "settingsViewController.h"

@implementation generalDocumentsViewClass

-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    [self.myconnection viewAllDocuments:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    [self.documentCollectionView registerNib:[UINib nibWithNibName:@"documentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"documentCell"];
    [self.documentCollectionView registerNib:[UINib nibWithNibName:@"documentPlusCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"documentPlusCell"];
    self.documentNameArray=[[NSMutableArray alloc] init];
    self.canEditArray=[[NSMutableArray alloc]init];
    self.canViewArray=[[NSMutableArray alloc] init];
    self.sendArray=[[NSMutableArray alloc] init];
    self.cellIdAray=[[NSMutableArray alloc] init];
    self.existingDocDictAray=[[NSMutableArray alloc]init];
    self.newdocumentNameArray=[[NSMutableArray alloc]init];
    self.newcanEditArray=[[NSMutableArray alloc]init];
    self.newcellIdAray=[[NSMutableArray alloc]init];
    self.inserFlag=0;
  
    
    self.readFlag=self.writeFlag=0;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.documentNameArray.count+1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.documentNameArray.count) {
        documentCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"documentCell"forIndexPath:indexPath];
        cell.documentText.delegate=self;
        cell.documentText.text=[self.documentNameArray objectAtIndex:indexPath.row];
        if (indexPath.row<6) {
            cell.documentText.userInteractionEnabled=NO;
            cell.deleteButon.hidden=TRUE;
            cell.deleteButon.userInteractionEnabled=NO;

        }
        else
        {
            cell.documentText.userInteractionEnabled=YES;
            cell.deleteButon.hidden=FALSE;
            cell.deleteButon.userInteractionEnabled=YES;
            
        }
        if([[self.canViewArray objectAtIndex:indexPath.row]isEqualToString:@"1"])
        {
            [cell.readButton setImage:[UIImage imageNamed:@"eye.png"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.readButton setImage:[UIImage imageNamed:@"eye_red.png"] forState:UIControlStateNormal];
        }
        if ([[self.canEditArray objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
            [cell.writeButton setImage:[UIImage imageNamed:@"edit_blue.png"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.writeButton setImage:[UIImage imageNamed:@"edit_red.png"] forState:UIControlStateNormal];
        }
        return cell;
    }
    else
    {
        documentPlusCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"documentPlusCell"forIndexPath:indexPath];
        return  cell;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.documentCollectionView) {
        self.inpath=indexPath;
        UICollectionViewCell *cell=(UICollectionViewCell *)[self.documentCollectionView cellForItemAtIndexPath:indexPath];
        if ([cell isKindOfClass:[documentPlusCollectionViewCell class]]) {
            
            if (!([[self.documentNameArray lastObject]isEqualToString:@""])) {
                [self.documentNameArray addObject:@""];
                [self.canEditArray addObject:@"1"];
                [self.canViewArray addObject:@"1"];
                NSArray *visibleItems = [self.documentCollectionView indexPathsForVisibleItems];
                [self.documentCollectionView reloadData];
                NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
                NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.documentNameArray.count - 1 inSection:currentItem.section];
                [self.documentCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }
            
        }
    }
    
}
//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    documentCollectionViewCell *cell1 = (documentCollectionViewCell *)[[textField superview] superview];
//    NSIndexPath *myindex=[self.documentCollectionView indexPathForCell:cell1];
//    self.activeField=cell1.documentText;
//    if ([self.documentNameArray containsObject:@""]) {
//        [self.documentNameArray removeObject:@""];
//        [self.canViewArray removeLastObject];
//        [self.canEditArray removeLastObject];
//    }
//    if (myindex.row<self.documentNameArray.count) {
//        [self.documentNameArray replaceObjectAtIndex:myindex.row withObject:cell1.documentText.text];
//        [self.documentNameArray addObject:@""];
//        [self.canEditArray addObject:@"1"];
//        [self.canViewArray addObject:@"1"];
//
//    }
//    else{
//        
//        [self.newdocumentNameArray addObject:cell1.documentText.text];
//        [self.newcanEditArray addObject:@"1"];
//        [self.newcanViewArray addObject:@"1"];
//    }
//        [self.documentCollectionView reloadData];
//    return  YES;
//    
//}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    documentCollectionViewCell *cell1 = (documentCollectionViewCell *)[[textField superview] superview];
    NSIndexPath *myindex=[self.documentCollectionView indexPathForCell:cell1];
    self.activeField=cell1.documentText;
    for (int i=0; i<self.documentNameArray.count-1; i++) {
        NSString *str=[self.documentNameArray objectAtIndex:i];
       
        if([cell1.documentText.text caseInsensitiveCompare:str] == NSOrderedSame )
        {
            self.inserFlag=1;
            break;
           
        }
        else
        {
            self.inserFlag=0;

        }
    }
    if (self.inserFlag==0) {
        [self.documentNameArray replaceObjectAtIndex:myindex.row withObject:cell1.documentText.text];

    }
    else{
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@" Warning..."
                                   message:[NSString stringWithFormat:@"Document Name Already Exists"]
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       cell1.documentText.text=@"";
                                                       
                                                       
                                                   }];
        [alert addAction:ok];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });
        

    }
    [self.documentCollectionView reloadData];
    
    return  YES;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    documentCollectionViewCell *cell1 = (documentCollectionViewCell *)[[textField superview] superview];
    self.activeField=cell1.documentText;
    return  YES;
}
//textfield delegate functions for validations

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.text.length<=14) {
                
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789!@#%$^&*()-_][{};':,.<>/?"];
                unichar u = [string characterAtIndex:0];
        if ([myCharSet characterIsMember:u])
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


-(IBAction)readAccess:(id)sender
{
    documentCollectionViewCell *cell1 = (documentCollectionViewCell *)[[sender superview] superview];
    NSIndexPath *myindex=[self.documentCollectionView indexPathForCell:cell1];
    if ([cell1.readButton.currentImage isEqual:[UIImage imageNamed:@"eye.png"]]) {
        [self.canViewArray replaceObjectAtIndex:myindex.row withObject:@"0" ];
        [self.canEditArray replaceObjectAtIndex:myindex.row withObject:@"0"];
    }
    else
    {
        [self.canViewArray replaceObjectAtIndex:myindex.row withObject:@"1"];
    }
    
    [self.documentCollectionView reloadData];
    
}
-(IBAction)writeAccess:(id)sender
{
    documentCollectionViewCell *cell1 = (documentCollectionViewCell *)[[sender superview] superview];
    NSIndexPath *myindex=[self.documentCollectionView indexPathForCell:cell1];
    if ([cell1.readButton.currentImage isEqual:[UIImage imageNamed:@"eye.png"]])
    {
        if ([cell1.writeButton.currentImage isEqual:[UIImage imageNamed:@"edit_red.png"]])
        {
            [self.canEditArray replaceObjectAtIndex:myindex.row withObject:@"1"];
            
        }
        else
        {
            [self.canEditArray replaceObjectAtIndex:myindex.row withObject:@"0"];
        }
    }
    [self.documentCollectionView reloadData];
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
    [self.scrollView setContentOffset:CGPointMake(0, self.activeField.frame.origin.y+50) animated:YES];

}
- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

-(IBAction)doneButton:(id)sender
{
    if ([self.documentNameArray containsObject:@""]) {
        [self.documentNameArray removeObject:@""];
    }
    if (self.documentNameArray.count>self.cellIdAray.count) {
        for (int j=self.cellIdAray.count; j<self.documentNameArray.count; j++) {
            [self.cellIdAray insertObject:@"" atIndex:j];
        }
    }
   
    for (int i=0; i<[self.documentNameArray count]; i++) {
        
                       NSMutableDictionary *localDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:[self.documentNameArray objectAtIndex:i],@"document_title",[self.canEditArray objectAtIndex:i],@"checkbox_edit",[self.canViewArray objectAtIndex:i],@"checkbox_view",[self.cellIdAray objectAtIndex:i],@"id", nil];
        
        
       [localDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] forKey:@"o_id"];
       [self.sendArray addObject:localDict];
    }
    [self.myconnection createNewDocument:self.sendArray officeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    //[self removeFromSuperview];
}
-(IBAction)cancelButton:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    [self removeFromSuperview];
}
-(void)viewAllResponse:(id)responseList
{
    self.existingDocDictAray=responseList;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.documentNameArray removeAllObjects];
        [self.canEditArray removeAllObjects];
        [self.canViewArray removeAllObjects];
        [self.cellIdAray removeAllObjects];
        for (int i=0;i<[responseList count]; i++) {
            [self.documentNameArray addObject:[[responseList objectAtIndex:i]objectForKey:@"document_title"]];
            [self.canEditArray addObject:[[responseList objectAtIndex:i]objectForKey:@"checkbox_edit"]];
            [self.canViewArray addObject:[[responseList objectAtIndex:i]objectForKey:@"checkbox_view"]];
            [self.cellIdAray addObject:[[responseList objectAtIndex:i]objectForKey:@"id"]];

        }
            [self.documentCollectionView reloadData];
  
    });
    
    
    
}
-(void)viewAllDateResponse:(id)responseList
{
    
    if ([responseList count]>0) {
        generalsettingsmainclass *ob1 = (generalsettingsmainclass *)self.superview.superview;
        [ob1 viewAllDateResponse:responseList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
            
        });
    }
    else
    {
        
        [self showalerviewcontroller:@"Connection Failed"];
    }
    

    
    
    
}

-(IBAction)deleteDocuments:(id)sender
{
    
    
    
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@" Warning..."
                               message:[NSString stringWithFormat:@"Are You sure Want to delete The Document "]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   documentCollectionViewCell *cell1 = (documentCollectionViewCell *)[[sender superview] superview];
                                                   self.inpath=[self.documentCollectionView indexPathForCell:cell1];
                                                   NSLog(@"%@",_inpath);
                                                   if (!(self.cellIdAray.count==self.documentNameArray.count)) {
                                                       [self.documentNameArray removeObjectAtIndex:self.inpath.row];
                                                       [self.canViewArray removeObjectAtIndex:self.inpath.row];
                                                       [self.canEditArray removeObjectAtIndex:self.inpath.row];
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           [self.documentCollectionView reloadData];
                                                           
                                                           
                                                       });
                                                       
                                                   }
                                                   else{
                                                       [self.myconnection deleteDocument:[self.cellIdAray objectAtIndex:self.inpath.row] officeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]docTypeId:@"0"];
                                                       
                                                   }

                                                   
                                                   
                                               }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       
                                                   }];
    [alert addAction:cancel];
    
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    

}

-(void)deleteExixtDoc:(id)responseMesg
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Files Are Inside The Document"
                               message:[NSString stringWithFormat:@"You can not delete the Folder"]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
//                                                   [self.myconnection deleteDocument:[self.cellIdAray objectAtIndex:self.inpath.row] officeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]docTypeId:@"1"];
                                                   

                                            
                         }];
    

    [alert addAction:ok];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    

}


@end
