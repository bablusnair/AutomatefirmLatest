//
//  registrationPopupClass.m
//  Automate Firm
//
//  Created by leonine on 11/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "registrationPopupClass.h"
#import "registrationViewController.h"

@implementation registrationPopupClass

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib {
    self.languagenamesarray=[[NSMutableArray alloc] initWithObjects:@"English",@"Arabic",@"Hindi",@"Telugu",@"Tamil",@"Malayalam",@"Bengali",@"Persian",@"Urdu",@"Nepali",@"SriLankan",@"Kannada", nil];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;

}
- (IBAction)closeAction:(id)sender {
    [self removeFromSuperview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=self.languagenamesarray[indexPath.row];
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    self.languageText.text=self.languagenamesarray[indexPath.row];
    self.languagTable.hidden=true;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==3) {
    self.languagTable.hidden=false;
    return  NO;
    }
    else
        return  YES;
}
- (IBAction)proceedActionToLogin:(id)sender {
    NSString * pwdstring = [self.paswrText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [self.myconnection sendUserDetails:pwdstring language:self.languageText.text emId:[[NSUserDefaults standardUserDefaults]objectForKey:@"employeeIdNumber"]];


}
//RegistrationComplete Response and Load Login page
-(void)registraionCmpleteResponse:(id)response
{
    if ([response isEqualToString:@" 1"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            registrationViewController *obj =(registrationViewController *)[self.superview nextResponder];
            [obj performSegueWithIdentifier:@"backToLogin" sender:Nil];

        });
    }
}
@end
