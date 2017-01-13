//
//  timesettingsviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 21/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "attendancesettingsviewclass.h"
#import "AppDelegate.h"
#import "timeConditionsClass.h"
@interface timesettingsviewclass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,headerprotocol,UITextViewDelegate>
{
    AppDelegate *appObj;
    timeConditionsClass *objTime;
}
@property (retain, nonatomic)connectionclass *myconnection;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;

@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)IBOutlet UIView *datePickerView;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;

@property(nonatomic,retain)IBOutlet UITableView *weekSelectionTC;
@property(nonatomic,retain)IBOutlet UITableView *halfDaySelectionTC;
@property(nonatomic,retain)IBOutlet UITableView *daySelectionTC;

@property(nonatomic,retain) NSMutableArray *numberArray;
@property(nonatomic,retain) NSMutableArray *weekSelectionArray;
@property(nonatomic,retain) NSMutableArray *halfdaySelectionArray;
@property(nonatomic,retain) NSMutableArray *grouparray;
@property(nonatomic,retain) NSMutableArray *groupIDArray;
@property(nonatomic,retain)NSString *ServiceStr;

@property(nonatomic,retain)NSIndexPath *indexpath;


@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;
@property(nonatomic,assign)int z;
@property(nonatomic,assign)int a;
@property(nonatomic,assign)int b;
@property(nonatomic,assign)int c;
@property(nonatomic,assign)int d;
@property(nonatomic,assign)int e;
@property(nonatomic,assign)int f;
@property(nonatomic,assign)int p;
@property(nonatomic,assign)int q;
@property(nonatomic,assign)int r;
@property(nonatomic,assign)int flag;
@property(nonatomic,assign)int flagValue;


@property(nonatomic,retain)NSString *penaltyfirstcheckbuttonvalue;
@property(nonatomic,retain)NSString *penaltysecondcheckbuttonvalue;
@property(nonatomic,retain)NSString *penaltythirdcheckbuttonvalue;
@property(nonatomic,retain)NSString *workhoursfirstcheckbuttonvalue;
@property(nonatomic,retain)NSString *workhoursecondcheckbuttonvalue;
@property(nonatomic,retain)NSString *workhoursthirdcheckbuttonvalue;
@property(nonatomic,retain)NSString *workhoursfourthcheckbuttonvalue;
@property(nonatomic,retain)NSString *workhoursfifthcheckbuttonvalue;
@property(nonatomic,retain)NSString *gracetimecheckbuttonvalue;
@property(nonatomic,retain)NSString *workingdetailsfirstcheckbuttonvalue;
@property(nonatomic,retain)NSString *workingdetailssecondcheckbuttonvalue;
@property(nonatomic,retain)NSString *workingdetailsthirdcheckbuttonvalue;
@property(nonatomic,retain)NSString *latearrivalvalueoption;
@property(nonatomic,retain)NSString *graceTimeValue;
@property(nonatomic,retain)NSString *workingDetailsValue;

@property(nonatomic,retain)IBOutlet UILabel *graceManadtory;
@property(nonatomic,retain)IBOutlet UILabel *workingHourMandatory;


@property(nonatomic,retain)IBOutlet UITextField *graceTimeText;
@property(nonatomic,retain)IBOutlet UITextField *workingText1;
//@property(nonatomic,retain)IBOutlet UITextField *workingText2;
@property(nonatomic,retain)IBOutlet UITextField *workingText3;
@property(nonatomic,retain)IBOutlet UITextField *timeruletextfield;
@property(nonatomic,retain)IBOutlet UITextView *descriptiontextview;
@property(nonatomic,retain)IBOutlet UITextField *gracetimeapplicableText;
@property(nonatomic,retain)IBOutlet UITextField *lateArrivaltext1;
@property(nonatomic,retain)IBOutlet UITextField *lateArrivaltext2;
@property(nonatomic,retain)IBOutlet UITextField *lateArrivaltext3;
@property(nonatomic,retain)IBOutlet UITextField *workingDetailsTex1;
@property(nonatomic,retain)IBOutlet UITextField *workingDetailsTex2;
@property(nonatomic,retain)IBOutlet UITextField *workingHoursText1;
@property(nonatomic,retain)IBOutlet UITextField *workingHoursText2;
@property(nonatomic,retain)IBOutlet UITextField *workingHoursText3;
@property(nonatomic,retain)IBOutlet UITextField *workingHoursText4;
@property(nonatomic,retain)IBOutlet UITextField *workingHoursText5;
@property(nonatomic,retain)IBOutlet UITextField *penalitiesText1;
@property(nonatomic,retain)IBOutlet UITextField *penalitiesText2;
@property(nonatomic,retain)IBOutlet UITextField *penalitiesText3;
@property(nonatomic,retain)IBOutlet UITextField *abbrbText;
@property(nonatomic,retain)IBOutlet UITextField *latearrivalHoursText;
@property(nonatomic,retain)IBOutlet UITextField *latearrivalWeekText;
@property(nonatomic,retain)IBOutlet UITextField *latearrivalhalfdayText;
@property(nonatomic,retain)IBOutlet UITextField *latearrivalDayText;


@property(nonatomic,retain)IBOutlet UIButton *timeallowedButton;
//@property(nonatomic,retain)IBOutlet UIButton *timerdButton;
@property(nonatomic,retain)IBOutlet UIButton *doneButton;
@property(nonatomic,retain)IBOutlet UIButton *workingCheckBox1Button;
@property(nonatomic,retain)IBOutlet UIButton *workingCheckBox2Button;
@property(nonatomic,retain)IBOutlet UIButton *workingCheckBox3Button;
//@property(nonatomic,retain)IBOutlet UIButton *timerdButton1;
//@property(nonatomic,retain)IBOutlet UIButton *timerdButton2;
@property(nonatomic,retain)IBOutlet UIButton *penalityCheckButton1;
@property(nonatomic,retain)IBOutlet UIButton *penalityCheckButton2;
@property(nonatomic,retain)IBOutlet UIButton *penalityCheckButton3;
@property(nonatomic,retain)IBOutlet UIButton *lateArrivalCheckBox1;
@property(nonatomic,retain)IBOutlet UIButton *lateArrivalCheckBox2;
@property(nonatomic,retain)IBOutlet UIButton *lateArrivalCheckBox3;
@property(nonatomic,retain)IBOutlet UIButton *workingHourCheckButton1;
@property(nonatomic,retain)IBOutlet UIButton *workingHourCheckButton2;
@property(nonatomic,retain)IBOutlet UIButton *workingHourCheckButton3;
@property(nonatomic,retain)IBOutlet UIButton *workingHourCheckButton4;
@property(nonatomic,retain)IBOutlet UIButton *workingHourCheckButton5;


-(IBAction)donebuttonaction:(id)sender;
-(IBAction)groupselectionaction:(id)sender;
-(IBAction)timecheckBoxAction:(id)sender;
-(IBAction)doneTimerAction:(id)sender;
-(IBAction)workingcheckBox:(id)sender;
-(IBAction)lateArrivalCheckBoxAction:(id)sender;
-(IBAction)workingcheckButtonAction:(id)sender;
-(IBAction)cancelbuttonaction:(id)sender;
-(IBAction)penalityCheckButtonAction:(id)sender;
@end
