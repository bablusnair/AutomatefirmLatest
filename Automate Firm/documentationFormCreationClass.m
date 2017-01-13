//
//  documentationFormCreationClass.m
//  Automate Firm
//
//  Created by leonine on 6/16/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "documentationFormCreationClass.h"
#import "documentflowcellclass.h"
#import "documentsRemarksTableCell.h"
#import "pjtgenatedcustumviewclass.h"
#import "documentationIndividualSelectionViewClass.h"
#import "leaveFormViewClass.h"
#import "advanceFormClass.h"
@implementation documentationFormCreationClass

- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)awakeFromNib
{
    self.firstArray=[[NSMutableArray alloc] initWithObjects:@"The govt. attestation document is not attached",@"I request you to pls do the needy",@"Attach the medical report", nil];
    
    self.firstView.hidden=TRUE;
    
    self.toArray=[[NSMutableArray alloc] initWithObjects:@"Alex Fernando, Asst.Manager",@"Ivan Ronald, Finance Human Resource",@"Ryan Harris, Marketing Manager",@"Sam Johnson, Salesman",@"Johnathan Francis, Accountant", nil];
    self.fromArray=[[NSMutableArray alloc]initWithObjects:@"Alex, Human Resource,Marketing",@"Edward, Managing Director",@"Francis, Human Resource, Production",@"Irin Thomas, CEO",@"Jacob John,HR Admin", nil];
    self.toTableView.hidden=TRUE;
    self.datePickerView.hidden=TRUE;
    [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[UIDatePicker class]]]
     setBackgroundColor:[UIColor clearColor]];
    self.x=0;
    self.y=0;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.firstTableView) {
        
        return self.firstArray.count;
    }
    else if(tableView==self.secondTableView)
        return 10;
    else{//if (tableView==self.toTableView) {
        return self.toArray.count;
    }
    
    
    
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
    else if(tableView==self.secondTableView)
    {
        
        documentflowcellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"simlecell2"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"documentflowtablecell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        return cell;
        
        
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        if (tableView==self.toTableView) {
            cell.textLabel.text=[self.toArray objectAtIndex:indexPath.row];
        }
//        else
//        {
//            cell.textLabel.text=[self.fromArray objectAtIndex:indexPath.row];
//        }
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.toTableView) {
        self.toTextView.text=[self.toArray objectAtIndex:indexPath.row];
        self.toTableView.hidden=TRUE;
    }
    
}

-(IBAction)tileButtonClicked:(id)sender
{
    if (self.x1%2==0) {
        self.firstView.hidden=FALSE;
        self.x1++;
        
    }
    else
    {
        self.firstView.hidden=TRUE;
        self.x1++;
    }
}

-(IBAction)closeButton:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        self.toView.hidden=TRUE;
        button.hidden=TRUE;
        self.toLabel.hidden=TRUE;
        self.combo1.hidden=TRUE;
        self.x=1;
        self.subjectView.frame=CGRectMake(self.subjectView.frame.origin.x, 74, self.subjectView.frame.size.width, self.subjectView.frame.size.height);
        self.subjectLabel.frame=CGRectMake(self.subjectLabel.frame.origin.x, 51, self.subjectLabel.frame.size.width, self.subjectLabel.frame.size.height);
        self.subjectButton.frame=CGRectMake(self.subjectButton.frame.origin.x, 51, self.subjectButton.frame.size.width, self.subjectButton.frame.size.height);
        self.messageRemainingView.frame=CGRectMake(self.messageRemainingView.frame.origin.x, 124, self.messageRemainingView.frame.size.width, self.messageRemainingView.frame.size.height);
        
    }
    else if(button.tag==2)
    {
        self.fromView.hidden=TRUE;
        button.hidden=TRUE;
        self.fromLabel.hidden=TRUE;
    }
    else
    {
        self.subjectView.hidden=TRUE;
        button.hidden=TRUE;
        self.subjectLabel.hidden=TRUE;
        if (self.x==0) {
            self.messageRemainingView.frame=CGRectMake(self.messageRemainingView.frame.origin.x, 201, self.messageRemainingView.frame.size.width, self.messageRemainingView.frame.size.height);
        }
        else
        {
            self.messageRemainingView.frame=CGRectMake(self.messageRemainingView.frame.origin.x, 74, self.messageRemainingView.frame.size.width, self.messageRemainingView.frame.size.height);
        }
    }
}

-(IBAction)dropDown1Action:(id)sender
{
    self.toTableView.hidden=false;
}

-(IBAction)datePickerAction:(id)sender
{
    
    NSDate *myDate = self.datePicker.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    
    self.dateText.text=prettyVersion;
    self.datePickerView.hidden=TRUE;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.dateText) {
        self.datePickerView.hidden=FALSE;
        
    }
    return NO;
}
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
    [self.priorityButton1 setImage:[UIImage imageNamed:@"priority icon yellow.png"] forState:UIControlStateNormal];
    [self.priorityButton2 setImage:[UIImage imageNamed:@"priority icon green unclick.png"] forState:UIControlStateNormal];
    [self.priorityButton3 setImage:[UIImage imageNamed:@"priority icon red unclick.png"] forState:UIControlStateNormal];
}
-(IBAction)prioritybutton2action:(id)sender
{
    [self.priorityButton1 setImage:[UIImage imageNamed:@"priority icon yellow unclick.png"] forState:UIControlStateNormal];
    [self.priorityButton2 setImage:[UIImage imageNamed:@"priority icon green.png"] forState:UIControlStateNormal];
    [self.priorityButton3 setImage:[UIImage imageNamed:@"priority icon red unclick.png"] forState:UIControlStateNormal];
}
-(IBAction)prioritybutton3action:(id)sender
{
    [self.priorityButton1 setImage:[UIImage imageNamed:@"priority icon yellow unclick.png"] forState:UIControlStateNormal];
    [self.priorityButton2 setImage:[UIImage imageNamed:@"priority icon green unclick.png"] forState:UIControlStateNormal];
    [self.priorityButton3 setImage:[UIImage imageNamed:@"priority icon red.png"] forState:UIControlStateNormal];
}


@end
