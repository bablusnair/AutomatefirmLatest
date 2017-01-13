//
//  viewclassmovecopyclass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 22/08/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "viewclassmovecopyclass.h"

@implementation viewclassmovecopyclass

-(void)awakeFromNib
{
    
    
    //self.frame=CGRectMake(9, 1116, self.frame.size.width, self.frame.size.height);
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-850, -300, 1900, 1000)];
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layer.shadowOpacity = 0.6f;
   
    self.layer.shadowPath = shadowPath.CGPath;
    
}


@end
