//
//  designationDeletionPopUpClass.m
//  Automate Firm
//
//  Created by leonine on 10/18/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "designationDeletionPopUpClass.h"

@implementation designationDeletionPopUpClass

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.alpha=100;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-500, -350, 1300, 1000)];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    //  self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
}

@end
