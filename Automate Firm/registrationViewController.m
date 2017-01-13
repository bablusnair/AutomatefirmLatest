//
//  registrationViewController.m
//  Automate Firm
//
//  Created by leonine on 11/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "registrationViewController.h"

@interface registrationViewController ()

@end

@implementation registrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    self.x=0;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"forgetAction"]isEqualToString:@"1"]) {
        
        [self resendAction:self];
    }
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"forgetAction"];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)proceedAction:(id)sender {
    self.regstrationSubview.hidden=false;
    
    [self.regScrollView setContentOffset:CGPointMake(0,351) animated:YES];
    

    
//    UIView *popUpView=[[[NSBundle mainBundle]loadNibNamed:@"registartionPopupView" owner:self options:nil]objectAtIndex:0];
//    
//   // popUpView.frame=CGRectMake(120, 90, 800, 600);
//    [self.view addSubview:popUpView];
}
- (IBAction)registrationOkAction:(id)sender {
    
    if ((self.cmpnyIdText.text.length && self.empIdText.text.length && self.authCodeText.text.length)>0) {
        
        NSString * cmpnyString = [self.cmpnyIdText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString * empstring = [self.empIdText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString * authstring = [self.authCodeText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        [self.myconnection registerServiceFunction:cmpnyString paswrd:empstring cmpnyId:authstring];
        
        
        
    }
    else{
       // [self showalerviewcontroller:@"Enter All fields" mainMsg:@"Registration Failed"];
    }

    
}


//RegistrationResponse

-(void)registrationDetailResponse:(id)details
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([details objectForKey:@"basic_info"]!=(id)[NSNull null]) {
            
            
            //NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[[details objectForKey:@"basic_info"] objectForKey:@"emp_encode_image"] options:0];
            
//            self.myimage.image=[UIImage imageWithData:decodedData];
//            self.myimage.layer.cornerRadius = self.myimage.frame.size.width / 2;
//            self.myimage.clipsToBounds = YES;
            
            
            self.nameLabel.text=[[details objectForKey:@"basic_info"] objectForKey:@"emp_name"];
            self.empCodeLabel.text=[[details objectForKey:@"basic_info"] objectForKey:@"e_code"];
            self.workingPremiseLabel.text=[[details objectForKey:@"basic_info"] objectForKey:@"office_name"];
            self.designationLabel.text=[[details objectForKey:@"basic_info"] objectForKey:@"designation_title"];
            self.firmLabel.text=[[details objectForKey:@"basic_info"] objectForKey:@"office_name"];
            self.departmntLabel.text=[[details objectForKey:@"basic_info"] objectForKey:@"department_name"];
            self.catgryLabel.text=[[details objectForKey:@"basic_info"] objectForKey:@"cat_name"];
        }
         [[NSUserDefaults standardUserDefaults] setObject:[[details objectForKey:@"basic_info"] objectForKey:@"emp_id"] forKey:@"employeeIdNumber"];
    });
    
    

}

//Resend authentication code EmpId
- (IBAction)resendAction:(id)sender {
    
    if (self.x%2==0) {
        
        self.paswrdImage.image=[UIImage imageNamed:@"loginicon_1.png"];
        self.authCodeText.placeholder=@"email-id";
        self.okButon.frame=CGRectMake(779, 319, 49, 30);
        self.resendButn.frame=CGRectMake(459, 319, 73, 21);
        self.phoneText.hidden=false;
        self.phnImage.hidden=false;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[self.resendButn attributedTitleForState:UIControlStateNormal]];
        [attributedString replaceCharactersInRange:NSMakeRange(0, attributedString.length) withString:@"CANCEL"];
        [self.resendButn setAttributedTitle:attributedString forState:UIControlStateNormal];
        self.x++;
    }
    else{
        self.paswrdImage.image=[UIImage imageNamed:@"loginicon_3.png"];
        self.authCodeText.placeholder=@"Authentication Code";
        self.okButon.frame=CGRectMake(779, 262, 49, 30);
        self.resendButn.frame=CGRectMake(459, 262, 73, 21);
        self.phoneText.hidden=true;
        self.phnImage.hidden=true;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[self.resendButn attributedTitleForState:UIControlStateNormal]];
        [attributedString replaceCharactersInRange:NSMakeRange(0, attributedString.length) withString:@"RESEND"];
        [self.resendButn setAttributedTitle:attributedString forState:UIControlStateNormal];
        
        
        self.x++;
    }

}

- (IBAction)registerCmpleteAction:(id)sender {
    NSString * pwdstring = [self.paswrdText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [self.myconnection sendUserDetails:pwdstring language:self.languageText.text emId:[[NSUserDefaults standardUserDefaults]objectForKey:@"employeeIdNumber"]];
    
    
}
//RegistrationComplete Response and Load Login page
-(void)registraionCmpleteResponse:(id)response
{
    if ([response isEqualToString:@" 1"]) {
        [self dismissViewControllerAnimated: YES completion:nil];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            registrationViewController *obj =(registrationViewController *)[self.superview nextResponder];
//            [obj performSegueWithIdentifier:@"backToLogin" sender:Nil];
//            
//        });
    }
}


@end
