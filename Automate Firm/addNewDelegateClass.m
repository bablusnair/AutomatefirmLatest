//
//  addNewDelegateClass.m
//  
//
//  Created by leonine on 10/8/15.
//
//

#import "addNewDelegateClass.h"
#import "moduleTableViewCell.h"
@implementation addNewDelegateClass

-(void)awakeFromNib
{
    self.moduleIconArray=[[NSMutableArray alloc]initWithObjects:@"officeDeselected.png",@"officeDeselected.png",@"officeDeselected.png",@"officeDeselected.png",@"officeDeselected.png",@"officeDeselected.png",@"officeDeselected.png",@"officeDeselected.png",@"officeDeselected.png", nil];
    self.moduleIconArray1=[[NSMutableArray alloc]initWithObjects:@"office_selected.png",@"office_selected.png",@"office_selected.png",@"office_selected.png",@"office_selected.png",@"office_selected.png",@"office_selected.png",@"office_selected.png",@"office_selected.png", nil];
     self.moduleArray=[[NSMutableArray alloc]initWithObjects:@"Accounts",@"Documents",@"Project",@"Staffing",@"Tasks",@"Inventory",@"Marketing",@"Surveillance",@"Settings", nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.moduleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    moduleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"moduleTableViewCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    cell.backImage.image=[UIImage imageNamed:@"bottom_left buttton.png"];
    cell.iconImage.image=[UIImage imageNamed:[self.moduleIconArray objectAtIndex:indexPath.row]];
    cell.nameLabel.text=[self.moduleArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    moduleTableViewCell *cell=(moduleTableViewCell *)[self.moduleTableView cellForRowAtIndexPath:indexPath];
    cell.backImage.image=[UIImage imageNamed:@"bottom_left buttton_selected.png"];
    cell.iconImage.image=[UIImage imageNamed:[self.moduleIconArray1 objectAtIndex: indexPath.row]];
    cell.nameLabel.textColor=[UIColor whiteColor];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    moduleTableViewCell *cell=(moduleTableViewCell *)[self.moduleTableView cellForRowAtIndexPath:indexPath];
    cell.backImage.image=[UIImage imageNamed:@"bottom_left buttton.png"];
    cell.iconImage.image=[UIImage imageNamed:[self.moduleIconArray objectAtIndex: indexPath.row]];
    cell.nameLabel.textColor=[UIColor blackColor];
}
-(IBAction)doneButtonAction:(id)sender
{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"settingsApplyDelegationView" owner:self options:nil];
    [self addSubview:[nib objectAtIndex:0]];
}
@end
