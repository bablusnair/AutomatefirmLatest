//
//  signupViewController.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 23/01/2017.
//  Copyright © 2017 leonine. All rights reserved.
//

#import "signupViewController.h"

@interface signupViewController ()

@end

@implementation signupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    [self.myconnection displayAllCountries];
    [self.myconnection signupAgentlistingservice];
    [self.myconnection signupsectorlistingservice];
    
    
    self.countrydict=[[NSMutableDictionary alloc] init];
    self.statedict=[[NSMutableDictionary alloc] init];
    self.citydict=[[NSMutableDictionary alloc] init];
    self.sectordict=[[NSMutableDictionary alloc] init];
    self.agentdict=[[NSMutableDictionary alloc] init];
    
     self.filterflag=0;
     self.filterflag1=0;
     self.filterflag2=0;
    
    self.encodedString=@"";
    self.sectorTableview.hidden=true;
    self.agentTableview.hidden=true;
    self.livinginTableview.hidden=true;
    self.stateTableview.hidden=true;
    self.cityTableview.hidden=true;
    self.datebackgroundView.hidden=true;
    self.estdatebackgroundView.hidden=true;
    
    self.sectorArray=[[NSMutableArray alloc] init];
    
    self.agentArray=[[NSMutableArray alloc] init];
    
    self.livingInArray=[[NSMutableArray alloc] init];

    self.stateArray=[[NSMutableArray alloc] init];
    
    self.cityArray=[[NSMutableArray alloc] init];
    
    self.filtercountryArray=[[NSMutableArray alloc] init];
    self.filterstateArray=[[NSMutableArray alloc] init];
    self.filtercityArray=[[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd/MMM/yyyy"];
    self.subTextfield.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
   
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
        
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
        
    }
    
}



- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.scrollView.contentOffset = CGPointMake(0,0);

    if (textField==self.regemailTextfield)
    {
        
        [self validateEmail:self.regemailTextfield.text];
        return  YES;
    }
   else if (textField==self.secondaryTextfield)
    {
        
        [self validateEmail:self.secondaryTextfield.text];
        return  YES;
    }
   else if (textField==self.urlTextfield)
   {
       self.domainstring=self.urlTextfield.text;
       NSString *str =[NSString stringWithFormat:@"%.@automatefirm.com",self.urlTextfield.text];
       self.urlTextfield.text=str;
       return  YES;
   }

    else
    {
        return YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  
    if (textField==self.sectorTextfield) {
        
        self.sectorTableview.hidden=false;
        return NO;
        
    }
   else if (textField==self.agentTextfield) {
        
        self.agentTableview.hidden=false;
        return NO;
        
    }
   else if (textField==self.livinginTextfield) {
       
       self.livinginTableview.hidden=false;
       return NO;
       
   }
   else if (textField==self.stateTextfield) {
       
       self.stateTableview.hidden=false;
       return NO;
       
   }
   else if (textField==self.cityTextfield) {
       
       self.cityTableview.hidden=false;
       return NO;
       
   }
   else if (textField==self.dateTextfield) {
       
       self.datebackgroundView.hidden=false;
       return NO;
       
   }
   else if (textField==self.estTextfield) {
       
       self.estdatebackgroundView.hidden=false;
       return NO;
       
   }
   else
   {
       self.activeField=textField;
       return  YES;
   
   }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.sectorTableview) {
        
        return [self.sectorArray count];
    }
    else if (tableView==self.agentTableview) {
        
        return [self.agentArray count];
    }
    else if (tableView==self.livinginTableview) {
        
       // if (self.filterflag==1)
        //{
           // return [self.filtercountryArray count];
       // }
       // else
       // {
            return [self.livingInArray count];
       // }
       
    }
    else if (tableView==self.stateTableview) {
        
        //if (self.filterflag1==1)
       // {
        //    return [self.filterstateArray count];
       // }
      //  else
       // {
            return [self.stateArray count];
       // }

    }
    else
    {
        
       // if (self.filterflag2==1)
       // {
            //return [self.filtercityArray count];
       // }
       // else
       // {
            return [self.cityArray count];
        //}

    }
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.sectorTableview) {
        
        UITableViewCell *cell =[[UITableViewCell alloc] init];
        cell.textLabel.text=[self.sectorArray objectAtIndex:indexPath.row];
        return cell;
    }
    else  if (tableView==self.agentTableview) {
        
        UITableViewCell *cell =[[UITableViewCell alloc] init];
        cell.textLabel.text=[self.agentArray objectAtIndex:indexPath.row];
        return cell;
    }
    else  if (tableView==self.livinginTableview) {
        
        UITableViewCell *cell =[[UITableViewCell alloc] init];
       
     //   if (self.filterflag==1)
        //{
           // cell.textLabel.text = [self.filtercountryArray objectAtIndex:indexPath.row];
        //}
      //  else
        //{
             cell.textLabel.text=[self.livingInArray objectAtIndex:indexPath.row];
       // }
    
        return cell;
    }

    else  if (tableView==self.stateTableview) {
        
        UITableViewCell *cell =[[UITableViewCell alloc] init];
        
//        if (self.filterflag1==1)
//        {
//            cell.textLabel.text = [self.filterstateArray objectAtIndex:indexPath.row];
//        }
//        else
//        {
            cell.textLabel.text=[self.stateArray objectAtIndex:indexPath.row];
//        }

        return cell;
    }

    else  {
        
        UITableViewCell *cell =[[UITableViewCell alloc] init];
        
//        if (self.filterflag2==1)
//        {
//            cell.textLabel.text = [self.filtercityArray objectAtIndex:indexPath.row];
//        }
//        else
//        {
          cell.textLabel.text=[self.cityArray objectAtIndex:indexPath.row];
        
//        }

        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.sectorTableview) {
        
        self.sectorTextfield.text=[self.sectorArray objectAtIndex:indexPath.row];
        self.sectorTableview.hidden=true;
        
        if (self.sectorTextfield.text.length>0) {
            
             self.sectorString=[self.sectordict objectForKey:self.sectorTextfield.text];
        }
       
    }
   else  if (tableView==self.agentTableview) {
        
        self.agentTextfield.text=[self.agentArray objectAtIndex:indexPath.row];
        self.agentTableview.hidden=true;
       
       if (self.agentTextfield.text.length>0) {
           
           self.agentString=[self.agentdict objectForKey:self.agentTextfield.text];
       }
    }
   else  if (tableView==self.livinginTableview) {
       
       self.livinginTextfield.text=[self.livingInArray objectAtIndex:indexPath.row];
       
       if(self.livinginTextfield.text.length>0)
       {
            [self.myconnection displaySelectedStates:[self.countrydict objectForKey:self.livinginTextfield.text]];
           self.countryString=[self.countrydict objectForKey:self.livinginTextfield.text];
       }
      
       self.livinginTableview.hidden=true;
   }
   else  if (tableView==self.stateTableview) {
       
       self.stateTextfield.text=[self.stateArray objectAtIndex:indexPath.row];
       
       if(self.stateTextfield.text.length>0)
       {
            [self.myconnection displayAllCities:[self.statedict objectForKey:self.stateTextfield.text]];
           self.stateString=[self.statedict objectForKey:self.stateTextfield.text];
       }
       self.stateTableview.hidden=true;
   }
   else  if (tableView==self.cityTableview) {
       
       self.cityTextfield.text=[self.cityArray objectAtIndex:indexPath.row];
       self.cityTableview.hidden=true;
       self.cityString=[self.citydict objectForKey:self.cityTextfield.text];
   }
    
}



- (IBAction)datepickerDoneaction:(id)sender
{
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
        dateFormat.dateStyle=NSDateFormatterMediumStyle;
        [dateFormat setDateFormat:@"yyyy"];
    
        NSDateFormatter *dateFormat1=[[NSDateFormatter alloc]init];
        dateFormat1.dateStyle=NSDateFormatterMediumStyle;
        [dateFormat1 setDateFormat:@"dd/MMM/yyyy"];
    
        if ( [sender tag]==0) {
    
            NSString *str=[NSString stringWithFormat:@"%@",[dateFormat1  stringFromDate:self.DatesDatePicker.date]];
            self.dateTextfield.text=str;
            self.datebackgroundView.hidden=true;
        }
    
        else{
            
            NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:self.estDatePicker.date]];
            self.estTextfield.text=str;
            self.estdatebackgroundView.hidden=true;
        }
    
}


-(IBAction)signupbuttonAction:(id)sender
{
    
    [self.myconnection signupserviceForAdminModule:self.domainstring username:self.usernameTextfield.text firmname:self.firmnameTextfield.text sector:self.sectorString estdate:self.estTextfield.text sub:self.subTextfield.text agent:self.agentString firstname:self.firstnameTextfield.text lastname:self.lastnameTextfield.text dob:self.dateTextfield.text regcontact:self.regcontactTextfield.text regemail:self.regemailTextfield.text recoverymail:self.secondaryTextfield.text livingin:self.countryString state:self.stateString city:self.cityString imagedata:self.encodedString status:@"T"];
    
}

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
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
        });
        
        
        
    }
    
    return [emailTest evaluateWithObject:emailStr];
   
    
}

-(IBAction)uploadLogoAction:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
   [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.logoImageview.image = chosenImage;
    
    if (self.logoImageview!=Nil) {
        
        self.nofileChooselabel.hidden=true;
    }
    else{
        
        self.nofileChooselabel.hidden=false;
    }
    
    
    
    NSData *data=UIImagePNGRepresentation(chosenImage);
    NSData *image64BaseData= [data base64EncodedDataWithOptions:0];
    self.encodedString=[[NSString alloc]initWithData:image64BaseData encoding:NSUTF8StringEncoding];

    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)allcountryresponse:(id)countrylist;
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.livingInArray removeAllObjects];
        for (int i=0; i<[countrylist count]; i++) {
            
            
            NSMutableDictionary *dict = [countrylist objectAtIndex:i];
            [self.countrydict setObject:[dict objectForKey:@"country_id"] forKey:[dict objectForKey:@"country_name"]];
            [self.livingInArray addObject:[dict objectForKey:@"country_name"]];
            
        }
        
        [self.livinginTableview reloadData];
        
    });

}

-(void)allstateresponse:(id )statelist
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.stateArray removeAllObjects];
        for (int i=0; i<[statelist count]; i++) {
            
            
            NSMutableDictionary *dict = [statelist objectAtIndex:i];
            [self.statedict setObject:[dict objectForKey:@"state_id"] forKey:[dict objectForKey:@"name"]];
            [self.stateArray addObject:[dict objectForKey:@"name"]];
            
        }
        
        [self.stateTableview reloadData];
        
    });


}

-(void)allcityresponse:(id)Citylist
{
    
    [self.cityArray removeAllObjects];
    NSLog(@"%@",Citylist);

    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.cityArray removeAllObjects];
        
        for (int i=0; i<[Citylist count]; i++) {
            
            NSMutableDictionary *dict = [Citylist objectAtIndex:i];
            
            [self.citydict setObject:[dict objectForKey:@"city_id"] forKey:[dict objectForKey:@"name"]];
            [self.cityArray addObject:[dict objectForKey:@"name"]];
        }
        
        [self.cityTableview reloadData];
        
    });

}

-(void)signupmodulesectorResponse:(id)details
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.sectorArray removeAllObjects];
        
        for (int i=0; i<[details count]; i++) {
            
            NSMutableDictionary *dict = [details objectAtIndex:i];
            
            [self.sectordict setObject:[dict objectForKey:@"s_id"] forKey:[dict objectForKey:@"title"]];
            
            [self.sectorArray addObject:[dict objectForKey:@"title"]];
        }
        
        [self.sectorTableview reloadData];
        
    });
    
}

-(void)signupmoduleagentResponse:(id)details
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.agentArray removeAllObjects];
        
        for (int i=0; i<[details count]; i++) {
            
            NSMutableDictionary *dict = [details objectAtIndex:i];
            
           [self.agentdict setObject:[dict objectForKey:@"id"] forKey:[dict objectForKey:@"agent_name"]];
            
            [self.agentArray addObject:[dict objectForKey:@"agent_name"]];
        }
        
        [self.agentTableview reloadData];
        
    });

}

-(void)signupAdminmoduleResponse:(id)details
{
    NSLog(@"%@",details);
    
    if ([[details objectForKey:@"result"]isEqualToString:@"success"]) {
        
        [self performSegueWithIdentifier:@"nextview" sender:Nil];
        
    }
    
}

-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Error"
                               message:[NSString stringWithFormat:@"%@",errorMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self presentViewController:alert animated:YES completion:nil];
    });

}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (textField==self.livinginTextfield) {
//       
//            self.filterflag=1;
//            self.livinginTableview.hidden=FALSE;
//            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.livinginTextfield.text stringByReplacingCharactersInRange:range withString:string]];
//            self.filtercountryArray = [[self.livingInArray filteredArrayUsingPredicate:bPredicate] mutableCopy];
//            [self.livinginTableview reloadData];
//            if ([string isEqualToString:@""] && textField.text.length==1)
//            {
//                self.filterflag=0;//
//                [self.livinginTableview reloadData];
//            }
//        
//        return  YES;
//    }
//    
//     else if (textField==self.stateTextfield) {
//       
//       self.filterflag1=1;
//       self.stateTableview.hidden=FALSE;
//       NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.stateTextfield.text stringByReplacingCharactersInRange:range withString:string]];
//       self.filterstateArray = [[self.stateArray filteredArrayUsingPredicate:bPredicate] mutableCopy];
//       [self.stateTableview reloadData];
//       if ([string isEqualToString:@""] && textField.text.length==1)
//       {
//           self.filterflag1=0;//
//           [self.stateTableview reloadData];
//       }
//       
//       return  YES;
//   }
//    
//     else if (textField==self.cityTextfield) {
//         
//         self.filterflag2=1;
//         self.cityTableview.hidden=FALSE;
//         NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.cityTextfield.text stringByReplacingCharactersInRange:range withString:string]];
//         self.filtercityArray = [[self.cityArray filteredArrayUsingPredicate:bPredicate] mutableCopy];
//         [self.cityTableview reloadData];
//         if ([string isEqualToString:@""] && textField.text.length==1)
//         {
//             self.filterflag2=0;//
//             [self.cityTableview reloadData];
//         }
//         
//         return  YES;
//     }
//    
//    else
//    {
//        return Nil;
//    }
//}
@end
