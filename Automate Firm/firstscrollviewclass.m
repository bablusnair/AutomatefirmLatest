//
//  firstscrollviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/9/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "firstscrollviewclass.h"

//#import "assetTableViewCell.h"
@implementation firstscrollviewclass
@synthesize firstArray,firstTableView,secondArray,secondTableView;
-(void)awakeFromNib
{
    self.firstArray=[[NSMutableArray alloc]initWithObjects:@"Housing",@"Entertainment",@"Medical Insurance",@"Children's Education",@"Vehicle", nil];
    self.secondArray=[[NSMutableArray alloc]initWithObjects:@"Provident Fund",@"ESI",@"Professional Taxes",@"Income Tax",@"Vehicle", nil];
    
    self.x=0;
    
    NSData *newData = [[NSUserDefaults standardUserDefaults] objectForKey:@"employeewholeDetails"];
    NSDictionary *employeedictdetails = [NSKeyedUnarchiver unarchiveObjectWithData:newData];
    
    self.detailsDict=[[NSMutableDictionary alloc]init];
    self.detailsDict = [employeedictdetails objectForKey:@"basic_info"];
    
    [self displayDetails];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==firstTableView) {
        return self.firstArray.count;
    }
    else
    {
        return self.secondArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==firstTableView)
    {
        newearningscellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"newearningscell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        cell.mylabel.text=[self.firstArray objectAtIndex:indexPath.row];
        return cell;
   }
    else
    {
        newearningscellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"newearningscell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        cell.mylabel.text=[self.secondArray objectAtIndex:indexPath.row];
        return cell;
    }
}
-(IBAction)addnewActions:(id)sender

{
//    UIButton *mybutton=(UIButton *)sender;
//    if (mybutton.tag==1)
//    {
//        NSInteger row = 0;
//        NSInteger section = 0;
//        [self.thirdArray insertObject:@"Add New" atIndex:row];
//        NSIndexPath *myindexpath = [NSIndexPath indexPathForRow:row inSection:section];
//        [self.thirdTableView beginUpdates];
//        [self.thirdTableView insertRowsAtIndexPaths:@[myindexpath] withRowAnimation:UITableViewRowAnimationMiddle];
//        [self.thirdTableView endUpdates];
//    }
//    else
//    {
//        NSInteger row = 0;
//        NSInteger section = 0;
//        [self.fourthArray insertObject:@"Add" atIndex:row];
//        NSIndexPath *myindexpath = [NSIndexPath indexPathForRow:row inSection:section];
//        [self.fourthTableView beginUpdates];
//        [self.fourthTableView insertRowsAtIndexPaths:@[myindexpath] withRowAnimation:UITableViewRowAnimationMiddle];
//        [self.fourthTableView endUpdates];
//    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}



-(void)displayDetails
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        self.salaryLabel.text=[self.detailsDict objectForKey:@"emp_month_salary"];
        if ([self.detailsDict objectForKey:@"bank_name"]!=(id)[NSNull null]) {
            self.bankNameLabel.text=[self.detailsDict objectForKey:@"bank_name"];
        }
        else
            self.bankNameLabel.text=@"";
        
        
        self.bankAccountNoLabel.text=[self.detailsDict objectForKey:@"emp_bank_acc_no"];
        self.pfNoLabel.text=[self.detailsDict objectForKey:@"emp_provident_fund"];
        self.incomeTaxLabel.text=[self.detailsDict objectForKey:@"emp_income_tax_no"];
        self.nationalIDLabel.text=[self.detailsDict objectForKey:@"emp_national_id"];
        
        self.passportNoLabel.text=[self.detailsDict objectForKey:@"emp_passport_no"];
        
        NSDateFormatter *df=[[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd"];
        NSDate *date1=[df dateFromString:[self.detailsDict objectForKey:@"emp_visa_expiry"]];
        [df setDateFormat:@"dd MMM yyyy"];
        
        self.visaExpiryLabel.text=[df stringFromDate:date1];
        self.labourCardLabel.text=[self.detailsDict objectForKey:@"emp_labour_card_no"];
        

    });
}
@end
