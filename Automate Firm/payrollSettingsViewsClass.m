//
//  payrollSettingsViewsClass.m
//  Automate Firm
//
//  Created by leonine on 12/2/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "payrollSettingsViewsClass.h"
#import "settingcell.h"
#import "rulesTableViewCell.h"
#import "settingsViewController.h"
@implementation payrollSettingsViewsClass
@synthesize k;
-(void)awakeFromNib
{
    [[NSUserDefaults standardUserDefaults]setObject:@"pay" forKey:@"ruleType"];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    [self.myconnection viewAllPayrule:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    self.payIdArray=[[NSMutableArray alloc]init];
    

    [ self.mycollectionview registerNib:[UINib nibWithNibName:@"settingcustumcell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
    self.payrollLabel=[[NSMutableArray alloc]initWithObjects:@"Pay",@"Earnings",@"Deductions",@"Overtime", nil];
    self.payrollImage=[[NSMutableArray alloc]initWithObjects:@"cash-stack-128.png",@"money_bag-128.png",@"icon05.png",@"1434035077_time.png", nil];
    
    self.selectedFlag=1;
    
    self.overtimeArray=[[NSMutableArray alloc] init];
    self.overtimeIDArray=[[NSMutableArray alloc]init];
    self.payArray=[[NSMutableArray alloc] init];
    self.earningsArray=[[NSMutableArray alloc] init];
    self.earningsIdArray=[[NSMutableArray alloc]init];
    
    self.deductDteArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.DeductionsDescArray=[[NSMutableArray alloc]initWithObjects:@"", nil];

    self.DeductionsArray=[[NSMutableArray alloc] initWithObjects:@"Income Tax", nil];
    //self.DeductionsArray=[[NSMutableArray alloc] init];
    self.DeductionsIdArray=[[NSMutableArray alloc] initWithObjects:@"0", nil];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disablecollcetionview) name:@"disablepayrollCollectionView" object:Nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enablecollcetionview) name:@"enableCollectionView" object:Nil];
    
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
    
    return self.payrollLabel.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    settingcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
    
    if (indexPath.row==0) {
        k=indexPath;
        cell.mylabel.textColor=[UIColor blueColor];
    }
    cell.myimg.image=[UIImage imageNamed:[self.payrollImage objectAtIndex:indexPath.row]];
    cell.mylabel.text=[self.payrollLabel objectAtIndex:indexPath.row];
    
    
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
        self.selectedFlag=1;
        [[NSUserDefaults standardUserDefaults]setObject:@"pay" forKey:@"ruleType"];
        [self.myconnection viewAllPayrule:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];

        [self.createRuleButton setTitle:@"Create New Pay" forState:UIControlStateNormal];
        [self.mytableview reloadData];
        
    }
    if (indexPath.row==1) {
        self.selectedFlag=2;
        [[NSUserDefaults standardUserDefaults]setObject:@"earnings" forKey:@"ruleType"];
        [self.myconnection viewAllEarningsList:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];

        [self.createRuleButton setTitle:@"Create New Earnings" forState:UIControlStateNormal];
        [self.mytableview reloadData];
        
    }
    if (indexPath.row==2) {
        self.selectedFlag=3;
        [[NSUserDefaults standardUserDefaults]setObject:@"deductions" forKey:@"ruleType"];
        [self.myconnection viewAllDeductionList:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];

        [self.createRuleButton setTitle:@"Create New Deductions" forState:UIControlStateNormal];
        [self.mytableview reloadData];
        
    }
    if (indexPath.row==3) {
        self.selectedFlag=4;
        [[NSUserDefaults standardUserDefaults]setObject:@"overtime" forKey:@"ruleType"];
        [self.myconnection viewAllOvertimeRule:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        [self.createRuleButton setTitle:@"Create New Overtime" forState:UIControlStateNormal];
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
        return self.payArray.count;
    }
    else if (self.selectedFlag==2){
        return self.earningsArray.count;
    }
    else if (self.selectedFlag==3){
        return self.DeductionsArray.count;
    }
    else
    {
        return self.overtimeArray.count;
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
        cell.mainLabel.text=[[self.payArray objectAtIndex:indexPath.row ]objectForKey:@"rule_name"];
        cell.descriLabel.text=[[self.payArray objectAtIndex:indexPath.row ]objectForKey:@"description"];
        cell.datemodifyLabel.text=[[self.payArray objectAtIndex:indexPath.row ]objectForKey:@"modified_date"];
    }
    if (self.selectedFlag==2) {
        cell.mainLabel.text=[[self.earningsArray objectAtIndex:indexPath.row ]objectForKey:@"earnings_name"];
        cell.descriLabel.text=[[self.earningsArray objectAtIndex:indexPath.row ]objectForKey:@"description"];
        cell.datemodifyLabel.text=[[self.earningsArray objectAtIndex:indexPath.row ]objectForKey:@"last_modified_date"];
    }
    if (self.selectedFlag==3) {
        cell.mainLabel.text=[self.DeductionsArray objectAtIndex:indexPath.row];
        cell.descriLabel.text=[self.DeductionsDescArray objectAtIndex:indexPath.row];
        cell.datemodifyLabel.text=[self.deductDteArray objectAtIndex:indexPath.row];
    }
    if (self.selectedFlag==4) {
        if (self.overtimeArray.count>0) {
            
            cell.mainLabel.text=[[self.overtimeArray objectAtIndex:indexPath.row] objectForKey:@"name"];
            cell.descriLabel.text=[[self.overtimeArray objectAtIndex:indexPath.row] objectForKey:@"description"];
            cell.datemodifyLabel.text=[[self.overtimeArray objectAtIndex:indexPath.row] objectForKey:@"modified_date"];
        }
        
    }
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disablepayrollCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Tableview" object:Nil];
    
    if (self.selectedFlag==1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults]setObject:@"update" forKey:@"payAction"];
            [[NSUserDefaults standardUserDefaults]setObject:[self.payIdArray objectAtIndex:indexPath.row] forKey:@"ruleid"];
            // if (indexPath.row==0) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"paySettingsView" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.payrollContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.payrollContainsView addSubview:myview];
            //        }
            //        else
            //        {
            //            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"paySettingsView" owner:self options:nil];
            //            UIView *myview=[nib objectAtIndex:0];
            //            [[NSUserDefaults standardUserDefaults]setObject:@"Update" forKey:@"payAction"];
            //            CATransition *applicationLoadViewIn =[CATransition animation];
            //            [applicationLoadViewIn setDuration:0.5];
            //            [applicationLoadViewIn setType:kCATransitionReveal];
            //            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            //            [[self.payrollContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            //            [self.payrollContainsView addSubview:myview];
            //        }

        });
        
    }
    else if (self.selectedFlag==2)
    {
         dispatch_async(dispatch_get_main_queue(), ^{
             [[NSUserDefaults standardUserDefaults]setObject:@"update" forKey:@"earningsAction"];
            [[NSUserDefaults standardUserDefaults]setObject:[self.earningsIdArray objectAtIndex:indexPath.row] forKey:@"earningRuleID"];
             
             NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"earningsview" owner:self options:nil];
             UIView *myview=[nib objectAtIndex:0];
             CATransition *applicationLoadViewIn =[CATransition animation];
             [applicationLoadViewIn setDuration:0.5];
             [applicationLoadViewIn setType:kCATransitionReveal];
             [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
             [[self.payrollContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
             [self.payrollContainsView addSubview:myview];
         });
        
    }
    else if (self.selectedFlag==3)
    {
        if (indexPath.row==0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"incometaxView" owner:self options:nil];
                UIView *myview=[nib objectAtIndex:0];
                CATransition *applicationLoadViewIn =[CATransition animation];
                [applicationLoadViewIn setDuration:0.5];
                [applicationLoadViewIn setType:kCATransitionReveal];
                [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
                [[self.payrollContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
                [self.payrollContainsView addSubview:myview];
            });
            
            
        }
        else
        {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [[NSUserDefaults standardUserDefaults]setObject:@"update" forKey:@"deductionsAction"];
                 [[NSUserDefaults standardUserDefaults]setObject:[self.DeductionsIdArray objectAtIndex:indexPath.row] forKey:@"deductionRuleID"];
                 NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"deductionsView" owner:self options:nil];
                 UIView *myview=[nib objectAtIndex:0];
                 CATransition *applicationLoadViewIn =[CATransition animation];
                 [applicationLoadViewIn setDuration:0.5];
                 [applicationLoadViewIn setType:kCATransitionReveal];
                 [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
                 [[self.payrollContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
                 [self.payrollContainsView addSubview:myview];
                 
            });
        }
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults]setObject:@"update" forKey:@"overtimeAction"];
            [[NSUserDefaults standardUserDefaults]setObject:[self.overtimeIDArray objectAtIndex:indexPath.row] forKey:@"overtimeID"];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"overtimeSettingsView" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.payrollContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.payrollContainsView addSubview:myview];
        });
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

        if (editingStyle==UITableViewCellEditingStyleDelete) {
       
            
            

            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Delete?"
                                       message:@"Are you sure you want to delete?"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           
                                                           //PAY
                                                            if (self.selectedFlag==1) {
                                                                [self.myconnection deletePayRule:[self.payIdArray objectAtIndex:indexPath.row] officeid:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
                                                                [self.payIdArray removeObjectAtIndex:indexPath.row];
                                                                [self.payArray removeObjectAtIndex:indexPath.row];
                                                                [self.mytableview reloadData];
                                                            }
                                                           //earnings
                                                           if (self.selectedFlag==2) {
                                                               //[self.myconnection deleteEarningRule:[self.earningsIdArray objectAtIndex:indexPath.row]:@"1"];
                                                               [self.myconnection deleteEarningRule:[self.earningsIdArray objectAtIndex:indexPath.row] typeOfDel:@"1"];
                                                               [self.earningsIdArray removeObjectAtIndex:indexPath.row];
                                                               [self.earningsArray removeObjectAtIndex:indexPath.row];
                                                               [self.mytableview reloadData];
                                                           }
                                                           if (self.selectedFlag==3) {
                                                               
                                                               if ((!(indexPath.row==0))&&(self.selectedFlag==3)) {
                                                               

                                                               [self.myconnection deleteDeductionRule:[self.DeductionsIdArray objectAtIndex:indexPath.row] idFlag:@"1"];
                                                               [self.DeductionsIdArray removeObjectAtIndex:indexPath.row];
                                                               [self.DeductionsArray removeObjectAtIndex:indexPath.row];
                                                               [self.mytableview reloadData];
                                                               }
                                                               else{
                                                                   
                                                                   UIAlertController *alert= [UIAlertController
                                                                                              alertControllerWithTitle:@"Warning"
                                                                                              message:@"You Are not Allowed to Delete IncomeTax Rule "
                                                                                              preferredStyle:UIAlertControllerStyleAlert];
                                                                   
                                                                   UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                                                                              handler:^(UIAlertAction * action){
                                                                                                                  [self.mytableview setEditing:false animated:YES];

                                                                                                                  
  
                                                                                                              }];
                                                                   [alert addAction:ok];
                                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                                       
                                                                       [(settingsViewController *)[self.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
                                                                   });

                                                               }
                                                               
                                                           }
                                                           
                                                           //Overtime
                                                           if (self.selectedFlag==4) {
                                                               [self.myconnection deleteOvertimeRule:[self.overtimeIDArray objectAtIndex:indexPath.row]];
                                                               [self.overtimeIDArray removeObjectAtIndex:indexPath.row];
                                                               [self.overtimeArray removeObjectAtIndex:indexPath.row];
                                                               [self.mytableview reloadData];
                                                           }
                                                        
                                                           

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
-(IBAction)createNewRuleAction:(id)sender
{
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disablepayrollCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Tableview" object:Nil];
    if (self.selectedFlag==1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults]setObject:@"create" forKey:@"payAction"];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"paySettingsView" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self.payrollContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
                [self.payrollContainsView addSubview:myview];
            });
        });
        
    }
    if (self.selectedFlag==2){
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults]setObject:@"create" forKey:@"earningsAction"];
            app.earningRuleId=@"0";
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"earningsview" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.payrollContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.payrollContainsView addSubview:myview];
        });
        
    }
    if (self.selectedFlag==3) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults]setObject:@"create" forKey:@"deductionsAction"];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"deductionsView" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.payrollContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.payrollContainsView addSubview:myview];
        });
        
    }
    if (self.selectedFlag==4) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults]setObject:@"create" forKey:@"overtimeAction"];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"overtimeSettingsView" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.payrollContainsView layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.payrollContainsView addSubview:myview];
        });
        
    }
}

//<<--------------------Service Service Part-------------------------------->>

//View All Pay Rule
-(void)viewAllPayResponse:(id)responseList
{
    if ([responseList count]>0) {
        [self.payArray removeAllObjects];
        [self.payIdArray removeAllObjects];
        
        for (int i=0; i<[[responseList objectForKey:@"rule_list"]count]; i++) {
            NSMutableDictionary *Dict=[[responseList objectForKey:@"rule_list"] objectAtIndex:i];
            [self.payIdArray addObject:[Dict objectForKey:@"id"]];
            // [self.payIdArray addObject:[holyDict objectForKey:@"rule_name"]];
        }
        [self.payArray addObjectsFromArray:[responseList objectForKey:@"rule_list"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.mytableview reloadData];
            
        });
    }
    
    
}

//View All Overtime rule
-(void)initiallyruleviewresponse:(NSMutableArray *)viewrulearray
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (viewrulearray.count > 0) {
            [self.overtimeIDArray removeAllObjects];
            [self.overtimeArray removeAllObjects];
            for (int i=0; i<viewrulearray.count; i++) {
                NSMutableDictionary *overtimeDict=[viewrulearray objectAtIndex:i];
                [self.overtimeIDArray addObject:[overtimeDict objectForKey:@"id"]];
            }
            [self.overtimeArray addObjectsFromArray:viewrulearray];
            [self.mytableview reloadData];
        }
        
    });
}


//View All Earnings Rule
-(void)allearningsResponse :(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([responseData count] > 0) {
            [self.earningsIdArray removeAllObjects];
            [self.earningsArray removeAllObjects];
            //[self.earningdescArray removeAllObjects];
            for (int i=0; i<[responseData count]; i++) {
                NSMutableDictionary *Dict=[responseData objectAtIndex:i];
                [self.earningsIdArray addObject:[Dict objectForKey:@"id"]];
            }
            [self.earningsArray addObjectsFromArray:responseData];
            [self.mytableview reloadData];
        }
        
    });
}

//View all Deduction rules

-(void)viewalldedctionResponse:(id)responseDta
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([responseDta count] > 0) {
            [self.DeductionsArray removeAllObjects];
            [self.DeductionsIdArray removeAllObjects];
            [self.DeductionsDescArray removeAllObjects];
            [self.deductDteArray removeAllObjects];
            [self.DeductionsArray addObject:@"Income Tax"];
            [self.DeductionsIdArray addObject:@"0"];
            [self.DeductionsDescArray addObject:@""];
            [self.deductDteArray addObject:@""];
            for (int i=0; i<[responseDta count]; i++) {
                NSMutableDictionary *Dict=[responseDta objectAtIndex:i];
                [self.DeductionsIdArray addObject:[Dict objectForKey:@"d_id"]];
                [self.DeductionsArray addObject:[Dict objectForKey:@"d_name"]];
                [self.DeductionsDescArray addObject:[Dict objectForKey:@"description"]];
                [self.deductDteArray addObject:[Dict objectForKey:@"modified_date"]];

            }
            [self.mytableview reloadData];
        }
        
    });
    
}



@end
