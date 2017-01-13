//
//  settingsViewController.m
//  
//
//  Created by leonine on 12/10/15.
//
//

#import "settingsViewController.h"
#import "attendancesettingsviewclass.h"
#import "officesetupmainview.h"
#import "delegateViewsClass.h"
#import "borrowingSettingsViewClass.h"
#import "generalsettingsmainclass.h"
#import "documentationSettingsViewClass.h"
#import "payrollSettingsViewsClass.h"
#import "settingsMainTableViewCell.h"

@interface settingsViewController ()

@end
@implementation settingsViewController
@synthesize k;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.myarray1=[[NSMutableArray alloc] initWithObjects:@"General",@"Office",@"Delegate", nil];
    self.myarray2=[[NSMutableArray alloc] initWithObjects:@"Attendance",@"Payroll",@"Borrowing", nil];
    self.myarray3=[[NSMutableArray alloc] initWithObjects:@"Paperworks", nil];
    
    self.generalarray2=[[NSMutableArray alloc] initWithObjects:@"general_white.png",@"office_whiteNew.png",@"deligate_white.png", nil];
    
    self.generalarray=[[NSMutableArray alloc] initWithObjects:@"general.png",@"officeSelected.png",@"deligate.png", nil];
    self.imagearraystaffing=[[NSMutableArray alloc] initWithObjects:@"attendance.png",@"payroll.png", @"borrowings.png",nil];
    
    self.imagearraystaffing2=[[NSMutableArray alloc] initWithObjects:@"attendance_white.png",@"payroll_white_new.png", @"borrowings_white.png",nil];
    self.settingsLabel.text=@"Attendance";
    
    
    NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"attendancesettingsview" owner:self options:Nil];
    [self.settingscontainsview addSubview:[nib objectAtIndex:0]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disabletableview) name:@"Tableview" object:Nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enabletableview) name:@"enabletable" object:Nil];
   
}


-(void)disabletableview
{
    
    [self.mytableview setUserInteractionEnabled:FALSE];
    
}


-(void)enabletableview
{
    
    [self.mytableview setUserInteractionEnabled:TRUE];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 3;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        
        return [self.myarray1 count];
    }
    
    else  if (section==1) {
        
        return [self.myarray2 count];
    }
    
    else
        
        return [self.myarray3 count];
    


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    settingsMainTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"settingsMainTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    if (indexPath.section==0) {
        //UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.nameLabel.text=[self.myarray1 objectAtIndex:indexPath.row];
        cell.iconImage.image=[UIImage imageNamed:[self.generalarray objectAtIndex:indexPath.row]];
        return cell;
    }
    else  if (indexPath.section==1) {
        
        //UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.nameLabel.text=[self.myarray2 objectAtIndex:indexPath.row];
        cell.iconImage.image=[UIImage imageNamed:[self.imagearraystaffing objectAtIndex:indexPath.row]];
        if(indexPath.row==0)
        {
            k=indexPath;
            cell.backView.backgroundColor=[UIColor colorWithRed:94.0/255.0 green:158.0/255.0 blue:230.0/255.0 alpha:1];
            cell.iconImage.image=[UIImage imageNamed:@"attendance_white.png"];
            cell.nameLabel.textColor=[UIColor whiteColor];
        }
        return cell;
        
    }
    else
    {
        //UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.nameLabel.text=[self.myarray3 objectAtIndex:indexPath.row];
        cell.iconImage.image=[UIImage imageNamed:@"paperwork.png"];
        return cell;
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
        return 35;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
        
        return 35;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
        return 40;
    

}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
        if (section==0) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
            return view;
        }
    
        else  if (section==1) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
            UIImageView *myimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            myimgview.image=[UIImage imageNamed:@"staffingpath.png"];
            [view addSubview:myimgview];
            UIImageView *myimgview2 = [[UIImageView alloc] initWithFrame:CGRectMake(11, 4, 29,28)];
            myimgview2.image=[UIImage imageNamed:@"staffing_white.png"];
            [myimgview addSubview:myimgview2];
            UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(51, 5, 220, 25)];
            titlelabel.text=@"Staffing";
            titlelabel.textColor=[UIColor whiteColor];
            titlelabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
            [myimgview addSubview:titlelabel];
            return view;
        }
        
        else
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
            UIImageView *myimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            myimgview.image=[UIImage imageNamed:@"staffingpath.png"];
            [view addSubview:myimgview];
            UIImageView *myimgview2 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 4, 26,26)];
            myimgview2.image=[UIImage imageNamed:@"documentation_white.png"];
            [myimgview addSubview:myimgview2];
            UILabel *titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(51, 5, 220, 25)];
            titlelabel.text=@"Documentation";
            titlelabel.textColor=[UIColor whiteColor];
            titlelabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
            [myimgview addSubview:titlelabel];
            
            return view;
            
        }
       
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    settingsMainTableViewCell *cell1=(settingsMainTableViewCell *)[self.mytableview cellForRowAtIndexPath:k];
    
    //UITableViewCell *cell1=(UITableViewCell *)[self.mytableview cellForRowAtIndexPath:k];
    cell1.backView.backgroundColor=[UIColor whiteColor];
    cell1.iconImage.image=[UIImage imageNamed:@"attendance.png"];
    cell1.nameLabel.textColor=[UIColor blackColor];
    
    //UITableViewCell *cell=(UITableViewCell *)[self.mytableview cellForRowAtIndexPath:indexPath];
    settingsMainTableViewCell *cell=(settingsMainTableViewCell *)[self.mytableview cellForRowAtIndexPath:indexPath];
    //UIView *bgColorView = [[UIView alloc] init];
    cell.backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"attendancerf.png"]];
    //[cell setSelectedBackgroundView:bgColorView];
    
    
    
    if (indexPath.section==0) {
        
        
        cell.iconImage.image=[UIImage imageNamed:[self.generalarray2 objectAtIndex:indexPath.row]];
        cell.nameLabel.textColor=[UIColor whiteColor];
        
        if(indexPath.row==0)
        {
            self.settingsLabel.text=@"General";
            
            
            for (UIView *myview in self.settingscontainsview.subviews) {
                
                if ([myview isKindOfClass:[officesetupmainview class]] || [myview isKindOfClass:[attendancesettingsviewclass class]] || [myview isKindOfClass:[delegateViewsClass class]] || [myview isKindOfClass:[borrowingSettingsViewClass class]] || [myview isKindOfClass:[generalsettingsmainclass class]]  || [myview isKindOfClass:[documentationSettingsViewClass class]] || [myview isKindOfClass:[payrollSettingsViewsClass class]]) {
                    
                    [myview removeFromSuperview];
                }
                
            }
            
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"generalsettingsmainview" owner:self options:Nil];
            
            [self.settingscontainsview addSubview:[nib objectAtIndex:0]];

        }
        else if (indexPath.row==1)
            
        {
            self.settingsLabel.text=@"Office";
            for (UIView *myview in self.settingscontainsview.subviews) {
                
                if ([myview isKindOfClass:[officesetupmainview class]] || [myview isKindOfClass:[attendancesettingsviewclass class]] || [myview isKindOfClass:[delegateViewsClass class]] || [myview isKindOfClass:[borrowingSettingsViewClass class]] || [myview isKindOfClass:[generalsettingsmainclass class]] || [myview isKindOfClass:[documentationSettingsViewClass class]] || [myview isKindOfClass:[payrollSettingsViewsClass class]]) {
                    
                    [myview removeFromSuperview];
                }
                
            }
            
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"officesetupviews" owner:self options:Nil];
            
            [self.settingscontainsview addSubview:[nib objectAtIndex:0]];

            
        }
        else
        {
            
            self.settingsLabel.text=@"Delegate";
            
            for (UIView *myview in self.settingscontainsview.subviews) {
                
                if ([myview isKindOfClass:[officesetupmainview class]] || [myview isKindOfClass:[attendancesettingsviewclass class]] || [myview isKindOfClass:[delegateViewsClass class]] || [myview isKindOfClass:[borrowingSettingsViewClass class]] || [myview isKindOfClass:[generalsettingsmainclass class]] || [myview isKindOfClass:[documentationSettingsViewClass class]] || [myview isKindOfClass:[payrollSettingsViewsClass class]]) {
                    
                    [myview removeFromSuperview];
                }
                
            }
            
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"delegateViews" owner:self options:Nil];
            [self.settingscontainsview addSubview:[nib objectAtIndex:0]];
            
        }

    }
    
    
    if (indexPath.section==1) {
        
        cell.iconImage.image=[UIImage imageNamed:[self.imagearraystaffing2 objectAtIndex:indexPath.row]];
        cell.nameLabel.textColor=[UIColor whiteColor];
        if(indexPath.row==0)
        {
            self.settingsLabel.text=@"Attendance";
            
            for (UIView *myview in self.settingscontainsview.subviews) {
                if ([myview isKindOfClass:[officesetupmainview class]] || [myview isKindOfClass:[attendancesettingsviewclass class]] || [myview isKindOfClass:[delegateViewsClass class]] || [myview isKindOfClass:[borrowingSettingsViewClass class]] || [myview isKindOfClass:[generalsettingsmainclass class]] || [myview isKindOfClass:[documentationSettingsViewClass class]] || [myview isKindOfClass:[payrollSettingsViewsClass class]]) {
                    
                    [myview removeFromSuperview];
                }
                
            }
            
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"attendancesettingsview" owner:self options:Nil];
            [self.settingscontainsview addSubview:[nib objectAtIndex:0]];
        }
        else if (indexPath.row==1)
            
        {
            
            self.settingsLabel.text=@"Payroll";
            
            for (UIView *myview in self.settingscontainsview.subviews) {
                if ([myview isKindOfClass:[officesetupmainview class]] || [myview isKindOfClass:[attendancesettingsviewclass class]] || [myview isKindOfClass:[delegateViewsClass class]] || [myview isKindOfClass:[borrowingSettingsViewClass class]] || [myview isKindOfClass:[generalsettingsmainclass class]] || [myview isKindOfClass:[documentationSettingsViewClass class]] || [myview isKindOfClass:[payrollSettingsViewsClass class]]) {
                    
                    [myview removeFromSuperview];
                }
                
            }
            
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"payrollSettingsView" owner:self options:Nil];
            [self.settingscontainsview addSubview:[nib objectAtIndex:0]];
           
        }
        else
        {
            self.settingsLabel.text=@"Borrowings";
            for (UIView *myview in self.settingscontainsview.subviews) {
                
                if ([myview isKindOfClass:[officesetupmainview class]] || [myview isKindOfClass:[attendancesettingsviewclass class]] || [myview isKindOfClass:[delegateViewsClass class]] || [myview isKindOfClass:[borrowingSettingsViewClass class]] || [myview isKindOfClass:[generalsettingsmainclass class]] || [myview isKindOfClass:[documentationSettingsViewClass class]] || [myview isKindOfClass:[payrollSettingsViewsClass class]]) {
                    
                    [myview removeFromSuperview];
                }
                
            }
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"borrowingSettingsView" owner:self options:Nil];
            [self.settingscontainsview addSubview:[nib objectAtIndex:0]];
            
            
        }
        
    }
    
    if (indexPath.section==2) {
        
        cell.iconImage.image=[UIImage imageNamed:@"paperwork_white.png"];
        cell.nameLabel.textColor=[UIColor whiteColor];
        
        if(indexPath.row==0)
        {
            self.settingsLabel.text=@"Paperworks";
            
            for (UIView *myview in self.settingscontainsview.subviews) {
                
                if ([myview isKindOfClass:[officesetupmainview class]] || [myview isKindOfClass:[attendancesettingsviewclass class]] || [myview isKindOfClass:[delegateViewsClass class]] || [myview isKindOfClass:[borrowingSettingsViewClass class]] || [myview isKindOfClass:[generalsettingsmainclass class]] || [myview isKindOfClass:[documentationSettingsViewClass class]] || [myview isKindOfClass:[payrollSettingsViewsClass class]]) {
                    
                    [myview removeFromSuperview];
                }
                
            }
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"documentationSettingsView" owner:self options:Nil];
            [self.settingscontainsview addSubview:[nib objectAtIndex:0]];
        }

    }
    
}




-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    settingsMainTableViewCell *cell=(settingsMainTableViewCell *)[self.mytableview cellForRowAtIndexPath:indexPath];
    
    //UITableViewCell *cell=(UITableViewCell *)[self.mytableview cellForRowAtIndexPath:indexPath];
    //UIView *bgColorView = [[UIView alloc] init];
    //bgColorView.backgroundColor = [UIColor blackColor];
    //[cell setSelectedBackgroundView:bgColorView];
    cell.backView.backgroundColor=[UIColor whiteColor];
    
    
    if (indexPath.section==0) {
        cell.iconImage.image=[UIImage imageNamed:[self.generalarray objectAtIndex:indexPath.row]];
        cell.nameLabel.textColor=[UIColor blackColor];
    }
    if (indexPath.section==1) {
        cell.iconImage.image=[UIImage imageNamed:[self.imagearraystaffing objectAtIndex:indexPath.row]];
        cell.nameLabel.textColor=[UIColor blackColor];
        
    }
    if (indexPath.section==2) {
        cell.iconImage.image=[UIImage imageNamed:@"paperwork.png"];
        cell.nameLabel.textColor=[UIColor blackColor];
    }
    
}







@end
