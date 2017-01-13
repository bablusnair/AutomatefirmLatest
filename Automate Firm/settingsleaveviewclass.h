//
//  settingsleaveviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 20/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "AccordionView.h"
@interface settingsleaveviewclass : UIView
{
    AccordionView *accordion;
}
-(IBAction)radioButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *radioButton1;
@property(nonatomic,retain)IBOutlet UIButton *radioButton2;
@property(nonatomic,retain)IBOutlet UIButton *radioButton3;

@end
