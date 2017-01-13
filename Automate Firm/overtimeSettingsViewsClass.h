//
//  overtimeSettingsViewsClass.h
//  Automate Firm
//
//  Created by leonine on 12/4/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "timeConditionsClass.h"
#import "connectionclass.h"
#import "headerprotocol.h"
#import "payrollSettingsViewsClass.h"

@interface overtimeSettingsViewsClass : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,headerprotocol>
{
    timeConditionsClass *timeObj;
}

@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *activeField;
@property(nonatomic,retain)IBOutlet UIButton *regularButton;
@property(nonatomic,retain)IBOutlet UIButton *offdayButton;
@property(nonatomic,retain)IBOutlet UIButton *partialdayButton;
@property(nonatomic,retain)IBOutlet UIButton *holidayButton;
@property(nonatomic,retain)IBOutlet UIButton *specificDayButton;
-(IBAction)tabButtonAction:(id)sender;
-(IBAction)doneButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIScrollView *contentScrollView;

@property(nonatomic,retain)IBOutlet UIButton *doneButton;

@property(nonatomic,retain)IBOutlet UITableView *overtimeTypeTC;

@property(nonatomic,retain)NSString *action;

-(IBAction)groupselectionaction:(id)sender;
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)NSMutableArray *grouparray;
@property(nonatomic,retain)NSIndexPath *indexpath;
-(IBAction)removegroupfromcollectionview:(id)sender;


@property(nonatomic,retain)IBOutlet UITextField *overtimeTypeText;
@property(nonatomic,retain)IBOutlet UITextField *overtimeNameText;
@property(nonatomic,retain)IBOutlet UITextField *abbrvText;
@property(nonatomic,retain)IBOutlet UITextView *descriptionTextView;
@property(nonatomic,retain)NSMutableArray *overtimeTypeArray;


@property(nonatomic,retain)NSString *currentTab;


@property(nonatomic,retain)IBOutlet UIImageView *offdayIcon;
@property(nonatomic,retain)IBOutlet UIImageView *partialdayIcon;
@property(nonatomic,retain)IBOutlet UIImageView *holidayIcon;
@property(nonatomic,retain)IBOutlet UIImageView *specificdayIcon;

@property(nonatomic,retain)NSMutableDictionary *overtimeDict;



//Regular

@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain)IBOutlet UIView *datePickerView;
@property(nonatomic,retain)IBOutlet UITableView *payOTTC;
@property(nonatomic,retain)NSMutableArray *payOTArray;
@property(nonatomic,retain)NSMutableArray *payOTDisplayArray;
@property(nonatomic,retain)NSMutableArray *payOTDisplayArray1;
-(IBAction)doneTimerAction:(id)sender;
@property(nonatomic,assign)int flag;
@property(nonatomic,assign)int payOTFlag;
@property(nonatomic,assign)int payOTTextFlag;

@property(nonatomic,assign)int selectedFlag;
@property(nonatomic,assign)int selectedFlag1;

@property(nonatomic,retain)IBOutlet UITextField *regularDailyLimitText;
@property(nonatomic,retain)IBOutlet UITextField *regularAfterText1;
@property(nonatomic,retain)IBOutlet UITextField *regularAfterText2;
@property(nonatomic,retain)IBOutlet UITextField *regularPayOTText1;
@property(nonatomic,retain)IBOutlet UITextField *regularPayOTText2;
@property(nonatomic,retain)IBOutlet UITextField *regularPayOTText3;

@property(nonatomic,retain)IBOutlet UILabel *regularMandatoryLabel1;
@property(nonatomic,retain)IBOutlet UILabel *regularMandatoryLabel2;

@property(nonatomic,retain)IBOutlet UIButton *checkButton1;
@property(nonatomic,retain)IBOutlet UIButton *checkButton2;
@property(nonatomic,retain)IBOutlet UIButton *checkButton3;
-(IBAction)checkButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UITextField *checkText1;
@property(nonatomic,retain)IBOutlet UITextField *checkText2;
@property(nonatomic,retain)IBOutlet UITextField *checkText3;
@property(nonatomic,assign)int a;
@property(nonatomic,assign)int b;
@property(nonatomic,assign)int c;


@property(nonatomic,retain)NSString *reg_date1;
@property(nonatomic,retain)NSString *reg_date2;
@property(nonatomic,retain)NSString *reg_date3;
@property(nonatomic,retain)NSString *reg_ot1;
@property(nonatomic,retain)NSString *reg_ot2;
@property(nonatomic,retain)NSString *reg_ot3;
@property(nonatomic,retain)NSString *reg_pf;
@property(nonatomic,retain)NSString *reg_esi;
@property(nonatomic,retain)NSString *reg_incentives;




//Off Day

-(IBAction)regularCheckButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *regularCheckButton1;
@property(nonatomic,retain)IBOutlet UITextField *regularCheckText1;

-(IBAction)dropButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UILabel *dropLabel1;

@property(nonatomic,retain)IBOutlet UIView *offDayDropView;
@property(nonatomic,retain)IBOutlet UIView *offDayFirstView;
@property(nonatomic,retain)IBOutlet UIView *offDaywholeView;

@property(nonatomic,retain)IBOutlet UITableView *dropTableView;

@property(nonatomic,retain)NSMutableArray *dropArray;
@property(nonatomic,retain)NSMutableArray *payOTArray1;

@property(nonatomic,assign)int dropFlag;
@property(nonatomic,assign)int dropTableFlag;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int offdayFlag;

@property(nonatomic,retain)IBOutlet UITextField *offDayFirstText;
@property(nonatomic,retain)IBOutlet UITextField *offdayDailyLimitText;
@property(nonatomic,retain)IBOutlet UITextField *offdayAfterText1;
@property(nonatomic,retain)IBOutlet UITextField *offdayAfterText2;
@property(nonatomic,retain)IBOutlet UITextField *offdayPayOTText1;
@property(nonatomic,retain)IBOutlet UITextField *offdayPayOTText2;
@property(nonatomic,retain)IBOutlet UITextField *offdayPayOTText3;

@property(nonatomic,retain)IBOutlet UIButton *dropButton1;


@property(nonatomic,retain)IBOutlet UILabel *offdayMandatoryLabel1;
@property(nonatomic,retain)IBOutlet UILabel *offdayMandatoryLabel2;

@property(nonatomic,retain)NSString *off_date1;
@property(nonatomic,retain)NSString *off_date2;
@property(nonatomic,retain)NSString *off_date3;
@property(nonatomic,retain)NSString *off_firstDate;
@property(nonatomic,retain)NSString *off_ot1;
@property(nonatomic,retain)NSString *off_ot2;
@property(nonatomic,retain)NSString *off_ot3;
@property(nonatomic,retain)NSString *off_same_regular;



//Partial Day

@property(nonatomic,retain)IBOutlet UIView *partialDropView;
@property(nonatomic,retain)IBOutlet UIView *partialFirstView;
@property(nonatomic,retain)IBOutlet UIView *partialWholeView;

@property(nonatomic,retain)IBOutlet UILabel *dropLabel2;

@property(nonatomic,retain)IBOutlet UIButton *dropButton2;
@property(nonatomic,retain)IBOutlet UIButton *regularCheckButton2;

@property(nonatomic,retain)IBOutlet UITextField *partialFirstText;
@property(nonatomic,retain)IBOutlet UITextField *partialDailyLimitText;
@property(nonatomic,retain)IBOutlet UITextField *partialAfterText1;
@property(nonatomic,retain)IBOutlet UITextField *partialAfterText2;
@property(nonatomic,retain)IBOutlet UITextField *partialPayOTText1;
@property(nonatomic,retain)IBOutlet UITextField *partialPayOTText2;
@property(nonatomic,retain)IBOutlet UITextField *partialPayOTText3;
@property(nonatomic,retain)IBOutlet UITextField *regularCheckText2;


@property(nonatomic,retain)IBOutlet UILabel *partialMandatoryLabel1;
@property(nonatomic,retain)IBOutlet UILabel *partialMandatoryLabel2;

@property(nonatomic,assign)int y;
@property(nonatomic,assign)int partialFlag;

@property(nonatomic,retain)NSString *par_date1;
@property(nonatomic,retain)NSString *par_date2;
@property(nonatomic,retain)NSString *par_date3;
@property(nonatomic,retain)NSString *par_firstDate;
@property(nonatomic,retain)NSString *par_ot1;
@property(nonatomic,retain)NSString *par_ot2;
@property(nonatomic,retain)NSString *par_ot3;
@property(nonatomic,retain)NSString *par_same_regular;

//Holiday
@property(nonatomic,retain)IBOutlet UIView *holidayDropView;
@property(nonatomic,retain)IBOutlet UIView *holidayFirstView;
@property(nonatomic,retain)IBOutlet UIView *holidayWholeView;


@property(nonatomic,retain)IBOutlet UILabel *dropLabel3;

@property(nonatomic,retain)IBOutlet UIButton *dropButton3;
@property(nonatomic,retain)IBOutlet UIButton *regularCheckButton3;

@property(nonatomic,retain)IBOutlet UITextField *holidayFirstText;
@property(nonatomic,retain)IBOutlet UITextField *holidayDailyLimitText;
@property(nonatomic,retain)IBOutlet UITextField *holidayAfterText1;
@property(nonatomic,retain)IBOutlet UITextField *holidayAfterText2;
@property(nonatomic,retain)IBOutlet UITextField *holidayPayOTText1;
@property(nonatomic,retain)IBOutlet UITextField *holidayPayOTText2;
@property(nonatomic,retain)IBOutlet UITextField *holidayPayOTText3;

@property(nonatomic,assign)int z;
@property(nonatomic,assign)int holidayFlag;

@property(nonatomic,retain)IBOutlet UILabel *holidayMandatoryLabel1;
@property(nonatomic,retain)IBOutlet UILabel *holidayMandatoryLabel2;

@property(nonatomic,retain)NSString *hol_date1;
@property(nonatomic,retain)NSString *hol_date2;
@property(nonatomic,retain)NSString *hol_date3;
@property(nonatomic,retain)NSString *hol_firstDate;
@property(nonatomic,retain)NSString *hol_ot1;
@property(nonatomic,retain)NSString *hol_ot2;
@property(nonatomic,retain)NSString *hol_ot3;
@property(nonatomic,retain)NSString *hol_same_regular;

//Specific Days

@property(nonatomic,retain)NSMutableDictionary *specificDict;

@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker1;
@property(nonatomic,retain)IBOutlet UIView *datePicker1View;
-(IBAction)timeAction:(id)sender;
@property(nonatomic,assign)int timeFlag;

@property(nonatomic,retain)IBOutlet UIView *firstView;
@property(nonatomic,retain)IBOutlet UIView *secondView;
@property(nonatomic,retain)IBOutlet UIView *thirdView;
@property(nonatomic,retain)IBOutlet UIView *fourthView;
@property(nonatomic,retain)IBOutlet UIView *fifthView;
@property(nonatomic,retain)IBOutlet UIView *sixthView;
@property(nonatomic,retain)IBOutlet UIView *seventhView;


@property(nonatomic,retain)IBOutlet UITextField *specificDay1Text;
@property(nonatomic,retain)IBOutlet UITextField *specificCondition1Text;
@property(nonatomic,retain)IBOutlet UITextField *specificFromTime1Text;
@property(nonatomic,retain)IBOutlet UITextField *specificToTime1Text;
@property(nonatomic,retain)IBOutlet UITextField *specificPayOT1Text;

@property(nonatomic,retain)IBOutlet UITextField *specificDay2Text;
@property(nonatomic,retain)IBOutlet UITextField *specificCondition2Text;
@property(nonatomic,retain)IBOutlet UITextField *specificFromTime2Text;
@property(nonatomic,retain)IBOutlet UITextField *specificToTime2Text;
@property(nonatomic,retain)IBOutlet UITextField *specificPayOT2Text;


@property(nonatomic,retain)IBOutlet UITextField *specificDay3Text;
@property(nonatomic,retain)IBOutlet UITextField *specificCondition3Text;
@property(nonatomic,retain)IBOutlet UITextField *specificFromTime3Text;
@property(nonatomic,retain)IBOutlet UITextField *specificToTime3Text;
@property(nonatomic,retain)IBOutlet UITextField *specificPayOT3Text;

@property(nonatomic,retain)IBOutlet UITextField *specificDay4Text;
@property(nonatomic,retain)IBOutlet UITextField *specificCondition4Text;
@property(nonatomic,retain)IBOutlet UITextField *specificFromTime4Text;
@property(nonatomic,retain)IBOutlet UITextField *specificToTime4Text;
@property(nonatomic,retain)IBOutlet UITextField *specificPayOT4Text;


@property(nonatomic,retain)IBOutlet UITextField *specificDay5Text;
@property(nonatomic,retain)IBOutlet UITextField *specificCondition5Text;
@property(nonatomic,retain)IBOutlet UITextField *specificFromTime5Text;
@property(nonatomic,retain)IBOutlet UITextField *specificToTime5Text;
@property(nonatomic,retain)IBOutlet UITextField *specificPayOT5Text;

@property(nonatomic,retain)IBOutlet UITextField *specificDay6Text;
@property(nonatomic,retain)IBOutlet UITextField *specificCondition6Text;
@property(nonatomic,retain)IBOutlet UITextField *specificFromTime6Text;
@property(nonatomic,retain)IBOutlet UITextField *specificToTime6Text;
@property(nonatomic,retain)IBOutlet UITextField *specificPayOT6Text;


@property(nonatomic,retain)IBOutlet UITextField *specificDay7Text;
@property(nonatomic,retain)IBOutlet UITextField *specificCondition7Text;
@property(nonatomic,retain)IBOutlet UITextField *specificFromTime7Text;
@property(nonatomic,retain)IBOutlet UITextField *specificToTime7Text;
@property(nonatomic,retain)IBOutlet UITextField *specificPayOT7Text;

@property(nonatomic,retain)NSMutableArray *dayArray;
@property(nonatomic,retain)NSMutableArray *dummyDayArray;
@property(nonatomic,retain)IBOutlet UITableView *specificDayTC;

@property(nonatomic,retain)NSMutableArray *conditionArray;
@property(nonatomic,retain)IBOutlet UITableView *conditionsTableView;

@property(nonatomic,retain)NSMutableArray *specificConditionArray;
@property(nonatomic,retain)NSMutableArray *specificPayOTRateArray;

@property(nonatomic,assign)int dayFlag;
@property(nonatomic,assign) int conditionFlag;

-(void)specificDayList:(int)count;
-(void)changeTextFieldAction:(UITextField *)textfield;
-(void)timeInitialSettings;
-(void)timeMaxSettings:(NSString *)currentTime;

//Weekly

@property(nonatomic,retain)IBOutlet UITextField *weeklyDailyLimitText;
@property(nonatomic,retain)IBOutlet UITextField *weeklyAfterText1;
@property(nonatomic,retain)IBOutlet UITextField *weeklyPayOTText1;


@property(nonatomic,retain)IBOutlet UILabel *weeklyMandatoryLabel1;


@property(nonatomic,retain)IBOutlet UIButton *weeklyCheckButton1;
@property(nonatomic,retain)IBOutlet UIButton *weeklyCheckButton2;
@property(nonatomic,retain)IBOutlet UIButton *weeklyCheckButton3;
-(IBAction)weeklyCheckAction:(id)sender;

@property(nonatomic,retain)IBOutlet UITextField *weeklyCheckText1;
@property(nonatomic,retain)IBOutlet UITextField *weeklyCheckText2;
@property(nonatomic,retain)IBOutlet UITextField *weeklyCheckText3;
@property(nonatomic,assign)int p;
@property(nonatomic,assign)int q;
@property(nonatomic,assign)int r;

@property(nonatomic,retain)IBOutlet UIButton *weeklyCheckButton4;
@property(nonatomic,retain)IBOutlet UIButton *weeklyCheckButton5;
@property(nonatomic,retain)IBOutlet UIButton *weeklyCheckButton6;
-(IBAction)weeklyCheckAction1:(id)sender;
@property(nonatomic,retain)IBOutlet UITextField *weeklyCheckText4;
@property(nonatomic,retain)IBOutlet UITextField *weeklyCheckText5;
@property(nonatomic,retain)IBOutlet UITextField *weeklyCheckText6;
@property(nonatomic,assign)int i;
@property(nonatomic,assign)int j;
@property(nonatomic,assign)int k;
@property(nonatomic,retain)IBOutlet UITableView *weeklyWorkingHoursTC;
@property(nonatomic,retain)IBOutlet UITextField *weeklyWorkingHoursText;
@property(nonatomic,retain)NSMutableArray *workingHoursArray;

@property(nonatomic,retain)NSString *paidLeavesValue;
@property(nonatomic,retain)NSString *paidHolidaysvalue;
@property(nonatomic,retain)NSString *apply7thValue;


@end

