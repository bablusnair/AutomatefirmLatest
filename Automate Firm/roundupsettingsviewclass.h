//
//  roundupsettingsviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 20/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"

@interface roundupsettingsviewclass : UIView<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,headerprotocol>
{
    AppDelegate *appObj;
}

@property(nonatomic,retain)connectionclass *myconnection;

@property(nonatomic,retain)IBOutlet UITableView *minuteTableView;

@property(nonatomic,retain)NSMutableArray *timeArray;

@property(nonatomic,assign) int x;
@property(nonatomic,assign) int y;
@property(nonatomic,assign) int z;
@property(nonatomic,assign) int p;
@property(nonatomic,assign) int flag;
@property(nonatomic,assign) int flag1;
@property(nonatomic,assign) int flagValue;
@property(nonatomic,assign) int checkinFlag;
@property(nonatomic,assign) int checkoutFlag;

@property(nonatomic,retain)IBOutlet UITextField *roundupNameText;
@property(nonatomic,retain)IBOutlet UITextField *checkinRoundingText;
@property(nonatomic,retain)IBOutlet UITextField *checkoutRoundingText;
@property(nonatomic,retain)IBOutlet UITextField *breakStartText;
@property(nonatomic,retain)IBOutlet UITextField *breakEndText;
@property(nonatomic,retain)IBOutlet UITextField *checkinRoundingDropText;
@property(nonatomic,retain)IBOutlet UITextField *checkoutRoundingDropText;

@property(nonatomic,retain)IBOutlet UITextView *descriptionTextView;

@property(nonatomic,retain)IBOutlet UIButton  *checkButton1;
@property(nonatomic,retain)IBOutlet UIButton  *checkButton2;
@property(nonatomic,retain)IBOutlet UIButton  *checkButton3;
@property(nonatomic,retain)IBOutlet UIButton  *checkButton4;

@property(nonatomic,retain)NSString *checkinRounding;
@property(nonatomic,retain)NSString *checkoutRounding;
@property(nonatomic,retain)NSString *breakStart;
@property(nonatomic,retain)NSString *breakEnd;






-(IBAction)donebuttonaction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton  *doneButton;
-(IBAction)cancelButtonAction:(id)sender;
-(IBAction)checkButtonAction:(id)sender;
@end
