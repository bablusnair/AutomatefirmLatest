//
//  addnewemployeeclass.m
//  bablusdemokpproject
//
//  Created by Emvigo on 22/01/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "addnewemployeeclass.h"
#import "ViewController.h"
#import "custumclasscell.h"
#import "Customcell1.h"
#import "staffinghomeview.h"
@implementation addnewemployeeclass


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)awakeFromNib {
    
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"addnewemployee1View" owner:self options:nil];//Load 1st employee add screen to myView.
    [self.myView addSubview:[nib objectAtIndex:0]];
}
-(void)willRemoveSubview:(UIView *)subview
{
    NSString *action=[[NSUserDefaults standardUserDefaults]objectForKey:@"action"]; //When try to remove view.
    if ([action isEqualToString:@"remove"]) {
        [self removeFromSuperview];
    }
    
    
}

@end
