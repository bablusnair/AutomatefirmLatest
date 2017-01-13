//
//  carryforwardPopUpViewClass.m
//  Automate Firm
//
//  Created by leonine on 11/6/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "carryforwardPopUpViewClass.h"

@implementation carryforwardPopUpViewClass

-(void)awakeFromNib
{
    self.frame=CGRectMake(-220, -60, self.frame.size.width, self.frame.size.height);
    self.backgroundColor=[UIColor whiteColor];
    self.alpha=100;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-400, -250, 1300, 1000)];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    //  self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
    
    accordion = [[carryForwardOptionsTile alloc] initWithFrame:CGRectMake(15, 80, 770, 500)];
    [self addSubview:accordion];
    
    
    carryForwardOptionsTile *myobj = (carryForwardOptionsTile *)[self.subviews lastObject];
    [myobj CreationoftileforUpdation:5];
    
}
-(IBAction)closeButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableall" object:Nil];

    [self removeFromSuperview];
}
@end
