//
//  documentationSettingsViewClass.m
//  Automate Firm
//
//  Created by leonine on 11/20/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "documentationSettingsViewClass.h"
#import "settingcell.h"
#import "rulesTableViewCell.h"
@implementation documentationSettingsViewClass
@synthesize  k,selectedFlag,firstTimeFlag;

-(void)awakeFromNib{
    [ self.mycollectionview registerNib:[UINib nibWithNibName:@"settingcustumcell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    self.documentationIcon=[[NSMutableArray alloc]initWithObjects:@"custom.png",@"leave.png",@"advance.png", @"loan.png",@"fine.png", @"exp_reimb.png", @"PEF.png",@"promotion.png",@"terminate.png",@"retirement.png",  nil];
    
    self.documentationSelectedIcon=[[NSMutableArray alloc]initWithObjects:@"custom.png",@"leave_active.png",@"advance_active.png", @"loan_active.png",  @"fine_active.png", @"exp_reimb_active.png", @"PEF_active.png",@"promotion_active.png",@"terminate_active.png",@"retirement_active.png",  nil];
    
    self.documentationIconLabel=[[NSMutableArray alloc]initWithObjects:@"Custom",@"Leave Applications",@"Advance Pay Applications",@"Loan Applications",@"Fine Applications",@"Expense Reimbursement Form",@"Performance Evaluation Form",@"Promotion Letter",@"Termination Letter",@"Retirement all Separation Form", nil];
    
    
    self.customRuleArray=[[NSMutableArray alloc]initWithObjects:@"Custom 1", nil];
    self.customRuleIDArray=[[NSMutableArray alloc]initWithObjects:@"1", nil];
    self.leaveArray=[[NSMutableArray alloc]init];
    self.leavesIDArray=[[NSMutableArray alloc]init];
    self.advanceArray=[[NSMutableArray alloc] initWithObjects:@"Advance", nil];
    self.loanArray=[[NSMutableArray alloc]init];
    self.loanidarray=[[NSMutableArray alloc]init];
    self.fineArray=[[NSMutableArray alloc] init];
    self.fineIDArray=[[NSMutableArray alloc]init];
    
    self.expenseArray=[[NSMutableArray alloc]init];
    self.expenseIDArray=[[NSMutableArray alloc]init];
    self.performanceArray=[[NSMutableArray alloc] initWithObjects:@"Performance Evaluation", nil];
    self.promotionArray=[[NSMutableArray alloc] initWithObjects:@"Promotion Letter", nil];
    self.terminationArray=[[NSMutableArray alloc]initWithObjects:@"Termination Letter", nil];
    self.retirementArray=[[NSMutableArray alloc]initWithObjects:@"Retirement all Separation", nil ];
    self.selectedArray=[[NSMutableArray alloc]init];
    selectedFlag=0;
    firstTimeFlag=1;
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
   // [self.myconnection viewAllLeaves:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disablecollcetionview) name:@"disableDocumentsCollectionView" object:Nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enablecollcetionview) name:@"enableDocumentsCollectionView" object:Nil];

}

-(void)disablecollcetionview
{
    [self.mycollectionview setUserInteractionEnabled:FALSE];
    
}

-(void)enablecollcetionview
{
    [self.mycollectionview setUserInteractionEnabled:TRUE];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.documentationIcon.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    settingcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
    if (firstTimeFlag==1) {
        if (indexPath.row==0) {
            [self.selectedArray addObject:indexPath];
            firstTimeFlag=0;
        }
    }
    if ([self.selectedArray containsObject:indexPath]) {
        cell.mylabel.textColor=[UIColor blueColor];
        cell.myimg.image=[UIImage imageNamed:[self.documentationSelectedIcon objectAtIndex:indexPath.row]];
    }
    else
    {
        cell.mylabel.textColor=[UIColor blackColor];
        cell.myimg.image=[UIImage imageNamed:[self.documentationIcon objectAtIndex:indexPath.row]];
    }
    
    cell.mylabel.text=[self.documentationIconLabel objectAtIndex:indexPath.row];
    
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.mycollectionview.collectionViewLayout;
    flow.sectionInset = UIEdgeInsetsMake(10, 0, 14, 0);
    
    flow.minimumLineSpacing = 50;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.selectedArray removeAllObjects];
    [self.selectedArray addObject:indexPath];
    [self.mycollectionview reloadData];
    
    if (indexPath.row==0) {
        self.selectedFlag=0;
        [self.addNewButton setTitle:@"Add New Custom Rule" forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults]setObject:@"customPaperwork" forKey:@"ruleType"];
        [self.mytableview reloadData];
        
    }
    
    if (indexPath.row==1) {
        self.selectedFlag=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"leavePaperwork" forKey:@"ruleType"];
        [self.addNewButton setTitle:@"" forState:UIControlStateNormal];
        [self.myconnection listingAllLeavePaperworkRule:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];
        
        
        
        
    }
    if (indexPath.row==2) {
        self.selectedFlag=2;
        [[NSUserDefaults standardUserDefaults]setObject:@"advancePaperwork" forKey:@"ruleType"];
        [self.myconnection viewAdvanceRuleConditions:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        [self.addNewButton setTitle:@"" forState:UIControlStateNormal];
        [self.mytableview reloadData];
        
        
    }
    
    if (indexPath.row==3) {
        self.selectedFlag=3;
         [[NSUserDefaults standardUserDefaults]setObject:@"loanPaperwork" forKey:@"ruleType"];
        [self.myconnection viewAllloanRules:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        [self.addNewButton setTitle:@"" forState:UIControlStateNormal];
        [self.mytableview reloadData];
       
        
    }
    if (indexPath.row==4) {
        self.selectedFlag=4;
        [[NSUserDefaults standardUserDefaults]setObject:@"finePaperwork" forKey:@"ruleType"];
        [self.myconnection viewAllFineRules:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        [self.addNewButton setTitle:@"" forState:UIControlStateNormal];
        [self.mytableview reloadData];
    }
    if (indexPath.row==5) {
        self.selectedFlag=5;
        [[NSUserDefaults standardUserDefaults]setObject:@"expensePaperwork" forKey:@"ruleType"];
        [self.myconnection viewAllExpenseRule:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        [self.addNewButton setTitle:@"" forState:UIControlStateNormal];
        [self.mytableview reloadData];
    }
    if (indexPath.row==6) {
        self.selectedFlag=6;
        [[NSUserDefaults standardUserDefaults]setObject:@"performancePaperwork" forKey:@"ruleType"];
        [self.addNewButton setTitle:@"Create New Performance Evaluation" forState:UIControlStateNormal];
        [self.mytableview reloadData];
    }
    if (indexPath.row==7) {
        self.selectedFlag=7;
        [[NSUserDefaults standardUserDefaults]setObject:@"promotionPaperwork" forKey:@"paperworkruleTypeAction"];
        [self.addNewButton setTitle:@"" forState:UIControlStateNormal];
        [self.mytableview reloadData];
    }
    if (indexPath.row==8) {
        self.selectedFlag=8;
        [[NSUserDefaults standardUserDefaults]setObject:@"terminationPaperwork" forKey:@"ruleType"];
        [self.addNewButton setTitle:@"" forState:UIControlStateNormal];
        [self.mytableview reloadData];
    }
    if (indexPath.row==9) {
        self.selectedFlag=9;
        [[NSUserDefaults standardUserDefaults]setObject:@"retirementPaperwork" forKey:@"ruleType"];
        [self.addNewButton setTitle:@"" forState:UIControlStateNormal];
        [self.mytableview reloadData];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectedFlag==0) {
        return self.customRuleArray.count;
    }
    if (self.selectedFlag==1){
        return self.leaveArray.count;
    }
    else if (self.selectedFlag==2){
        return self.advanceArray.count;
    }
    else if (self.selectedFlag==3){
        return self.loanArray.count;
    }
    else if (self.selectedFlag==4)
    {
        return self.fineArray.count;
    }
    else if (self.selectedFlag==5){
        return self.expenseArray.count;
    }
    else if (self.selectedFlag==6){
        return self.performanceArray.count;
    }
    else if (self.selectedFlag==7){
        return self.promotionArray.count;
    }
    else if (self.selectedFlag==8){
        return self.terminationArray.count;
    }
    else
    {
        return self.retirementArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"simplecell";
    rulesTableViewCell  *cell = (rulesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"rulesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    if (selectedFlag==0) {
        cell.mainLabel.text=[self.customRuleArray objectAtIndex:indexPath.row];
    }
    if (self.selectedFlag==1) {
        if (self.leaveArray.count > 0) {
            NSMutableDictionary *mydict=[self.leaveArray objectAtIndex:indexPath.row];
            cell.mainLabel.text=[mydict objectForKey:@"leave_name"];
            cell.descriMainLabel.hidden=TRUE;
            cell.descriLabel.text=@"";
            if ([mydict objectForKey:@"modified_date"]!=(id)[NSNull null]) {
                cell.datemodifyLabel.text=[mydict objectForKey:@"modified_date"];
            }
            else
                cell.datemodifyLabel.text=@"";

        }
    }
    if (self.selectedFlag==2) {
        
        cell.mainLabel.text=[self.advanceArray objectAtIndex:indexPath.row];
        cell.descriLabel.text=@"The installment amounts are deducted on every payment peroid of an employee.";
        cell.datemodifyLabel.text=self.dateString;
    }
    if (self.selectedFlag==3) {
        if (self.loanArray.count > 0) {
            NSMutableDictionary *mydict = [self.loanArray objectAtIndex:indexPath.row];
            cell.mainLabel.text=[mydict objectForKey:@"loan_type"];
            cell.descriLabel.text=[mydict objectForKey:@"description"];
            cell.datemodifyLabel.text=[mydict objectForKey:@"modified_date"];
        }
    }
    if (self.selectedFlag==4) {
         NSMutableDictionary *mydict = [self.fineArray objectAtIndex:indexPath.row];
        cell.mainLabel.text=[mydict objectForKey:@"violation_name"];
        cell.descriLabel.text=[mydict objectForKey:@"description"];
        cell.datemodifyLabel.text=[mydict objectForKey:@"modified_date"];
    }
    if (self.selectedFlag==5) {
        if(self.expenseArray.count>0)
        {
            NSMutableDictionary *mydict = [self.expenseArray objectAtIndex:indexPath.row];
            cell.mainLabel.text=[mydict objectForKey:@"expen_name"];
            cell.descriLabel.text=[mydict objectForKey:@"expen_desc"];
            cell.datemodifyLabel.text=[mydict objectForKey:@"expen_created_date"];
        }
    }
    if (self.selectedFlag==6) {
        cell.mainLabel.text=[self.performanceArray objectAtIndex:indexPath.row];
    }
    if (self.selectedFlag==7) {
        cell.mainLabel.text=[self.promotionArray objectAtIndex:indexPath.row];
    }
    if (self.selectedFlag==8) {
        cell.mainLabel.text=[self.terminationArray objectAtIndex:indexPath.row];
    }
    if (self.selectedFlag==9) {
        cell.mainLabel.text=[self.retirementArray objectAtIndex:indexPath.row];
    }
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disableDocumentsCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Tableview" object:Nil];
    
    if (self.selectedFlag==0) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"custom PaperworkRuleView" owner:self options:nil];
        UIView *myview=[nib objectAtIndex:0];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        
        [[self.documentsContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
        [self.documentsContainsView addSubview:myview];
    }
    
    if (self.selectedFlag==1) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[self.leavesIDArray objectAtIndex:indexPath.row] forKey:@"leaveID"];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"leaveDocumentsView" owner:self options:nil];
        UIView *myview=[nib objectAtIndex:0];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        
        [[self.documentsContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
        [self.documentsContainsView addSubview:myview];
        
    }
    if (self.selectedFlag==2) {
        
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"advanceDocumentsView" owner:self options:nil];
        UIView *myview=[nib objectAtIndex:0];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        
        rulesTableViewCell  *cell=[self.mytableview cellForRowAtIndexPath:indexPath];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:cell.mainLabel.text forKey:@"LeaveName"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leavePaperwork" object:Nil];
        [[self.documentsContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
        [self.documentsContainsView addSubview:myview];
    }
    if (self.selectedFlag==3) {
        
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"loanDocumentView" owner:self options:nil];
        UIView *myview=[nib objectAtIndex:0];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        
        rulesTableViewCell  *cell=[self.mytableview cellForRowAtIndexPath:indexPath];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:cell.mainLabel.text forKey:@"LeaveName"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leavePaperwork" object:Nil];
        [[self.documentsContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
        [self.documentsContainsView addSubview:myview];
    }
    
    if (self.selectedFlag==4)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"fineDocumentsView" owner:self options:nil];
        UIView *myview=[nib objectAtIndex:0];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        
        rulesTableViewCell  *cell=[self.mytableview cellForRowAtIndexPath:indexPath];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:cell.mainLabel.text forKey:@"LeaveName"];
        [[NSUserDefaults standardUserDefaults]setObject:cell.descriLabel.text forKey:@"description"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leavePaperwork" object:Nil];
        [[self.documentsContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
        [self.documentsContainsView addSubview:myview];
    }
    if (self.selectedFlag==5) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"expenseDocumentView" owner:self options:nil];
        UIView *myview=[nib objectAtIndex:0];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        
        rulesTableViewCell  *cell=[self.mytableview cellForRowAtIndexPath:indexPath];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:cell.mainLabel.text forKey:@"LeaveName"];
        [[NSUserDefaults standardUserDefaults]setObject:cell.descriLabel.text forKey:@"description"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leavePaperwork" object:Nil];
        [[self.documentsContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
        [self.documentsContainsView addSubview:myview];
    }
    if (self.selectedFlag==6) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"performanceEvaluationView" owner:self options:nil];
        UIView *myview=[nib objectAtIndex:0];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        
        rulesTableViewCell  *cell=[self.mytableview cellForRowAtIndexPath:indexPath];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:cell.mainLabel.text forKey:@"LeaveName"];
        [[NSUserDefaults standardUserDefaults]setObject:cell.descriLabel.text forKey:@"description"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leavePaperwork" object:Nil];
        [[self.documentsContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
        [self.documentsContainsView addSubview:myview];
    }


}
-(IBAction)createAction:(id)sender
{
    if (selectedFlag==6) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"performanceEvaluationView" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"leavePaperwork" object:Nil];
            [[self.documentsContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.documentsContainsView addSubview:myview];
        });
    }
}

-(void)initiallyLeaveRuleViewResponse:(NSMutableArray *)leavesArray
{
    
    if (leavesArray.count > 0) {
        [self.leaveArray removeAllObjects];
        [self.leavesIDArray removeAllObjects];
        for (int i=0; i<leavesArray.count; i++) {
            NSMutableDictionary *leaveDict=[leavesArray objectAtIndex:i];
            [self.leavesIDArray addObject:[leaveDict objectForKey:@"leave_id"]];
        }
        [self.leaveArray addObjectsFromArray:leavesArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mytableview reloadData];
        });
        
    }
    
    
    
}
-(void)viewAllAdvanceResponse:(id)responseList
{
    if ([responseList count]>0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults] setObject:[[responseList objectAtIndex:0]objectForKey:@"advance_id"] forKey:@"advance_ruleId"];
            self.dateString=[[responseList objectAtIndex:0]objectForKey:@"last_modified_date"];
            [self.mytableview reloadData];
            
        });
        
        
    }
    
    
}
-(void)viewAllLoanResponse:(id)responseList
{
    
    [self.loanArray removeAllObjects];
    [self.loanidarray removeAllObjects];
    
    for (int i=0; i<[responseList count]; i++) {
        NSMutableDictionary *holyDict=[responseList objectAtIndex:i];
        [self.loanidarray addObject:[holyDict objectForKey:@"loan_id"]];
    }
    [self.loanArray addObjectsFromArray:responseList];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.mytableview reloadData];
        
    });
}
-(void)viewAllFineResponse:(id)responseList
{
    
    
    [self.fineArray removeAllObjects];
    [self.fineIDArray removeAllObjects];
    for (int i=0; i<[responseList count]; i++) {
        NSMutableDictionary *holyDict=[responseList objectAtIndex:i];
        [self.fineIDArray addObject:[holyDict objectForKey:@"fine_id"]];
    }
    [self.fineArray addObjectsFromArray:responseList];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.mytableview reloadData];
        
    });
}
-(void)initiallyruleviewresponse:(NSMutableArray *)viewrulearray
{
    [self.expenseIDArray removeAllObjects];
    [self.expenseArray removeAllObjects];
    if ([viewrulearray count] > 0) {
        for (int i=0; i<[viewrulearray count]; i++) {
            NSMutableDictionary *expenseDict=[viewrulearray objectAtIndex:i];
            [self.expenseIDArray addObject:[expenseDict objectForKey:@"expen_id"]];
        }
        [self.expenseArray addObjectsFromArray:viewrulearray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.mytableview reloadData];
            
        });
        
    }
}
@end
