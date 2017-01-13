//
//  addNewDelegateClass.m
//  
//
//  Created by leonine on 10/8/15.
//
//

#import "addNewDelegatesClass.h"
#import "moduleTableViewsCell.h"
@implementation addNewDelegatesClass
@synthesize x,y;
-(void)awakeFromNib
{
    self.moduleIconArray=[[NSMutableArray alloc]initWithObjects:@"officeDeselected.png",@"officeDeselected.png",@"officeDeselected.png",@"officeDeselected.png", nil];
    self.moduleIconArray1=[[NSMutableArray alloc]initWithObjects:@"office_selected.png",@"office_selected.png",@"office_selected.png",@"office_selected.png", nil];
//     self.moduleArray=[[NSMutableArray alloc]initWithObjects:@"Accounts",@"Documents",@"Project",@"Staffing",@"Tasks",@"Inventory",@"Marketing",@"Surveillance",@"Settings", nil];
    self.moduleArray=[[NSMutableArray alloc]initWithObjects:@"Settings",@"Documents",@"Staffing",@"Accounts", nil];

    x=0;y=0;
    self.deleagteCheckButton.userInteractionEnabled=NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.moduleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    moduleTableViewsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"moduleTableViewsCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
//    if (indexPath.row==0) {
//        cell.backImage.image=[UIImage imageNamed:@"bottom_left buttton_selected.png"];
//        cell.nameLabel.textColor=[UIColor whiteColor];
//        cell.iconImage.image=[UIImage imageNamed:[self.moduleIconArray1 objectAtIndex: indexPath.row]];
//
//    }
  //  else{
        cell.backImage.image=[UIImage imageNamed:@"bottom_left buttton.png"];
        cell.iconImage.image=[UIImage imageNamed:[self.moduleIconArray objectAtIndex:indexPath.row]];
 //   }
    
    cell.nameLabel.text=[self.moduleArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    moduleTableViewsCell *cell=(moduleTableViewsCell *)[self.moduleTableView cellForRowAtIndexPath:indexPath];
   
    cell.backImage.image=[UIImage imageNamed:@"bottom_left buttton_selected.png"];
    cell.iconImage.image=[UIImage imageNamed:[self.moduleIconArray1 objectAtIndex: indexPath.row]];
    cell.nameLabel.textColor=[UIColor whiteColor];
    switch (indexPath.row) {
        case 0:
            
            
            [self.delgateScroll setContentOffset:CGPointMake(0,0) animated:YES];
            self.delgateScroll.scrollEnabled=false;
            break;
        case 2:
            [self.delgateScroll setContentOffset:CGPointMake(0, 430) animated:YES];
            self.delgateScroll.scrollEnabled=false;

            break;
            
        default:
            break;
    }

}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
      moduleTableViewsCell *cell=(moduleTableViewsCell *)[self.moduleTableView cellForRowAtIndexPath:indexPath];
    
    cell.backImage.image=[UIImage imageNamed:@"bottom_left buttton.png"];
    cell.iconImage.image=[UIImage imageNamed:[self.moduleIconArray objectAtIndex: indexPath.row]];
    cell.nameLabel.textColor=[UIColor blackColor];
  
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView==self.createOnlyText) {
        if (self.x%2==0)
        {
            [self.createOnlyButton setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            self.deleagteCheckButton.userInteractionEnabled=NO;
            self.applyDesignationButton.userInteractionEnabled=NO;
            self.assignEmployeeButton.userInteractionEnabled=NO;
            self.deleagteCheckButton.backgroundColor=[UIColor lightGrayColor];
            self.x++;
        }
        else {
            [self.createOnlyButton setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            self.deleagteCheckButton.userInteractionEnabled=YES;
            self.applyDesignationButton.userInteractionEnabled=YES;
            self.assignEmployeeButton.userInteractionEnabled=YES;
            self.deleagteCheckButton.backgroundColor=[UIColor clearColor];
            self.x++;
        }

        return  NO;
    }
    else if (textView==self.applyToDesignationText)
    {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"settingsApplyDelegationViews" owner:self options:nil];
        [self addSubview:[nib objectAtIndex:0]];
        return  NO;
    }
    else if (textView==self.assignEmployeeText)
    {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"assignToSpecificEmployeeView" owner:self options:nil];
        [self addSubview:[nib objectAtIndex:0]];
        return  NO;
    }
    else
    {
        if (self.y%2==0) {
            [self.deleagteCheckButton setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
            self.y++;
        }
        else
        {
            [self.deleagteCheckButton setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
            self.y++;
        }
        return NO;
    }
}
-(IBAction)doneButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableoffice" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}
-(IBAction) cancelButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableoffice" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
    
}
-(IBAction)applyToDesignationAction:(id)sender
{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"settingsApplyDelegationViews" owner:self options:nil];
    [self addSubview:[nib objectAtIndex:0]];
}
-(IBAction)applyTospecificEmployeeAction:(id)sender
{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"assignToSpecificEmployeeView" owner:self options:nil];
    [self addSubview:[nib objectAtIndex:0]];
}
-(IBAction)radioButtonAction:(id)sender
{
    if (self.x%2==0) {
        [self.createOnlyButton setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        self.deleagteCheckButton.userInteractionEnabled=NO;
        self.applyDesignationButton.userInteractionEnabled=NO;
        self.assignEmployeeButton.userInteractionEnabled=NO;
        self.deleagteCheckButton.backgroundColor=[UIColor lightGrayColor];
        self.x++;
    }
    else {
        [self.createOnlyButton setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
        self.deleagteCheckButton.userInteractionEnabled=YES;
        self.applyDesignationButton.userInteractionEnabled=YES;
        self.assignEmployeeButton.userInteractionEnabled=YES;
        self.deleagteCheckButton.backgroundColor=[UIColor clearColor];
        self.x++;
    }
}
-(IBAction)checkButtonAction:(id)sender
{
    if (self.y%2==0) {
        [self.deleagteCheckButton setImage:[UIImage imageNamed:@"check_box_tick.png"] forState:UIControlStateNormal];
        self.y++;
    }
    else
    {
        [self.deleagteCheckButton setImage:[UIImage imageNamed:@"check_box_blank.png"] forState:UIControlStateNormal];
        self.y++;
    }

   
}
-(void)willRemoveSubview:(UIView *)subview
{
    

    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"doneAction"] isEqualToString:@"assignEmployee"]) {
        
        self.deleagteCheckButton.userInteractionEnabled=YES;
        self.deleagteCheckButton.backgroundColor=[UIColor clearColor];
        
    }
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"doneAction"] isEqualToString:@"applyDesignation"]) {
        self.deleagteCheckButton.userInteractionEnabled=YES;
        self.deleagteCheckButton.backgroundColor=[UIColor clearColor];
    }
}
- (IBAction)addDocSubVIew:(id)sender
{
    switch ([sender tag]) {
            
        case 1:
            self.docmntSubView.hidden=false;
            break;
        case 2:
            self.shiftSubView.hidden=false;
            break;
        case 3:
            self.empDetailSubview.hidden=false;
            break;
        case 4:
            self.timeCardSubview.hidden=false;
            self.empDetailViewBtn.frame=CGRectMake(263, 499, 21, 18);
            self.empdetailLabelButn.frame=CGRectMake(286, 497, 102, 20);
            self.empDetailSubview.frame=CGRectMake(292, 515, 148, 122);
            break;

        default:
            break;
    }
    
}
@end
