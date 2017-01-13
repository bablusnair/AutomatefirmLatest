//
//  settingsleaveviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 20/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "AccordionView.h"
#import "connectionclass.h"
#import "AppDelegate.h"
@interface settingsleaveviewsclass : UIView<UITextFieldDelegate,headerprotocol>
{
    AccordionView *accordion;
    AppDelegate *app;
}

@property(nonatomic,retain)connectionclass *myconnection;

@property(nonatomic,assign) int x;

@property(nonatomic,retain)IBOutlet UITextField *leaveName;
@property(nonatomic,retain)IBOutlet UITextField *abbrvText;
@property(nonatomic,retain)IBOutlet UITextField *fixedText;
@property(nonatomic,retain)IBOutlet UITextField *onrequestText;
@property(nonatomic,retain)IBOutlet UITextField *attendanceText;

@property(nonatomic,retain)IBOutlet UILabel *leaveNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *abbrvLabel;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryLabel1;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryLabel2;

@property(nonatomic,retain)IBOutlet UIButton *radioButtonFirst;
@property(nonatomic,retain)IBOutlet UIButton *radioButtonSecond;
@property(nonatomic,retain)IBOutlet UIButton *radioButtonThird;
@property(nonatomic,retain)IBOutlet UIButton *doneButton;
@property(nonatomic,retain)IBOutlet UIButton *cancelButton;

-(IBAction)radioButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;
-(IBAction)donebuttonaction:(id)sender;

-(void)disabledradiobuttons;
-(void)enabledabledradiobuttons;

@property(nonatomic,retain)NSMutableDictionary *finalDict;
@property(nonatomic,retain)NSString *typeValue;

@property(nonatomic,retain)NSMutableArray *leaveTileIDArray;
@property(nonatomic,retain)IBOutlet UIButton *plusButton;
-(IBAction)plusNewTile:(id)sender;


@end
