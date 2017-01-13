//
//  employeeindividualviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/8/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "headerprotocol.h"
#include "IndividualAccordionView.h"
#import "connectionclass.h"
@interface employeeindividualviewclass : UIView<headerprotocol>
{
   IndividualAccordionView *accordion;
}

@property(nonatomic,retain)NSMutableArray *tileTitle;
@property(nonatomic,assign)int rowSize;
@property(nonatomic,assign)int z;
@property(nonatomic,retain)IBOutlet UITableView *mytableview;
-(IBAction)closebuttonaction:(id)sender;
-(IBAction)editbuttonaction:(id)sender;
@property (retain, nonatomic)connectionclass *myconnection;
-(void)addAccordian;
@property(nonatomic,retain)NSString *designationString;
@end
