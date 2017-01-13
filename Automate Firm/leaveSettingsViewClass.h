//
//  leaveSettingsViewClass.h
//  bablusdemokpproject
//
//  Created by leonine on 8/20/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface leaveSettingsViewClass : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
-(IBAction)advancedAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIView *paymentStructureView;
@property(nonatomic,assign) int x;
@property(nonatomic,retain)IBOutlet UILabel *paidLeaveLabel;
@property(nonatomic,retain)IBOutlet UIButton *carryRadioButton1;
@property(nonatomic,retain)IBOutlet UIButton *carryRadioButton2;
@property(nonatomic,retain)IBOutlet UIButton *carryRadioButton3;
@property(nonatomic,retain)IBOutlet UIButton *carryRadioButton4;
@property(nonatomic,retain)IBOutlet UIButton *carryRadioButton5;
@property(nonatomic,retain)IBOutlet UIButton *carryRadioButton6;
@property(nonatomic,retain)IBOutlet UIButton *carryRadioButton7;
-(IBAction)carryForwardButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UITextField *joiningMonthText;
@property(nonatomic,retain)IBOutlet UITableView *monthTableView;
@property(nonatomic,retain)NSMutableArray *monthArray;
@property(nonatomic,retain)IBOutlet UITextField *carryText1;
@property(nonatomic,retain)IBOutlet UITextField *carryText2;
@property(nonatomic,retain)IBOutlet UITextField *carryText3;
@property(nonatomic,retain)IBOutlet UITextField *carryText4;
@property(nonatomic,retain)IBOutlet UITextField *carryText5;
@property(nonatomic,retain)IBOutlet UITextField *carryText6;
@property(nonatomic,retain)IBOutlet UITextField *carryText7;
@end
