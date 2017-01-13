//
//  holidaySettingsViewClass.h
//  Automate Firm
//
//  Created by leonine on 2/4/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "holidayTableViewCell.h"
#import "connectionclass.h"
#import "attendancesettingsviewclass.h"
@interface holidaySettingsViewClass : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,headerprotocol>

-(IBAction)doneButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;
@property(nonatomic,retain)connectionclass * myconnection;
@property(nonatomic,retain)attendancesettingsviewclass * ob;


@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *activeField;

@property(nonatomic,retain)IBOutlet UITableView *holidayTypeTC;
@property(nonatomic,retain)IBOutlet UITableView *holidayOccuranceTC;
@property(nonatomic,retain)IBOutlet UITableView *holidayMainTC;
@property(nonatomic,retain)IBOutlet UITableView *durationTC;
@property(nonatomic,retain)IBOutlet UITableView *paymentTC;
@property(nonatomic,retain)IBOutlet UITableView *officeTC;
@property(nonatomic,retain)IBOutlet UITableView *departmentTC;
@property(nonatomic,retain)IBOutlet UITableView *categoryTC;
@property(nonatomic,retain)IBOutlet UIView *categoryView;
-(IBAction)categoryDoneButtonAction:(id)sender;

@property(nonatomic,retain)NSMutableArray *mainDurationArray;
@property(nonatomic,retain)NSMutableArray *mainPaymentArray;
@property(nonatomic,retain)NSMutableArray *mainOfficeArray;
@property(nonatomic,retain)NSMutableArray *mainDepartmentArray;
@property(nonatomic,retain)NSMutableArray *mainCategoryArray;
@property(nonatomic,retain)NSMutableArray *selectedArray;
@property(nonatomic,retain)NSMutableArray *selectedIdArray;
@property(nonatomic,retain)NSMutableArray *unSelectedArray;


@property(nonatomic,retain)NSMutableArray *categoryCellTextlabelAray;


@property(nonatomic,retain)NSMutableDictionary *mainCatgoryDict;
@property(nonatomic,retain)NSMutableDictionary *updateIdDict;
@property(nonatomic,retain)NSMutableDictionary *updateIdOfficeDict;
@property(nonatomic,retain)NSMutableDictionary *existingCategoryDict;
@property(nonatomic,retain)NSMutableDictionary *existingCategoryIdDict;
@property(nonatomic,retain)NSMutableDictionary *existingDepartmentIdDict;
@property(nonatomic,retain)NSMutableDictionary *existingWorkingPremiseIdDict;





@property(nonatomic,retain)IBOutlet UIView *datePickerView;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
-(IBAction)doneTimerAction:(id)sender;

@property(nonatomic,retain)NSMutableArray *holidayTypeArray;
@property(nonatomic,retain)NSMutableArray *holidayOccuranceArray;
@property(nonatomic,retain)NSMutableArray *fromDateArray;
@property(nonatomic,retain)NSMutableArray *toDateArray;
@property(nonatomic,retain)NSMutableArray *durationArray;
@property(nonatomic,retain)NSMutableArray *paymentArray;
@property(nonatomic,retain)NSMutableArray *officeArray;
@property(nonatomic,retain)NSMutableArray *departmentArray;
@property(nonatomic,retain)NSMutableArray *categoryArray;
@property(nonatomic,retain)NSMutableArray *workingPremiseIdArray;
@property(nonatomic,retain)NSMutableArray *deptIDList;
@property(nonatomic,retain)NSMutableArray *categoryIDList;
@property(nonatomic,retain)NSMutableDictionary *categoryIdDict;
@property(nonatomic,retain)NSMutableDictionary *responseDict;
@property(nonatomic,retain)NSMutableDictionary *TableEachTileIdDict;
@property(nonatomic,retain)NSMutableDictionary *flagTileIdDict;




@property(nonatomic,retain)NSString * PassingString;
@property(nonatomic,retain)NSString * officeIdString;
@property(nonatomic,retain)NSString * resetFlag;
@property(nonatomic,retain)NSString * deleteFlag;
@property(nonatomic,retain)NSString * mandString;





@property(nonatomic,retain)NSString * idString;
@property(nonatomic,retain)NSString * idStringDept;
@property(nonatomic,retain)NSString * updateFlag;


@property(nonatomic,retain)NSString * flagString;
@property(nonatomic,retain)NSString * ruleidString;
@property(nonatomic,retain)NSString * holidayruleidString;
@property(nonatomic,retain)NSString * holidayTileIdString;
@property(nonatomic,retain)NSString * catidString;
@property(nonatomic,retain)NSString * cancelString;
@property(nonatomic,retain)NSString * doneString;
@property(nonatomic,retain)NSString * workingIdString;
@property(nonatomic,retain)NSString * cancelActionFlag;












@property(nonatomic,retain)NSMutableArray *serviceArray;

@property(nonatomic,retain)IBOutlet UITextField *holidayNameText;
@property(nonatomic,retain)IBOutlet UITextField *holidayTypeText;
@property(nonatomic,retain)IBOutlet UITextField *holidayOccuranceText;
@property(nonatomic,retain)IBOutlet UITextField *descriptionText;

@property(nonatomic,retain)NSString *currentDate;

-(IBAction)fromDateBeginEdit:(id)sender;
-(IBAction)toDateBeginEdit:(id)sender;
-(IBAction)durationBeginEdit:(id)sender;
-(IBAction)paymentBeginEdit:(id)sender;
-(IBAction)officeBeginEdit:(id)sender;
-(IBAction)departmentBeginEdit:(id)sender;
-(IBAction)categoryBeginEdit:(id)sender;
-(IBAction)deleteTilePressing:(id)sender;



@property(nonatomic,retain)NSIndexPath *inPath;
@property(nonatomic,assign)int dateFlag;
@property(nonatomic,assign)int idFlag;

@property(nonatomic,retain)NSMutableDictionary *selectedCategoryDict;
-(void)showAlert:(NSString *)alertMessage;
-(void)deleteTile:(NSString *)alertFlag;
-(id)sotingFunction:(id)sortAray;




@end
