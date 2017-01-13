//
//  portalSettingsViewClass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 25/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "portalSettingsViewClass.h"
#import "settingsViewController.h"

@implementation portalSettingsViewClass
@synthesize x,y,check1,check10,check11,check12,check2,check3,check4,check5,check6,check7,check8,check9;
-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    [self.myconnection viewPortal:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    
    self.workStatusDropArray=[[NSMutableArray alloc] initWithObjects:@"on a daily basis",@"on the last day of the month",@"after each payment period", nil];
    self.leadershipArray1=[[NSMutableArray alloc] initWithObjects:@"Weekly",@"Semi-monthly",@"Monthly",@"Quarterly",@"Semi-anually",@"Annually", nil];
    
    x=y=0;
    check1=check10=check11=check12=check2=check3=check4=check5=check6=check7=check8=check9=0;
    
    
    self.pictureValue=self.personalValue=self.nomineeValue=self.homeAddressValue=self.educationValue=self.contactValue=self.localAddressValue=self.skillsValue=self.checkoutValue=self.workStatusValue=self.leadershipValue=self.payValue=self.overtimeValue=self.shiftValue=self.weekValue=self.leavesValues=1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.workStatusTC) {
        return self.workStatusDropArray.count;
    }
    else
    {
        return  self.leadershipArray1.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.workStatusTC) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.workStatusDropArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return  cell;
    }
    else{
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.leadershipArray1 objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return  cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.workStatusTC) {
        self.workStatusText.text=[self.workStatusDropArray objectAtIndex:indexPath.row];
        self.workStatusTC.hidden=true;
        self.workStatusValue=indexPath.row + 1;
    }
    else
    {
        self.leadershipText.text=[self.leadershipArray1 objectAtIndex:indexPath.row];
        self.leadershipTC.hidden=true;
        self.leadershipValue=indexPath.row + 1;
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.workStatusText) {
        self.workStatusTC.hidden=false;
        self.leadershipTC.hidden=true;
        return NO;
    }
    else if (textField==self.leadershipText)
    {
        self.leadershipTC.hidden=false;
        self.workStatusTC.hidden=true;
        return  NO;
    }
    else
        return NO;
}
-(IBAction)doneButton:(id)sender
{

    NSMutableDictionary *portalDetailsDict=[[NSMutableDictionary alloc]init];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.pictureValue] forKey:@"picture"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.personalValue] forKey:@"personal"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.nomineeValue] forKey:@"nominee"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.homeAddressValue] forKey:@"home_add"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.educationValue] forKey:@"education"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.contactValue] forKey:@"contact"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.localAddressValue] forKey:@"local_add"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.skillsValue] forKey:@"skills"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.checkoutValue] forKey:@"checkout"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.workStatusValue] forKey:@"work_status"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.leadershipValue] forKey:@"leadership_list"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.payValue] forKey:@"pay"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.overtimeValue] forKey:@"overtime"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.shiftValue] forKey:@"shift"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.weekValue] forKey:@"week"];
    [portalDetailsDict setObject:[NSString stringWithFormat:@"%d",self.leavesValues] forKey:@"leaves"];
    
    NSMutableDictionary *mainPortalDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:portalDetailsDict,@"portal_details",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"o_id", nil];
    
    [self.myconnection createPortal:mainPortalDict];
    

}
-(IBAction)cancelButton:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)editPictureAction:(id)sender
{
    if (x%2==0) {
        [self.profileButton setImage:[UIImage imageNamed:@"icon_2.png"] forState:UIControlStateNormal];
        self.canEditLabel.text=@"Can't Edit Picture";
        self.pictureValue=0;
        x++;
    }
    else
    {
        [self.profileButton setImage:[UIImage imageNamed:@"icon_profile.png"] forState:UIControlStateNormal];
        self.canEditLabel.text=@"Can Edit Picture";
        self.pictureValue=1;
        x++;
    }
}
-(IBAction)editCheckoutAction:(id)sender
{
    if (y%2==0) {
        [self.checkoutButton setImage:[UIImage imageNamed:@"icon_4.png"] forState:UIControlStateNormal];
        self.allowLabel.text=@"Don't allow Employee to checkout using portal";
        self.checkoutValue=0;
        y++;
    }
    else
    {
        [self.checkoutButton setImage:[UIImage imageNamed:@"icon_location.png"] forState:UIControlStateNormal];
        self.allowLabel.text=@"Allow Employee to checkout using portal";
        self.checkoutValue=1;
        y++;
    }
}
-(IBAction)checkBoxAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        if (check1%2==0) {
            [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.personalValue=0;
            check1++;
        }
        else
        {
            [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.personalValue=1;
            check1++;
        }
        
    }
    if (button.tag==2) {
        if (check2%2==0) {
            [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.nomineeValue=0;
            check2++;
        }
        else
        {
            [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.nomineeValue=1;
            check2++;
        }
    }
    if (button.tag==3) {
        if (check3%2==0) {
            [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.homeAddressValue=0;
            check3++;
        }
        else
        {
            [self.checkButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.homeAddressValue=1;
            check3++;
        }
    }
    if (button.tag==4) {
        if (check4%2==0) {
            [self.checkButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.educationValue=0;
            check4++;
        }
        else
        {
            [self.checkButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.educationValue=1;
            check4++;
        }
    }
    if (button.tag==5) {
        if (check5%2==0) {
            [self.checkButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.contactValue=0;
            check5++;
        }
        else
        {
            [self.checkButton5 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.contactValue=1;
            check5++;
        }
    }
    if (button.tag==6) {
        if (check6%2==0) {
            [self.checkButton6 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.localAddressValue=0;
            check6++;
        }
        else
        {
            [self.checkButton6 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.localAddressValue=1;
            check6++;
        }
    }
    if (button.tag==7) {
        if (check7%2==0) {
            [self.checkButton7 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.skillsValue=0;
            check7++;
        }
        else
        {
            [self.checkButton7 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.skillsValue=1;
            check7++;
        }
    }
    if (button.tag==8) {
        if (check8%2==0) {
            [self.checkButton8 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.payValue=0;
            check8++;
        }
        else
        {
            [self.checkButton8 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.payValue=1;
            check8++;
        }
    }
    if (button.tag==9) {
        if (check9%2==0) {
            [self.checkButton9 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.overtimeValue=0;
            check9++;
        }
        else
        {
            [self.checkButton9 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.overtimeValue=1;
            check9++;
        }
    }
    if (button.tag==10) {
        if (check10%2==0) {
            [self.checkButton10 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.shiftValue=0;
            check10++;
        }
        else
        {
            [self.checkButton10 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.shiftValue=1;
            check10++;
        }
    }
    if (button.tag==11) {
        if (check11%2==0) {
            [self.checkButton11 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.weekValue=0;
            check11++;
        }
        else
        {
            [self.checkButton11 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.weekValue=1;
            check11++;
        }
    }
    if (button.tag==12) {
        if (check12%2==0) {
            [self.checkButton12 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            self.leavesValues=0;
            check12++;
        }
        else
        {
            [self.checkButton12 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            self.leavesValues=1;
            check12++;
        }
    }
}

-(void)createResponse:(id)Response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[Response objectForKey:@"status"] isEqualToString:@"200"]) {
            [self showalerviewcontroller:@"Successfully Created"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
            [self removeFromSuperview];
        }
        else
        {
            [self showalerviewcontroller:@"Failed to Create"];
        }
    });
}
-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([responseData count]>0) {
            NSMutableArray *portalArray=[responseData objectForKey:@"portal_details"];
            NSMutableDictionary *portalDict=[portalArray objectAtIndex:0];
            
            if([[portalDict objectForKey:@"picture"]isEqualToString:@"1"])
            {
                [self.profileButton setImage:[UIImage imageNamed:@"icon_profile.png"] forState:UIControlStateNormal];
                self.canEditLabel.text=@"Can Edit Picture";
                self.pictureValue=1;
            }
            else
            {
                [self.profileButton setImage:[UIImage imageNamed:@"icon_2.png"] forState:UIControlStateNormal];
                self.canEditLabel.text=@"Can't Edit Picture";
                self.pictureValue=0;
                x++;
            }
            
            if ([[portalDict objectForKey:@"personal"]isEqualToString:@"1"]) {
                [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.personalValue=1;
            }
            else
            {
                [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.personalValue=0;
                check1++;
            }
            
            if ([[portalDict objectForKey:@"nominee"]isEqualToString:@"1"]) {
                [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.nomineeValue=1;
            }
            else
            {
                [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.nomineeValue=0;
                check2++;
            }
            
            if ([[portalDict objectForKey:@"home_add"]isEqualToString:@"1"]) {
                [self.checkButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.homeAddressValue=1;
            }
            else
            {
                [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.homeAddressValue=0;
                check3++;
            }
            
            if ([[portalDict objectForKey:@"education"]isEqualToString:@"1"]) {
                [self.checkButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.educationValue=1;
            }
            else
            {
                [self.checkButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.educationValue=0;
                check4++;
            }
            
            if ([[portalDict objectForKey:@"contact"]isEqualToString:@"1"]) {
                [self.checkButton5 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.contactValue=1;
            }
            else
            {
                [self.checkButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.contactValue=0;
                check5++;
            }
            if ([[portalDict objectForKey:@"local_add"]isEqualToString:@"1"]) {
                [self.checkButton6 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.localAddressValue=1;
            }
            else
            {
                [self.checkButton6 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.localAddressValue=0;
                check6++;
            }
            
            if ([[portalDict objectForKey:@"skills"]isEqualToString:@"1"]) {
                [self.checkButton7 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.skillsValue=1;
            }
            else
            {
                [self.checkButton7 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.skillsValue=0;
                check7++;
            }
            if ([[portalDict objectForKey:@"checkout"]isEqualToString:@"1"]) {
                [self.checkoutButton setImage:[UIImage imageNamed:@"icon_location.png"] forState:UIControlStateNormal];
                self.allowLabel.text=@"Allow Employee to checkout using portal";
                self.checkoutValue=1;
            }
            else
            {
                [self.checkoutButton setImage:[UIImage imageNamed:@"icon_4.png"] forState:UIControlStateNormal];
                self.allowLabel.text=@"Don't allow Employee to checkout using portal";
                self.checkoutValue=0;
                y++;
            }
            
            if ([[portalDict objectForKey:@"work_status"]isEqualToString:@"1"]) {
                self.workStatusText.text=[self.workStatusDropArray objectAtIndex:0];
                self.workStatusValue=1;
            }
            else if ([[portalDict objectForKey:@"work_status"]isEqualToString:@"2"])
            {
                self.workStatusText.text=[self.workStatusDropArray objectAtIndex:1];
                self.workStatusValue=2;
            }
            else
            {
                self.workStatusText.text=[self.workStatusDropArray objectAtIndex:2];
                self.workStatusValue=3;
            }
            
            switch ([[portalDict objectForKey:@"leadership_list"] integerValue]) {
                case 1:
                    self.leadershipText.text=[self.leadershipArray1 objectAtIndex:0];
                    self.leadershipValue=1;
                    break;
                case 2:
                    self.leadershipText.text=[self.leadershipArray1 objectAtIndex:1];
                    self.leadershipValue=2;
                    break;
                case 3:
                    self.leadershipText.text=[self.leadershipArray1 objectAtIndex:2];
                    self.leadershipValue=3;
                    break;
                case 4:
                    self.leadershipText.text=[self.leadershipArray1 objectAtIndex:3];
                    self.leadershipValue=4;
                    break;
                case 5:
                    self.leadershipText.text=[self.leadershipArray1 objectAtIndex:4];
                    self.leadershipValue=5;
                    break;
                case 6:
                    self.leadershipText.text=[self.leadershipArray1 objectAtIndex:5];
                    self.leadershipValue=6;
                    break;
                    
                default:
                    break;
            }
            
            if ([[portalDict objectForKey:@"pay"]isEqualToString:@"1"]) {
                [self.checkButton8 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.payValue=1;
            }
            else
            {
                [self.checkButton8 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.payValue=0;
                check8++;
            }
            
            if ([[portalDict objectForKey:@"overtime"]isEqualToString:@"1"]) {
                [self.checkButton9 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.overtimeValue=1;
            }
            else
            {
                [self.checkButton9 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.overtimeValue=0;
                check9++;
            }
            if ([[portalDict objectForKey:@"shift"]isEqualToString:@"1"]) {
                [self.checkButton10 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.shiftValue=1;
            }
            else
            {
                [self.checkButton10 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.shiftValue=0;
                check10++;
            }
            if ([[portalDict objectForKey:@"week"]isEqualToString:@"1"]) {
                [self.checkButton11 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.weekValue=1;
            }
            else
            {
                [self.checkButton11 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.weekValue=0;
                check11++;
            }
            if ([[portalDict objectForKey:@"leaves"]isEqualToString:@"1"]) {
                [self.checkButton12 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                self.leavesValues=1;
            }
            else
            {
                [self.checkButton12 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
                self.leavesValues=0;
                check12++;
            }
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
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
    
}
@end
