//
//  presentfilerview.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 26/07/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "presentfilerview.h"

@implementation presentfilerview

-(void)awakeFromNib
{
    //self.filterview.hidden=FALSE;
    
    //self.frame=CGRectMake(9, 116, self.frame.size.width, self.frame.size.height);
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-850, -300, 1300, 1000)];
    
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
    //  self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    
    self.layer.shadowOpacity = 0.6f;
    
    self.layer.shadowPath = shadowPath.CGPath;
    
}
@end
