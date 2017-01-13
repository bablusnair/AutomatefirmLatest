//
//  staffinghomeview.m
//  bablusdemokpproject
//
//  Created by Emvigo on 16/02/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "staffinghomeview.h"
#import "ContainerTableCell.h"
#import "ViewController.h"
#import "demostaffingviewclass.h"
#import "addnewemployeeclass.h"
#import "staffingidcardviewclass.h"
@implementation staffinghomeview
@synthesize i;

- (void)drawRect:(CGRect)rect {
    
    
    self.frame=CGRectMake(140,22, self.frame.size.width, self.frame.size.height);
  
  
}
-(void)awakeFromNib
{
    
    NSArray *myviewarray2=[[NSBundle mainBundle] loadNibNamed:@"demostaffing" owner:self options:Nil];
    [self.mainview addSubview:[myviewarray2 objectAtIndex:0]];
 
    self.i=self.j=0;
    
}


- (IBAction)addemployeeactionbutton:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"create" forKey:@"empStatus"];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *action=[[NSUserDefaults standardUserDefaults]objectForKey:@"action"];
        if ([action isEqualToString:@"remove"]) {
            self.i=0;
            [[NSUserDefaults standardUserDefaults]setObject:@"nil" forKey:@"action"];
        }
        
        if (self.i%2==0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"employeeview" owner:self options:Nil];
                [self.mainview addSubview:[myviewarray objectAtIndex:0]];
            });
            self.i++;
        }
        else
        {
            for (UIView *myview in self.mainview.subviews) {
                if ([myview isKindOfClass:[addnewemployeeclass class]])
                    [myview removeFromSuperview];
            }
            self.i++;
        }
    });
}
-(IBAction)identityCardAction:(id)sender
{
    if (self.j%2==0) {
        NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"staffingidcardsview" owner:self options:Nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainview addSubview:[myviewarray objectAtIndex:0]];
        });
        self.j++;
    }
    else
    {
        {
            for (UIView *myview in self.mainview.subviews) {
                if ([myview isKindOfClass:[staffingidcardviewclass class]])
                    [myview removeFromSuperview];
            }
            self.j++;
        }
    }
}
- (IBAction)shiftButtonAction:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"shiftMainView" owner:self options:Nil];
        [self.mainview addSubview:[myviewarray objectAtIndex:0]];
    });
}
@end
