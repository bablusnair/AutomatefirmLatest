//
//  RegistrationViewViewController.m
//  Automate Firm
//
//  Created by leonine on 1/13/17.
//  Copyright © 2017 leonine. All rights reserved.
//

#import "RegistrationViewViewController.h"

@interface RegistrationViewViewController ()

@end

@implementation RegistrationViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(IBAction)save:(id)sender
{
    [self performSegueWithIdentifier:@"register" sender:nil];
}

@end
