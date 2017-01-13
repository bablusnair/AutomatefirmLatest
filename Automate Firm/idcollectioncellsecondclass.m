//
//  idcollectioncellsecondclass.m
//  bablusdemokpproject
//
//  Created by leonine on 24/06/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "idcollectioncellsecondclass.h"

@implementation idcollectioncellsecondclass
-(void)awakeFromNib
{
    
 self.mylabel.transform=CGAffineTransformMakeRotation( ( -90 * M_PI ) / 180 );
 
    //self.bartextview.layer.borderWidth = 1.0;
   // self.bartextview.layer.borderColor = [UIColor blueColor].CGColor;
}



@end
