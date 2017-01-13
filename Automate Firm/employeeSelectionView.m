//
//  employeeSelectionView.m
//  Automate Firm
//
//  Created by leonine on 6/22/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "employeeSelectionView.h"
#import "SerachListingEmployeeView.h"
#import "selectedEmployeeListingView.h"
#import <QuartzCore/QuartzCore.h>
@implementation employeeSelectionView
@synthesize x;
-(void)awakeFromNib
{
    self.frame=CGRectMake(150, 110, self.frame.size.width, self.frame.size.height);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-400, -300, 1400, 1000)];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
    
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    
    x=0;
    self.flag=0;
    self.nameArray=[[NSMutableArray alloc] init];
    self.filterarray=[[NSMutableArray alloc]init];
    
    
    
    self.maindictionary=[[NSMutableDictionary alloc] init];
    

    
    self.nameArray=[[self.maindictionary allKeys] mutableCopy];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupType"]isEqualToString:@"expense"]) {
        
        [self.myconnection employeeListingAccordingToType:@"expense" :[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupType"]isEqualToString:@"advance"])
    {
        [self.myconnection employeeListingAccordingToType:@"advance" :[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupType"]isEqualToString:@"fine"])
    {
        [self.myconnection listingAllEmployeesForFine:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupType"]isEqualToString:@"loan"])
    {
        [self.myconnection employeeListingAccordingToType:@"loan" :[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (x==1) {
        return self.filterarray.count;
    }
    else
        return self.nameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SerachListingEmployeeView *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"SerachListingEmployeeView" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    cell.myImage.layer.cornerRadius = 25;
    cell.myImage.layer.masksToBounds = YES;
    if (x==1) {
        
        
        NSMutableArray *loadarray=[self.maindictionary objectForKey:[self.filterarray objectAtIndex:indexPath.row]];
        cell.empID=[loadarray objectAtIndex:0];
        if (!([[loadarray objectAtIndex:1]isEqualToString:@""])) {
            NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[loadarray objectAtIndex:1] options:0];
            
            cell.myImage.image=[UIImage imageWithData:decodedData];
        }
        else
        {
            cell.myImage.image=[UIImage imageNamed:@"user.png"];
        }
        
        
        cell.nameLabel.text=[loadarray objectAtIndex:2];
        cell.desigLabel.text=[loadarray objectAtIndex:3];
        cell.empIDLabel.text=[loadarray objectAtIndex:4];
        cell.unitLabel.text=[loadarray objectAtIndex:5];
    }
    else
    {
        NSMutableArray *loadarray=[self.maindictionary objectForKey:[self.nameArray objectAtIndex:indexPath.row]];
        
        
        cell.empID=[loadarray objectAtIndex:0];
        if (!([[loadarray objectAtIndex:1]isEqualToString:@""])) {
            NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[loadarray objectAtIndex:1] options:0];
            
            cell.myImage.image=[UIImage imageWithData:decodedData];
        }
        else
        {
            cell.myImage.image=[UIImage imageNamed:@"user.png"];
        }
        
        
        cell.nameLabel.text=[loadarray objectAtIndex:2];
        cell.desigLabel.text=[loadarray objectAtIndex:3];
        cell.empIDLabel.text=[loadarray objectAtIndex:4];
        cell.unitLabel.text=[loadarray objectAtIndex:5];
        
    }
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SerachListingEmployeeView *cell=[self.myTableView cellForRowAtIndexPath:indexPath];
    [cell setAlpha:0.6];
    cell.userInteractionEnabled=NO;
    NSMutableArray *empArray=[self.maindictionary objectForKey:cell.nameLabel.text];
    [[NSUserDefaults standardUserDefaults]setObject:empArray forKey:@"selectedEmp"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"empSelection" object:Nil];
    [self removeFromSuperview];
    
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.searchTextField) {
        x=1;
        self.myTableView.hidden=FALSE;
        //   NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",[self.mytextfield.text stringByReplacingCharactersInRange:range withString:string]];
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.searchTextField.text stringByReplacingCharactersInRange:range withString:string]];
        self.filterarray = [[self.nameArray filteredArrayUsingPredicate:bPredicate] mutableCopy];
        [self.myTableView reloadData];
        
        if ([string isEqualToString:@""] && textField.text.length==1) {
            
            x=0;
            
            [self.myTableView reloadData];
            
        }
        
        return  YES;
    }
    else
    {
        return  YES;
    }
    return false;
    
    
}

-(IBAction)doneButtonAction:(id)sender
{
    [self removeFromSuperview];
}


//<<<-----------------------Service Got Response-------------------------->>>>

-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.maindictionary removeAllObjects];
        [self.filterarray removeAllObjects];
        [self.nameArray removeAllObjects];
        
        NSMutableArray *empDetailsArray=[responseData objectForKey:@"employee_details"];
        for (int i=0; i<empDetailsArray.count; i++) {
            NSMutableDictionary *empDict=[empDetailsArray objectAtIndex:i];
            NSMutableArray *empArray=[[NSMutableArray alloc]initWithObjects:[empDict objectForKey:@"emp_id"],[empDict objectForKey:@"emp_encode_image"],[empDict objectForKey:@"emp_name"],[empDict objectForKey:@"designation_title"],[empDict objectForKey:@"e_code"],[empDict objectForKey:@"working_premise"], nil];
            [self.maindictionary setObject:empArray forKey:[empDict objectForKey:@"emp_name"]];
        }
        self.nameArray=[[self.maindictionary allKeys]mutableCopy];
        
        [self.myTableView reloadData];
    });
    
}
-(void)viewAllResponse:(id)responseList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.maindictionary removeAllObjects];
        [self.filterarray removeAllObjects];
        [self.nameArray removeAllObjects];
        
        NSMutableArray *empDetailsArray=[responseList objectForKey:@"employee_details"];
        for (int i=0; i<empDetailsArray.count; i++) {
            NSMutableDictionary *empDict=[empDetailsArray objectAtIndex:i];
            NSMutableArray *empArray=[[NSMutableArray alloc]initWithObjects:[empDict objectForKey:@"emp_id"],[empDict objectForKey:@"emp_encode_image"],[empDict objectForKey:@"emp_name"],[empDict objectForKey:@"designation_title"],[empDict objectForKey:@"e_code"],[empDict objectForKey:@"working_premise"], nil];
            [self.maindictionary setObject:empArray forKey:[empDict objectForKey:@"emp_name"]];
        }
        self.nameArray=[[self.maindictionary allKeys]mutableCopy];
        
        [self.myTableView reloadData];
        
    });
}


@end
