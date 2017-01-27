//
//  weeksetting.h
//  bablusdemokpproject
//
//  Created by leonine on 17/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "timeConditionsClass.h"
@interface weeksetting : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UITextViewDelegate,headerprotocol>
{
    timeConditionsClass *objTime;
    MBProgressHUD *HUD;
}
@property(nonatomic,retain)AppDelegate *app;

@property (retain, nonatomic)connectionclass *myconnection;

-(IBAction)groupselectionaction:(id)sender;
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
-(IBAction)donebuttonaction:(id)sender;
-(IBAction)cancelbuttonaction:(id)sender;
//-(IBAction)removegroupfromcollectionview:(id)sender;
@property(nonatomic,retain)NSMutableArray *grouparray;
@property(nonatomic,retain)NSIndexPath *indexpath;
-(IBAction)dayButtonAction:(id)sender;

@property(nonatomic,retain)NSMutableArray *dayArray1;

@property(nonatomic,retain)IBOutlet UITextField *weekRuleNameText;
@property(nonatomic,retain)IBOutlet UITextField *BreakTypeText;
@property(nonatomic,retain)IBOutlet UITableView *BreakTypeTC;
@property(nonatomic,retain)NSMutableArray *breakTypeArray;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker3;
@property(nonatomic,retain)IBOutlet UIView *datePickerView3;
@property(nonatomic,retain)IBOutlet UITextView *descriptionTextView;
-(IBAction)doneTimerAction3:(id)sender;

@property(nonatomic,retain)IBOutlet UITableView *numberfirsttable;
@property(nonatomic,retain)IBOutlet UITableView *numbersecondtable;
@property(nonatomic,retain)IBOutlet UITableView *numberthirdtable;
@property(nonatomic,retain)IBOutlet UITableView *numberfourthtable;

@property(nonatomic,retain)IBOutlet UITextField *weekStartsOnText;
@property(nonatomic,retain)IBOutlet UITextField *abbrbText;
@property(nonatomic,retain)IBOutlet UITextField *nubertext1;
@property(nonatomic,retain)IBOutlet UITextField *nubertext2;
@property(nonatomic,retain)IBOutlet UITextField *nubertext3;
@property(nonatomic,retain)IBOutlet UITextField *nubertext4;

@property(nonatomic,retain)IBOutlet UITextField *dayText5;
@property(nonatomic,assign)NSInteger x;
-(IBAction)dateButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UITableView *dayfirsttable;
@property(nonatomic,retain)IBOutlet UITableView *daysecondtable;
@property(nonatomic,retain)IBOutlet UITableView *daythirdtable;
@property(nonatomic,retain)IBOutlet UITableView *dayfourthtable;

@property(nonatomic,retain)IBOutlet UITableView *weekDaySelectionTC;

@property (retain, nonatomic)NSMutableArray *dayarray1;
@property (retain, nonatomic)NSMutableArray *dayarray2;
@property (retain, nonatomic)NSMutableArray *dayarray3;
@property (retain, nonatomic)NSMutableArray *dayarray4;



@property (retain, nonatomic)NSMutableArray *dictloadarray;
@property (retain, nonatomic)NSMutableArray *dictloadarray2;
@property (retain, nonatomic)NSMutableArray *dictloadarray3;
@property (retain, nonatomic)NSMutableArray *dictloadarray4;


@property (retain, nonatomic)NSMutableDictionary *mydict;

@property(nonatomic,retain)IBOutlet UITextField *daytext1;
@property(nonatomic,retain)IBOutlet UITextField *daytext2;
@property(nonatomic,retain)IBOutlet UITextField *daytext3;
@property(nonatomic,retain)IBOutlet UITextField *daytext4;


@property(nonatomic,assign)NSInteger y;
@property(nonatomic,retain)IBOutlet UITextField *beginningTime;
@property(nonatomic,retain)IBOutlet UITextField *endingTime;
@property(nonatomic,retain)IBOutlet UITextField *breakBeginningTime;
@property(nonatomic,retain)IBOutlet UITextField *breakEndingTime;
@property(nonatomic,retain)IBOutlet UITextField *durationText;
@property(nonatomic,retain)IBOutlet UITextField *breakDurationText;


-(IBAction)timeAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain)IBOutlet UIView *datePickerView;
-(IBAction)datePickerAction:(id)sender;

@property(nonatomic,assign)NSInteger partialDayFlag;

@property (weak, nonatomic) IBOutlet UIView *dateview1;
@property (weak, nonatomic) IBOutlet UIView *dateview2;
@property (weak, nonatomic) IBOutlet UIView *dateview4;
@property (weak, nonatomic) IBOutlet UIView *dateview3;

@property (retain, nonatomic)NSMutableArray *selectedarray1;
@property (retain, nonatomic)NSMutableArray *selectedarray2;
@property (retain, nonatomic)NSMutableArray *selectedarray3;
@property (retain, nonatomic)NSMutableArray *selectedarray4;


@property (retain, nonatomic)NSMutableArray *unselectedarray1;
@property (retain, nonatomic)NSMutableArray *unselectedarray2;
@property (retain, nonatomic)NSMutableArray *unselectedarray3;
@property (retain, nonatomic)NSMutableArray *unselectedarray4;


@property (retain, nonatomic)NSMutableArray *daydummy;
@property (retain, nonatomic)NSMutableArray *numberdummy;
@property (retain, nonatomic)NSMutableArray *numberdummy2;
@property (retain, nonatomic)NSMutableArray *numberdummy3;
@property (retain, nonatomic)NSMutableArray *numberdummy4;
@property (retain, nonatomic)NSMutableArray *newnumberdummy;
@property(nonatomic,retain)NSIndexPath *k1;
@property(nonatomic,retain)NSIndexPath *k2;


//@property (retain, nonatomic)UIAlertView *myalert1;
//@property (retain, nonatomic)UIAlertView *myalert2;
//@property (retain, nonatomic)UIAlertView *myalert3;
//@property (retain, nonatomic)UIAlertView *myalert4;
//@property (retain, nonatomic)UIAlertView *myalert5;
- (IBAction)done1:(id)sender;
- (IBAction)done2:(id)sender;
- (IBAction)done3:(id)sender;
- (IBAction)done4:(id)sender;


@property(nonatomic,retain)NSMutableArray *weekStartsArray;

@property (retain, nonatomic)NSMutableArray *numberarray1;
@property (retain, nonatomic)NSMutableArray *numberarray2;
@property (retain, nonatomic)NSMutableArray *numberarray3;
@property (retain, nonatomic)NSMutableArray *numberarray4;

@property (nonatomic,assign)int c;
@property (nonatomic,assign)int t;
@property (retain, nonatomic)NSString *globalstring;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryLabel1;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryLabel2;

@property (weak, nonatomic) IBOutlet UIButton *donebutton;

//@property (retain, nonatomic)NSString *breakdurationString;
//@property (retain, nonatomic)NSString *partialDurationString;


@property(nonatomic,retain)NSString *offdayfirstString;
@property(nonatomic,retain)NSString *offdaysecondString;
@property(nonatomic,retain)NSString *offdaythirdString;
@property(nonatomic,retain)NSString *offdayfourthString;

@property(nonatomic,retain)NSMutableArray *offfirstArray;
@property(nonatomic,retain)NSMutableArray *offsecondArray;
@property(nonatomic,retain)NSMutableArray *offthirdArray;
@property(nonatomic,retain)NSMutableArray *offfourthArray;

-(void)firstreset;
-(void)secondreset;
-(void)thirdreset;
-(void)fourthreset;
-(void)parialreset;

@property(nonatomic,retain)NSString *breaktypestring;
@property(nonatomic,retain)NSString *ServiceStr;


@property (assign, nonatomic)int myflag;


@property (weak, nonatomic) IBOutlet UIButton *includedesignationbutton;




@property(nonatomic,retain)NSMutableArray *myselectedarray;
@property(nonatomic,retain)NSMutableArray *globalusearray;
@property(nonatomic,retain)NSString *superstring;

-(void)donesuperfunction;
-(void)donesuperfunction2;
-(void)donesuperfunction3;
-(void)donesuperfunction4;

@property (nonatomic,assign)int f;

@property (nonatomic,assign)int myownflag;
@property (nonatomic,assign)int myserviceflag1;



@property (retain, nonatomic)NSMutableDictionary *checkdict;
@property (retain, nonatomic)NSString *checkstring;
@property (retain, nonatomic)NSSet *partialset;
@property (retain, nonatomic)NSSet *resultset;

-(void)alertViewControllerForResetPartialDay;

@end
