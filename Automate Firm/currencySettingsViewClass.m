//
//  currencySettingsViewClass.m
//  Automate Firm
//
//  Created by leonine on 1/13/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "currencySettingsViewClass.h"
#import "notesCollectionViewCell.h"
#import "plusNotesCollectionViewCell.h"
#import "coinsCollectionViewCell.h"
#import "addCoinsCollectionViewCell.h"
#import "settingsViewController.h"
@implementation currencySettingsViewClass
@synthesize index,pickerFlag;
-(void)awakeFromNib
{
    [ self.currencyNotesCV registerNib:[UINib nibWithNibName:@"notesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"notesCell"];
    [ self.currencyNotesCV registerNib:[UINib nibWithNibName:@"plusNotesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"notesPlus"];
    
    
    [ self.currencyCoinsCV registerNib:[UINib nibWithNibName:@"coinsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"coinsCell"];
    [ self.currencyCoinsCV registerNib:[UINib nibWithNibName:@"addCoinsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"addCoinsCell"];
    
    self.notesArray=[[NSMutableArray alloc]init];
    self.coinsArray=[[NSMutableArray alloc]init];
    self.coinsImageArray=[[NSMutableArray alloc]init];
    self.notesImageArray=[[NSMutableArray alloc]init];
    
    self.currencyLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"currency"];
    
    pickerFlag=0;
    
    
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
    if (collectionView==self.currencyNotesCV) {
        return self.notesArray.count + 1;//Need to return one  more cell, for displaying 2 cells at a time
    }
    else
    {
        return  self.coinsArray.count + 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.currencyNotesCV) {
        if (indexPath.row < self.notesArray.count) {
            notesCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"notesCell"forIndexPath:indexPath];
            cell.notesText.text=[self.notesArray objectAtIndex: indexPath.row];
            cell.iconImage.image=[self.notesImageArray objectAtIndex:indexPath.row];
            
            return cell;
        }
        else
        {
            plusNotesCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"notesPlus"forIndexPath:indexPath];
            return cell;
        }
    }
    else
    {
        if (indexPath.row < self.coinsArray.count) {
            coinsCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"coinsCell"forIndexPath:indexPath];
            cell.coinsText.text=[self.coinsArray objectAtIndex: indexPath.row];
            cell.iconImage.image=[self.coinsImageArray objectAtIndex:indexPath.row];
            return cell;
        }
        else
        {
            addCoinsCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"addCoinsCell"forIndexPath:indexPath];
            return cell;
        }

    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.currencyNotesCV) {
        UICollectionViewCell *cell=(UICollectionViewCell *)[self.currencyNotesCV cellForItemAtIndexPath:indexPath];
        if ([cell isKindOfClass:[plusNotesCollectionViewCell class]]) {
            
            if (!([[self.notesArray lastObject]isEqualToString:@" "])) {
                [self.notesArray addObject:@" "];
                [self.notesImageArray addObject:[UIImage imageNamed:@"currencyNotes.png" ]];
                [self.currencyNotesCV reloadData];
            }
            
        }
    }
    else
    {
        UICollectionViewCell *cell=(UICollectionViewCell *)[self.currencyCoinsCV cellForItemAtIndexPath:indexPath];
        if ([cell isKindOfClass:[addCoinsCollectionViewCell class]]) {
            if (!([[self.coinsArray lastObject]isEqualToString:@" "])) {
                [self.coinsArray addObject:@" "];
                [self.coinsImageArray addObject:[UIImage imageNamed:@"currencyCoins.png"]];
                [self.currencyCoinsCV reloadData];
            }
            
        }
    }
    
}
-(IBAction)cancelAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)DoneAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)deleteNoteCell:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.currencyNotesCV];
    NSIndexPath *inPath= [self.currencyNotesCV indexPathForItemAtPoint:buttonPosition];
    
//    notesCollectionViewCell *clickedCell=(notesCollectionViewCell *)[[self superview] superview];
//    NSIndexPath *inPath = [self.currencyNotesCV indexPathForCell:clickedCell];
    
    [self.notesArray removeObjectAtIndex:inPath.row];
    [self.notesImageArray removeObjectAtIndex:inPath.row];
    [self.currencyNotesCV reloadData];
}
-(IBAction)deleteCoinsCell:(id)sender
{
    //CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.currencyCoinsCV];
    //NSIndexPath *inPath1= [self.currencyCoinsCV indexPathForItemAtPoint:buttonPosition];
    
    
    coinsCollectionViewCell *clickedCell = (coinsCollectionViewCell *)[[sender superview] superview];
    NSIndexPath *inPath1 = [self.currencyCoinsCV indexPathForCell:clickedCell];
    
    [self.coinsArray removeObjectAtIndex:inPath1.row];
    [self.coinsImageArray removeObjectAtIndex:inPath1.row];
    [self.currencyCoinsCV reloadData];
}

-(IBAction)imagePickerAction:(id)sender//Got Response when upload notes image
{
    pickerFlag=1;
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.currencyNotesCV];
    index= [self.currencyNotesCV indexPathForItemAtPoint:buttonPosition];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Warning"
                                   message:@"Device not support camera"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                       [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:picker animated:YES completion:nil];
                                                   }];
        [alert addAction:ok];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });

        
    }
    else
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera && UIImagePickerControllerSourceTypePhotoLibrary;
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:picker animated:YES completion:nil];
    }
    
    
    
}
-(IBAction)imagePickerAction1:(id)sender//Got Response when upload coins image
{
    pickerFlag=2;
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.currencyCoinsCV];
    index= [self.currencyCoinsCV indexPathForItemAtPoint:buttonPosition];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (pickerFlag==1) {
        notesCollectionViewCell *cell=(notesCollectionViewCell *)[self.currencyNotesCV cellForItemAtIndexPath:index];
        UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
        cell.iconImage.image = chosenImage;
        [self.notesImageArray replaceObjectAtIndex:index.row withObject:chosenImage];
        [self.currencyNotesCV reloadData];
    }
    else if(pickerFlag==2)
    {
        coinsCollectionViewCell *cell=(coinsCollectionViewCell *)[self.currencyCoinsCV cellForItemAtIndexPath:index];
        
        
        UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
        cell.iconImage.image = chosenImage;
        [self.coinsImageArray replaceObjectAtIndex:index.row withObject:chosenImage];
        [self.currencyCoinsCV reloadData];
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)denominationEndEditing:(id)sender//Got response when notes denomination text end editing
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.currencyNotesCV];
    NSIndexPath *inPath= [self.currencyNotesCV indexPathForItemAtPoint:buttonPosition];
    notesCollectionViewCell *cell=(notesCollectionViewCell *)[self.currencyNotesCV cellForItemAtIndexPath:inPath];
    float amount=[cell.notesText.text floatValue];
    if (!(amount == 0)) {
        NSString *value=[NSString stringWithFormat:@"%.1f",amount];
        cell.notesText.text=value;
        [self.notesArray replaceObjectAtIndex:inPath.row withObject:cell.notesText.text];
        [self.currencyNotesCV reloadData];
    }
    
}

-(IBAction)coinsDenominationEndEditing:(id)sender //Got response when coins denomination text end editing
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.currencyCoinsCV];
    NSIndexPath *inPath= [self.currencyCoinsCV indexPathForItemAtPoint:buttonPosition];
    coinsCollectionViewCell *cell=(coinsCollectionViewCell *)[self.currencyCoinsCV cellForItemAtIndexPath:inPath];

    float amount=[cell.coinsText.text floatValue];
    if (!(amount == 0)) {
        NSString *value=[NSString stringWithFormat:@"%.1f",amount];
        cell.coinsText.text=value;
        [self.coinsArray replaceObjectAtIndex:inPath.row withObject:cell.coinsText.text];
        [self.currencyCoinsCV reloadData];
    }
    
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
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


@end
