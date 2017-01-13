                                                                                                                                                                                              //
//  addnewemployee2Class.m
//  bablusdemokpproject
//
//  Created by leonine on 8/19/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "addnewemployee2Class.h"
#import "homeViewController.h"

@implementation addnewemployee2Class

- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
-(void)awakeFromNib
{
 dispatch_async(dispatch_get_main_queue(), ^{
    self.connection=[[connectionclass alloc]init];
    self.connection.mydelegate=self;
    
     
    
    [self.connection displayAllCountries];//Function call to list all country
    
     [self.connection getLocalCity:[[NSUserDefaults standardUserDefaults]objectForKey:@"empID"]];
    
    [self clearFunction];
    
     
    
    self.relationshipTableView.hidden=true;
    self.localCityTableView.hidden=true;
    self.homeCountryTableView.hidden=true;
    self.homeStateTableView.hidden=true;
    self.homeCityTableView.hidden=true;
    
    self.relationshipArray=[[NSMutableArray alloc]initWithObjects:@"Spouse",@"Parent",@"Child",@"Relative",@"Friend",@"Colleague", nil];
    self.localCityArray=[[NSMutableArray alloc]init];
    self.homeCountryArray=[[NSMutableArray alloc]init];
    self.homeStateArray=[[NSMutableArray alloc]init];
    self.homeCityArray=[[NSMutableArray alloc]init];
    self.countryFilteredArray=[[NSMutableArray alloc]init];
    self.stateFilterdArray=[[NSMutableArray alloc]init];
    self.cityFilteredArray=[[NSMutableArray alloc]init];
    self.localCityFilteredArray=[[NSMutableArray alloc]init];
    
    self.countryDict=[[NSMutableDictionary alloc]init];
    self.stateDict=[[NSMutableDictionary alloc]init];
    self.cityDict=[[NSMutableDictionary alloc]init];
     self.localCityDict=[[NSMutableDictionary alloc]init];
    
    self.x=self.y=0;
    self.z=0;
    self.p=0;
    self.q=0;
    self.r=0;
     
     self.empID=@"0";
     
     //set static text
     self.codeText1.leftView = self.plusLabel1;;
     self.codeText1.leftViewMode = UITextFieldViewModeAlways;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
 });
}
-(void)fillDetails:(NSMutableDictionary *)detailsDict
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"%@",detailsDict);
        NSMutableDictionary *personalDict=[detailsDict objectForKey:@"basic_info"];
        self.empID=[personalDict objectForKey:@"emp_id"];
        self.empCode=[personalDict objectForKey:@"emp_code"];
        self.companyTelephoneText.text=[personalDict objectForKey:@"emp_company_phone"];
        self.extText.text=[personalDict objectForKey:@"emp_company_ph_ext"];
        self.codeText1.text=[NSString stringWithFormat:@"+%@",[personalDict objectForKey:@"cmp_mob_code"]];
        self.companyMobileText.text=[personalDict objectForKey:@"emp_company_mobile"];
        self.codeText2.text=[NSString stringWithFormat:@"+%@",[personalDict objectForKey:@"per_mob_code"]];
        self.personalMobileText.text=[personalDict objectForKey:@"emp_personal_mobile"];
        self.personalEmailText.text=[personalDict objectForKey:@"emp_personal_email"];
        self.companyEmailText.text=[personalDict objectForKey:@"emp_company_email"];
        self.nomineeNameText.text=[personalDict objectForKey:@"emp_nominee_name"];
        self.nomineeContactText.text=[personalDict objectForKey:@"emp_nominee_contact"];
        self.nomineeRelationshipText.text=[personalDict objectForKey:@"emp_nominee_relationship"];
        self.localBlockText.text=[personalDict objectForKey:@"emp_local_block_address"];
        self.localStreetText.text=[personalDict objectForKey:@"emp_local_street_address"];
        self.localBuildingText.text=[personalDict objectForKey:@"emp_local_building"];
        self.localFlatText.text=[personalDict objectForKey:@"emp_local_flat"];
        if ([personalDict objectForKey:@"local_city"]!=(id)[NSNull null]) {
            self.localCityText.text=[personalDict objectForKey:@"local_city"];
        }
        else
            self.localCityText.text=@"";
        
        self.localCityID=[personalDict objectForKey:@"emp_local_city"];
        self.localPostcodeText.text=[personalDict objectForKey:@"emp_local_post_code"];
        self.homeBlockText.text=[personalDict objectForKey:@"emp_home_block_address"];
        self.homeStreetText.text=[personalDict objectForKey:@"emp_home_street_address"];
        self.homeBuildingText.text=[personalDict objectForKey:@"emp_home_building"];
        self.homeFlatText.text=[personalDict objectForKey:@"emp_home_flat"];
        if ([personalDict objectForKey:@"emp_country"]!=(id)[NSNull null]) {
            self.homeCountryText.text=[personalDict objectForKey:@"emp_country"];
        }
        else
            self.homeCountryText.text=@"";
        
        if (self.homeCountryText.text.length > 0) {
            self.x=1;
        }
        self.homeCountryID=[personalDict objectForKey:@"emp_home_country"];
        self.homeStateID=[personalDict objectForKey:@"emp_home_state"];
        
        if ([personalDict objectForKey:@"state"]!=(id)[NSNull null]) {
            self.homeStateText.text=[personalDict objectForKey:@"state"];
            
        }
        else
            self.homeStateText.text=@"";
        
        if (self.homeStateText.text.length > 0) {
            self.x=2;
        }
        self.homeCityID=[personalDict objectForKey:@"emp_home_city"];
        if ([personalDict objectForKey:@"emp_city"]!=(id)[NSNull null]) {
            self.homeCityText.text=[personalDict objectForKey:@"emp_city"];
        }
        else
            self.homeCityText.text=@"";
        
        self.homePostcodeText.text=[personalDict objectForKey:@"emp_home_post_code"];
        
        [self.connection displaySelectedStates:self.homeCountryID];
        [self.connection displayAllCities:self.homeStateID];
    });
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.relationshipTableView)
        return self.relationshipArray.count;
    else if (tableView==self.localCityTableView)
    {
        if (self.r==1) {
            return self.localCityFilteredArray.count;
        }
        else
            return self.localCityArray.count;
    }
    else if (tableView==self.homeCountryTableView)
    {
       if (self.y==1) {
             return self.countryFilteredArray.count;
        }
        else
            return self.homeCountryArray.count;
    }
    else if (tableView==self.homeStateTableView)
    {
        if (self.z==1) {
            return self.stateFilterdArray.count;
        }
        else
            return self.homeStateArray.count;
    }
    else
        if (self.p==1) {
            return self.cityFilteredArray.count;
        }
        else
            return self.homeCityArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.relationshipTableView)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.relationshipArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return cell;
    }
    else if (tableView==self.localCityTableView)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        if (self.r==1) {
            cell.textLabel.text=[self.localCityFilteredArray objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text=[self.localCityArray objectAtIndex:indexPath.row];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return cell;
    }
    else if (tableView==self.homeCountryTableView)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        if (self.y==1) {
            cell.textLabel.text = [self.countryFilteredArray objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text = [self.homeCountryArray objectAtIndex:indexPath.row];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return cell;
    }
    else if (tableView==self.homeStateTableView)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        if (self.z==1) {
            cell.textLabel.text=[self.stateFilterdArray objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text=[self.homeStateArray objectAtIndex:indexPath.row];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return cell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        if (self.p==1) {
            cell.textLabel.text=[self.cityFilteredArray objectAtIndex:indexPath.row];
        }
        else
        {
           cell.textLabel.text=[self.homeCityArray objectAtIndex:indexPath.row];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.homeCountryTableView) {
        self.x=1;
        if (self.y==1) {
            self.homeCountryText.text=[self.countryFilteredArray objectAtIndex:indexPath.row];
        }
        else
        {
            self.homeCountryText.text=[self.homeCountryArray objectAtIndex:indexPath.row];
        }
        
        self.homeCountryTableView.hidden=TRUE;
        self.homeCountryID=[self.countryDict objectForKey:self.homeCountryText.text];
        //Function calling for listing all the states in the selected country
        [self.connection displaySelectedStates:self.homeCountryID];
        
        [self.homeCountryText resignFirstResponder];
        self.homeStateText.text=@"";
        self.homeCityText.text=@"";

        self.z=0;
        self.p=0;
    }
    else if (tableView==self.homeStateTableView)
    {
        self.x=2;
        if (self.z==1) {
            self.homeStateText.text=[self.stateFilterdArray objectAtIndex:indexPath.row];

        }
        else
        {
            self.homeStateText.text=[self.homeStateArray objectAtIndex:indexPath.row];
        }
        self.homeStateTableView.hidden=true;
        self.homeStateID=[self.stateDict objectForKey:self.homeStateText.text];
        //Function calling for listing all the cities in the selected country
        self.cityAddressFlag=@"homeCity";
        [self.connection displayAllCities:self.homeStateID];
        [self.homeStateText resignFirstResponder];
        self.homeCityText.text=@"";
        self.p=0;

    }
    else if (tableView==self.homeCityTableView)
    {
        if (self.p==1) {
            self.homeCityText.text=[self.cityFilteredArray objectAtIndex:indexPath.row];
        }
        else
        {
            self.homeCityText.text=[self.homeCityArray objectAtIndex:indexPath.row];
        }
        self.homeCityID=[self.cityDict objectForKey:self.homeCityText.text];
        self.homeCityTableView.hidden=true;
        [self.homeCityText resignFirstResponder];
    }
    else if (tableView==self.relationshipTableView)
    {
        self.nomineeRelationshipText.text=[self.relationshipArray objectAtIndex:indexPath.row];
        self.relationshipTableView.hidden=TRUE;
    }
    else
    {
        if (self.r==1) {
            self.localCityText.text=[self.localCityFilteredArray objectAtIndex:indexPath.row];
        }
        else
        {
            self.localCityText.text=[self.localCityArray objectAtIndex:indexPath.row];
        }
        self.localCityID=[self.localCityDict objectForKey:self.localCityText.text];
        self.localCityTableView.hidden=true;
        [self.localCityText resignFirstResponder];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.nomineeRelationshipText) {
        [self.relationshipTableView reloadData];
        self.relationshipTableView.hidden=false;
        return NO;
    }
    else if (textField==self.localCityText)
    {
        [self.localCityTableView reloadData];
        self.localCityTableView.hidden=false;
        return YES;
    }
    else if (textField==self.homeCountryText)
    {
        [self.homeCountryTableView reloadData];
        self.homeCountryTableView.hidden=false;
        return YES;
    }
    else if (textField==self.homeStateText)
    {
        if (self.x>=1) {
            [self.homeStateTableView reloadData];
            self.homeStateTableView.hidden=FALSE;
            self.homeStateText.textColor=[UIColor blackColor];
            self.homeStateText.userInteractionEnabled=YES;
            self.homeStateText.backgroundColor=[UIColor clearColor];
            self.homeStateText.text=@"";
            return  YES;
        }
        else
        {
            self.homeStateText.text=@"Must Select Country";
            self.homeStateText.textColor=[UIColor redColor];
            return NO;
        }
        
    }
    else if (textField==self.homeCityText)
    {
        if (self.x==2) {
            [self.homeCityTableView reloadData];
            self.homeCityTableView.hidden=FALSE;
            self.homeCityText.textColor=[UIColor blackColor];
            self.homeCityText.userInteractionEnabled=YES;
            self.homeCityText.backgroundColor=[UIColor clearColor];
            self.homeCityText.text=@"";
            return YES;
        }
        else
        {
            self.homeCityText.text=@"Must Select State";
            self.homeCityText.textColor=[UIColor redColor];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.homeCountryText) {
        if (!(self.homeCountryText.text.length >0)) {
            self.homeCountryTableView.hidden=true;
            self.homeStateText.text=@"";
            self.homeCityText.text=@"";
            
        }
        return  YES;
    }
    else if (textField==self.homeStateText)
    {
        if (!(self.homeStateText.text.length >0)) {
            self.homeStateTableView.hidden=true;
            self.homeCityText.text=@"";
            
        }
        return  YES;

    }
    else if (textField==self.homeCityText)
    {
        if (!(self.homeCityText.text.length > 0)) {
            self.homeCityTableView.hidden=true;
        }
        return  YES;

    }
    else if (textField==self.companyEmailText)
    {
        self.q=1;
        [self validateEmail:self.companyEmailText.text];
        return  YES;
    }
    else if (textField==self.personalEmailText)
    {
        self.q=2;
        [self validateEmail:self.personalEmailText.text];
        return  YES;
    }
    else
        return  YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    if (textField==self.homeCountryText) {
        self.y=1;
        [self.countryFilteredArray removeAllObjects];
        self.homeCountryTableView.hidden=FALSE;
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",
                                   [self.homeCountryText.text stringByReplacingCharactersInRange:range withString:string]];
        self.countryFilteredArray = [[self.homeCountryArray filteredArrayUsingPredicate:bPredicate]
                                     mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeCountryTableView reloadData];
        });
        
        
        if ([string isEqualToString:@""] && textField.text.length==1) {
            self.y=0;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.homeCountryTableView reloadData];
            });
        }
        
        
        return YES;
    }
    else if (textField==self.homeStateText)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.z=1;
            self.homeStateTableView.hidden=FALSE;
            [self.stateFilterdArray removeAllObjects];
            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",
                                       [self.homeStateText.text stringByReplacingCharactersInRange:range withString:string]];
            self.stateFilterdArray = [[self.homeStateArray filteredArrayUsingPredicate:bPredicate]
                                      mutableCopy];
            
            [self.homeStateTableView reloadData];
            if ([string isEqualToString:@""] && textField.text.length==1) {
                self.z=0;
                [self.homeStateTableView reloadData];
            }
            
            
            
        });
        return YES;
    }
    else if(textField==self.homeCityText)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.p=1;
            self.homeCityTableView.hidden=FALSE;
            [self.cityFilteredArray removeAllObjects];
            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",
                                       [self.homeCityText.text stringByReplacingCharactersInRange:range withString:string]];
            self.cityFilteredArray = [[self.homeCityArray filteredArrayUsingPredicate:bPredicate]
                                      mutableCopy];
            [self.homeCityTableView reloadData];
            if ([string isEqualToString:@""] && textField.text.length==1) {
                self.p=0;
                [self.homeCityTableView reloadData];
            }
        });
        
        return YES;
    }
    else if (textField==self.localCityText)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.r=1;
            self.localCityTableView.hidden=FALSE;
            [self.localCityFilteredArray removeAllObjects];
            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",
                                       [self.localCityText.text stringByReplacingCharactersInRange:range withString:string]];
            self.localCityFilteredArray = [[self.localCityArray filteredArrayUsingPredicate:bPredicate]
                                           mutableCopy];
            [self.localCityTableView reloadData];
            if ([string isEqualToString:@""] && textField.text.length==1) {
                self.r=0;
                [self.localCityTableView reloadData];
            }

        });
        return YES;
    }
    else if ((textField==self.companyTelephoneText)||(textField==self.nomineeContactText))
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=19) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789+-"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    else if ((textField==self.codeText1)||(textField==self.codeText2))
    {
        if ([string isEqualToString:@""]) {
            
            
            if ([textField.text isEqualToString:@"+"]) {
                
                return NO;
            }
            else
            {
                 return YES;
            }
            
           
        }
        if (textField.text.length<=3) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789+"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    else if ((textField==self.companyMobileText)||(textField==self.personalMobileText))
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=13) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789+-"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    else if (textField==self.companyEmailText)
    {
        self.companyEmailText.textColor=[UIColor blackColor];
        return YES;
    }
    else if (textField==self.personalEmailText)
    {
        self.personalEmailText.textColor=[UIColor blackColor];
        return YES;
    }
    else if(textField==self.extText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789+"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    else if (textField==self.localPostcodeText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=19) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    else if (textField==self.homePostcodeText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=19) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    else if (textField==self.nomineeNameText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=50) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
            //for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    else if ((textField==self.localBlockText) || (textField==self.localStreetText) || (textField==self.localBuildingText) || (textField==self.localFlatText) || (textField==self.homeBlockText) || (textField==self.homeStreetText) || (textField==self.homeBuildingText) || (textField==self.homeFlatText))
    {
        if ([string isEqualToString:@""]) {
            
            if ([textField.text isEqualToString:@"+"]) {
                
               return NO;
            }
            else
            {
                 return YES;
            }
            
           
        }
        if (textField.text.length<=20) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-/><?|.,"];
            //for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
        {
            return NO;
        }

    }
    else
    {
        return YES;
    }
}

//Email Validation
- (BOOL)validateEmail:(NSString *)emailStr
{
    //dispatch_async(dispatch_get_main_queue(), ^{
        if([emailStr isEqualToString:@""])
        {
            return YES;
        }
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if ([emailTest evaluateWithObject:emailStr]) {
            if (self.q==1) {
                self.companyEmailText.textColor=[UIColor blackColor];
                self.q=0;
            }
            else
            {
                self.personalEmailText.textColor=[UIColor blackColor];
                self.q=0;
            }
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
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
                    [(homeViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
                }
                else
                {
                    [(homeViewController *)[self.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
                }
                
            });
            
            
            
            if (self.q==1) {
                self.companyEmailText.textColor=[UIColor redColor];
                self.q=0;
            }
            else
            {
                self.personalEmailText.textColor=[UIColor redColor];
                self.q=0;
            }
        }
        return [emailTest evaluateWithObject:emailStr];
   // });
    
}

//Keyboard scrolling action

- (void) keyboardDidShow:(NSNotification *)notification
{
   // dispatch_async(dispatch_get_main_queue(), ^{
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
   // });
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
   // dispatch_async(dispatch_get_main_queue(), ^{
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
  //  });
    
}


-(IBAction)saveButtonAction:(id)sender
{
    if ((self.companyEmailText.text.length > 0) && (self.companyMobileText.text.length >0)) {
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
            
            NSMutableDictionary *contactDetails=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"empID"],@"emp_id",self.companyTelephoneText.text,@"emp_company_phone",self.extText.text,@"emp_company_ph_ext",self.companyMobileText.text,@"emp_company_mobile",[self.codeText1.text substringFromIndex:1],@"emp_mob_code",self.personalMobileText.text,@"emp_personal_mobile",[self.codeText2.text substringFromIndex:1],@"per_mob_code",self.personalEmailText.text,@"emp_personal_email",self.companyEmailText.text,@"emp_company_email",self.nomineeNameText.text,@"emp_nominee_name",self.nomineeContactText.text,@"emp_nominee_contact",self.nomineeRelationshipText.text,@"emp_nominee_relationship",self.localBlockText.text,@"emp_local_block_address",self.localStreetText.text,@"emp_local_street_address",self.localBuildingText.text,@"emp_local_building",self.localFlatText.text,@"emp_local_flat",self.localCityID,@"emp_local_city",self.localPostcodeText.text,@"emp_local_post_code",self.homeBlockText.text,@"emp_home_block_address",self.homeStreetText.text,@"emp_home_street_address",self.homeBuildingText.text,@"emp_home_building",self.homeFlatText.text,@"emp_home_flat",self.homeCountryID,@"emp_home_country",self.self.homeStateID,@"emp_home_state",self.self.homeCityID,@"emp_home_city",self.homePostcodeText.text,@"emp_home_post_code", nil];
            
            [self.connection addNewEmployeeSave2:contactDetails];
        }
        else
        {
            NSMutableDictionary *contactDetails=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.empCode,@"emp_id",self.companyTelephoneText.text,@"emp_company_phone",self.extText.text,@"emp_company_ph_ext",self.companyMobileText.text,@"emp_company_mobile",[self.codeText1.text substringFromIndex:1],@"emp_mob_code",self.personalMobileText.text,@"emp_personal_mobile",[self.codeText2.text substringFromIndex:1],@"per_mob_code",self.personalEmailText.text,@"emp_personal_email",self.companyEmailText.text,@"emp_company_email",self.nomineeNameText.text,@"emp_nominee_name",self.nomineeContactText.text,@"emp_nominee_contact",self.nomineeRelationshipText.text,@"emp_nominee_relationship",self.localBlockText.text,@"emp_local_block_address",self.localStreetText.text,@"emp_local_street_address",self.localBuildingText.text,@"emp_local_building",self.localFlatText.text,@"emp_local_flat",self.localCityID,@"emp_local_city",self.localPostcodeText.text,@"emp_local_post_code",self.homeBlockText.text,@"emp_home_block_address",self.homeStreetText.text,@"emp_home_street_address",self.homeBuildingText.text,@"emp_home_building",self.homeFlatText.text,@"emp_home_flat",self.homeCountryID,@"emp_home_country",self.self.homeStateID,@"emp_home_state",self.self.homeCityID,@"emp_home_city",self.homePostcodeText.text,@"emp_home_post_code", nil];
            
            [self.connection updateEmployee2:contactDetails];
        }
        
        
        
    }
    else
    {
        [self alertAction:@"Must Enter All the Mandatory Fields"];
        
    }
    
    
    
}
-(IBAction)clearButtonAction:(id)sender
{
    [self clearFunction];
}
-(void)clearFunction
{
    self.x=self.y=self.z=self.p=0;self.localCityID=@"";self.homeCountryID=@"";self.homeStateID=@"";self.homeCityID=@"";
    
    self.companyTelephoneText.text=@"";self.extText.text=@"";self.companyMobileText.text=@"";self.personalMobileText.text=@"";self.personalEmailText.text=@"";self.companyEmailText.text=@"";self.nomineeNameText.text=@"";self.nomineeContactText.text=@"";self.nomineeRelationshipText.text=@"";
    self.localBlockText.text=@"";self.localStreetText.text=@"";self.localBuildingText.text=@"";self.localFlatText.text=@"";self.localCityText.text=@"";self.localPostcodeText.text=@"";self.homeBlockText.text=@"";self.homeStreetText.text=@"";self.homeBuildingText.text=@"";self.homeFlatText.text=@"";self.homeCountryText.text=@"";self.homeStateText.text=@"";self.homeCityText.text=@"";self.homePostcodeText.text=@"";
}
-(void)willRemoveSubview:(UIView *)subview
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *action=[[NSUserDefaults standardUserDefaults]objectForKey:@"action"];
        [[NSUserDefaults standardUserDefaults]setObject:@"remove" forKey:@"action"];
        if ([action isEqualToString:@"save"]) {
            [self removeFromSuperview];
            
        }
    });
    
}
-(IBAction)cancelButtonAction:(id)sender
{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"cancel" forKey:@"action"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:Nil];
    [self removeFromSuperview];
}
-(void)alertAction:(NSString *)message

{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@""
                               message:[NSString stringWithFormat:@"%@",message]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
            [(homeViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            [(homeViewController *)[self.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
        
    });
}



//--------------------------------------------------Response Part----------------------------------------


//Got response if no network connection is available
-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Error"
                               message:@"No internet connection"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
            [(homeViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            [(homeViewController *)[self.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
        
    });
    
    
}

-(void)addNewEmployeeSaveResponse:(NSString *)saveResponse
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([saveResponse isEqualToString:@"1"]) {
                       
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"addnewemployee3View" owner:self options:nil];
            [self addSubview:[nib objectAtIndex:0]];
        }
        else
        {
            [self alertAction:@"Error in saving"];
        }
        
    });
    
    
}
-(void)createResponse:(id)Response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([Response isEqualToString:@"1"]) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"addnewemployee3View" owner:self options:nil];
            [self addSubview:[nib objectAtIndex:0]];
        }
        else
        {
            [self alertAction:@"Error in saving"];
        }
        
    });
}
-(void)allcountryresponse:(id)countrylist//Response for listing all country
{
    
    self.y=0;
    [self.homeCountryArray removeAllObjects];
    for (int i=0; i<[countrylist count]; i++) {
        
        NSString *mystring=[[countrylist objectAtIndex:i] objectForKey:@"name"];
        [self.homeCountryArray addObject:mystring];
        [self.countryDict setObject:[[countrylist objectAtIndex:i] objectForKey:@"country_id"] forKey:mystring];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.homeCountryTableView reloadData];
    });
    
    
}
-(void)allstateresponse:(id)statelist //Response for listing all states
{
    self.z=0;
    [self.homeStateArray removeAllObjects];
    for (int i=0; i<[statelist count]; i++) {
        
        NSString *mystring=[[statelist objectAtIndex:i] objectForKey:@"name"];
        [self.homeStateArray addObject:mystring];
        [self.stateDict setObject:[[statelist objectAtIndex:i] objectForKey:@"state_id"] forKey:mystring];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.homeStateTableView reloadData];
    });
    
}
-(void)allcityresponse:(id)Citylist//Response for listing all cities
{
    if (!([Citylist count] > 0)) {
        self.homeCityText.backgroundColor=[UIColor lightGrayColor];
        self.homeCityText.text=@"No City to Select";
        self.homeCityText.textColor=[UIColor redColor];
        self.homeCityText.userInteractionEnabled=NO;
    }
    else
    {
        self.p=0;
        [self.homeCityArray removeAllObjects];
        for (int i=0; i<[Citylist count]; i++) {
            [self.homeCityArray addObject:[[Citylist objectAtIndex:i]objectForKey:@"name"]];
            [self.cityDict setObject:[[Citylist objectAtIndex:i] objectForKey:@"city_id"] forKey:[[Citylist objectAtIndex:i]objectForKey:@"name"]];
        }
        

            
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeCityTableView reloadData];
        });
    }
   
    
}

-(void)serviceGotResponse:(id)responseData
{
    [self.localCityArray removeAllObjects];
    NSMutableArray *localCity=[responseData objectForKey:@"city"];

    
    for (int i=0; i<[localCity count]; i++) {
        
        NSMutableDictionary *localCityDict=[localCity objectAtIndex:i];
        
        [self.localCityArray addObject:[localCityDict objectForKey:@"name"]];
        [self.localCityDict setObject:[localCityDict objectForKey:@"city_id"] forKey:[[localCity objectAtIndex:i] objectForKey:@"name"]];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"update"]){
            
                NSData *newData = [[NSUserDefaults standardUserDefaults] objectForKey:@"employeewholeDetails"];
                self.detailsDict=[[NSMutableDictionary alloc]init];
                self.detailsDict=[NSKeyedUnarchiver unarchiveObjectWithData:newData];
            
            
                [self fillDetails:self.detailsDict];
            }
        [self.localCityTableView reloadData];
    });
    
    
}
@end
