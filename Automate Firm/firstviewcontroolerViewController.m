//
//  firstviewcontroolerViewController.m
//  bablusdemokpproject
//
//  Created by Emvigo on 20/01/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "firstviewcontroolerViewController.h"
#import "ViewController.h"
@interface firstviewcontroolerViewController ()
- (IBAction)staffing:(id)sender;

@end

@implementation firstviewcontroolerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(IBAction)back:(UIStoryboardSegue *)segue
{
    
    
    
    
}




- (IBAction)staffing:(id)sender {
    
    [self performSegueWithIdentifier:@"staffing" sender:Nil];
}





@end
