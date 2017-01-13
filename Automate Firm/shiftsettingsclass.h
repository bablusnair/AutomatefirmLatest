//
//  shiftsettingsclass.h
//  bablusdemokpproject
//
//  Created by leonine on 18/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "connectionclass.h"
#import "timeConditionsClass.h"
#import "AppDelegate.h"
@interface shiftsettingsclass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,headerprotocol,UITextViewDelegate>
{
    AppDelegate *objApp;
    timeConditionsClass *objTime;//creating an instance variable of timeconditionsclass
}
-(IBAction)groupselectionaction:(id)sender;
@property (retain, nonatomic)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)IBOutlet  UITextField *abbrbText;
@property(nonatomic,retain)IBOutlet  UITextField *shiftTypeText;
@property(nonatomic,retain)IBOutlet UITableView *shiftTypetableView;
@property(nonatomic,retain)NSMutableArray *shiftTypeArray;

@property(nonatomic,assign)int dayPunchStartTimeFlag;
@property(nonatomic,assign)int dayShiftStartTimeFlag;
@property(nonatomic,assign)int dayShiftEndTimeFlag;
@property(nonatomic,assign)int dayBreakBeginTimeFlag;

@property(nonatomic,assign)int swingPunchStartTimeFlag;
@property(nonatomic,assign)int swingShiftStartTimeFlag;
@property(nonatomic,assign)int swingShiftEndTimeFlag;
@property(nonatomic,assign)int swingBreakBeginTimeFlag;

@property(nonatomic,assign)int nightPunchStartTimeFlag;
@property(nonatomic,assign)int nightShiftStartTimeFlag;
@property(nonatomic,assign)int nightShiftEndTimeFlag;
@property(nonatomic,assign)int nightBreakBeginTimeFlag;

@property(nonatomic,retain)IBOutlet  UITextField *shiftNameText;
@property(nonatomic,retain)IBOutlet  UITextView *shiftDescription;

-(IBAction)cancelbuttonaction:(id)sender;
-(IBAction)donebuttonaction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *doneButton;
@property(nonatomic,retain)IBOutlet UIButton *dayshift;
@property(nonatomic,retain)IBOutlet UIButton *noonshift;
@property(nonatomic,retain)IBOutlet UIButton *nightshift;
-(IBAction)shiftarrangebuttonaction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *firstcheck;
@property(nonatomic,retain)IBOutlet UIButton *thirdcheck;
-(IBAction)checkboxactionbutton:(id)sender;
@property(nonatomic,retain)NSIndexPath *indexpath;
@property(nonatomic,retain)NSMutableArray *grouparray;
@property(nonatomic,retain)NSMutableArray *groupIDarray;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain)IBOutlet UIView *datePickerView;
-(IBAction)doneTimerAction:(id)sender;
@property(nonatomic,retain)IBOutlet  UITextField *timeText1;
@property(nonatomic,retain)IBOutlet  UITextField *timeText2;
@property(nonatomic,retain)IBOutlet  UITextField *timeText3;
@property(nonatomic,retain)IBOutlet  UITextField *timeText4;
@property(nonatomic,retain)IBOutlet  UITextField *timeText5;
@property(nonatomic,retain)IBOutlet  UITextField *workingHours;
@property(nonatomic,retain)IBOutlet  UITextField *breakDuration;
@property(nonatomic,assign)int flag;

@property(nonatomic,retain)IBOutlet UITextField *checkBoxText1;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText3;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;
@property(nonatomic,assign)int z;
//-(IBAction)saveButtonAction:(id)sender;
-(IBAction)discardButtonAction:(id)sender;
@property(nonatomic,assign)int flagValue;
@property(nonatomic,assign)int flagValue1;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker1;
@property(nonatomic,retain)IBOutlet UIView *datePickerView1;
-(IBAction)doneTimerAction1:(id)sender;
@property(nonatomic,retain)IBOutlet UITextField *inTimeText;
@property(nonatomic,retain)IBOutlet UITextField *outTimeText;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker2;
@property(nonatomic,retain)IBOutlet UIView *datePickerView2;
-(IBAction)doneTimerAction2:(id)sender;
@property(nonatomic,assign)int breakDurationFlag;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker3;
@property(nonatomic,retain)IBOutlet UIView *datePickerView3;
-(IBAction)doneTimerAction3:(id)sender;

@property(nonatomic,retain)IBOutlet UIScrollView *contentScrollView;


@property(nonatomic,assign)int timerFlag1;
@property(nonatomic,assign)int timerFlag2;

@property(nonatomic,retain)IBOutlet UITextField *dayBreakTypeText;
@property(nonatomic,retain)IBOutlet UITableView *dayBreakTypeTC;
@property(nonatomic,retain)NSMutableArray *breakTypeArray;
@property(nonatomic,retain)NSString *dayInTimeValue;
@property(nonatomic,retain)NSString *dayOutTimeValue;

@property(nonatomic,retain)NSString *serviceStr;


-(void)resetDayShift;

//Swing

@property(nonatomic,retain)IBOutlet  UITextField *swingtimeText1;
@property(nonatomic,retain)IBOutlet  UITextField *swingtimeText2;
@property(nonatomic,retain)IBOutlet  UITextField *swingtimeText3;
@property(nonatomic,retain)IBOutlet  UITextField *swingtimeText4;
@property(nonatomic,retain)IBOutlet  UITextField *swingtimeText5;

@property(nonatomic,retain)IBOutlet UITextField *swingcheckBoxText2;
@property(nonatomic,retain)IBOutlet UITextField *swingcheckBoxText3;

@property(nonatomic,retain)IBOutlet UITextField *swinginTimeText;
@property(nonatomic,retain)IBOutlet UITextField *swingoutTimeText;
@property(nonatomic,retain)IBOutlet  UITextField *swingworkingHours;
@property(nonatomic,retain)IBOutlet  UITextField *swingbreakDuration;
-(IBAction)swingcheckboxactionbutton:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *swingsecondcheck;
@property(nonatomic,retain)IBOutlet UIButton *swingthirdcheck;
@property(nonatomic,assign)int p;
@property(nonatomic,assign)int q;
@property(nonatomic,assign)int r;

@property(nonatomic,retain)IBOutlet UITextField *swingBreakTypeText;
@property(nonatomic,retain)IBOutlet UITableView *swingBreakTypeTC;


@property(nonatomic,retain)NSString *swingInTimeValue;
@property(nonatomic,retain)NSString *swingOutTimeValue;

-(void)resetSwingShift;

//Night

@property(nonatomic,retain)IBOutlet  UITextField *nighttimeText1;
@property(nonatomic,retain)IBOutlet  UITextField *nighttimeText2;
@property(nonatomic,retain)IBOutlet  UITextField *nighttimeText3;
@property(nonatomic,retain)IBOutlet  UITextField *nighttimeText4;
@property(nonatomic,retain)IBOutlet  UITextField *nighttimeText5;

@property(nonatomic,retain)IBOutlet UITextField *nightcheckBoxText2;
@property(nonatomic,retain)IBOutlet UITextField *nightcheckBoxText3;

@property(nonatomic,retain)IBOutlet UITextField *nightinTimeText;
@property(nonatomic,retain)IBOutlet UITextField *nightoutTimeText;
@property(nonatomic,retain)IBOutlet  UITextField *nightworkingHours;
@property(nonatomic,retain)IBOutlet  UITextField *nightbreakDuration;
-(IBAction)nightcheckboxactionbutton:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *nightsecondcheck;
@property(nonatomic,retain)IBOutlet UIButton *nightthirdcheck;
@property(nonatomic,assign)int i;
@property(nonatomic,assign)int j;
@property(nonatomic,assign)int k;

@property(nonatomic,retain)IBOutlet UITextField *nightBreakTypeText;
@property(nonatomic,retain)IBOutlet UITableView *nightBreakTypeTC;


@property(nonatomic,retain)NSString *nightInTimeValue;
@property(nonatomic,retain)NSString *nightOutTimeValue;

-(void)resetNightShift;

@end
