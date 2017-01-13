//
//  advancesettingsviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 20/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "advanceTileClass.h"
#include "connectionclass.h"

@interface advancesettingsviewclass : UIView<headerprotocol>
{
    advanceTileClass *accordion;
        AppDelegate *myappde;

}
@property(nonatomic,retain)connectionclass * myconnection;

-(IBAction)donebuttonaction:(id)sender;
-(IBAction)cancelbuttonaction:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *plusButton;
- (IBAction)addNewTile:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *cancelbutton;
@property (retain, nonatomic) IBOutlet UIButton *donebutton;
@end
