//
//  loansettingsviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 19/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "loanTileClass.h"
#import "connectionclass.h"
@interface loansettingsviewclass : UIView<UITextFieldDelegate,headerprotocol>
{
    loanTileClass *accordion;
}
-(IBAction)cancelButtonAction:(id)sender;

@property(nonatomic,retain)IBOutlet UITextField *loantype;
@property(nonatomic,retain)IBOutlet UITextField *abbrevation;
@property(nonatomic,retain)IBOutlet UITextField *descriptiontext;

@property (retain, nonatomic)connectionclass *myconnection;

@property(nonatomic,retain)IBOutlet UIButton *plusButton;
-(IBAction)plusNewTile:(id)sender;
-(void)disableddonebutton;
-(void)enableddonebutton;

@property(nonatomic,retain)IBOutlet UIButton *donebutton;
@property(nonatomic,retain)IBOutlet UIButton *cancelbutton;
@end
