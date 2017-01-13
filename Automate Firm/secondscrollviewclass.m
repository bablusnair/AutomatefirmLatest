//
//  secondscrollviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/9/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "secondscrollviewclass.h"
#import "educationTableViewCell.h"
@implementation secondscrollviewclass
@synthesize degreeArray,institutionArray,descriptionArray,experienceArray,levelArray;

-(void)awakeFromNib
{
    self.degreeArray=[[NSMutableArray alloc]init];
    self.institutionArray=[[NSMutableArray alloc]init];
    self.yearArray=[[NSMutableArray alloc]init];
    self.descriptionArray=[[NSMutableArray alloc]init];
    self.experienceArray=[[NSMutableArray alloc]init];
    self.levelArray=[[NSMutableArray alloc]init];
    
    NSData *newData = [[NSUserDefaults standardUserDefaults] objectForKey:@"employeewholeDetails"];
    NSDictionary *employeedictdetails = [NSKeyedUnarchiver unarchiveObjectWithData:newData];
    
    self.detailsDict=[[NSMutableDictionary alloc]init];
    self.detailsDict = [employeedictdetails objectForKey:@"basic_info"];
    self.educationArray=[[NSMutableArray alloc]initWithArray:[employeedictdetails objectForKey:@"education"]];
    self.skillsArray=[[NSMutableArray alloc]initWithArray:[employeedictdetails objectForKey:@"skill"]];
    
    [self displayDetails];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.firstTableView) {
        
        return self.degreeArray.count;
    }
    else
        return self.descriptionArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.firstTableView)
    {
        educationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"educationTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.dgreelLabel.text=[self.degreeArray objectAtIndex:indexPath.row];
        cell.institutionLabel.text=[self.institutionArray objectAtIndex:indexPath.row];
        cell.yearLabel.text=[self.yearArray objectAtIndex:indexPath.row];
        return cell;
    }
    else
    {
        secondscrollfirstcellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil)
        {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"secondscrollfirstcell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.dgreelLabel.text=[self.descriptionArray objectAtIndex:indexPath.row];
        cell.institutionLabel.text=[NSString stringWithFormat:@"%@ Year",[self.experienceArray objectAtIndex:indexPath.row]];
        cell.yearLabel.text=[NSString stringWithFormat:@"%@/10",[self.levelArray objectAtIndex:indexPath.row]];
        return cell;
    }
}

-(void)displayDetails
{
    
        [self.degreeArray removeAllObjects];
        [self.institutionArray removeAllObjects];
        [self.yearArray removeAllObjects];
        [self.descriptionArray removeAllObjects];
        [self.experienceArray removeAllObjects];
        [self.levelArray removeAllObjects];
        
        NSLog(@"%@",self.detailsDict);
        self.companyTelephone.text=[self.detailsDict objectForKey:@"emp_company_phone"];
        self.companyExt.text=[self.detailsDict objectForKey:@"emp_company_ph_ext"];
        self.companyMobile.text=[NSString stringWithFormat:@"+%@%@",[self.detailsDict objectForKey:@"cmp_mob_code"],[self.detailsDict objectForKey:@"emp_company_mobile"]];
        self.personalMobile.text=[NSString stringWithFormat:@"+%@%@",[self.detailsDict objectForKey:@"per_mob_code"],[self.detailsDict objectForKey:@"emp_personal_mobile"]];
        self.companyEmail.text=[self.detailsDict objectForKey:@"emp_company_email"];
        self.personalEmail.text=[self.detailsDict objectForKey:@"emp_personal_email"];
        self.nomineeName.text=[self.detailsDict objectForKey:@"emp_nominee_name"];
        self.nomineeContact.text=[self.detailsDict objectForKey:@"emp_nominee_contact"];
        self.localBlock.text=[self.detailsDict objectForKey:@"emp_local_block_address"];
        self.localStreet.text=[self.detailsDict objectForKey:@"emp_local_street_address"];
        self.localBuilding.text=[self.detailsDict objectForKey:@"emp_local_building"];
        self.localFlat.text=[self.detailsDict objectForKey:@"emp_local_flat"];
        if ([self.detailsDict objectForKey:@"local_city"]!=(id)[NSNull null]) {
            self.localCity.text=[self.detailsDict objectForKey:@"local_city"];
        }
        else
        {
            self.localCity.text=@"";
        }
        
        self.localPostCode.text=[self.detailsDict objectForKey:@"emp_local_post_code"];
        
        self.homeBlock.text=[self.detailsDict objectForKey:@"emp_home_block_address"];
        self.homeStreet.text=[self.detailsDict objectForKey:@"emp_home_street_address"];
        self.homeBuilding.text=[self.detailsDict objectForKey:@"emp_home_building"];
        self.homeFlat.text=[self.detailsDict objectForKey:@"emp_home_flat"];
        
        if ([self.detailsDict objectForKey:@"emp_country"]!=(id)[NSNull null]) {
            self.homeCountry.text=[self.detailsDict objectForKey:@"emp_country"];
        }
        else
        {
            self.homeCountry.text=@"";
        }
        if ([self.detailsDict objectForKey:@"emp_city"]!=(id)[NSNull null]) {
            self.homeCity.text=[self.detailsDict objectForKey:@"emp_city"];
        }
        else
        {
            self.homeCity.text=@"";
        }
        if ([self.detailsDict objectForKey:@"state"]!=(id)[NSNull null]) {
            self.homeState.text=[self.detailsDict objectForKey:@"state"];
        }
        else
        {
            self.homeState.text=@"";
        }

        
        self.homePostCode.text=[self.detailsDict objectForKey:@"emp_home_post_code"];
        
        for (int i=0; i<self.educationArray.count; i++) {
            NSMutableDictionary *educationDict=[self.educationArray objectAtIndex:i];
            [self.degreeArray addObject:[educationDict objectForKey:@"degree"]];
            [self.institutionArray addObject:[educationDict objectForKey:@"institution"]];
            [self.yearArray addObject:[educationDict objectForKey:@"year"]];
        }
        [self.firstTableView reloadData];
        
        for (int i=0; i<self.skillsArray.count; i++) {
            NSMutableDictionary *skillDict=[self.skillsArray objectAtIndex:i];
            [self.descriptionArray addObject:[skillDict objectForKey:@"description"]];
            [self.experienceArray addObject:[NSString stringWithFormat:@"%@",[skillDict objectForKey:@"experience"]]];
            [self.levelArray addObject:[NSString stringWithFormat:@"%@",[skillDict objectForKey:@"proficiency_level"]]];
        }
        [self.secondtableview reloadData];
    
}
@end
