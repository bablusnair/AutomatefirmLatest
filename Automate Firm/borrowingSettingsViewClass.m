//
//  borrowingSettingsViewClass.m
//  Automate Firm
//
//  Created by leonine on 11/7/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "borrowingSettingsViewClass.h"
#import "settingcell.h"
#import "rulesTableViewCell.h"
#import "settingsViewController.h"
@implementation borrowingSettingsViewClass
@synthesize k;
-(void)awakeFromNib
{
    

  
    [ self.mycollectionview registerNib:[UINib nibWithNibName:@"settingcustumcell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    self.borrowingLabel=[[NSMutableArray alloc]initWithObjects:@"Advances",@"Loans",@"Fines",@"Expense Reimbursement", nil];
    self.borrowingImage=[[NSMutableArray alloc]initWithObjects:@"icon01.png",@"icon02.png",@"icon03.png",@"icon04.png", nil];
    
    self.loanidarray=[[NSMutableArray alloc] init];
    self.loanarray=[[NSMutableArray alloc] init];
    self.advancearray=[[NSMutableArray alloc] initWithObjects:@"Advances", nil];
    self.finearray=[[NSMutableArray alloc] init] ;
    
     self.fineIdarray=[[NSMutableArray alloc] init] ;
    self.expenseArray=[[NSMutableArray alloc] init];
    self.expenseIDArray=[[NSMutableArray alloc]init];
    self.selectedFlag=1;
    
    [self.createNewRuleButton setTitle:@"" forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disablecollcetionview) name:@"disableCollectionView" object:Nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enablecollcetionview) name:@"enableCollectionView" object:Nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewallloanserviceurl) name:@"viewallloanservice" object:Nil];

    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    [[NSUserDefaults standardUserDefaults]setObject:@"advance" forKey:@"ruleType"];
    [self.myconnection viewAdvanceRuleConditions:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
}


-(void)viewallloanserviceurl
{
    
     [self.myconnection viewAllloanRules:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    
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
    
    return self.borrowingLabel.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
  
        settingcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
    
        if (indexPath.row==0) {
            k=indexPath;
            cell.mylabel.textColor=[UIColor blueColor];
        }
        cell.myimg.image=[UIImage imageNamed:[self.borrowingImage objectAtIndex:indexPath.row]];
        cell.mylabel.text=[self.borrowingLabel objectAtIndex:indexPath.row];
        
        
        UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.mycollectionview.collectionViewLayout;
        flow.sectionInset = UIEdgeInsetsMake(10, 0, 14, 0);
        
        flow.minimumLineSpacing = 70;
        return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    settingcell *cell1=(settingcell *)[self.mycollectionview cellForItemAtIndexPath:k];
    cell1.mylabel.textColor=[UIColor blackColor];
    
    settingcell *cell=(settingcell *)[self.mycollectionview cellForItemAtIndexPath:indexPath];
    
    cell.mylabel.textColor=[UIColor blueColor];

        
        
    if (indexPath.row==0) {
        [[NSUserDefaults standardUserDefaults]setObject:@"advance" forKey:@"ruleType"];
        self.selectedFlag=1;
        [self.myconnection viewAdvanceRuleConditions:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        [self.createNewRuleButton setTitle:@"" forState:UIControlStateNormal];
        [self.mytableview reloadData];
            
    }
    if (indexPath.row==1) {
        [[NSUserDefaults standardUserDefaults]setObject:@"loan" forKey:@"ruleType"];
        self.selectedFlag=2;
        [self.createNewRuleButton setTitle:@"Create New Loan" forState:UIControlStateNormal];
        [self.myconnection viewAllloanRules:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        [self.mytableview reloadData];
           
    }
    
    if (indexPath.row==2) {
        [[NSUserDefaults standardUserDefaults]setObject:@"fine" forKey:@"ruleType"];
        self.selectedFlag=3;
        [self.createNewRuleButton setTitle:@"Create New Fine" forState:UIControlStateNormal];
          [self.myconnection viewAllFineRules:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];

        [self.mytableview reloadData];
          
    }
    if (indexPath.row==3) {
        [[NSUserDefaults standardUserDefaults]setObject:@"expense" forKey:@"ruleType"];
        self.selectedFlag=4;
        [self.createNewRuleButton setTitle:@"Create New Expense" forState:UIControlStateNormal];
        [self.myconnection viewAllExpenseRule:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        [self.mytableview reloadData];
    }
    
    
        
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    settingcell *cell=(settingcell *)[self.mycollectionview cellForItemAtIndexPath:indexPath];
    
    cell.mylabel.textColor=[UIColor blackColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectedFlag==1){
        return self.advancearray.count;
    }
    else if (self.selectedFlag==2){
        return self.loanarray.count;
    }
    else if (self.selectedFlag==3){
        return self.finearray.count;
    }
    else
    {
        return self.expenseArray.count;
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
    if (self.selectedFlag==1) {
        cell.mainLabel.text=[self.advancearray objectAtIndex:indexPath.row];
        cell.descriLabel.text=@"The installment amounts are deducted on every payment peroid of an employee.";
        cell.datemodifyLabel.text=self.dateString;
    }
    if (self.selectedFlag==2) {
        NSMutableDictionary *mydict = [self.loanarray objectAtIndex:indexPath.row];
        cell.mainLabel.text=[mydict objectForKey:@"loan_type"];
        cell.descriLabel.text=[mydict objectForKey:@"description"];
        cell.datemodifyLabel.text=[mydict objectForKey:@"modified_date"];
    }
    if (self.selectedFlag==3) {
        cell.mainLabel.text=[[self.finearray objectAtIndex:indexPath.row] objectForKey:@"violation_name"];
        cell.descriLabel.text=[[self.finearray objectAtIndex:indexPath.row] objectForKey:@"description"];
        cell.datemodifyLabel.text=[[self.finearray objectAtIndex:indexPath.row] objectForKey:@"modified_date"];
    }
    if (self.selectedFlag==4) {
        if (self.expenseArray.count==0) {
            cell.mainLabel.text=[self.expenseArray objectAtIndex:indexPath.row];
        }
        else
        {
            NSMutableDictionary *mydict = [self.expenseArray objectAtIndex:indexPath.row];
            cell.mainLabel.text=[mydict objectForKey:@"expen_name"];
            cell.descriLabel.text=[mydict objectForKey:@"expen_desc"];
            cell.datemodifyLabel.text=[mydict objectForKey:@"expen_created_date"];
        }
        
    }
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disableCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Tableview" object:Nil];
    if (self.selectedFlag==1) {
        
        [[NSUserDefaults standardUserDefaults]setObject:@"update" forKey:@"advanceAction"];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"advancesettingsview" owner:self options:nil];
        UIView *myview=[nib objectAtIndex:0];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.borrowingContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
        [self.borrowingContainsView addSubview:myview];
        
        
        
    }
    else if (self.selectedFlag==2)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"update" forKey:@"loanAction"];
        [[NSUserDefaults standardUserDefaults] setObject:[self.loanidarray objectAtIndex:indexPath.row] forKey:@"Loan_ruleId"];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"loansettingsview" owner:self options:nil];
        
        
        AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        myappde.loan_idstring=@"0";
        
        myappde.includedesignationflag=0;
        
        myappde.myselectedTag=0;
        
        myappde.designation_tile=@"";
        
        [myappde.loantileid_array removeAllObjects];
        
        [myappde.appde_locgroupdictionary removeAllObjects];
        
        [myappde.appde_localdict removeAllObjects];
        
        [myappde.loanupdate_dictionary removeAllObjects];

        
        
        
        
        
        UIView *myview=[nib objectAtIndex:0];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.borrowingContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
        [self.borrowingContainsView addSubview:myview];
    }
    else if (self.selectedFlag==3)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"update" forKey:@"FineSettingAction"];
        [[NSUserDefaults standardUserDefaults] setObject:[self.fineIdarray objectAtIndex:indexPath.row] forKey:@"fine_Id"];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"fineSettingsView" owner:self options:nil];
        UIView *myview=[nib objectAtIndex:0];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.borrowingContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
        [self.borrowingContainsView addSubview:myview];
        
    }
    else if (self.selectedFlag==4)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"update" forKey:@"expenseAction"];
        [[NSUserDefaults standardUserDefaults] setObject:[self.expenseIDArray objectAtIndex:indexPath.row] forKey:@"expense_ID"];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"expenseReimbursementSettingsView" owner:self options:nil];
        UIView *myview=[nib objectAtIndex:0];
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.borrowingContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
        [self.borrowingContainsView addSubview:myview];
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        if (self.selectedFlag==3) {


        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Delete?"
                                   message:@"Are you sure you want to delete?"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       NSString *rid=[self.fineIdarray objectAtIndex:indexPath.row];
                                                       [self.myconnection deleteFineSetingRule:rid];
                                                       [self.fineIdarray removeObjectAtIndex:indexPath.row];
                                                       [self.finearray removeObjectAtIndex:indexPath.row];
                                                       [self.mytableview reloadData];
                                                       
                                                   }];
        
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                            [self.mytableview setEditing:false animated:YES];
                                                       }];
        [alert addAction:ok];
        [alert addAction:cancel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });
        
        
    }
        else if(self.selectedFlag==2) {
            
            
            
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Delete?"
                                       message:@"Are you sure you want to delete?"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           NSString *rid=[self.loanidarray objectAtIndex:indexPath.row];
                                                           [self.myconnection deletethemainloanRules:rid];
                                                           [self.loanidarray removeObjectAtIndex:indexPath.row];
                                                           [self.loanarray removeObjectAtIndex:indexPath.row];
                                                           [self.mytableview reloadData];
                                                           
                                                       }];
            
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                               [self.mytableview setEditing:false animated:YES];
                                                           }];
            [alert addAction:ok];
            [alert addAction:cancel];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [(settingsViewController *)[self.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
            });
            
            
        }
        else if (self.selectedFlag==4)
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Delete?"
                                       message:@"Are you sure you want to delete?"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           NSString *rid=[self.expenseIDArray objectAtIndex:indexPath.row];
                                                           [self.myconnection deleteExpenseRule:rid];
                                                           [self.expenseIDArray removeObjectAtIndex:indexPath.row];
                                                           [self.expenseArray removeObjectAtIndex:indexPath.row];
                                                           [self.mytableview reloadData];
                                                           
                                                       }];
            
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                               [self.mytableview setEditing:false animated:YES];
                                                           }];
            [alert addAction:ok];
            [alert addAction:cancel];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [(settingsViewController *)[self.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
            });
        }
        

        
}
        
}

-(IBAction)createRuleButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disableCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Tableview" object:Nil];
    
    if (self.selectedFlag==2) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults] setObject:@"create" forKey:@"loanAction"];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"loansettingsview" owner:self options:nil];
            
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loantype"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"abbrevation"];
            
            AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
            
            myappde.loan_idstring=@"0";
            
            myappde.includedesignationflag=0;
            
            myappde.myselectedTag=0;
            
            myappde.designation_tile=@"";
            
            [myappde.loantileid_array removeAllObjects];
            
            [myappde.appde_locgroupdictionary removeAllObjects];
            
            [myappde.appde_localdict removeAllObjects];
            
            [myappde.loanupdate_dictionary removeAllObjects];
            
            
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.borrowingContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.borrowingContainsView addSubview:myview];
        });
    }
    else if (self.selectedFlag==3)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults] setObject:@"create" forKey:@"FineSettingAction"];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"fineSettingsView" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.borrowingContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.borrowingContainsView addSubview:myview];
        });
    }
    else if (self.selectedFlag==4)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults] setObject:@"create" forKey:@"expenseAction"];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"expenseReimbursementSettingsView" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.borrowingContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.borrowingContainsView addSubview:myview];
        });
        
    }
}
-(void)viewAllFineResponse:(id)responseList
{
   
    
    [self.finearray removeAllObjects];
    [self.fineIdarray removeAllObjects];
    for (int i=0; i<[responseList count]; i++) {
        NSMutableDictionary *holyDict=[responseList objectAtIndex:i];
        [self.fineIdarray addObject:[holyDict objectForKey:@"fine_id"]];
    }
    [self.finearray addObjectsFromArray:responseList];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.mytableview reloadData];
        
    });
    
    
    

}


-(void)viewAllLoanResponse:(id)responseList
{
    
    [self.loanarray removeAllObjects];
    [self.loanidarray removeAllObjects];
 
    for (int i=0; i<[responseList count]; i++) {
        NSMutableDictionary *holyDict=[responseList objectAtIndex:i];
        [self.loanidarray addObject:[holyDict objectForKey:@"loan_id"]];
    }
    [self.loanarray addObjectsFromArray:responseList];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.mytableview reloadData];
        
    });

    
}

-(void)deleteloanrules:(NSString *)deletedresponse
{
    
    if ([deletedresponse isEqualToString:@"1"]) {
        
        [self viewallloanserviceurl];
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
//View all Expense Reimbursement

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
