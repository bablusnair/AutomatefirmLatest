//
//  individualofficeclass.m
//  Automate Firm
//
//  Created by leonine on 05/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "individualofficeclass.h"
#import "otherdetailscellclass.h"
#import "officetypecellclass.h"
#import "departmentTableViewCell.h"
#import "categoryTableViewCell.h"
#import "settingsViewController.h"
#import "officesetupmainview.h"

@implementation individualofficeclass
@synthesize x,k,deptEditFlag,i,catEditFlag,j,g,filteredFlag,filteredFlag1,filteredFlag2,otherflag,alertFlag;
-(IBAction)cancel:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"wpsdictionary"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"printerdictionary"];
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabled" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    
}

-(IBAction)addnewbank:(id)sender
{
    self.bankflag=1;
    NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"addnewbankviews" owner:self options:Nil];
    [self addSubview:[nib objectAtIndex:0]];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"wpsdictionary"];
   
}

-(void)awakeFromNib
{
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.countryaray=[[NSMutableArray alloc]init];
    self.countryserviceid=[[NSMutableArray alloc]init];
    self.stateserviceid=[[NSMutableArray alloc]init];
    self.cityserviceid=[[NSMutableArray alloc]init];
    self.statearay=[[NSMutableArray alloc]init];
    self.city=[[NSMutableArray alloc]init];
    self.countrydict=[[NSMutableDictionary alloc]init];
    self.statedict=[[NSMutableDictionary alloc]init];
    self.citydict=[[NSMutableDictionary alloc]init];
    self.fileteredArraycity = [[NSMutableArray alloc]init];
    self.fileteredArraystate = [[NSMutableArray alloc]init];
    
    
    NSMutableDictionary * myoficeDictionary = [[NSMutableDictionary alloc]init];
    
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"dictionaryKey"];
    
    myoficeDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disabled" object:Nil];
    self.officetypeimagearray=[[NSMutableArray alloc] initWithObjects:@"store.png",@"online_store.png",@"warehouse.png",@"production_blacks.png", nil];
    self.officetypearray=[[NSMutableArray alloc] initWithObjects:@"Store",@"Online Store",@"Warehouse",@"Production Unit", nil];
    self.bankarray=[[NSMutableArray alloc] initWithObjects:@"SBI(Tvm)",@"ICICI(Ekm)",@"FBI(Klm)",@"SBI(Tvm)",nil];
    self.otherdetailsfield1array=[[NSMutableArray alloc] init];
    self.otherdetailsfield2array=[[NSMutableArray alloc] init];
    self.finyrarray=[[NSMutableArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    self.sectorarar=[[NSMutableArray alloc] init];
    self.sectorIDArray=[[NSMutableArray alloc]init];
    self.currencyaray=[[NSMutableArray alloc] init];
    self.currencyIDArray=[[NSMutableArray alloc]init];
    self.currencyAbbrvArray=[[NSMutableArray alloc]init];
    self.deptArray=[[NSMutableArray alloc] initWithObjects:@"", nil];
    self.deptIDArray=[[NSMutableArray alloc] initWithObjects:@"", nil];
    self.deptSequenceArray=[[NSMutableArray alloc] initWithObjects:@"", nil];
    self.categoryArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.categoryIDArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.categorySequenceArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    self.selectedDeptArray=[[NSMutableArray alloc]init];
    self.selectedCategryArray=[[NSMutableArray alloc]init];
    self.fileteredArray=[[NSMutableArray alloc]init];
    self.popupDropdownContentArray=[[NSMutableArray alloc]init];
    self.popupDropdownIDArray=[[NSMutableArray alloc]init];

     dispatch_async(dispatch_get_main_queue(), ^{

         if ([[myoficeDictionary objectForKey:@"other_details"] count]>0) {
             for (int a=0; a<[[myoficeDictionary objectForKey:@"other_details"] count]; a++) {
                    [self.otherdetailsfield1array insertObject:[[[myoficeDictionary objectForKey:@"other_details"]objectAtIndex:a]objectForKey:@"heading"]atIndex:a];
                 [self.otherdetailsfield2array insertObject:[[[myoficeDictionary objectForKey:@"other_details"]objectAtIndex:a]objectForKey:@"description"]atIndex:a];
                 
             }
             
         }
         else
         {
             [self.otherdetailsfield1array addObject:@""];
             [self.otherdetailsfield2array addObject:@""];
         }

         [self.otherdetailstableview reloadData];
        self.send_otherdetailsarray=[[NSMutableArray alloc]init];
    
       [self.myconnection displayAllCountries];
       for (int a=0; a<[[myoficeDictionary objectForKey:@"selected_department"] count]; a++) {
     
           [self.deptArray insertObject:[[[myoficeDictionary objectForKey:@"selected_department"]objectAtIndex:a]objectForKey:@"department_name"]atIndex:a];
           [self.deptIDArray insertObject:[[[myoficeDictionary objectForKey:@"selected_department"]objectAtIndex:a]objectForKey:@"dept_id"]atIndex:a];
           [self.deptSequenceArray insertObject:[[[myoficeDictionary objectForKey:@"selected_department"]objectAtIndex:a]objectForKey:@"code"]atIndex:a];
           
        }
    for (int a=0; a<[[myoficeDictionary objectForKey:@"selected_category"] count]; a++) {
        
     
        [self.categoryArray insertObject:[[[myoficeDictionary objectForKey:@"selected_category"]objectAtIndex:a]objectForKey:@"cat_name"]atIndex:a];
        [self.categoryIDArray insertObject:[[[myoficeDictionary objectForKey:@"selected_category"]objectAtIndex:a]objectForKey:@"cat_id"]atIndex:a];
        [self.categorySequenceArray insertObject:[[[myoficeDictionary objectForKey:@"selected_category"]objectAtIndex:a]objectForKey:@"code"]atIndex:a];
        
    }
         
         for (int a=0; a<[[myoficeDictionary objectForKey:@"currency_list"] count]; a++) {
             NSMutableDictionary *currencyDict=[[myoficeDictionary objectForKey:@"currency_list"]objectAtIndex:a];
             [self.currencyaray addObject:[currencyDict objectForKey:@"title"]];
             [self.currencyIDArray addObject:[currencyDict objectForKey:@"c_id"]];
             [self.currencyAbbrvArray addObject:[currencyDict objectForKey:@"abbreviation"]];
         }
         for (int a=0; a<[[myoficeDictionary objectForKey:@"sector_list"] count]; a++) {
             NSMutableDictionary *sectorDict=[[myoficeDictionary objectForKey:@"sector_list"]objectAtIndex:a];
             [self.sectorarar addObject:[sectorDict objectForKey:@"title"]];
             [self.sectorIDArray addObject:[sectorDict objectForKey:@"s_id"]];
         }
         
    [self.departmentTableView reloadData];
    [self.categoryTableView reloadData];
         [self.currencytable reloadData];
         [self.sectotable reloadData];
         
    self.officetextfield.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"office_name"];
     self.subtitletext.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"sub_title"];
     self.financialyeartext.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"year"];
     self.abbrvtextfield.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"abrivation"];
         
         NSArray *currencyArray=[[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"currency"] componentsSeparatedByString:@"###"];
         
         self.selectedCurrency=[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"currency"];
         
     self.currencytextfield.text = [currencyArray objectAtIndex:1];
     self.regtext.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"reg_id"];
     self.emailtextfield.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"email"];
     self.telephonetextfield.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"telephone"];
         
         self.selectedSector=[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"sector"];
         NSArray *sectorArray=[[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"sector"] componentsSeparatedByString:@"###"];
         
     self.sectortextfield.text = [sectorArray objectAtIndex:1];
     self.websitetext.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"website"];
     self.faxtextfield.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"fax"];
     self.buildingtext.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"building"];
     self.blocktext.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"block"];
     self.streettext.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"street"];
     self.postcodetext.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"pincode"];
         if (!([[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"country"] isEqualToString:@" "])) {
             self.countrytext.text = [[[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"country"]componentsSeparatedByString:@"###"]objectAtIndex:1] ;
             [self.myconnection displaySelectedStates:[[[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"country"]componentsSeparatedByString:@"###"]objectAtIndex:0]];
         }
     if (!([[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"state"]isEqualToString:@" "])) {
         self.statetext.text = [[[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"state"]componentsSeparatedByString:@"###"]objectAtIndex:1];
         [self.myconnection displayAllCities:[[[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"state"]componentsSeparatedByString:@"###"]objectAtIndex:0]];
     }
         NSString * city=[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"city"];
     if (!([[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"city"]isEqualToString:@" "])) {
         
          self.citytext.text = [[[[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"city"]componentsSeparatedByString:@"###"]objectAtIndex:1];
     }
    
     self.landmarktext.text = [[[myoficeDictionary objectForKey:@"office"]objectAtIndex:0]objectForKey:@"landmark"];
    
    
     
     });
    

    //using keyboard notification functions
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    

    self.financialyrtableview.hidden=TRUE;
    self.selectedarray=[[NSMutableArray alloc] init];
    self.departmentcategorydeletealertview.hidden=TRUE;
    
    
    if (self.deptArray.count>0) {
        
        deptEditFlag=1;
        catEditFlag=1;
    }
    else
    {
        deptEditFlag=0;
        catEditFlag=0;
    }
    
    if (self.categoryArray.count>0) {
        
        deptEditFlag=1;
        catEditFlag=1;
    }
    else
    {
        deptEditFlag=0;
        catEditFlag=0;
    }
    self.alertFlag=0;
     self.bankflag=0;
     self.printerflag=0;
     self.send_selectedbankarray = [[NSMutableArray alloc]init];
     self.send_selectedprinterarray = [[NSMutableArray alloc]init];
    g=1;
    otherflag=1;
    self.fordeletedepartflag=0;
    
}




//Country Listing
-(void)allcountryresponse:(id)countrylist
{
    filteredFlag=0;
    
    [self.countryaray removeAllObjects];
    for (int a=0; a<[countrylist count]; a++) {
        
        NSString *mystring=[[countrylist objectAtIndex:a] objectForKey:@"name"];
        [self.countryaray addObject:mystring];
        [self.countrydict setObject:[[countrylist objectAtIndex:a] objectForKey:@"country_id"] forKey:mystring];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.countrytable reloadData];
    });
    
}
//state Listing
-(void)allstateresponse:(id)statelist
{

    
    self.filteredFlag1=0;
    [self.statearay removeAllObjects];
    for (int a=0; a<[statelist count]; a++) {
        
        NSString *mystring=[[statelist objectAtIndex:a] objectForKey:@"name"];
        [self.statearay addObject:mystring];
        [self.statedict setObject:[[statelist objectAtIndex:a] objectForKey:@"state_id"] forKey:mystring];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.statetable reloadData];
    });
}

//City Listing
-(void)allcityresponse:(id)Citylist

{
    
    if (!([Citylist count] > 0)) {
        self.citytext.backgroundColor=[UIColor lightGrayColor];
        self.citytext.text=@"No City to Select";
        self.citytext.textColor=[UIColor redColor];
        self.citytext.userInteractionEnabled=NO;
    }
    else
    {
        self.filteredFlag2=0;
        [self.city removeAllObjects];
        for (int a=0; a<[Citylist count]; a++) {
            [self.city addObject:[[Citylist objectAtIndex:a]objectForKey:@"name"]];
            [self.citydict setObject:[[Citylist objectAtIndex:a] objectForKey:@"city_id"] forKey:[[Citylist objectAtIndex:a]objectForKey:@"name"]];
        }
        
        self.citytext.backgroundColor=[UIColor clearColor];
        self.citytext.userInteractionEnabled=YES;
        //self.citytext.text=@"";
        self.citytext.textColor=[UIColor blackColor];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.citytable reloadData];
        });
    }

    
}


//using keyboard notification functions

- (void) keyboardDidShow:(NSNotification *)notification
{
    
    
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height+50, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.frame;
    aRect.size.height -= kbRect.size.height;
    
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
        
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
        
    }
    
}


- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,0);
    self.scrollView.contentSize=CGSizeMake(645,500);
}


//uitextfield editing delegate functionality


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.financialyeartext) {
      
        [self.financialyeartext resignFirstResponder];
        self.financialyrtableview.hidden=FALSE;
        return NO;
    }
    if(textField == self.sectortextfield)
    {
        self.sectotable.hidden = FALSE;
        return  NO;
    }
    if(textField == self.currencytextfield)
    {
        self.currencytable.hidden = FALSE;
        return  NO;
    }
    
    if (textField==self.countrytext) {
        if([self.countrytext.text isEqualToString:@"Invalid choice"])
        {
          self.countrytext.text=@"";
            filteredFlag=0;
            [self.countrytable reloadData];
            
        }
        self.statetable.hidden=TRUE;
        self.citytable.hidden=TRUE;
        self.countrytable.hidden=FALSE;
        return YES;
    }
    
    if (textField==self.statetext) {
        self.countrytable.hidden=TRUE;
        self.citytable.hidden=TRUE;
        if([self.statetext.text isEqualToString:@"Invalid choice"])
        {
            self.statetext.text=@"";
            filteredFlag1=0;
            [self.statetable reloadData];
            
        }
        if(self.countrytext.text.length > 0)
        {
            if ([self.countrytext.text isEqualToString:@"Invalid choice"]) {
                self.statetext.text =@"Select a Country";
                self.statetext.textColor=[UIColor redColor];
                self.statetable.hidden=TRUE;
                return NO;
            }
            else
            {
                self.statetext.textColor=[UIColor blackColor];
                self.statetable.hidden=FALSE;
                return YES;
            }
            
            
        }
        else{
            self.statetext.text =@"Select a Country";
            self.statetext.textColor=[UIColor redColor];
            return  NO;
        }
       
    }
    
    if (textField==self.citytext) {
        self.countrytable.hidden=TRUE;
        self.statetable.hidden=TRUE;
        if([self.citytext.text isEqualToString:@"Invalid choice"])
        {
            self.citytext.text=@"";
            filteredFlag2=0;
            [self.citytable reloadData];
        }
        if(self.statetext.text.length > 0)
        {
            if ([self.statetext.text isEqualToString:@"Invalid choice"]) {
                self.citytext.text=@"Select a state";
                self.citytext.textColor=[UIColor redColor];
                self.citytable.hidden=TRUE;
                return  NO;
            }
            else
            {
                self.citytext.textColor=[UIColor blackColor];
                self.citytable.hidden=FALSE;
                return  YES;
            }

            
            
            
        }
        else{
            self.citytext.text =@"Select a State";
            self.citytext.textColor=[UIColor redColor];
            return  NO;
        }

    }
    if (textField==self.popupDropdownText) {
        self.popupDropdownTC.hidden=false;
        return  NO;
    }

    else
    {
        
        return YES;
    }
    
}

//uitableview delegate functionality


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.otherdetailstableview) {
        
        
         return [self.otherdetailsfield1array count];
    }
    
    else if(tableView==self.financialyrtableview)
    {
        return self.finyrarray.count;
    }
    else if(tableView==self.sectotable)
    {
        return self.sectorarar.count;
    }
    else if(tableView==self.currencytable)
    {
        return self.currencyaray.count;
    }

    else if(tableView==self.departmentTableView)
    {
        return self.deptArray.count;
    }
    else if(tableView==self.countrytable)
    {
        if (filteredFlag==1) {
            return  self.fileteredArray.count;
        }
        else
            
            return self.countryaray.count;
    }
    else if(tableView==self.statetable)
    {
        if (filteredFlag1==1) {
            return  self.fileteredArraystate.count;
        }
        else
        {
            return self.statearay.count;
        }
    }
    else if(tableView==self.citytable)
    {
        if (filteredFlag2==1) {
            return  self.fileteredArraycity.count;
        }
        else
        {
            return self.city.count;
        }
    }
    else if (tableView==self.popupDropdownTC)
        return self.popupDropdownContentArray.count;

    else
    {
        return  self.categoryArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.otherdetailstableview) {
        
        static NSString *simpleTableIdentifier = @"simplecell";
        otherdetailscellclass  *cell = (otherdetailscellclass *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
            if (cell == nil)
            {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"otherdetailscellview" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            }
        
        
        cell.field1.text=[self.otherdetailsfield1array objectAtIndex:indexPath.row];
        cell.field2.text=[self.otherdetailsfield2array objectAtIndex:indexPath.row];
        cell.field1.userInteractionEnabled=TRUE;
        cell.field2.userInteractionEnabled=TRUE;
        
        
                if ([self.selectedarray containsObject:indexPath]) {
                
                    if (cell.field1.text.length>0 && cell.field2.text.length>0) {
                    
                    [cell.field1 setUserInteractionEnabled:FALSE];
                    [cell.field2 setUserInteractionEnabled:FALSE];
                    }
                    else
                    {
                
                        [cell.field1 setUserInteractionEnabled:TRUE];
                        [cell.field2 setUserInteractionEnabled:TRUE];
                
                    }
            
                }
               else
                {
                    
                if (cell.field1.text.length>0 && cell.field2.text.length>0) {
                    
                 [cell.field1 setUserInteractionEnabled:FALSE];
                 [cell.field2 setUserInteractionEnabled:FALSE];
                    
                    
                  }
                
            }
        
        
        UILongPressGestureRecognizer *press=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressaction:)];
        [cell addGestureRecognizer:press];
        return cell;
    

    }
    
    else if(tableView==self.financialyrtableview)
    {
        static NSString *cellIdentifier = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifier];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text=[self.finyrarray objectAtIndex:indexPath.row];
        return cell;

    }
    else if(tableView==self.sectotable)
    {
        static NSString *cellIdentifier = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifier];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text=[self.sectorarar objectAtIndex:indexPath.row];
        return cell;
        
    }
    else if(tableView==self.currencytable)
    {
        static NSString *cellIdentifier = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifier];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.numberOfLines=2;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text=[self.currencyaray objectAtIndex:indexPath.row];
        return cell;
        
    }
    
    
    else if(tableView==self.departmentTableView)
    {
        
        departmentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"departmentTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        cell.deptNameText.text=[self.deptArray objectAtIndex:indexPath.row];
        
        if (deptEditFlag==1) {
            
            if (!(indexPath.row == self.deptArray.count - 1)) {
                [self.selectedDeptArray addObject:indexPath];
            }
            
        }
        
        
        if ([self.selectedDeptArray containsObject:indexPath]) {
            
            if (cell.deptNameText.text.length>0) {
                
                 cell.deptNameText.userInteractionEnabled=NO;
            }
            else
            {
                cell.deptNameText.userInteractionEnabled=YES;
            }
        }
       
        return  cell;
    }
    
    else if(tableView==self.countrytable)
    {
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        if (filteredFlag==0) {
            cell.textLabel.text=[self.countryaray objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text=[self.fileteredArray objectAtIndex:indexPath.row];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:11];
        
        return  cell;
    }
   
    else if(tableView==self.statetable)
    {
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        if (filteredFlag1==0) {
            cell.textLabel.text=[self.statearay objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text=[self.fileteredArraystate objectAtIndex:indexPath.row];
        }
         cell.textLabel.font=[UIFont systemFontOfSize:11];
        return  cell;
    }

    else if(tableView==self.citytable)
    {
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        
        if (filteredFlag2==0) {
            cell.textLabel.text=[self.city objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text=[self.fileteredArraycity objectAtIndex:indexPath.row];
        }
        
         cell.textLabel.font=[UIFont systemFontOfSize:11];
        return  cell;
    }
    else if (tableView==self.popupDropdownTC)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.popupDropdownContentArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0];
        return  cell;
    }

    else
    {
        categoryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"categoryTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
         cell.categoryText.text=[self.categoryArray objectAtIndex:indexPath.row];
        
        if (catEditFlag==1) {
            if (!(indexPath.row == self.categoryArray.count - 1)) {
                [self.selectedCategryArray addObject:indexPath];
            }
        }
        
        if ([self.selectedCategryArray containsObject:indexPath]) {
            
            if (cell.categoryText.text.length>0) {
                
                cell.categoryText.userInteractionEnabled=NO;
            }
            else
            {
                cell.categoryText.userInteractionEnabled=YES;
            }

        }

        return  cell;
    }
    
}
//tableview selected Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.financialyrtableview) {
        
        self.financialyeartext.text=[self.finyrarray objectAtIndex:indexPath.row];
        self.financialyrtableview.hidden=TRUE;
    }
    
    if (tableView==self.sectotable) {
        
        self.sectortextfield.text=[self.sectorarar objectAtIndex:indexPath.row];
        self.selectedSector=[NSString stringWithFormat:@"%@###%@",[self.sectorarar objectAtIndex:indexPath.row],[self.sectorIDArray objectAtIndex:indexPath.row]];
        self.sectotable.hidden=TRUE;
    }
    
    if (tableView==self.currencytable) {
        
        self.currencytextfield.text=[self.currencyAbbrvArray objectAtIndex:indexPath.row];
        self.selectedCurrency=[NSString stringWithFormat:@"%@###%@",[self.currencyIDArray objectAtIndex:indexPath.row],[self.currencyaray objectAtIndex:indexPath.row]];
        self.currencytable.hidden=TRUE;
    }
    if (tableView == self.countrytable)
    {
        if (filteredFlag == 0) {
            self.countrytext.text = [self.countryaray objectAtIndex:indexPath.row];
        }
        else
        {
            self.countrytext.text = [self.fileteredArray objectAtIndex:indexPath.row];
            
        }
        if ([self.countryaray containsObject:self.countrytext.text ])
        {
            [self.myconnection displaySelectedStates:[self.countrydict objectForKey:self.countrytext.text]];
            
            self.statetext.text =@"";
            self.citytext.text=@"";
            self.postcodetext.text=@"";
            
            self.filteredFlag1 = self.filteredFlag2=0;
            
            self.countrytable.hidden=TRUE;

        }
        [self.countrytext resignFirstResponder];
    }
    
    if (tableView == self.statetable)
    {
        
        if (filteredFlag1 == 0) {
        self.statetext.text = [self.statearay objectAtIndex:indexPath.row];
                    }
        else
        {
            self.statetext.text = [self.fileteredArraystate objectAtIndex:indexPath.row];
            
        }
        [self.myconnection displayAllCities:[self.statedict objectForKey:self.statetext.text]];
        self.citytext.text=@"";
        self.postcodetext.text=@"";
               self.filteredFlag2=0;
        self.statetable.hidden=TRUE;
        [self.statetext resignFirstResponder];
        
    }
    if (tableView == self.citytable)
    {
        
        if (filteredFlag2 == 0) {
            
            self.citytext.text = [self.city objectAtIndex:indexPath.row];
        }
        else
        {
             self.citytext.text = [self.fileteredArraycity objectAtIndex:indexPath.row];
        }
        self.citytable.hidden=TRUE;
        [self.citytext resignFirstResponder];
        
    }
    if (tableView==self.popupDropdownTC) {
        if (self.moveFlag==1) {
            self.moveID=[self.popupDropdownIDArray objectAtIndex:indexPath.row];
            self.popupDropdownText.text=[self.popupDropdownContentArray objectAtIndex:indexPath.row];
            self.popupDropdownTC.hidden=true;
        }
        else
        {
            self.moveID=[self.popupDropdownIDArray objectAtIndex:indexPath.row];
            self.popupDropdownText.text=[self.popupDropdownContentArray objectAtIndex:indexPath.row];
            self.popupDropdownTC.hidden=true;
        }
        
    }
    
    
}




//Long press gusture function for deleteing and editing a uitableview cell (Other details function)


-(void)longpressaction:(UILongPressGestureRecognizer *)pressguster
{
    
    otherdetailscellclass *clickedCell = (otherdetailscellclass *)pressguster.view;
    [clickedCell.field1 setUserInteractionEnabled:TRUE];
    [clickedCell.field2 setUserInteractionEnabled:TRUE];
     clickedCell.closebutton.hidden=FALSE;
    self.otherdteialsdeleteflag=0;
  
}

//for department delete function

-(IBAction)deleteDept:(id)sender
{
    departmentTableViewCell *cell1 = (departmentTableViewCell *)[[sender superview] superview];
    NSIndexPath *myindex=[self.departmentTableView indexPathForCell:cell1];

    if (!(myindex.row==[self.deptArray count]-1)) {
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:@"Are you sure you want to delete?"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   
                                                   
//                                                   departmentTableViewCell *cell1 = (departmentTableViewCell *)[[sender superview] superview];
//                                                   NSIndexPath *myindex=[self.departmentTableView indexPathForCell:cell1];
                                                   if(!(myindex.row == self.deptArray.count - 1))
                                                   {
                                                       if ([[self.deptIDArray objectAtIndex:myindex.row]isEqualToString:@"0"]) {
                                                           [self.deptArray removeObjectAtIndex:myindex.row];
                                                       }
                                                       else
                                                       {
                                                           [self.myconnection deleteDepartment:[self.deptIDArray objectAtIndex:myindex.row]];
                                                       }
                                                       
                                                        self.inPath=myindex;
                                                       self.fordeletedepartflag=1;
                                                       [self.departmentTableView reloadData];
                                                   }
                                               }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       //Do Some action here
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    }
}

//for category delete function

-(IBAction)deleteCat:(id)sender
{
     categoryTableViewCell *cell1 = (categoryTableViewCell *)[[sender superview] superview];
     NSIndexPath *myindex=[self.categoryTableView indexPathForCell:cell1];
    if (!(myindex.row==[self.categoryArray count]-1)) {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Warning"
                                   message:@"Are you sure you want to delete?"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       
                                                       
                                                       
                                                       if(!(myindex.row == self.categoryArray.count - 1))
                                                       {
                                                           if ([[self.categoryIDArray objectAtIndex:myindex.row]isEqualToString:@"0"]) {
                                                               [self.deptArray removeObjectAtIndex:myindex.row];
                                                               [self.deptIDArray removeObjectAtIndex:myindex.row];
                                                               [self.deptSequenceArray removeObjectAtIndex:myindex.row];
                                                               
                                                           }
                                                           else
                                                           {
                                                               [self.myconnection deleteCategory:[self.categoryIDArray objectAtIndex:myindex.row]];
                                                           }
                                                           
                                                           self.inPath=myindex;
                                                           self.fordeletedepartflag=1;
                                                           self.fordeletecategoryindex=myindex;
                                                           [self.categoryTableView reloadData];
                                                       }
                                                   }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           //Do Some action here
                                                       }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });
        
       // NSIndexPath *indexPath = [NSIndexPath indexPathForRow:myindex.row+1 inSection:0];
       // categoryTableViewCell *cell2 = [self.categoryTableView cellForRowAtIndexPath:indexPath];
       // [cell2 .categoryText resignFirstResponder];
       // self.fordeletedepartflag=1;
       // self.fordeletecategoryindex=myindex;
        
      //  self.departmentcategorydeletealertview.hidden=FALSE;
    }
    
}


//for add otherdetails button action

-(IBAction)addotherdetailsaction:(id)sender
{
    
    if (![self.otherdetailsfield1array containsObject:@""] && ![self.otherdetailsfield2array containsObject:@""] && g==1) {
         
         [self.otherdetailsfield1array addObject:@""];
         [self.otherdetailsfield2array addObject:@""];
       
          NSArray *visibleItems = [self.otherdetailstableview indexPathsForVisibleRows];
         [self.otherdetailstableview reloadData];
         NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
         NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.otherdetailsfield1array.count - 1 inSection:currentItem.section];
         [self.otherdetailstableview scrollToRowAtIndexPath:nextItem atScrollPosition:UITableViewScrollPositionBottom animated:YES];
     }
}


//for begin action of heading textfield of otherdetails


-(IBAction)textfieldbegininaction:(id)sender
{
    g=0;
    self.otherdteialsdeleteflag=0;
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,350);
    otherdetailscellclass *clickedCell = (otherdetailscellclass *)[[sender superview] superview];
    self.inPath=[self.otherdetailstableview indexPathForCell:clickedCell];
    
    clickedCell.closebutton.hidden=TRUE;
    
}


//for ending action of heading textfield of otherdetails


-(IBAction)textfieldendinginaction:(id)sender
{
    
    otherdetailscellclass *clickedCell = (otherdetailscellclass *)[[sender superview] superview];
    NSIndexPath *myinedx = [self.otherdetailstableview indexPathForCell:clickedCell];
    [clickedCell.field1 resignFirstResponder];
    
    if (self.otherdteialsdeleteflag==0) {
        
        [self.otherdetailsfield1array replaceObjectAtIndex:myinedx.row withObject:clickedCell.field1.text];
        
        if (clickedCell.field2.text.length>0) {
            
            if ([clickedCell.field1.text isEqualToString:@""]) {
                
                [clickedCell.field1 setUserInteractionEnabled:TRUE];
               // [clickedCell.field2 setUserInteractionEnabled:TRUE];
            }
            else
            {
                [self.otherdetailstableview reloadData];
                          }
            
        }
        clickedCell.field2.userInteractionEnabled=YES;
        
        g=1;
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,0);
        
    }

    
}


//for begin action of heading_details textfield of otherdetails


-(IBAction)textfieldbegininaction2:(id)sender
{
    g=0;
    self.otherdteialsdeleteflag=0;
    
    otherdetailscellclass *clickedCell = (otherdetailscellclass *)[[sender superview] superview];
       self.inPath=[self.otherdetailstableview indexPathForCell:clickedCell];
    if (!(clickedCell.field1.text.length > 0)) {
        clickedCell.field2.userInteractionEnabled=NO;
        [clickedCell.field2 resignFirstResponder];
    }
    else
    {
        clickedCell.field2.userInteractionEnabled=YES;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,350);
    }
    clickedCell.closebutton.hidden=TRUE;
}

//for ending action of heading_details textfield of otherdetails

-(IBAction)textfieldendinginaction2:(id)sender
{
    
    
    
    otherdetailscellclass *clickedCell = (otherdetailscellclass *)[[sender superview] superview];
    NSIndexPath *myinedx = [self.otherdetailstableview indexPathForCell:clickedCell];
    [clickedCell.field2 resignFirstResponder];
    
    if (self.otherdteialsdeleteflag==0) {
        
        [self.otherdetailsfield2array replaceObjectAtIndex:myinedx.row withObject:clickedCell.field2.text];
        [self.selectedarray addObject:myinedx];
        
        if (clickedCell.field2.text.length>0) {
            
            if ([clickedCell.field1.text isEqualToString:@""])
            {
                
                [clickedCell.field1 setUserInteractionEnabled:TRUE];
                [clickedCell.field2 setUserInteractionEnabled:TRUE];
            }
            else
            {
                [self.otherdetailstableview reloadData];
            }
            
        }
        
        g=1;
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,0);
        
    }

    
}


//textfield delegate functions for validations

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
      if (textField==self.countrytext) {
        
        filteredFlag=1;
        self.countrytable.hidden=FALSE;
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.countrytext.text stringByReplacingCharactersInRange:range withString:string]];
        self.fileteredArray = [[self.countryaray filteredArrayUsingPredicate:bPredicate] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.countrytable reloadData];
            

        });
        if ([string isEqualToString:@""] && textField.text.length==1) {
            filteredFlag=0;
        dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.countrytable reloadData];
            
            });
        }
        return  YES;
        
    }

    if (textField==self.statetext) {
        
        filteredFlag1=1;
        
               NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.statetext.text stringByReplacingCharactersInRange:range withString:string]];
        
        self.fileteredArraystate = [[self.statearay filteredArrayUsingPredicate:bPredicate] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.statetable.hidden=FALSE;
            [self.statetable reloadData];
            
            
        });

        
        
        if ([string isEqualToString:@""] && textField.text.length==1) {
            
            
            
            filteredFlag1=0;
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.statetable reloadData];
                
                
            });
            
            }
        
        
        
        return  YES;
        
    }
    if (textField==self.citytext) {
        
        filteredFlag2=1;
        
        self.citytable.hidden=FALSE;
        
        //   NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",[self.mytextfield.text stringByReplacingCharactersInRange:range withString:string]];
        
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.citytext.text stringByReplacingCharactersInRange:range withString:string]];
        
        self.fileteredArraycity = [[self.city filteredArrayUsingPredicate:bPredicate] mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.citytable reloadData];
            
            
        });
        
        
        
        if ([string isEqualToString:@""] && textField.text.length==1) {
            
            
            
            filteredFlag2=0;
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.citytable reloadData];
                
                
            });
            
            
        }
        
        
        
        return  YES;
        
    }
    if (textField==self.abbrvtextfield) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.officetextfield) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=33) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.subtitletext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=33) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.regtext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=13) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
//    if (textField==self.websitetext) {
//        
//        if ([string isEqualToString:@""]) {
//            return YES;
//        }
//        if (textField.text.length<=25) {
//            
//            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_.@"];
//            unichar c = [string characterAtIndex:0];
//            if ([myCharSet characterIsMember:c])
//            {
//                return YES;
//            }
//            else
//            {
//                return NO;
//            }
//            //return YES;
//        }
//        return NO;
//    }
    if (textField==self.regtext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=13) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.buildingtext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=13) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.blocktext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=13) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.postcodetext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=13) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.streettext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=33) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.landmarktext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=35) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }


    if ((textField==self.telephonetextfield) || (textField==self.faxtextfield))
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=12) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789+-"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
            
        }
        return NO;
    }
 
    return  YES;
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.emailtextfield)
    {
        
        [self validateEmail:self.emailtextfield.text];
        
    }
    
    if (textField == self.websitetext)
    {
        
        [self validateWebsite:self.websitetext.text];
        
    }
    if (textField==self.countrytext) {
        
             if (!(self.countrytext.text.length > 0))
             {
            self.countrytable.hidden=true;
            self.statetext.text=@"";
            self.citytext.text=@"";
            self.postcodetext.text=@"";
             }
             if ([self.countryaray containsObject:self.countrytext.text ])
             {
                 //self.statetable.hidden= FALSE;
             }
                else
                {
                    self.countrytext.text=@"Invalid choice";
                    self.statetext.text=@"";
                    self.citytext.text=@"";
                    self.postcodetext.text=@"";
                    self.countrytable.hidden=TRUE;
                }
        
    }
    if (textField==self.statetext) {
        if (!(self.statetext.text.length > 0)) {
            self.statetable.hidden=true;
            self.citytext.text=@"";
            self.postcodetext.text=@"";
        }
        if ([self.statearay containsObject:self.statetext.text ])
        {
           // self.citytable.hidden= FALSE;
        }
        else
        {
            self.statetext.text=@"Invalid choice";
            self.citytext.text=@"";
            self.postcodetext.text=@"";
            self.citytable.hidden=TRUE;
        }
    }
    if (textField==self.citytext) {
        if (!(self.citytext.text.length > 0)) {
            self.citytable.hidden=true;
            self.postcodetext.text=@"";
        }
        if ([self.city containsObject:self.citytext.text ])
        {
            // self.citytable.hidden= FALSE;
        }
        else
        {
            self.citytext.text=@"Invalid choice";
            
            self.postcodetext.text=@"";
            self.citytable.hidden=TRUE;
        }

       
    }


}

//Email validation function

- (BOOL)validateEmail:(NSString *)emailStr
{
    if([emailStr isEqualToString:@""])
    {
        return YES;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailTest evaluateWithObject:emailStr]) {
        
        NSLog(@"Correct");
        
    }
    else
    {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Error"
                                   message:@"Please enter valid Email Address"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       //Do Some action here
                                                   }];
        [alert addAction:ok];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });

        
    }
    return [emailTest evaluateWithObject:emailStr];
}
- (BOOL)validateWebsite:(NSString *)webStr
{
    if([webStr isEqualToString:@""])
    {
        return YES;
    }
    NSString *webRegex = @"www.+[A-Za-z0-9-]+\\.[A-Za-z]{2,4}";
    NSPredicate *webTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", webRegex];
    if ([webTest evaluateWithObject:webStr]) {
        
        NSLog(@"Correct");
        
    }
    else
    {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Error"
                                   message:@"Please enter valid Website Address"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       //Do Some action here
                                                   }];
        [alert addAction:ok];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });
        
        
    }
    return [webTest evaluateWithObject:webStr];
}

//Final done button action

-(IBAction)donebuttonaction:(id)sender
{
    BOOL value = [self validateEmail:self.emailtextfield.text];
    BOOL value1= [self validateWebsite:self.websitetext.text];
    [self.emailtextfield resignFirstResponder];
    [self.websitetext resignFirstResponder];
    otherdetailscellclass *mycell = [self.otherdetailstableview cellForRowAtIndexPath:self.globalindex];
   
    [mycell.field2 resignFirstResponder];
    [mycell.field1 resignFirstResponder];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabled" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    
    //Removing Null Values Before updation
   
    if ([self.deptArray containsObject:@""]) {
        
        [self.deptArray removeObject:@""];
    }
    if ([self.categoryArray containsObject:@""]) {
        
        [self.categoryArray removeObject:@""];
    }
    
    
    //String Formatting for Services
    
    NSString *countrystring=[NSString stringWithFormat:@"%@###%@",[self.countrydict objectForKey:self.countrytext.text],self.countrytext.text];
    NSString *statestring=[NSString stringWithFormat:@"%@###%@",[self.statedict objectForKey:self.statetext.text],self.statetext.text];
    NSString *citystring   =[NSString stringWithFormat:@"%@###%@",[self.citydict objectForKey:self.citytext.text],self.citytext.text];
    
    //Array Selection from selecing/unselecting Bank,Printer,other Details
    
    NSMutableArray *selectedbanks=[[[NSUserDefaults standardUserDefaults]objectForKey:@"dictionaryKey"] objectForKey:@"selected_bank"];
    if (self.bankflag==0) {
        
        [self.send_selectedbankarray removeAllObjects];
        
        for (int m=0; m<selectedbanks.count; m++) {
            
            NSMutableDictionary *dict=[[selectedbanks objectAtIndex:m] mutableCopy];
            [dict removeObjectForKey:@"bank_branch"];
            [dict removeObjectForKey:@"bank_name"];
            [self.send_selectedbankarray addObject:dict];
        
        }
    }
    else
    {
        
        NSMutableDictionary *mydict=[[NSUserDefaults standardUserDefaults] objectForKey:@"wpsdictionary"];
        
        NSMutableArray *myarray=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"wpsdictionary"] allKeys] mutableCopy];
        
        [self.send_selectedbankarray removeAllObjects];
        
            for (int a=0; a<myarray.count; a++) {
            
                NSMutableDictionary *mydictionarybank=[[NSMutableDictionary alloc] init];
                [mydictionarybank setObject:[myarray objectAtIndex:a] forKey:@"bank_id"];
                [mydictionarybank setObject:[mydict objectForKey:[myarray objectAtIndex:a]] forKey:@"code"];
                [self.send_selectedbankarray addObject:mydictionarybank];
            }
        }
        NSMutableArray *seletedprinters=[[[NSUserDefaults standardUserDefaults]objectForKey:@"dictionaryKey"] objectForKey:@"printer"];
    
        if (self.printerflag==0) {
         
            [self.send_selectedprinterarray removeAllObjects];
         
        for (int m=0; m<seletedprinters.count; m++) {
             
             NSMutableDictionary *dict=[[seletedprinters objectAtIndex:m] mutableCopy];
             [dict removeObjectForKey:@"p_id"];
             [dict removeObjectForKey:@"o_id"];
             [self.send_selectedprinterarray addObject:dict];
         }
    }
    else
    {
         [self.send_selectedprinterarray removeAllObjects];
        
         NSMutableDictionary *printerdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"printerdictionary"];
        
         NSMutableArray *printnamearray = [printerdict objectForKey:@"printername"];
         NSMutableArray *emailarray = [printerdict objectForKey:@"emailarray"];
         NSMutableArray *ratearray = [printerdict objectForKey:@"ratearray"];
        
        
        for (int b=0; b<printnamearray.count; b++) {
            
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
            [dict setObject:[printnamearray objectAtIndex:b] forKey:@"name"];
            NSString *str=[NSString stringWithFormat:@"%@@%@",[emailarray objectAtIndex:b],[ratearray objectAtIndex:b]];
            [dict setObject:str forKey:@"email"];
            [self.send_selectedprinterarray addObject:dict];
            
            
        }
        
    }
    if ((value==YES)&&(value1==YES)) {

        otherdetailscellclass *clickedCell = (otherdetailscellclass *)[self.otherdetailstableview cellForRowAtIndexPath:self.inPath];
        [clickedCell.field1 resignFirstResponder];
        [clickedCell.field2 resignFirstResponder];
    
        [self.otherdetailsfield1array removeObject:@""];
        [self.otherdetailsfield2array removeObject:@""];
        if (self.otherdetailsfield1array.count == self.otherdetailsfield2array.count) {
            for (int c=0; c<self.otherdetailsfield1array.count; c++) {
                NSMutableDictionary *mydict=[[NSMutableDictionary alloc] init];
                [mydict setObject:[self.otherdetailsfield1array objectAtIndex:c] forKey:@"heading"];
                [mydict setObject:[self.otherdetailsfield2array objectAtIndex:c] forKey:@"description"];
                [self.send_otherdetailsarray addObject:mydict];
            
            }
        }

    
        //Updation Function Service Calling
        
        if (self.officetextfield.text.length>0 && self.sectortextfield.text.length>0 && self.abbrvtextfield.text.length>0 && self.currencytextfield.text.length>0 && self.financialyeartext.text.length>0){
            
            if (self.send_selectedbankarray.count>0 && self.deptArray.count>0 && self.categoryArray.count>0 && self.send_selectedprinterarray.count > 0) {
                
                if (self.otherdetailsfield1array.count==self.otherdetailsfield2array.count) {
                    NSMutableArray *departmentArray=[[NSMutableArray alloc]init];
                    NSMutableArray *categoryArray=[[NSMutableArray alloc]init];
                    for (int dept=0; dept<self.deptArray.count; dept++) {
                        NSMutableDictionary *deptDict=[[NSMutableDictionary alloc]init];
                        [deptDict setObject:[self.deptArray objectAtIndex:dept] forKey:@"dept_name"];
                        [deptDict setObject:[self.deptIDArray objectAtIndex:dept] forKey:@"dept_id"];
                        [deptDict setObject:[self.deptSequenceArray objectAtIndex:dept] forKey:@"dept_code"];
                        [departmentArray addObject:deptDict];
                    }
                    for (int cat=0; cat<self.categoryArray.count; cat++) {
                        NSMutableDictionary *catDict=[[NSMutableDictionary alloc]init];
                        [catDict setObject:[self.categoryArray objectAtIndex:cat] forKey:@"cat_name"];
                        [catDict setObject:[self.categoryIDArray objectAtIndex:cat] forKey:@"cat_id"];
                        [catDict setObject:[self.categorySequenceArray objectAtIndex:cat] forKey:@"cat_code"];
                        [categoryArray addObject:catDict];
                    }
                    
                    
                    NSMutableDictionary *officeDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.officetextfield.text,@"office_name",[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"],@"id",self.abbrvtextfield.text,@"abrivation",self.subtitletext.text,@"sub_title",self.selectedSector,@"sector",self.regtext.text,@"reg_id",self.selectedCurrency,@"currency",self.financialyeartext.text,@"year",self.emailtextfield.text,@"email",self.telephonetextfield.text,@"telephone",self.faxtextfield.text,@"fax",self.websitetext.text,@"website",self.buildingtext.text,@"building",self.blocktext.text,@"block",self.streettext.text,@"street",countrystring,@"country",statestring,@"state",citystring,@"city",self.postcodetext.text,@"pincode",self.landmarktext.text,@"self.landmarktext.text",departmentArray,@"selected_department",categoryArray,@"selected_category",self.send_selectedbankarray,@"selected_bank",self.send_selectedprinterarray,@"printer_array",self.send_otherdetailsarray,@"otherdetails", nil];
                    
                    
                    [self.myconnection Editofficefunction:officeDict];//self.officetextfield.text officeId:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] abbrev:self.abbrvtextfield.text subtittle:self.subtitletext.text sector:self.sectortextfield.text regid:self.regtext.text currency:self.currencytextfield.text financialyear:self.financialyeartext.text emailid:self.emailtextfield.text telephonenumber:self.telephonetextfield.text fax:self.faxtextfield.text website:self.websitetext.text building:self.buildingtext.text block:self.blocktext.text street:self.streettext.text country:countrystring state:statestring city:citystring postcode:self.postcodetext.text landmark:self.landmarktext.text department_listarray:self.deptArray category_listarray:self.categoryArray bank_listarray:self.send_selectedbankarray printer_listarray:self.send_selectedprinterarray otherdetails_array:self.send_otherdetailsarray];
                    
                    
                    
                    [app hudStart:self];
                }
                else
                {
                    [self showalerviewcontroller:@"Other Details Heading and Description Mismatch"];
                }
            }
            else
            {
                [self showalerviewcontroller:@" Make sure that Office Must have Atleast One Department,Category,Bank and Printer"];
            }
        }
        else
        {
            [self showalerviewcontroller:@"Must Enter All The Mandatory Fileds"];
        }
    
    }
}

//Adding a new printer action

-(IBAction)addnewprinter:(id)sender
{
    self.printerflag=1;
    NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"addnewprinterpopup" owner:self options:Nil];
    [self addSubview:[nib objectAtIndex:0]];
    
   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"printerdictionary"];
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"printerdictionary"];
}


//begin action for department


-(IBAction)deptBeginEdit:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.departmentTableView];
    self.inPath= [self.departmentTableView indexPathForRowAtPoint:buttonPosition];
     self.fordeletedepartflag=0;
    alertFlag=0;
    
}

//end action for department

-(IBAction)deptEndEdit:(id)sender
{
    departmentTableViewCell *cell=(departmentTableViewCell *)[self.departmentTableView cellForRowAtIndexPath:self.inPath];
    cell.deptNameText.text=[cell.deptNameText.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    
    if (!([self.deptArray containsObject:cell.deptNameText.text])) {
        
        for (NSString *string in self.deptArray) {
            if([string caseInsensitiveCompare:cell.deptNameText.text] == NSOrderedSame )
            {
                [self showalerviewcontroller:[NSString stringWithFormat:@"%@ Already Exist",cell.deptNameText.text]];
                [self.departmentTableView reloadData];
                alertFlag=1;
                break;
            }
            
        }
        if (alertFlag==0) {
            if (cell.deptNameText.text.length > 0)
            {
                if (self.inPath.row == self.deptArray.count - 1)
                {
                    if (self.fordeletedepartflag==0)
                    {
                        [self.deptArray insertObject:cell.deptNameText.text atIndex:self.inPath.row];
                        [self.deptIDArray insertObject:@"0" atIndex:self.inPath.row];
                        [self deptAutocodeSequencing:1];
                        
                        [self.selectedDeptArray addObject:self.inPath];
                        
                        NSArray *visibleItems = [self.departmentTableView indexPathsForVisibleRows];
                        [self.departmentTableView reloadData];
                        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
                        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.deptArray.count - 1 inSection:currentItem.section];
                        
                        
                        [self.departmentTableView scrollToRowAtIndexPath:nextItem atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                        
                    }
                }
                else
                {
                    if (self.fordeletedepartflag==0) {
                        
                        [self.deptArray replaceObjectAtIndex:self.inPath.row withObject:cell.deptNameText.text];
                        
                    }
                }
                
                NSMutableDictionary *deptDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.deptIDArray objectAtIndex:self.inPath.row],@"dpmt_id",[self.deptArray objectAtIndex:self.inPath.row],@"dpmt_name",[self.deptSequenceArray objectAtIndex:self.inPath.row],@"dpmt_code",[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"],@"o_id", nil];
                [self.myconnection createorupdateDepartment:deptDict];
                
                [self.departmentTableView reloadData];
            }
            else
            {
                if (!(self.inPath.row ==self.deptArray.count -1 )) {
                    [self.deptArray removeObjectAtIndex:self.inPath.row];
                    [self.departmentTableView reloadData];
                }
                
            }
        }
        
    
    }
    else
        [self showalerviewcontroller:[NSString stringWithFormat:@"%@ Already Exist",cell.deptNameText.text]];

    [self.departmentTableView reloadData];


}
-(void)deptAutocodeSequencing:(int)ab
{
    while (ab<50000) {
        if ([self.deptSequenceArray containsObject:[NSString stringWithFormat:@"%d",ab]]) {
            ab++;
        }
        else
        {
            [self.deptSequenceArray insertObject:[NSString stringWithFormat:@"%d",ab] atIndex:self.inPath.row];
            break;
        }
            
    }
    
    
}
//begin action for category

-(IBAction)categoryBeginEdit:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.categoryTableView];
    self.inPath1= [self.categoryTableView indexPathForRowAtPoint:buttonPosition];
    NSLog(@"%@",self.inPath1);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,150);
   self.fordeletedepartflag=0;
    alertFlag=0;
}


//end action for category

-(IBAction)categoryEndEdit:(id)sender
{
    categoryTableViewCell *cell=(categoryTableViewCell *)[self.categoryTableView cellForRowAtIndexPath:self.inPath1];
    cell.categoryText.text=[cell.categoryText.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
    if (!([self.categoryArray containsObject:cell.categoryText.text])) {
        
        
        for (NSString *string in self.categoryArray) {
            if([string caseInsensitiveCompare:cell.categoryText.text] == NSOrderedSame )
            {
                [self showalerviewcontroller:[NSString stringWithFormat:@"%@ Already Exist",cell.categoryText.text]];
                alertFlag=1;
                [self.categoryTableView reloadData];
                break;
            }
        }
        if (alertFlag==0) {
            if (cell.categoryText.text.length > 0) {
                if (self.inPath1.row == self.categoryArray.count - 1) {
                    if (self.fordeletedepartflag==0)
                    {
                        [self.categoryArray insertObject:cell.categoryText.text atIndex:self.inPath1.row];
                        [self.categoryIDArray insertObject:@"0" atIndex:self.inPath1.row];
                        [self catAutocodeSequencing:1];
                        [self.selectedCategryArray addObject:self.inPath1];
                        
                        NSArray *visibleItems = [self.categoryTableView indexPathsForVisibleRows];
                        [self.categoryTableView reloadData];
                        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
                        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.categoryArray.count - 1 inSection:currentItem.section];
                        [self.categoryTableView scrollToRowAtIndexPath:nextItem atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                    }
                }
                else
                {
                    
                    if (self.fordeletedepartflag==0) {
                        
                        [self.categoryArray replaceObjectAtIndex:self.inPath1.row withObject:cell.categoryText.text];
                        
                    }
                }
                
                NSMutableDictionary *catDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.categoryIDArray objectAtIndex:self.inPath1.row],@"cat_id",[self.categoryArray objectAtIndex:self.inPath1.row],@"cat_name",[self.categorySequenceArray objectAtIndex:self.inPath1.row],@"cat_code",[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"],@"o_id", nil];
                [self.myconnection createorUpdateCategory:catDict];
                
                [self.categoryTableView reloadData];
            }
            else
            {
                if (!(self.inPath1.row ==self.categoryArray.count -1 )) {
                    
                    [self.categoryArray removeObjectAtIndex:self.inPath1.row];
                    [self.categoryTableView reloadData];
                }
            }
        }
    }
}
-(void)catAutocodeSequencing:(int)ab
{
    while (ab<50000) {
        if ([self.categorySequenceArray containsObject:[NSString stringWithFormat:@"%d",ab]]) {
            ab++;
        }
        else
        {
            [self.categorySequenceArray insertObject:[NSString stringWithFormat:@"%d",ab] atIndex:self.inPath1.row];
            break;
        }
        
    }
}

//department editing button action

-(IBAction)deptEditAction:(id)sender
{
    if (i%2==0) {
        [self.deptEditButton setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        deptEditFlag=0;
        [self.selectedDeptArray removeAllObjects];
        [self.departmentTableView reloadData];
        i++;
    }
    else
    {
        [self.deptEditButton setImage:[UIImage imageNamed:@"edit_button_new.png"] forState:UIControlStateNormal];
        deptEditFlag=1;
        [self.departmentTableView reloadData];
        i++;
    }
}


//category editing button action


-(IBAction)categoryEditAction:(id)sender
{
    if (j%2==0) {
        [self.catEditButton setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        catEditFlag=0;
        [self.selectedCategryArray removeAllObjects];
        [self.categoryTableView reloadData];
        j++;
    }
    else
    {
        [self.catEditButton setImage:[UIImage imageNamed:@"edit_button_new.png"] forState:UIControlStateNormal];
        catEditFlag=1;
        [self.categoryTableView reloadData];
        j++;
    }
}


//other details delete cell button action


-(IBAction)otherdetailsclosebuttonaction:(id)sender
{
    
    otherdetailscellclass *cell1 = (otherdetailscellclass *)[[sender superview] superview];
    NSIndexPath *myindex=[self.otherdetailstableview indexPathForCell:cell1];
    [self.otherdetailsfield1array removeObjectAtIndex:myindex.row];
    [self.otherdetailsfield2array removeObjectAtIndex:myindex.row];
    cell1.closebutton.hidden=TRUE;
    self.otherdteialsdeleteflag=1;
    [self.otherdetailstableview reloadData];
    
}


//Alertview  cancel for delete department and category cancel button action


-(IBAction)cancelfor_deletepopup:(id)sender
{
    
    self.departmentcategorydeletealertview.hidden=TRUE;
    
}


//Alertview done for delete department and category cancel button action

-(IBAction)donefor_deletepopup:(id)sender
{
    if (self.moveFlag==1) {
        NSMutableDictionary *deptDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.deptIDArray objectAtIndex:self.inPath.row],@"dpmt_id",self.moveID,@"new_dpmt_id", nil];
        [self.myconnection moveEmployeesToAnotherDepartment:deptDict];
    }
    else
    {
        NSMutableDictionary *catDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.categoryIDArray objectAtIndex:self.inPath.row],@"cat_id",self.moveID,@"new_cat_id", nil];
        [self.myconnection moveEmployeesToAnotherCategory:catDict];
    }
    
    
   
//    if(!(self.fordeletecategoryindex.row == self.categoryArray.count - 1))
//    {
//        [self.categoryArray removeObjectAtIndex:self.fordeletecategoryindex.row];
//        
//        self.inPath1=self.fordeletecategoryindex;
//              [self.categoryTableView reloadData];
//    }
//    self.departmentcategorydeletealertview.hidden=TRUE;
    
}



-(void)updateofficeResponse:(NSString *)updatedmessage
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([updatedmessage isEqualToString:@"success"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadoffice" object:Nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"enabled" object:Nil];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"wpsdictionary"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"printerdictionary"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"dictionaryKey"];
            
            self.errorFlag=1;
            [self showalerviewcontroller:@"Updated Successfully"];
        }
        else
        {
            [self showalerviewcontroller:@"Failed to Update"];
        }
        
    });
    
    
    
    
}
-(void)alertView:(NSString *)alertMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:[NSString stringWithFormat:@"%@",alertMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   
                                                   
                                                   //[self.otherdetailsfield1array removeObject:mycell.field1.text];
                                                   
                                                   [self.deptArray addObject:@""];
                                                   [self.categoryArray addObject:@""];
                                                   [self.otherdetailsfield2array addObject:@""];
                                                   //
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
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
                                                   if (_errorFlag==1) {
                                                       [app hudStop];
                                                       self.errorFlag=0;
                                                       [self removeFromSuperview];
                                                   }
                                                   
                                                   
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
}
-(void)createResponse:(id)Response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!([Response isEqualToString:@"error"])) {
            [self.deptIDArray replaceObjectAtIndex:self.inPath.row withObject:Response
             ];
        }
        
        
    });
}
-(void)viewAllResponse:(id)responseList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!([responseList isEqualToString:@"error"])) {
            [self.categoryIDArray replaceObjectAtIndex:self.inPath.row withObject:responseList
             ];
        }
        
    });
}
-(void)deleteResponse:(id)response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([response isEqualToString:@"exist"]) {
            
            self.departmentcategorydeletealertview.hidden=FALSE;
            self.departmentcategorydeletealertview.frame=CGRectMake(372, 155, self.departmentcategorydeletealertview.frame.size.width, self.departmentcategorydeletealertview.frame.size.height);
            self.popupLabel.text=@"Can not delete this entry as employees are currently assigned to this Department";
            [self.popupDropdownText setPlaceholder:@"Department"];
            [self.popupDropdownIDArray removeAllObjects];
            [self.popupDropdownContentArray removeAllObjects];
            [self.popupDropdownIDArray addObjectsFromArray:self.deptIDArray];
            [self.popupDropdownIDArray removeObjectAtIndex:self.inPath.row];
            [self.popupDropdownContentArray addObjectsFromArray:self.deptArray];
            [self.popupDropdownContentArray removeObjectAtIndex:self.inPath.row];
            [self.popupDropdownTC reloadData];
            
            self.moveFlag=1;
            
        }
        else
        {
            [self.deptArray removeObjectAtIndex:self.inPath.row];
            [self.deptIDArray removeObjectAtIndex:self.inPath.row];
            [self.deptSequenceArray removeObjectAtIndex:self.inPath.row];
            
            self.departmentcategorydeletealertview.hidden=true;
            [self.departmentTableView reloadData];
        }
        
        
    });
}
-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([responseData isEqualToString:@"exist"]) {
            
            self.departmentcategorydeletealertview.hidden=FALSE;
            self.departmentcategorydeletealertview.frame=CGRectMake(372, 315, self.departmentcategorydeletealertview.frame.size.width, self.departmentcategorydeletealertview.frame.size.height);
            self.popupLabel.text=@"Can not delete this entry as employees are currently assigned to this Category";
            [self.popupDropdownText setPlaceholder:@"Category"];
            [self.popupDropdownIDArray removeAllObjects];
            [self.popupDropdownContentArray removeAllObjects];
            [self.popupDropdownIDArray addObjectsFromArray:self.categoryIDArray];
            [self.popupDropdownIDArray removeObjectAtIndex:self.inPath.row];
            [self.popupDropdownContentArray addObjectsFromArray:self.categoryArray];
            [self.popupDropdownContentArray removeObjectAtIndex:self.inPath.row];
            [self.popupDropdownTC reloadData];
            
            self.moveFlag=2;
            
        }
        else
        {
            [self.categoryArray removeObjectAtIndex:self.inPath.row];
            [self.categoryIDArray removeObjectAtIndex:self.inPath.row];
            [self.categorySequenceArray removeObjectAtIndex:self.inPath.row];
            
            self.departmentcategorydeletealertview.hidden=true;
            [self.categoryTableView reloadData];
        }
        
    });
}
@end
