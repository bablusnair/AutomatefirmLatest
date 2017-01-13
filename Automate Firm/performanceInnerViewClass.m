//
//  performanceInnerViewClass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 29/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "performanceInnerViewClass.h"
#import "performanceEvaluationTableViewCell.h"
#import "performanceEvaluationTile.h"
@implementation performanceInnerViewClass
-(void)awakeFromNib
{
    self.inputQuestionArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.mandatoryIconArray=[[NSMutableArray alloc]initWithObjects:@"J_red.png", nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.inputQuestionArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    performanceEvaluationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"performanceEvaluationTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    cell.inputView.text=[self.inputQuestionArray objectAtIndex:indexPath.row];
    
    if ([cell.inputView.text isEqualToString:@""]) {
        cell.inputView.text=@"Input Question";
        cell.inputView.textColor=[UIColor lightGrayColor];
    }
    cell.inputView.delegate=self;
    [cell.mandatoryButton setImage:[UIImage imageNamed:[self.mandatoryIconArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    return  cell;
}
-(IBAction)saveButtonAction:(id)sender
{
    performanceEvaluationTile *ob = (performanceEvaluationTile *)self.superview.superview;
    
    [ob addaccordianview];
}
-(IBAction)mandatoryButtonAction:(id)sender
{
    performanceEvaluationTableViewCell *cell1 = (performanceEvaluationTableViewCell *)[[[sender superview] superview ]superview];
    NSIndexPath *myindex=[self.inputTC indexPathForCell:cell1];
    if ([[self.mandatoryIconArray objectAtIndex:myindex.row]isEqualToString:@"J_red.png"]) {
        [self.mandatoryIconArray replaceObjectAtIndex:myindex.row withObject:@"J_black.png"];
    }
    else
    {
        [self.mandatoryIconArray replaceObjectAtIndex:myindex.row withObject:@"J_red.png"];
    }
    [self.inputTC reloadData];
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    performanceEvaluationTableViewCell *cell1 = (performanceEvaluationTableViewCell *)[[[textView superview] superview] superview];
    //NSIndexPath *myindex=[self.inputTC indexPathForCell:cell1];
    if ([cell1.inputView.text isEqualToString:@"Input Question"]) {
        cell1.inputView.text=@"";
    }
    cell1.inputView.textColor=[UIColor blackColor];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    performanceEvaluationTableViewCell *cell1 = (performanceEvaluationTableViewCell *)[[[textView superview] superview] superview];
    NSIndexPath *myindex=[self.inputTC indexPathForCell:cell1];
    
    if (cell1.inputView.text.length > 0) {
        [self.inputQuestionArray insertObject:cell1.inputView.text atIndex:myindex.row];
        [self.mandatoryIconArray addObject:@"J_red.png"];
        
        
        
    }
    else
    {
        cell1.inputView.text=@"Input Question";
        cell1.inputView.textColor=[UIColor lightGrayColor];
    }
    
    
    
    return  YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    NSArray *visibleItems = [self.inputTC indexPathsForVisibleRows];
    [self.inputTC reloadData];
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.inputQuestionArray.count - 1 inSection:currentItem.section];
    //[self.inputTC scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.inputTC scrollToRowAtIndexPath:nextItem atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [self.inputTC reloadData];
}
@end
