//
//  paperworkViewClass.m
//  bablusdemokpproject
//
//  Created by leonine on 9/5/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "paperworkViewClass.h"
#import "documentationFrontCellClass.h"
@implementation paperworkViewClass

-(void)awakeFromNib
{
    self.priorityimgarray=[[NSMutableArray alloc] initWithObjects:@"priority icon green1.png",@"priority icon red1.png",@"priority icon yellow1.png",@"priority icon green1.png",@"priority icon red1.png",@"priority icon yellow1.png",@"priority icon green1.png",@"priority icon red1.png",@"priority icon yellow1.png",@"priority icon green1.png",@"priority icon red1.png",@"priority icon yellow1.png",@"priority icon red1.png",@"priority icon yellow1.png",@"priority icon red1.png",@"priority icon green1.png",@"priority icon green1.png",@"priority icon green1.png",@"priority icon green1.png",@"priority icon green1.png", nil];
    self.statusLabelArray=[[NSMutableArray alloc] initWithObjects:@"Forwarded",@"Reverted",@"Forwarded",@"Forwarded",@"Reverted",@"Forwarded",@"Reverted",@"Forwarded",@"Forwarded",@"Reverted",@"Forwarded",@"Reverted",@"Forwarded",@"Forwarded",@"Reverted",@"Forwarded",@"Reverted",@"Forwarded",@"Forwarded",@"Reverted", nil];
    self.statusImageArray=[[NSMutableArray alloc] initWithObjects:@"forwarded_icon1.png",@"reverted_icon1.png",@"forwarded_icon1.png",@"forwarded_icon1.png",@"reverted_icon1.png",@"forwarded_icon1.png",@"reverted_icon1.png",@"forwarded_icon1.png",@"forwarded_icon1.png",@"reverted_icon1.png",@"forwarded_icon1.png",@"reverted_icon1.png",@"forwarded_icon1.png",@"forwarded_icon1.png",@"reverted_icon1.png",@"forwarded_icon1.png",@"reverted_icon1.png",@"forwarded_icon1.png",@"forwarded_icon1.png",@"reverted_icon1.png", nil];
    //self.priorityimgarray=[[NSMutableArray alloc]initWithObjects:@"priority_pending.png",@"priority_completed.png",@"priority_onhold.png",@"priority_pending.png",@"priority_completed.png",@"priority_onhold.png",@"priority_pending.png",@"priority_completed.png",@"priority_onhold.png",@"priority_pending.png",@"priority_completed.png",@"priority_onhold.png",@"priority_pending.png",@"priority_completed.png",@"priority_onhold.png",@"priority_pending.png",@"priority_completed.png",@"priority_onhold.png",@"priority_pending.png",@"priority_completed.png", nil];
    self.numberArray=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20", nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.priorityimgarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    documentationFrontCellClass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"documentationFrontCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    if (indexPath.row%2==0) {
        [cell.myImag setImage:[UIImage imageNamed:@"grey_rectangle11.png"]];
        //[cell.myImag setImage:[UIImage imageNamed:@""]];
    }
    else
    {
        [cell.myImag setImage:[UIImage imageNamed:@"white_rectangle11.png"]];
        //[cell.myImag setImage:[UIImage imageNamed:@""]];
        
        
    }
    cell.numberLabel.text=[self.numberArray objectAtIndex:indexPath.row];
    cell.statusLabel.text=[self.statusLabelArray objectAtIndex:indexPath.row];
    [cell.statusImage setImage:[UIImage imageNamed:[self.statusImageArray objectAtIndex:indexPath.row]]];
    [cell.priorityButton setImage:[UIImage imageNamed:[self.priorityimgarray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arry=[[NSBundle mainBundle]loadNibNamed:@"documentationFormCreationView" owner:self options:nil];
    [self.superview addSubview:[arry objectAtIndex:0]];
}




@end
