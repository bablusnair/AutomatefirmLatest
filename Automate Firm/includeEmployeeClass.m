//
//  includeEmployeeClass.m
//  Automate Firm
//
//  Created by leonine on 10/22/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "includeEmployeeClass.h"
#import "employeeSelectionCellCollectionViewCell.h"
#import "storeViewCollectionViewCell.h"
@implementation includeEmployeeClass


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 
 
     self.frame=CGRectMake(10, -20, self.frame.size.width, self.frame.size.height);
     self.backgroundColor=[UIColor whiteColor];
     self.alpha=100;
     UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-500, -300, 1300, 1000)];
     self.layer.masksToBounds = NO;
     self.layer.shadowColor = [UIColor blackColor].CGColor;
     //  self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
     self.layer.shadowOpacity = 0.5f;
     self.layer.shadowPath = shadowPath.CGPath;
 
}
-(void)awakeFromNib
{
    [ self.storesCollectionView registerNib:[UINib nibWithNibName:@"storeViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"myCell"];
    [ self.employeeCollectionView registerNib:[UINib nibWithNibName:@"employeeSelectionCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"employeeCell"];
    
    self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.myconnetion=[[connectionclass alloc]init];
    self.myconnetion.mydelegate=self;
    
    self.employeeArray=[[NSMutableArray alloc]init];
    self.employeeIDArray=[[NSMutableArray alloc]init];
    self.employeeImageArray=[[NSMutableArray alloc]init];
    self.employeeSelectedArray=[[NSMutableArray alloc]init];
    self.storesArray=[[NSMutableArray alloc]init];
    self.storesIDArray=[[NSMutableArray alloc]init];
    self.selectedStoreArray=[[NSMutableArray alloc]init];
    self.filterArray=[[NSMutableArray alloc]init];
    self.filterIDArray=[[NSMutableArray alloc]init];
    self.selectedDepartmentArray=[[NSMutableArray alloc]init];
    self.selectedCategoryArray=[[NSMutableArray alloc]init];
    self.selectedDesignationArray=[[NSMutableArray alloc]init];
    self.selectedEmployeeArray=[[NSMutableArray alloc]init];
    
    self.finalDict=[[NSMutableDictionary alloc]init];
    self.empDict=[[NSMutableDictionary alloc]init];
    self.finalSelectedDict=[[NSMutableDictionary alloc]init];
    self.filterDictionary=[[NSMutableDictionary alloc]init];
    
    
    self.filterViewFlag=1;
    
    self.filterView.layer.borderWidth = 1;
    self.filterView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"ruleType"]isEqualToString:@"leavePaperwork"]) {
        self.type=@"leave";
        if (self.app.designationFlag==0) {
            [self.myconnetion listingAlltheEmployeesAccordingtoType:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] : @"leave" : self.app.ruleID : self.app.conditionID];
        }
        else
        {
            [self localView];
        }

    }
    

    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==self.storesCollectionView)
    {
        return  self.storesArray.count;
    }
    else
    {
        return  self.employeeArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.storesCollectionView)
    {
        static NSString *cellIdentifier = @"myCell";
        storeViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        if ([self.selectedStoreArray containsObject:indexPath]) {
            cell.storeLabel.textColor=[UIColor blueColor];
        }
        else
        {
            cell.storeLabel.textColor=[UIColor blackColor];
        }
        cell.storeLabel.text=[self.storesArray objectAtIndex:indexPath.row];
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"employeeCell";
        employeeSelectionCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.empNameLabel.text=[self.employeeArray objectAtIndex:indexPath.row];
        cell.empIDLabel.text=[NSString stringWithFormat:@"(%@)",[self.employeeIDArray objectAtIndex:indexPath.row]];
        cell.empIcon.layer.cornerRadius = cell.empIcon.frame.size.width / 2;
        cell.empIcon.clipsToBounds = YES;
        if ([[self.employeeImageArray objectAtIndex:indexPath.row]isEqualToString:@""]) {
            cell.empIcon.image=[UIImage imageNamed:@"img 1.png"];
            
        }
        else
        {
            NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[self.employeeImageArray objectAtIndex:indexPath.row] options:0];
            
            cell.empIcon.image=[UIImage imageWithData:decodedData];
        }
        cell.cellID=[self.empDict objectForKey:cell.empNameLabel.text];
        if([self.employeeSelectedArray containsObject:cell.cellID]) {
            
            [cell.selectionButton setImage:[UIImage imageNamed:@"check box (tick).png"] forState:UIControlStateNormal];
        }
        else {
            [cell.selectionButton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
        }
        return cell;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.employeeCollectionView)
    {
        employeeSelectionCellCollectionViewCell *cell=(employeeSelectionCellCollectionViewCell *)[self.employeeCollectionView cellForItemAtIndexPath:indexPath];
        
        NSMutableDictionary *mydict=[[NSMutableDictionary alloc] initWithDictionary:[self.finalDict objectForKey:self.selectedStore]];
        NSMutableArray *selectArray=[[NSMutableArray alloc]initWithArray:[mydict objectForKey:@"selected_employees"]];
        
        if ([cell.selectionButton.currentImage isEqual:[UIImage imageNamed:@"check box.png"]])
        {
            [self.employeeSelectedArray addObject:[self.empDict objectForKey:cell.empNameLabel.text]];
            
            
            NSMutableDictionary *addDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.empDict objectForKey:cell.empNameLabel.text],@"emp_id",cell.empNameLabel.text,@"emp_name", nil];
            
            [selectArray addObject:addDict];
            [mydict setObject:selectArray forKey:@"selected_employees"];
        }
        else
        {
            [self.employeeSelectedArray removeObject:[self.empDict objectForKey:cell.empNameLabel.text]];
            for (int i=0; i<selectArray.count; i++)
            {
                NSMutableDictionary *mydict=[selectArray objectAtIndex:i];
                if ([[mydict objectForKey:@"emp_id"]isEqualToString:[self.empDict objectForKey:cell.empNameLabel.text]]) {
                    [selectArray removeObjectAtIndex:i];
                }
            }
            [mydict setObject:selectArray forKey:@"selected_employees"];
        }
        
        NSMutableDictionary *finalDictTemp=[[NSMutableDictionary alloc]init];
        finalDictTemp=[self.finalDict mutableCopy];
        [finalDictTemp setObject:mydict forKey:self.selectedStore];
        
        self.finalDict=[[NSMutableDictionary alloc]initWithDictionary:finalDictTemp];
        
        if (self.employeeSelectedArray.count > 0) {
            [self.selectDeselectButton setTitle:@"Deselect All" forState:UIControlStateNormal];
            [self.selectDeselectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.selectDeselectButton setTag:2];
            
        }
        else
        {
            [self.selectDeselectButton setTitle:@"Select All" forState:UIControlStateNormal];
            [self.selectDeselectButton setTitleColor:[UIColor colorWithRed:83/255 green:125/255 blue:255/155 alpha:0.7] forState:UIControlStateNormal];
            [self.selectDeselectButton setTag:1];
        }
        [self.employeeCollectionView reloadData];
    }
    else
    {
        self.selectedPremiseType=@"S";
        [self.officeButton setImage:[UIImage imageNamed:@"top_office_normal.png"] forState:UIControlStateNormal];
        [self.employeeCollectionView setContentOffset:CGPointMake(0,0) animated:YES];
        storeViewCollectionViewCell *cell=(storeViewCollectionViewCell *)[self.storesCollectionView cellForItemAtIndexPath:indexPath];
        self.selectedStore=cell.storeLabel.text;
        self.selectedPremiseID=[self.storesIDArray objectAtIndex:indexPath.row];
        
        [self individualView:cell.storeLabel.text];
        [self.selectedStoreArray removeAllObjects];
        [self.selectedStoreArray addObject:indexPath];
        self.officename.textColor=[UIColor blackColor];
        [self.storesCollectionView reloadData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filterArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=[self.filterArray objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:13.0];
    UIButton *newRadioButton;
    newRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newRadioButton.frame = CGRectMake(30, 0, 15, 14.5);
    cell.accessoryView = newRadioButton;

    if (self.filterFlag==1) {
        if ([self.selectedDepartmentArray containsObject:[self.filterIDArray objectAtIndex:indexPath.row]]) {
            [newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        }
        else
        {
            [newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
        }
    }
    else if (self.filterFlag==2)
    {
        if ([self.selectedCategoryArray containsObject:[self.filterIDArray objectAtIndex:indexPath.row]]) {
            [newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        }
        else
        {
            [newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
        }
    }
    else if (self.filterFlag==3)
    {
        if ([self.selectedDesignationArray containsObject:[self.filterIDArray objectAtIndex:indexPath.row]]) {
            [newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen.png"] forState:UIControlStateNormal];
        }
        else
        {
            [newRadioButton setImage:[UIImage imageNamed:@"selection_buttoen_white.png"] forState:UIControlStateNormal];
        }
    }
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.filterViewFlag=2;
    UITableViewCell *cell=[self.filterTableView cellForRowAtIndexPath:indexPath];
    if (self.filterFlag==1) {
        UIButton *radioButton = (UIButton *)cell.accessoryView;
        if([radioButton.currentImage isEqual:[UIImage imageNamed:@"selection_buttoen.png"]])
        {
            [self.selectedDepartmentArray removeObject:[self.filterIDArray objectAtIndex:indexPath.row]];
        }
        else
        {
            [self.selectedDepartmentArray addObject:[self.filterIDArray objectAtIndex:indexPath.row]];
        }
       
    }
    else if (self.filterFlag==2)
    {
        UIButton *radioButton = (UIButton *)cell.accessoryView;
        if([radioButton.currentImage isEqual:[UIImage imageNamed:@"selection_buttoen.png"]])
        {
            [self.selectedCategoryArray removeObject:[self.filterIDArray objectAtIndex:indexPath.row]];
        }
        else
        {
            [self.selectedCategoryArray addObject:[self.filterIDArray objectAtIndex:indexPath.row]];
        }
    }
    else if (self.filterFlag==3)
    {
        UIButton *radioButton = (UIButton *)cell.accessoryView;
        if([radioButton.currentImage isEqual:[UIImage imageNamed:@"selection_buttoen.png"]])
        {
            [self.selectedDesignationArray removeObject:[self.filterIDArray objectAtIndex:indexPath.row]];
        }
        else
        {
            [self.selectedDesignationArray addObject:[self.filterIDArray objectAtIndex:indexPath.row]];
        }
    }
    [self.filterTableView reloadData];
}
-(IBAction)officeButtonAction:(id)sender
{
    [self.selectedStoreArray removeAllObjects];
    self.selectedStore=self.officename.text;
    self.selectedPremiseID=self.officeID;
    self.selectedPremiseType=@"O";
    [self.officeButton setImage:[UIImage imageNamed:@"officeSelected.png"] forState:UIControlStateNormal];
    self.officename.textColor=[UIColor blueColor];
    [self.employeeCollectionView setContentOffset:CGPointMake(0,0) animated:YES];
    [self individualView:self.officename.text];
    
    [self.storesCollectionView reloadData];
}
-(IBAction)showAllAction:(id)sender
{
    [self individualView:self.selectedStore];
}
-(IBAction)selectDeselect:(id)sender
{
    UIButton *button=(UIButton *)sender;
    NSMutableDictionary *mydict=[[NSMutableDictionary alloc] initWithDictionary:[self.finalDict objectForKey:self.selectedStore]];
    if (button.tag==1) {
        [self.employeeSelectedArray removeAllObjects];
        
        NSArray *allEmp=[self.empDict allKeys];
        for ( int i=0; i<allEmp.count; i++) {
            
            [self.employeeSelectedArray addObject:[self.empDict objectForKey:[allEmp objectAtIndex:i]]];
        }
        
        [mydict removeObjectForKey:@"selected_employees"];
        [mydict setObject:[mydict objectForKey:@"available_employees"] forKey:@"selected_employees"];
        
        [self.selectDeselectButton setTitle:@"Deselect All" forState:UIControlStateNormal];
        [self.selectDeselectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.selectDeselectButton setTag:2];
        [self.employeeCollectionView reloadData];
    }
    else
    {
        NSMutableArray *selectedArray=[[NSMutableArray alloc]init];
        [mydict setObject:selectedArray forKey:@"selected_employees"];
        
        [self.selectDeselectButton setTitle:@"Select All" forState:UIControlStateNormal];
        [self.selectDeselectButton setTitleColor:[UIColor colorWithRed:83/255 green:125/255 blue:255/155 alpha:0.7] forState:UIControlStateNormal];
        [self.selectDeselectButton setTag:1];
        [self.employeeSelectedArray removeAllObjects];
        [self.employeeCollectionView reloadData];
    }
    NSMutableDictionary *finalDictTemp=[[NSMutableDictionary alloc]init];
    finalDictTemp=[self.finalDict mutableCopy];
    [finalDictTemp setObject:mydict forKey:self.selectedStore];
    
    self.finalDict=[[NSMutableDictionary alloc]initWithDictionary:finalDictTemp];
    
}
-(IBAction)doneButtonAction:(id)sender
{
    self.app.designationFlag=1;
    NSMutableArray *desig=[[NSMutableArray alloc]initWithObjects:self.officename.text, nil];
    [desig addObjectsFromArray:self.storesArray];
    
    NSMutableArray *workingPremiseIDArray=[[NSMutableArray alloc] initWithObjects:self.officeID, nil];
    [workingPremiseIDArray addObjectsFromArray:self.storesIDArray];
    
    for (int i=0; i<desig.count; i++) {
        NSMutableDictionary *localDict=[self.finalDict objectForKey:[desig objectAtIndex:i]];
        NSMutableArray *localArray=[localDict objectForKey:@"selected_employees"];
        
        NSMutableDictionary *selectedDict=[[NSMutableDictionary alloc]init];
        [selectedDict setObject:localArray forKey:@"selected_employees"];
        [selectedDict setObject:[workingPremiseIDArray objectAtIndex:i] forKey:@"id"];
        
        [self.finalSelectedDict setObject:selectedDict forKey:[desig objectAtIndex:i]];
        
        
        for (int j=0; j<localArray.count; j++) {
            NSMutableDictionary *localDict1=[localArray objectAtIndex:j];
            NSString *myString=[NSString stringWithFormat:@"%@:%@",[desig objectAtIndex:i],[localDict1 objectForKey:@"emp_name"]];
            [self.selectedEmployeeArray addObject:myString];
        }
    }
    
    
    //error porsion
    if (desig.count>0) {
        
        NSMutableDictionary *desigDict=[[NSMutableDictionary alloc]init];
        [desigDict setObject:[self.finalSelectedDict objectForKey:[desig objectAtIndex:0]] forKey:@"office"];
        
        NSMutableArray *storesSelected=[[NSMutableArray alloc]init];
        for (int i=1; i<desig.count; i++) {
            
            [storesSelected addObject:[self.finalSelectedDict objectForKey:[desig objectAtIndex:i]]];
        }
        [desigDict setObject:storesSelected forKey:@"stores"];
        
        [[NSUserDefaults standardUserDefaults]setObject:self.selectedEmployeeArray forKey:@"selected_emp"];
        
        [[NSUserDefaults standardUserDefaults]setObject:desigDict forKey:@"selected_employees"];
        [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"officeDetails"];
        
      //  [self removeFromSuperview];
        
       // [[NSNotificationCenter defaultCenter] postNotificationName:@"enableall" object:Nil];
        
    }
    
    [self removeFromSuperview];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.filterDictionary removeAllObjects];
    if (textField==self.departmentText) {
        if (self.filterViewFlag==1) {
            [self.filterIDArray removeAllObjects];
            [self.filterArray removeAllObjects];
            NSMutableArray *deptArray=[self.finalDict objectForKey:@"department"];
            for (int i=0; i<deptArray.count; i++) {
                NSMutableDictionary *deptDict=[deptArray objectAtIndex:i];
                [self.filterArray addObject:[deptDict objectForKey:@"department_name"]];
                [self.filterIDArray addObject:[deptDict objectForKey:@"dept_id"]];
                [self.filterDictionary setObject:[deptDict objectForKey:@"department_name"] forKey:[deptDict objectForKey:@"dept_id"]];
            }
            self.filterView.frame=CGRectMake(25, 167, self.filterView.frame.size.width, self.filterView.frame.size.height);
            self.filterFlag=1;
            [self.filterTableView reloadData];
            self.filterView.hidden=false;
        }
        return  NO;
    }
    else if (textField==self.categoryText)
    {
        if (self.filterViewFlag==1) {
            [self.filterIDArray removeAllObjects];
            [self.filterArray removeAllObjects];
            NSMutableArray *cateArray=[self.finalDict objectForKey:@"category"];
            for (int i=0; i<cateArray.count; i++) {
                NSMutableDictionary *catDict=[cateArray objectAtIndex:i];
                [self.filterArray addObject:[catDict objectForKey:@"cat_name"]];
                [self.filterIDArray addObject:[catDict objectForKey:@"id"]];
                
                [self.filterDictionary setObject:[catDict objectForKey:@"cat_name"] forKey:[catDict objectForKey:@"id"]];
            }
            
            self.filterView.frame=CGRectMake(160, 167, self.filterView.frame.size.width, self.filterView.frame.size.height);
            self.filterFlag=2;
            [self.filterTableView reloadData];
            self.filterView.hidden=false;
        }
        return  NO;
    }
    else if (textField==self.designationText)
    {
        if (self.filterViewFlag==1) {
            [self.filterIDArray removeAllObjects];
            [self.filterArray removeAllObjects];
            NSMutableArray *desigArray=[self.finalDict objectForKey:@"designation"];
            for (int i=0; i<desigArray.count; i++) {
                NSMutableDictionary *desigDict=[desigArray objectAtIndex:i];
                [self.filterArray addObject:[desigDict objectForKey:@"designation_title"]];
                [self.filterIDArray addObject:[desigDict objectForKey:@"id"]];
                
                [self.filterDictionary setObject:[desigDict objectForKey:@"designation_title"] forKey:[desigDict objectForKey:@"id"]];
            }
            
            
            self.filterView.frame=CGRectMake(299, 167, self.filterView.frame.size.width, self.filterView.frame.size.height);
            self.filterFlag=3;
            [self.filterTableView reloadData];
            self.filterView.hidden=false;
        }
        return NO;
    }
    else
        return  YES;
}
-(IBAction)filterDoneAction:(id)sender
{
    self.filterViewFlag=1;
    self.filterView.hidden=true;
    if (self.filterFlag==1) {
        
        if (self.selectedDepartmentArray.count > 0) {
            
            self.categoryText.backgroundColor=[UIColor clearColor];
            self.categoryText.userInteractionEnabled=YES;
            self.designationText.backgroundColor=[UIColor clearColor];
            self.designationText.userInteractionEnabled=YES;
            
            if (self.selectedDepartmentArray.count == 1) {
                self.departmentText.text=[self.filterDictionary objectForKey:[self.selectedDepartmentArray objectAtIndex:0]];
            }
            else if (self.selectedDepartmentArray.count == self.filterArray.count)
            {
                self.departmentText.text=@"All";
            }
            else
            {
                self.departmentText.text=@"Multiple";
            }
            
            
            [self filterService];
            
        }
        else
        {
            self.departmentText.text=@"";
            self.categoryText.text=@"";
            self.categoryText.backgroundColor=[UIColor lightGrayColor];
            self.categoryText.userInteractionEnabled=NO;
            
            self.designationText.text=@"";
            self.designationText.backgroundColor=[UIColor lightGrayColor];
            self.designationText.userInteractionEnabled=NO;
        }
    }
    else if (self.filterFlag==2)
    {
        if (self.selectedCategoryArray.count > 0) {
            self.designationText.backgroundColor=[UIColor clearColor];
            self.designationText.userInteractionEnabled=YES;
            
            if (self.selectedCategoryArray.count == 1) {
                self.categoryText.text=[self.filterDictionary objectForKey:[self.selectedCategoryArray objectAtIndex:0]];
            }
            else if (self.selectedCategoryArray.count == self.filterArray.count)
            {
                self.categoryText.text=@"All";
            }
            else
            {
                self.categoryText.text=@"Multiple";
            }

            
            [self filterService];
            
        }
        else
        {
            self.categoryText.text=@"";
            self.designationText.text=@"";
            self.designationText.backgroundColor=[UIColor lightGrayColor];
            self.designationText.userInteractionEnabled=NO;
        }

    }
    else
    {
        if (self.selectedDesignationArray.count > 0) {
            
            if (self.selectedDesignationArray.count == 1) {
                self.designationText.text=[self.filterDictionary objectForKey:[self.selectedDesignationArray objectAtIndex:0]];
            }
            else if (self.selectedDesignationArray.count == self.filterArray.count)
            {
                self.designationText.text=@"All";
            }
            else
            {
                self.designationText.text=@"Multiple";
            }

            [self filterService];
        }
        else{
            self.designationText.text=@"";
        }
    }
}
-(void)filterService
{
    NSMutableDictionary *filterDict=[[NSMutableDictionary alloc]init];
    [filterDict setObject:self.selectedDepartmentArray forKey:@"department_list"];
    [filterDict setObject:self.selectedCategoryArray forKey:@"category_list"];
    [filterDict setObject:self.selectedDesignationArray forKey:@"designation_list"];
    [filterDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] forKey:@"office_id"];
    [filterDict setObject:self.selectedPremiseID forKey:@"working_premise"];
    [filterDict setObject:self.selectedPremiseType forKey:@"wp_type"];
    [filterDict setObject:self.type forKey:@"type"];
    [filterDict setObject:self.app.ruleID forKey:@"rule_id"];
    
    NSMutableDictionary *filterData=[[NSMutableDictionary alloc]initWithObjectsAndKeys:filterDict,@"filter_details", nil];
    
    [self.myconnetion employeePopupFilter:filterData];
    
}

//<<------------------------------Service Response Part------------------------------->>
-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.employeeArray removeAllObjects];
        [self.employeeIDArray removeAllObjects];
        [self.employeeImageArray removeAllObjects];
        [self.employeeSelectedArray removeAllObjects];
        [self.selectedDepartmentArray removeAllObjects];
        [self.selectedCategoryArray removeAllObjects];
        [self.selectedDesignationArray removeAllObjects];
        
        [self.storesArray removeAllObjects];
        [self.storesIDArray removeAllObjects];
        [self.selectedStoreArray removeAllObjects];
        
        [self.empDict removeAllObjects];
        [self.finalDict removeAllObjects];
        
        NSMutableDictionary *tempDict=[[NSMutableDictionary alloc] initWithDictionary:responseData];
        [tempDict removeObjectForKey:@"store_details"];
        self.finalDict=tempDict;
        
        NSMutableArray *stores=[self.finalDict objectForKey:@"store"];
        for (int i=0; i<stores.count; i++) {
            NSMutableDictionary *storesDict=[stores objectAtIndex:i];
            [self.storesArray addObject:[storesDict objectForKey:@"store_name"]];
            [self.storesIDArray addObject:[storesDict objectForKey:@"store_id"]];
        }
        NSMutableArray *officeArray=[self.finalDict objectForKey:@"office"];
        NSMutableDictionary *offDict=[officeArray objectAtIndex:0];
        self.officename.text=[offDict objectForKey:@"office_name"];
        self.officename.textColor=[UIColor blueColor];
        self.officeID=[offDict objectForKey:@"id"];
        self.selectedStore=self.officename.text;
        self.selectedPremiseID=self.officeID;
        self.selectedPremiseType=@"O";
        
        NSMutableDictionary *storesDetails=[responseData objectForKey:@"store_details"];
        
        for (int i=0; i<self.storesArray.count; i++) {
            NSMutableDictionary *selectedStoreDict=[storesDetails objectForKey:[self.storesArray objectAtIndex:i]];
            [self.finalDict setObject:selectedStoreDict forKey:[self.storesArray objectAtIndex:i]];
        }
        
        
        NSMutableDictionary *officeDetailsDict=[[NSMutableDictionary alloc] initWithDictionary:[self.finalDict objectForKey:self.officename.text]];
        
        
        NSMutableArray *desigsArray=[officeDetailsDict objectForKey:@"available_employees"];
        
        for (int i=0; i<desigsArray.count; i++) {
            NSMutableDictionary *desigDict=[desigsArray objectAtIndex:i];
            [self.employeeArray addObject:[desigDict objectForKey:@"emp_name"]];
            [self.employeeIDArray addObject:[desigDict objectForKey:@"emp_id"]];
            [self.employeeImageArray addObject:[desigDict objectForKey:@"emp_encode_image"]];
            [self.empDict setObject:[desigDict objectForKey:@"emp_id"] forKey:[desigDict objectForKey:@"emp_name"]];
        }
        
        
        
        
        
        
        NSMutableArray *selected=[officeDetailsDict objectForKey:@"selected_employees"];
        for (int i=0; i<selected.count; i++) {
            NSMutableDictionary *selectedDesigDict=[selected objectAtIndex:i];
            [self.employeeSelectedArray addObject:[selectedDesigDict objectForKey:@"emp_id"]];
        }
        if (self.employeeSelectedArray.count > 0) {
            [self.selectDeselectButton setTitle:@"Deselect All" forState:UIControlStateNormal];
            [self.selectDeselectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.selectDeselectButton setTag:2];
        }
        else
        {
            [self.selectDeselectButton setTitle:@"Select All" forState:UIControlStateNormal];
            [self.selectDeselectButton setTitleColor:[UIColor colorWithRed:83/255 green:125/255 blue:255/155 alpha:0.7] forState:UIControlStateNormal];
            [self.selectDeselectButton setTag:1];
        }
        
        NSMutableArray *deptArray=[self.finalDict objectForKey:@"department"];
        for (int i=0; i<deptArray.count; i++) {
            [self.selectedDepartmentArray addObject:[[deptArray objectAtIndex:i]objectForKey:@"dept_id"]];
        }
        
        NSMutableArray *catArray=[self.finalDict objectForKey:@"category"];
        for (int i=0; i<catArray.count; i++) {
            [self.selectedCategoryArray addObject:[[catArray objectAtIndex:i]objectForKey:@"id"]];
        }
        
        NSMutableArray *desigArray=[self.finalDict objectForKey:@"designation"];
        for (int i=0; i<desigArray.count; i++) {
            [self.selectedDesignationArray addObject:[[desigArray objectAtIndex:i]objectForKey:@"id"]];
        }
        
        [self.filterTableView reloadData];
        [self.employeeCollectionView reloadData];
        [self.storesCollectionView reloadData];
        
    });
}

-(void)individualView:(NSString *)selectedPremise
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.selectedStore=selectedPremise;
        NSMutableDictionary *officeDetailsDict=[[NSMutableDictionary alloc] initWithDictionary:[self.finalDict objectForKey:selectedPremise]];
        
        [self.empDict removeAllObjects];
        [self.employeeArray removeAllObjects];
        [self.employeeIDArray removeAllObjects];
        [self.employeeImageArray removeAllObjects];
        [self.employeeSelectedArray removeAllObjects];
        [self.selectedDepartmentArray removeAllObjects];
        [self.selectedDesignationArray removeAllObjects];
        [self.selectedCategoryArray removeAllObjects];
        
        NSMutableArray *desigsArray=[officeDetailsDict objectForKey:@"available_employees"];
        for (int i=0; i<desigsArray.count; i++) {
            NSMutableDictionary *desigDict=[desigsArray objectAtIndex:i];
            [self.employeeArray addObject:[desigDict objectForKey:@"emp_name"]];
            [self.employeeIDArray addObject:[desigDict objectForKey:@"emp_id"]];
            [self.employeeImageArray addObject:[desigDict objectForKey:@"emp_encode_image"]];
            [self.empDict setObject:[desigDict objectForKey:@"emp_id"] forKey:[desigDict objectForKey:@"emp_name"]];
        }
        
        NSMutableArray *selected=[officeDetailsDict objectForKey:@"selected_employees"];
        for (int i=0; i<selected.count; i++) {
            NSMutableDictionary *selectedDesigDict=[selected objectAtIndex:i];
            [self.employeeSelectedArray addObject:[selectedDesigDict objectForKey:@"emp_id"]];
        }
        if (self.employeeSelectedArray.count > 0) {
            [self.selectDeselectButton setTitle:@"Deselect All" forState:UIControlStateNormal];
            [self.selectDeselectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.selectDeselectButton setTag:2];
        }
        else
        {
            [self.selectDeselectButton setTitle:@"Select All" forState:UIControlStateNormal];
            [self.selectDeselectButton setTitleColor:[UIColor colorWithRed:83/255 green:125/255 blue:255/155 alpha:0.7] forState:UIControlStateNormal];
            [self.selectDeselectButton setTag:1];
        }
        
        NSMutableArray *deptArray=[self.finalDict objectForKey:@"department"];
        for (int i=0; i<deptArray.count; i++) {
            [self.selectedDepartmentArray addObject:[[deptArray objectAtIndex:i]objectForKey:@"dept_id"]];
        }
        
        NSMutableArray *catArray=[self.finalDict objectForKey:@"category"];
        for (int i=0; i<catArray.count; i++) {
            [self.selectedCategoryArray addObject:[[catArray objectAtIndex:i]objectForKey:@"id"]];
        }
        
        NSMutableArray *desigArray=[self.finalDict objectForKey:@"designation"];
        for (int i=0; i<desigArray.count; i++) {
            [self.selectedDesignationArray addObject:[[desigArray objectAtIndex:i]objectForKey:@"id"]];
        }
        
        [self.filterTableView reloadData];
        [self.employeeCollectionView reloadData];
        
        self.departmentText.text=@"All";
        self.categoryText.text=@"All";
        self.designationText.text=@"All";
    });
    
}

-(void)localView
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.finalDict removeAllObjects];
        [self.empDict removeAllObjects];
        self.finalDict=[[NSUserDefaults standardUserDefaults]objectForKey:@"officeDetails"];
        
        [self.employeeArray removeAllObjects];
        [self.employeeIDArray removeAllObjects];
        [self.employeeImageArray removeAllObjects];
        [self.employeeSelectedArray removeAllObjects];
        [self.selectedDepartmentArray removeAllObjects];
        [self.selectedCategoryArray removeAllObjects];
        [self.selectedDesignationArray removeAllObjects];
        
        [self.storesArray removeAllObjects];
        [self.storesIDArray removeAllObjects];
        [self.selectedStoreArray removeAllObjects];
        
        
        NSMutableArray *stores=[self.finalDict objectForKey:@"store"];
        for (int i=0; i<stores.count; i++) {
            NSMutableDictionary *storesDict=[stores objectAtIndex:i];
            [self.storesArray addObject:[storesDict objectForKey:@"store_name"]];
            [self.storesIDArray addObject:[storesDict objectForKey:@"store_id"]];
        }
        
        
        NSMutableArray *offArray=[self.finalDict objectForKey:@"office"];
        NSMutableDictionary *offDict=[offArray objectAtIndex:0];
        self.officename.text=[offDict objectForKey:@"office_name"];
        self.officename.textColor=[UIColor blueColor];
        self.officeID=[offDict objectForKey:@"id"];
        self.selectedStore=self.officename.text;
        self.selectedPremiseID=self.officeID;
        
        NSMutableDictionary *officeDetailsDict=[[NSMutableDictionary alloc] initWithDictionary:[self.finalDict objectForKey:self.officename.text]];
        
        
        NSMutableArray *desigsArray=[officeDetailsDict objectForKey:@"available_employees"];
        for (int i=0; i<desigsArray.count; i++) {
            NSMutableDictionary *desigDict=[desigsArray objectAtIndex:i];
            [self.employeeArray addObject:[desigDict objectForKey:@"emp_name"]];
            [self.employeeIDArray addObject:[desigDict objectForKey:@"emp_id"]];
            [self.employeeImageArray addObject:[desigDict objectForKey:@"emp_encode_image"]];
            [self.empDict setObject:[desigDict objectForKey:@"emp_id"] forKey:[desigDict objectForKey:@"emp_name"]];
        }
        
        
        
        
        
        
        NSMutableArray *selected=[officeDetailsDict objectForKey:@"selected_employees"];
        for (int i=0; i<selected.count; i++) {
            NSMutableDictionary *selectedDesigDict=[selected objectAtIndex:i];
            [self.employeeSelectedArray addObject:[selectedDesigDict objectForKey:@"emp_id"]];
        }
        
        NSMutableArray *deptArray=[self.finalDict objectForKey:@"department"];
        for (int i=0; i<deptArray.count; i++) {
            [self.selectedDepartmentArray addObject:[[deptArray objectAtIndex:i]objectForKey:@"dept_id"]];
        }
        
        NSMutableArray *catArray=[self.finalDict objectForKey:@"category"];
        for (int i=0; i<catArray.count; i++) {
            [self.selectedCategoryArray addObject:[[catArray objectAtIndex:i]objectForKey:@"id"]];
        }
        
        NSMutableArray *desigArray=[self.finalDict objectForKey:@"designation"];
        for (int i=0; i<desigArray.count; i++) {
            [self.selectedDesignationArray addObject:[[desigArray objectAtIndex:i]objectForKey:@"id"]];
        }
        
        [self.filterTableView reloadData];
        
        self.departmentText.text=@"All";
        self.categoryText.text=@"All";
        self.designationText.text=@"All";
        
        [self.employeeCollectionView reloadData];
        [self.storesCollectionView reloadData];
        
    });
    
}
-(void)viewAllResponse:(id)responseList
{
    dispatch_async(dispatch_get_main_queue(), ^{
     
        [self.employeeArray removeAllObjects];
        [self.employeeIDArray removeAllObjects];
        [self.employeeImageArray removeAllObjects];
        
        NSLog(@"%@",responseList);
        
        NSMutableArray *empArray=[responseList objectForKey:@"available_employees"];
        for (int i=0; i<empArray.count; i++) {
            NSMutableDictionary *employeeDict=[empArray objectAtIndex:i];
            [self.employeeArray addObject:[employeeDict objectForKey:@"emp_name"]];
            [self.employeeIDArray addObject:[employeeDict objectForKey:@"emp_id"]];
            [self.employeeImageArray addObject:[employeeDict objectForKey:@"emp_encode_image"]];
            
            
        }
        [self.employeeCollectionView reloadData];
    });
}

@end
