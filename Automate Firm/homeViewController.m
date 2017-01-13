//
//  homeViewController.m
//  Automire Firm
//
//  Created by leonine on 14/09/15.
//  Copyright (c) 2015 leonine. All rights reserved.
//

#import "homeViewController.h"
#import "staffinghomeview.h"
#import "documentationhomeviewclass.h"
@interface homeViewController ()

@end

@implementation homeViewController
@synthesize identifyhomebuttonindex;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if (self.identifyhomebuttonindex==4)
    {
        for (UIView *view in self.view.subviews) {
            if ( [view isKindOfClass:[staffinghomeview class]] ||  [view isKindOfClass:[documentationhomeviewclass class]]) {
                [view removeFromSuperview];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"staffinghome" owner:self options:Nil];
            [self.view addSubview:[myviewarray objectAtIndex:0]];
            [self.staffing setImage:[UIImage imageNamed:@"icon_staffing_default.png"] forState:UIControlStateNormal];
        });
    }
    else if(identifyhomebuttonindex==2)
    {
        for (UIView *view in self.view.subviews) {
            
            if ( [view isKindOfClass:[staffinghomeview class]]  || [view isKindOfClass:[documentationhomeviewclass class]]) {
                [view removeFromSuperview];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"documentationhomeview" owner:self options:Nil];
            [self.view addSubview:[myviewarray objectAtIndex:0]];
            [self.documentation setImage:[UIImage imageNamed:@"icon_documentation_red.png"] forState:UIControlStateNormal];
        });
    }
    
    
    
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)staffingactionbutton:(id)sender {
    
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[staffinghomeview class]]) {
            
            [view removeFromSuperview];
        }
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"staffinghome" owner:self options:Nil];
        
        [self.view addSubview:[myviewarray objectAtIndex:0]];
        
        [self.staffing setImage:[UIImage imageNamed:@"icon_staffing_default.png"] forState:UIControlStateNormal];
        [self.tasks setImage:[UIImage imageNamed:@"icon_task_blue_default.png"] forState:UIControlStateNormal];
        [self.inventory setImage:[UIImage imageNamed:@"icon_inventory_blue.png"] forState:UIControlStateNormal];
        [self.projects setImage:[UIImage imageNamed:@"icon_projects_blue_default.png"] forState:UIControlStateNormal];
        [self.documentation setImage:[UIImage imageNamed:@"icon_documentation_blue.png"] forState:UIControlStateNormal];
    });
}
- (IBAction)documentationactionbutton:(id)sender
{
    
    
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[staffinghomeview class]]) {
            [view removeFromSuperview];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"documentationhomeview" owner:self options:Nil];
        
        [self.view addSubview:[myviewarray objectAtIndex:0]];
    });
    
    [self.projects setImage:[UIImage imageNamed:@"icon_projects_blue_default.png"] forState:UIControlStateNormal];
    [self.staffing setImage:[UIImage imageNamed:@"icon_staffing_blue_default.png"] forState:UIControlStateNormal];
    [self.tasks setImage:[UIImage imageNamed:@"icon_task_blue_default.png"] forState:UIControlStateNormal];
    [self.inventory setImage:[UIImage imageNamed:@"icon_inventory_blue.png"] forState:UIControlStateNormal];
    [self.documentation setImage:[UIImage imageNamed:@"icon_documentation_red.png"] forState:UIControlStateNormal];
    
    
}
@end
