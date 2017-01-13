//
//  paySettingsViewClass.h
//  Automate Firm
//
//  Created by leonine on 12/3/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface paySettingsViewClass : UIView<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>

#import "connectionclass.h"
@interface paySettingsViewClass : UIView<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,headerprotocol>
@property(nonatomic,retain)connectionclass *myconnection;

@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)IBOutlet UIView *datePickerView;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain)NSMutableArray *grouparray;
@property(nonatomic,retain)NSIndexPath *indexpath;

-(IBAction)radioButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *radioButton1;
@property(nonatomic,retain)IBOutlet UIButton *radioButton2;
@property(nonatomic,retain)IBOutlet UIButton *radioButton3;
@property(nonatomic,retain)IBOutlet UIButton *radioButton4;
@property(nonatomic,retain)IBOutlet UIButton *radioButton5;
@property(nonatomic,retain)IBOutlet UIButton *radioButton6;


@property(nonatomic,retain)IBOutlet UITextField *radioText1;
@property(nonatomic,retain)IBOutlet UITextField *radioText2;
@property(nonatomic,retain)IBOutlet UITextField *radioText3;
@property(nonatomic,retain)IBOutlet UITextField *radioText4;
@property(nonatomic,retain)IBOutlet UITextField *radioText5;
@property(nonatomic,retain)IBOutlet UITextField *radioText6;
@property(nonatomic,retain)IBOutlet UITextField *payRuleNameText;
@property(nonatomic,retain)IBOutlet UITextField *currentStartsOnText;
@property(nonatomic,retain)IBOutlet UITextField *currentEndsOnText;
@property(nonatomic,retain)IBOutlet UITextField *nextStartsOnText;
@property(nonatomic,retain)IBOutlet UITextField *nextEndsOnText;
@property(nonatomic,retain)IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *abbrtext;

@property(nonatomic,assign)int radioFlag;
@property(nonatomic,assign)int timerFlag;
@property(nonatomic,assign)int timegapFlag;
@property(nonatomic,assign)NSString * paymntDateString;
@property(nonatomic,assign)NSString * fomatDateString;
@property(nonatomic,assign)NSString * updateString;
-(IBAction)doneAction:(id)sender;
-(IBAction)cancelAction:(id)sender;
-(IBAction)includeDesignationButtonAction:(id)sender;
-(IBAction)doneTimerAction:(id)sender;

-(void)disableAllTimeText;
-(void)settingDailyPay:(NSString *)startsDate;
@property(nonatomic,retain)IBOutlet UIView *monthlyCheckBoxView;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxValueText;
@property(nonatomic,retain)IBOutlet UIButton *checkButton;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryLabel;
-(IBAction)checkBoxAction:(id)sender;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int checkfieldFlag;

@property(nonatomic,retain)IBOutlet UITableView *monthPayTC;
@property(nonatomic,retain)NSMutableArray *monthPayArray;
-(void)resetButtonImageFunction:(int)idValue;
-(void)dateformatFuction:(NSString *)dateString;
-(void)alertAction:(NSString *)alertMessage;



@end
