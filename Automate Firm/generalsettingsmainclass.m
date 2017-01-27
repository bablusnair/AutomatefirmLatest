///
//  generalsettingsmainclass.m
//  Automate Firm
//
//  Created by leonine on 18/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "generalsettingsmainclass.h"
#import "officesetupcustomcell.h"
#import "settingcell.h"
#import "createnewdesignationviewclass.h"
#import "createnewbankviewclass.h"
#import "settingsViewController.h"
#import "currencySettingsViewClass.h"
#import "AppDelegate.h"

@implementation generalsettingsmainclass
@synthesize k,k1,selectedflag;

-(void)awakeFromNib
{
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    [self.myconnection viewAllDesignations];

    self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self.app hudStart:self];
    
    self.generaldesignationarray=[[NSMutableArray alloc]init];
    self.generalDesignationIDArray=[[NSMutableArray alloc]init];
    self.dummyDesignationArray=[[NSMutableArray alloc]init];
    self.dummyDesignationIDArray=[[NSMutableArray alloc]init];

    self.generalbrancharray=[[NSMutableArray alloc] init];
    self.generalBranchIDArray=[[NSMutableArray alloc]init];
    
    
    self.generalCurrencyarray=[[NSMutableArray alloc]initWithObjects:@"Rupee",@"Dollar", @"Dirham", @"Riyal", @"Dinar",@"Euro",@"Pound", nil];

    
    [ self.generalsettingcollectionview registerNib:[UINib nibWithNibName:@"settingcustumcell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
    self.dummyarray=[[NSMutableArray alloc]initWithObjects:@"Project Manager",@"Hr Coordinator", @"Market Analyst", @"Sales Coordinator", @"UI Designer",@"Project Manager2",@"Hr Coordinator2", @"Market Analyst2", @"Sales Coordinator2", @"UI Designer2", nil];
    
    
    self.iconsarray=[[NSMutableArray alloc]initWithObjects:@"designation.png",@"vehicle.png", @"bank.png", @"currency.png", @"icon_others.png", nil];
    
    self.iconnamesarray=[[NSMutableArray alloc]initWithObjects:@"Designations",@"Vehiles", @"Banks", @"Currencies", @"Others", nil];
    
    self.othersArray=[[NSMutableArray alloc]initWithObjects:@"Portal",@"Autocoding",@"Documents",@"Business Template", nil];
    self.othersIconArray=[[NSMutableArray alloc] initWithObjects:@"icon_5.png",@"autocoding.png",@"icon_document.png",@"businessTemplate.png", nil];
    
    self.imagestring=@"designation.png";
    selectedflag=1;
    
    
    self.dateString=@"";
    self.portalLastModifiedDate=@"";
    self.businessTemplateLastModifiedDate=@"";
    self.autocodeLastModifiedDate=@"";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disablecollcetionview) name:@"disableGeneralSettings" object:Nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enablecollcetionview) name:@"enableGeneralSettings" object:Nil];
    
}
-(void)disablecollcetionview
{
    [self.generalsettingcollectionview setUserInteractionEnabled:FALSE];
    
}

-(void)enablecollcetionview
{
    [self.generalsettingcollectionview setUserInteractionEnabled:TRUE];
    [self.myconnection displaymodifiedDateFunction:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    [self.generalsettingstableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.generalsettingstableview) {
        if (selectedflag==1)
        {
            return self.generaldesignationarray.count;
        }
        else  if (selectedflag==3)
        {
            return  self.generalbrancharray.count;
        }
        else if(selectedflag==4)
        {
            return  self.generalCurrencyarray.count;
        }
        
        else
        {
            return self.othersArray.count;
        }
    }
    else
    {
        return  self.dummyDesignationArray.count;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.generalsettingstableview) {
        static NSString *simpleTableIdentifier = @"simplecell";
        officesetupcustomcell  *cell = (officesetupcustomcell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"officesetupcell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        if (selectedflag==1) {
            if (self.generaldesignationarray.count == 0) {
                cell.mainLabel.text=[self.generaldesignationarray objectAtIndex: indexPath.row];
                cell.mainimage.image=[UIImage imageNamed:self.imagestring];
            }
            else
            {
                NSMutableDictionary *mydict=[self.generaldesignationarray objectAtIndex:indexPath.row];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.mainLabel.text=[mydict objectForKey:@"designation_title"];
                    cell.descriptionLabel.text=[mydict objectForKey:@"designation_description"];
                    cell.lastModifiedLabel.text=[mydict objectForKey:@"desig_modifide_date"];
                    cell.mainimage.image=[UIImage imageNamed:self.imagestring];
                    self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                    [self.app hudStop];
                });
            }
        }
        else if (selectedflag==2)
        {
            
        }
        else if (selectedflag==3)
        {
            if (self.generalbrancharray.count==0) {
                cell.mainLabel.text=[self.generalbrancharray objectAtIndex: indexPath.row];
                cell.mainimage.image=[UIImage imageNamed:self.imagestring];
            }
            else
            {
                
                NSMutableDictionary *mydict=[self.generalbrancharray objectAtIndex:indexPath.row];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.mainLabel.text=[mydict objectForKey:@"bank_name"];
                    cell.descriptionLabel.text=[mydict objectForKey:@"bank_description"];
                    cell.lastModifiedLabel.text=[mydict objectForKey:@"bank_modifide_date"];
                    cell.mainimage.image=[UIImage imageNamed:self.imagestring];
                    
                    self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                    [self.app hudStop];
                    
                });
                
            }
            
        }
        else if(selectedflag==4)
        {
            cell.mainLabel.text=[self.generalCurrencyarray objectAtIndex:indexPath.row];
            cell.mainimage.image=[UIImage imageNamed:self.imagestring];
            
        }
        else
        {
            cell.mainLabel.text=[self.othersArray objectAtIndex:indexPath.row];
            cell.mainimage.image=[UIImage imageNamed:[self.othersIconArray objectAtIndex:indexPath.row]];
            cell.descriptionLabel.text=@"";
            
            if (indexPath.row==0)
            {
                cell.lastModifiedLabel.text=self.portalLastModifiedDate;
            }
            else if (indexPath.row==1)
            {
                cell.lastModifiedLabel.text=self.autocodeLastModifiedDate;
            }
            else if (indexPath.row==2) {
                cell.lastModifiedLabel.text=self.dateString;
            }
            else if (indexPath.row==3)
            {
                cell.lastModifiedLabel.text=self.businessTemplateLastModifiedDate;
            }
        }
        
        return cell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        NSMutableDictionary *mydict=[self.dummyDesignationArray objectAtIndex:indexPath.row];
        cell.textLabel.text=[mydict objectForKey:@"designation_title"];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0];
        return cell;
    }
    
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.iconsarray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    settingcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
    cell.myimg.image=[UIImage imageNamed:[self.iconsarray objectAtIndex:indexPath.row]];
    cell.mylabel.text=[self.iconnamesarray objectAtIndex:indexPath.row];

        if (indexPath.row==0) {
            k=indexPath;
            cell.myimg.image=[UIImage imageNamed:@"designation - sel.png"];
        }
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.generalsettingcollectionview.collectionViewLayout;
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flow.minimumLineSpacing = 30;
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    settingcell *cell1=(settingcell *)[self.generalsettingcollectionview cellForItemAtIndexPath:k];
    cell1.myimg.image=[UIImage imageNamed:@"designation.png"];
    settingcell *cell2=(settingcell *)[self.generalsettingcollectionview cellForItemAtIndexPath:k1];
    cell2.myimg.image=[UIImage imageNamed:self.nsindeximagestring];
    
    settingcell *cell=(settingcell *)[self.generalsettingcollectionview cellForItemAtIndexPath:indexPath];
    
    if (indexPath.row==0) {
        selectedflag=1;
        cell.myimg.image=[UIImage imageNamed:@"designation - sel.png"];
        self.imagestring= @"designation.png";
        [self.generalsettingstableview reloadData];
        [self.createnewbutton setTitle:@"Add New Designation" forState:UIControlStateNormal];
        k1=indexPath;
        self.nsindeximagestring=@"designation.png";
        [self.myconnection viewAllDesignations];
        [self.app hudStart:self];
         //self.generalsettingstableview.editing=YES;
    }
    if (indexPath.row==2) {
        
        selectedflag=3;
        self.imagestring= @"bank.png";
        [self.generalsettingstableview reloadData];
        cell.myimg.image=[UIImage imageNamed:@"bank - sel.png"];
        [self.createnewbutton setTitle:@"Add New Bank" forState:UIControlStateNormal];
        k1=indexPath;
        self.nsindeximagestring=@"bank.png";
        [self.myconnection viewAllBank];
        [self.app hudStart:self];
         //self.generalsettingstableview.editing=YES;
    }
    
     if (indexPath.row==3) {
        
         selectedflag=4;
         self.imagestring= @"currency.png";
         [self.generalsettingstableview reloadData];
         cell.myimg.image=[UIImage imageNamed:@"currency - sel.png"];
         [self.createnewbutton setTitle:@"" forState:UIControlStateNormal];
         k1=indexPath;
         self.nsindeximagestring=@"currency.png";
           //self.generalsettingstableview.editing=YES;
     }
    if (indexPath.row==4) {
        [self.myconnection displaymodifiedDateFunction:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        selectedflag=5;
      //  self.generalsettingstableview.editing=NO;
        self.imagestring=@"icon_others.png";
        [self.generalsettingstableview reloadData];
        cell.myimg.image=[UIImage imageNamed:@"icon_others_select.png"];
        [self.createnewbutton setTitle:@"" forState:UIControlStateNormal];
        k1=indexPath;
        self.nsindeximagestring=@"icon_others.png";
    }
    
}

//Add New Button Action
-(IBAction)addnewbuttonaction:(id)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Tableview" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disableGeneralSettings" object:Nil];
    
    [self.generalsettingstableview setEditing:false animated:YES];
    
    UIButton *mybutton=(UIButton *)sender;
    
    for (UIView *view in self.generalsettingscontainsview.subviews) {
        
        if ([view isKindOfClass:[createnewdesignationviewclass class]] || [view isKindOfClass:[createnewbankviewclass class]] || [view isKindOfClass:[currencySettingsViewClass class]]) {
            
            [view removeFromSuperview];
        }
    }
    
    if ([mybutton.currentTitle isEqualToString:@"Add New Designation"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"create" forKey:@"desigAction"];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"createnewdesignationview" owner:self options:nil];
        [self.generalsettingscontainsview addSubview:[nib objectAtIndex:0]];
        
    }
    
    if ([mybutton.currentTitle isEqualToString:@"Add New Bank"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"create" forKey:@"bankAction"];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"createnewbank" owner:self options:nil];
        [self.generalsettingscontainsview addSubview:[nib objectAtIndex:0]];
        
    }
    
    if ([mybutton.currentTitle isEqualToString:@"Add New Currency"]) {
        
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"currencySettingsView" owner:self options:nil];
        [self.generalsettingscontainsview addSubview:[nib objectAtIndex:0]];
        
    }
    
}

//Deleting Rule Style
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        if (selectedflag==1) {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Delete?"
                                       message:@"Are you sure you want to delete?"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           
                                                           
                                                           NSString *str=[self.generalDesignationIDArray objectAtIndex:indexPath.row];
                                                           self.inPath=indexPath;
                                                           

                                                           [self.myconnection deleteDesignation:str];
                                                           
                                                           

                                                       }];
            
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                                [self.generalsettingstableview setEditing:false animated:YES];
                                                           }];
            [alert addAction:ok];
            [alert addAction:cancel];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [(settingsViewController *)[self.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
            });
            
            
        }
        else   if (selectedflag==3)
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Delete?"
                                       message:@"Are you sure you want to delete?"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           
                                                           
                                                           NSString *str=[self.generalBranchIDArray objectAtIndex:indexPath.row];
                                                           [self.generalbrancharray removeObjectAtIndex:indexPath.row];
                                                           [self.generalBranchIDArray removeObjectAtIndex:indexPath.row];
                                                           
                                                           [self.myconnection deleteBank:str];
                                                           
                                                           [self.generalsettingstableview reloadData];

                                                           
                                                       }];
            
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                               [self.generalsettingstableview setEditing:false animated:YES];
                                                           }];
            [alert addAction:ok];
            [alert addAction:cancel];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [(settingsViewController *)[self.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
            });
            
    }
    
        
    else
    {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Delete?"
                                   message:@"Are you sure you want to delete?"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       
                                                       
                                                       [self.generalCurrencyarray removeObjectAtIndex:indexPath.row];
                                                       [self.generalsettingstableview reloadData];
                                                       
                                                       
                                                   }];
        
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                       }];
        [alert addAction:ok];
        [alert addAction:cancel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });

    }
   
  }
   
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Detemine if it's in editing mode
    
    if (selectedflag==5)
    {
        return UITableViewCellEditingStyleNone;
    }
    else
    
        return UITableViewCellEditingStyleDelete;

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.generalsettingstableview) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Tableview" object:Nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disableGeneralSettings" object:Nil];
        
        // [self.generalsettingstableview setEditing:false animated:YES];
        
        officesetupcustomcell *cell1 = (officesetupcustomcell *)[self.generalsettingstableview cellForRowAtIndexPath:indexPath];
        
        
        for (UIView *view in self.generalsettingscontainsview.subviews) {
            
            if ([view isKindOfClass:[createnewdesignationviewclass class]] || [view isKindOfClass:[createnewbankviewclass class]] || [view isKindOfClass:[currencySettingsViewClass class]]) {
                
                [view removeFromSuperview];
            }
        }
        
        if (selectedflag==1) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"update" forKey:@"desigAction"];
            
            NSString *str=[self.generalDesignationIDArray objectAtIndex:indexPath.row];
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"desigID"];
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"createnewdesignationview" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.generalsettingscontainsview layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.generalsettingscontainsview addSubview:myview];
            
        }
        
        if (selectedflag==3) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"update" forKey:@"bankAction"];
            
            NSString *str=[self.generalBranchIDArray objectAtIndex:indexPath.row];
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"bankID"];
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"createnewbank" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.generalsettingscontainsview layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.generalsettingscontainsview addSubview:myview];
            
        }
        
        if (selectedflag==4) {
            
            [[NSUserDefaults standardUserDefaults]setObject:cell1.mainLabel.text forKey:@"currency"];
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"currencySettingsView" owner:self options:nil];
            UIView *myview=[nib objectAtIndex:0];
            CATransition *applicationLoadViewIn =[CATransition animation];
            [applicationLoadViewIn setDuration:0.5];
            [applicationLoadViewIn setType:kCATransitionReveal];
            [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.generalsettingscontainsview layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
            [self.generalsettingscontainsview addSubview:myview];
            
        }
        if (selectedflag==5) {
            if (indexPath.row==0) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"portalSettingsView" owner:self options:nil];
                UIView *myview=[nib objectAtIndex:0];
                CATransition *applicationLoadViewIn =[CATransition animation];
                [applicationLoadViewIn setDuration:0.5];
                [applicationLoadViewIn setType:kCATransitionReveal];
                [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
                [[self.generalsettingscontainsview layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
                [self.generalsettingscontainsview addSubview:myview];
            }
            else if (indexPath.row==1)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"autocodingMainView" owner:self options:nil];
                UIView *myview=[nib objectAtIndex:0];
                CATransition *applicationLoadViewIn =[CATransition animation];
                [applicationLoadViewIn setDuration:0.5];
                [applicationLoadViewIn setType:kCATransitionReveal];
                [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
                [[self.generalsettingscontainsview layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
                [self.generalsettingscontainsview addSubview:myview];
            }
            else if(indexPath.row==2)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"generalDocumentView" owner:self options:nil];
                UIView *myview=[nib objectAtIndex:0];
                CATransition *applicationLoadViewIn =[CATransition animation];
                [applicationLoadViewIn setDuration:0.5];
                [applicationLoadViewIn setType:kCATransitionReveal];
                [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
                [[self.generalsettingscontainsview layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
                [self.generalsettingscontainsview addSubview:myview];
            }
            else
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"businessThemeView" owner:self options:nil];
                UIView *myview=[nib objectAtIndex:0];
                CATransition *applicationLoadViewIn =[CATransition animation];
                [applicationLoadViewIn setDuration:0.5];
                [applicationLoadViewIn setType:kCATransitionReveal];
                [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
                [[self.generalsettingscontainsview layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
                [self.generalsettingscontainsview addSubview:myview];
            }
        }
        [self.generalsettingstableview reloadData];
    }
    else
    {
        NSMutableDictionary *mydict=[self.dummyDesignationArray objectAtIndex:indexPath.row];
        self.popupSelectionText.text=[mydict objectForKey:@"designation_title"];
        self.moveDesignationID=[self.dummyDesignationIDArray objectAtIndex:indexPath.row];
        self.popupTableView.hidden=true;
    }
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.popupSelectionText) {
        self.popupTableView.hidden=false;
    }
    return  NO;
}



//Response of listing all created designation
-(void)designationsGotresponse:(NSMutableArray *)designationsarray
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (designationsarray.count > 0) {
        
            [self.generaldesignationarray removeAllObjects];
            [self.generalDesignationIDArray removeAllObjects];
        
            for (int i=0; i<[designationsarray count]; i++) {
                NSMutableDictionary *mydict=[designationsarray objectAtIndex:i];
                [self.generalDesignationIDArray addObject:[mydict objectForKey:@"id"]];
            }
        
            [self.generaldesignationarray addObjectsFromArray:designationsarray];
        
            [self.generalsettingstableview reloadData];
        
        }
        else
        {
            self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            [self.app hudStop];
        }
    });
    
}
//Delete Service Response
-(void)deleteResponse:(id)response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([response isEqualToString:@"200"]) {
            
            [self.generaldesignationarray removeObjectAtIndex:self.inPath.row];
            [self.generalDesignationIDArray removeObjectAtIndex:self.inPath.row];
            [self.generalsettingstableview reloadData];
            
        }
        else if([response isEqualToString:@"1"])
        {
            [self.dummyDesignationIDArray addObjectsFromArray:self.generalDesignationIDArray];
            [self.dummyDesignationArray addObjectsFromArray:self.generaldesignationarray];
            [self.dummyDesignationArray removeObjectAtIndex:self.inPath.row];
            [self.dummyDesignationIDArray removeObjectAtIndex:self.inPath.row];
            
            [self.popupTableView reloadData];
            self.designationDeletionPopup.hidden=false;
        }
        
        
    });
}
//Move Service Response
-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([responseData isEqualToString:@"200"]) {
            [self.generaldesignationarray removeObjectAtIndex:self.inPath.row];
            [self.generalDesignationIDArray removeObjectAtIndex:self.inPath.row];
            [self.generalsettingstableview reloadData];
        }
        else
        {
            [self showalerviewcontroller:@"Error Occurred while Moving"];
        }
        
    });
}


//Response of listing all created bank
-(void)allBankViewResponse:(NSMutableArray *)bankList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (bankList.count > 0) {
            [self.generalBranchIDArray removeAllObjects];
            [self.generalbrancharray removeAllObjects];
        
            for (int i=0; i<[bankList count]; i++) {
                NSMutableDictionary *mydict=[bankList objectAtIndex:i];
                [self.generalBranchIDArray addObject:[mydict objectForKey:@"bank_id"]];
            }
        
            [self.generalbrancharray addObjectsFromArray:bankList];
            [self.generalsettingstableview reloadData];
        
        }
        else
        {
            self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            [self.app hudStop];
        }
        
    });
    
}
-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@""
                               message:[NSString stringWithFormat:@"%@",errorMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
    
}
-(void)viewAllDateResponse:(id)responseList
{
    for (int i=0; i<[responseList count]; i++) {
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[responseList objectForKey:@"document_date"]count]>0) {
            self.dateString=[[[responseList objectForKey:@"document_date"]objectAtIndex:0]objectForKey:@"modified_date"];
        }
        if ([[responseList objectForKey:@"portal_date"]count]>0) {
            self.portalLastModifiedDate=[[[responseList objectForKey:@"portal_date"]objectAtIndex:0]objectForKey:@"modified_date"];
        }
        if ([[responseList objectForKey:@"bus_temp_date"]count]>0) {
            self.businessTemplateLastModifiedDate=[[[responseList objectForKey:@"bus_temp_date"]objectAtIndex:0]objectForKey:@"modified_date"];
        }
        if ([[responseList objectForKey:@"autocoding_date"]count]>0) {
            self.autocodeLastModifiedDate=[[[responseList objectForKey:@"autocoding_date"]objectAtIndex:0]objectForKey:@"modified_date"];
        }
        [self.generalsettingstableview reloadData];
        
    });
}
-(void)willRemoveSubview:(UIView *)subview
{
    [self.myconnection displaymodifiedDateFunction:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    [self.generalsettingstableview reloadData];
}
-(IBAction)movePopupAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        self.designationDeletionPopup.hidden=true;
    }
    else
    {
        NSMutableDictionary *designationDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.generalDesignationIDArray objectAtIndex:self.inPath.row],@"d_id",self.moveDesignationID,@"new_desig_id", nil];
        NSLog(@"%@",designationDict);
        [self.myconnection moveEmployeesToDesignation:designationDict];
        self.designationDeletionPopup.hidden=true;
    }
    [self.generalsettingstableview reloadData];
}
@end
