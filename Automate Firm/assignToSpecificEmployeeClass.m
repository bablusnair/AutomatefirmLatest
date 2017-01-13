//
//  assignToSpecificEmployeeClass.m
//  Automate Firm
//
//  Created by leonine on 11/18/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "assignToSpecificEmployeeClass.h"
#import "SerachListingEmployeeView.h"
#import "selectedEmployeeListingView.h"
@implementation assignToSpecificEmployeeClass
@synthesize x;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame=CGRectMake(0, -30, self.frame.size.width, self.frame.size.height);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-400, -300, 1400, 1000)];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    [ self.mycollectionView registerNib:[UINib nibWithNibName:@"selectedEmployeeListingView" bundle:nil] forCellWithReuseIdentifier:@"selectedEmployee"];
    
    self.selectedEmployeeIconArray=[[NSMutableArray alloc]init];
    self.selectedArray=[[NSMutableArray alloc]init];
    self.selectedEmpNameArray=[[NSMutableArray alloc]init];
    self.nameArray=[[NSMutableArray alloc] init];
    self.filterarraycountry=[[NSMutableArray alloc]init];
    self.idArray=[[NSMutableArray alloc]init];
    
    x=0;
    
    



    self.maindictionary=[[NSMutableDictionary alloc] init];
    self.finalEmpDict=[[NSMutableDictionary alloc]init];
    self.empDict=[[NSMutableDictionary alloc]init];


    
    
    
    
    NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:@"ruleType"];
    if ([str isEqualToString:@"leavePaperwork"]) {
        
        if ([app.flowAction isEqualToString:@"1"]) {
            if (app.specificEmployeeFlag1==0) {
                
                [self.myconnection assigntoSpecificEmployee:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] : app.ruleID : app.conditionID :app.flowAction :@"leave" ];
            }
            else
            {
                [self loaclView];
            }
        }
        if ([app.flowAction isEqualToString:@"2"]) {
            if (app.specificEmployeeFlag2==0) {
                
                [self.myconnection assigntoSpecificEmployee:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] : app.ruleID : app.conditionID :app.flowAction :@"leave" ];
            }
            else
            {
                [self loaclView];
            }
        }
        if ([app.flowAction isEqualToString:@"3"]) {
            if (app.specificEmployeeFlag3==0) {
                
                [self.myconnection assigntoSpecificEmployee:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] : app.ruleID : app.conditionID :app.flowAction :@"leave" ];
            }
            else
            {
                [self loaclView];
            }
        }
        if ([app.flowAction isEqualToString:@"4"]) {
            if (app.specificEmployeeFlag4==0) {
                
                [self.myconnection assigntoSpecificEmployee:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] : app.ruleID : app.conditionID :app.flowAction :@"leave" ];
            }
            else
            {
                [self loaclView];
            }
        }
        if ([app.flowAction isEqualToString:@"5"]) {
            if (app.specificEmployeeFlag5==0) {
                
                [self.myconnection assigntoSpecificEmployee:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] : app.ruleID : app.conditionID :app.flowAction :@"leave" ];
            }
            else
            {
                [self loaclView];
            }
        }
        
        
        
        
        
    }
    
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (x==1) {
        return self.filterarraycountry.count;
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
    cell.myImage.layer.cornerRadius = cell.myImage.frame.size.width / 2;
    cell.myImage.clipsToBounds = YES;
    if (x==1) {
        cell.empID=[self.empDict objectForKey:[self.filterarraycountry objectAtIndex:indexPath.row]];
       NSInteger anIndex=[self.nameArray indexOfObject:[self.filterarraycountry objectAtIndex:indexPath.row]];
       if(NSNotFound == anIndex) {
           NSLog(@"not found");
       }
       NSMutableArray *loadarray=[self.maindictionary objectForKey:[self.idArray objectAtIndex:anIndex]];
       if ([[loadarray objectAtIndex:1]isEqualToString:@""]) {
           cell.myImage.image=[UIImage imageNamed:@"img 1.png"];
       }
       else
       {
           NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[loadarray objectAtIndex:1] options:0];
           
           cell.myImage.image=[UIImage imageWithData:decodedData];
       }
       cell.nameLabel.text=[loadarray objectAtIndex:0];
       cell.desigLabel.text=[loadarray objectAtIndex:2];
       cell.empIDLabel.text=[loadarray objectAtIndex:3];
       cell.unitLabel.text=[loadarray objectAtIndex:4];
   }
    else
   {
       cell.empID=[self.empDict objectForKey:[self.nameArray objectAtIndex:indexPath.row]];
       NSInteger anIndex=[self.nameArray indexOfObject:[self.nameArray objectAtIndex:indexPath.row]];
       if(NSNotFound == anIndex) {
           NSLog(@"not found");
       }
       NSMutableArray *loadarray=[self.maindictionary objectForKey:[self.idArray objectAtIndex:anIndex]];//[self.nameArray objectAtIndex:indexPath.row]];
       if ([[loadarray objectAtIndex:1]isEqualToString:@""]) {
           cell.myImage.image=[UIImage imageNamed:@"img 1.png"];
       }
       else
       {
           NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[loadarray objectAtIndex:1] options:0];
           
           cell.myImage.image=[UIImage imageWithData:decodedData];
       }
       cell.nameLabel.text=[loadarray objectAtIndex:0];
       cell.desigLabel.text=[loadarray objectAtIndex:2];
       cell.empIDLabel.text=[loadarray objectAtIndex:3];
       cell.unitLabel.text=[loadarray objectAtIndex:4];
       
   }
    
    if ([self.selectedArray containsObject:cell.empID]) {
        [cell.contentView setAlpha:0.6];
        cell.userInteractionEnabled=NO;
    }
    else
    {
        [cell.contentView setAlpha:1.0];
        cell.userInteractionEnabled=YES;
    }
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SerachListingEmployeeView *cell=[self.myTableView cellForRowAtIndexPath:indexPath];
    
    
    NSInteger anInteger=[self.nameArray indexOfObject:cell.nameLabel.text];
    
    NSMutableArray *empArray=[self.maindictionary objectForKey:[self.idArray objectAtIndex:anInteger]];
    
    [self.selectedArray addObject:[empArray objectAtIndex:5]];
    [self.selectedEmpNameArray  addObject:[empArray objectAtIndex:0]];
    [self.selectedEmployeeIconArray addObject:[empArray objectAtIndex:1]];
    [self.mycollectionView reloadData];
    [self.myTableView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.selectedEmpNameArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedEmployeeListingView *cell=(selectedEmployeeListingView *)[collectionView dequeueReusableCellWithReuseIdentifier:@"selectedEmployee" forIndexPath:indexPath];
    cell.employeeNamelabel.text=[self.selectedEmpNameArray objectAtIndex:indexPath.row];
    return cell;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.searchTextField) {
        x=1;
        self.myTableView.hidden=FALSE;
        //   NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",[self.mytextfield.text stringByReplacingCharactersInRange:range withString:string]];
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.searchTextField.text stringByReplacingCharactersInRange:range withString:string]];
        self.filterarraycountry = [[self.nameArray filteredArrayUsingPredicate:bPredicate] mutableCopy];
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
-(IBAction)deleteSelectedEmployee:(id)sender
{
    selectedEmployeeListingView *cell=(selectedEmployeeListingView *)[[sender superview] superview];
    
    NSIndexPath *removeindex=[self.mycollectionView indexPathForCell:cell];
    
    [self.selectedArray removeObject:[self.empDict objectForKey:cell.employeeNamelabel.text]];
    [self.selectedEmpNameArray removeObject:cell.employeeNamelabel.text];
    [self.selectedEmployeeIconArray removeObjectAtIndex:removeindex.row];

    [self.myTableView reloadData];
    [self.mycollectionView reloadData];
}
-(IBAction)doneButtonAction:(id)sender
{
    if ([app.flowAction isEqualToString:@"1"]) {
        app.designationFlag1=1;
    }
    if ([app.flowAction isEqualToString:@"2"]) {
        app.designationFlag2=1;
    }
    if ([app.flowAction isEqualToString:@"3"]) {
        app.designationFlag3=1;
    }
    if ([app.flowAction isEqualToString:@"4"]) {
        app.designationFlag4=1;
    }if ([app.flowAction isEqualToString:@"5"]) {
        app.designationFlag5=1;
    }
    
    [self.finalEmpDict setObject:self.selectedArray forKey:@"selectedEmployee"];
    [self.finalEmpDict setObject:self.selectedEmpNameArray forKey:@"selectedEmpName"];
    [self.finalEmpDict setObject:self.selectedEmployeeIconArray forKey:@"selectedEmpIcon"];
    if (self.selectedEmpNameArray.count == 1) {
        NSMutableArray *loadarray=[self.maindictionary objectForKey:[self.empDict objectForKey:[self.selectedEmpNameArray objectAtIndex:0]]];
        
        NSData *imageData;
        if ([[loadarray objectAtIndex:1]isEqualToString:@""]) {
            UIImage *image=[UIImage imageNamed:@"img 1.png"];
            imageData=UIImagePNGRepresentation(image);
        }
        else
        {
            imageData = [[NSData alloc] initWithBase64EncodedString:[loadarray objectAtIndex:1] options:0];
            
            
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:imageData forKey:@"selectedEmployeeIcon"];
    }
    [[NSUserDefaults standardUserDefaults]setObject:@"assignEmployee" forKey:@"doneAction"];
    [[NSUserDefaults standardUserDefaults]setObject:self.selectedArray forKey:@"selectedEmployee"];
    [[NSUserDefaults standardUserDefaults]setObject:self.finalEmpDict forKey:@"employeeDict"];
    
    
    
    [self removeFromSuperview];
}
-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@",responseData);
        
        [self.finalEmpDict removeAllObjects];
        [self.finalEmpDict addEntriesFromDictionary:responseData];
        [self.finalEmpDict removeObjectForKey:@"selected_employees"];
        
        [self.nameArray removeAllObjects];
        [self.selectedArray removeAllObjects];
        [self.selectedEmpNameArray removeAllObjects];
        [self.selectedEmployeeIconArray removeAllObjects];
        [self.maindictionary removeAllObjects];
        
        NSMutableArray *empListArray=[responseData objectForKey:@"available_employees"];
        for ( int i=0; i<empListArray.count; i++) {
            NSMutableDictionary *empDict=[empListArray objectAtIndex:i];
            NSMutableArray *empArray=[[NSMutableArray alloc]initWithObjects:[empDict objectForKey:@"emp_name"],[empDict objectForKey:@"emp_encode_image"],[empDict objectForKey:@"designation_title"],[empDict objectForKey:@"e_code"],[empDict objectForKey:@"department_name"],[empDict objectForKey:@"emp_id"], nil];
            [self.maindictionary setObject:empArray forKey:[empDict objectForKey:@"emp_id"]];
            [self.nameArray addObject:[empDict objectForKey:@"emp_name"]];
            [self.idArray addObject:[empDict objectForKey:@"emp_id"]];
            [self.empDict setObject:[empDict objectForKey:@"emp_id"] forKey:[empDict objectForKey:@"emp_name"]];
        }
        
        NSMutableArray *selectedArray=[responseData objectForKey:@"selected_employees"];
        for (int i=0; i<selectedArray.count; i++) {
            NSMutableDictionary *empDict=[selectedArray objectAtIndex:i];
            [self.selectedArray addObject:[empDict objectForKey:@"emp_id"]];
            [self.selectedEmpNameArray addObject:[empDict objectForKey:@"emp_name"]];
            [self.selectedEmployeeIconArray addObject:[empDict objectForKey:@"emp_encode_image"]];
        }
      
       
        
        [self.myTableView reloadData];
        [self.mycollectionView reloadData];
        
    });
}
-(void)loaclView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.nameArray removeAllObjects];
        [self.selectedArray removeAllObjects];
        [self.selectedEmpNameArray removeAllObjects];
        [self.selectedEmployeeIconArray removeAllObjects];
        [self.maindictionary removeAllObjects];
        [self.finalEmpDict removeAllObjects];
        [self.finalEmpDict addEntriesFromDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"employeeDict"]];
        
        NSMutableArray *empListArray=[_finalEmpDict objectForKey:@"available_employees"];
        for ( int i=0; i<empListArray.count; i++) {
            NSMutableDictionary *empDict=[empListArray objectAtIndex:i];
            NSMutableArray *empArray=[[NSMutableArray alloc]initWithObjects:[empDict objectForKey:@"emp_name"],[empDict objectForKey:@"emp_encode_image"],[empDict objectForKey:@"designation_title"],[empDict objectForKey:@"e_code"],[empDict objectForKey:@"department_name"],[empDict objectForKey:@"emp_id"], nil];
            [self.maindictionary setObject:empArray forKey:[empDict objectForKey:@"emp_id"]];
            [self.nameArray addObject:[empDict objectForKey:@"emp_name"]];
            [self.idArray addObject:[empDict objectForKey:@"emp_id"]];
            [self.empDict setObject:[empDict objectForKey:@"emp_id"] forKey:[empDict objectForKey:@"emp_name"]];
        }
        
        
        [self.nameArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        [self.selectedArray addObjectsFromArray:[self.finalEmpDict objectForKey:@"selectedEmployee"]];
        [self.selectedEmpNameArray addObjectsFromArray:[self.finalEmpDict objectForKey:@"selectedEmpName"]];
        [self.selectedEmployeeIconArray addObjectsFromArray:[self.finalEmpDict objectForKey:@"selectedEmpIcon"]];
        
        [self.myTableView reloadData];
        [self.mycollectionView reloadData];
        
        
    });
}
@end
