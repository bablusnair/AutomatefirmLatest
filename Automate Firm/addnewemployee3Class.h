//
//  addnewemployee3Class.h
//  bablusdemokpproject
//
//  Created by leonine on 8/20/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "connectionclass.h"
#import "headerprotocol.h"
#import "AppDelegate.h"
@interface addnewemployee3Class : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,headerprotocol>
{
    AppDelegate *app;
}
-(IBAction)saveButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;
-(IBAction)addnewEarningsAction:(id)sender;
-(IBAction)addNewDeductionsAction:(id)sender;
-(IBAction)checkBoxAction:(id)sender;
-(IBAction)checkBoxAction1:(id)sender;

@property(nonatomic,retain)connectionclass *myconnection;

@property(nonatomic,retain)IBOutlet UITableView *earningsTC;
@property(nonatomic,retain)IBOutlet UITableView *deductionsTC;
@property(nonatomic,retain)IBOutlet UITableView *leavesTC;
@property(nonatomic,retain)IBOutlet UITableView *holidayTC;
@property(nonatomic,retain)IBOutlet UITableView *loanTC;
@property(nonatomic,retain)IBOutlet UITableView *expenseReimbursementTC;

@property(nonatomic,retain)IBOutlet UITableView *empStatusTC;

@property(nonatomic,retain)NSMutableArray *earningsArray;
@property(nonatomic,retain)NSMutableArray *deductionsArray;
@property(nonatomic,retain)NSMutableArray *empStatusArray;



@property(nonatomic,retain)IBOutlet UITextField *empStatusTextField;
@property (weak, nonatomic)IBOutlet UITextField *monthlyBasicSalaryText;

@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;


@property(nonatomic,retain)NSMutableArray *unselectedEarningArray;
@property(nonatomic,retain)NSMutableArray *unselectedDeductionArray;
@property(nonatomic,retain)NSMutableArray *selectedLeaveArray;
@property(nonatomic,retain)NSMutableArray *defaultLeaveArray;
@property(nonatomic,retain)NSMutableArray *selectedHolidayArray;
@property(nonatomic,retain)NSMutableArray *defaultHolidayArray;
@property(nonatomic,retain)NSMutableArray *selectedLoanArray;
@property(nonatomic,retain)NSMutableArray *defaultLoanArray;
@property(nonatomic,retain)NSMutableArray *selectedExpenseArray;
@property(nonatomic,retain)NSMutableArray *defaultExpenseArray;

@property(nonatomic,retain)IBOutlet UITextField *shiftText;
@property(nonatomic,retain)IBOutlet UITextField *teamText;
@property(nonatomic,retain)IBOutlet UITextField *weekText;
@property(nonatomic,retain)IBOutlet UITextField *payText;
@property(nonatomic,retain)IBOutlet UITextField *overtimeText;

@property(nonatomic,retain)NSMutableArray *leavesArray;
@property(nonatomic,retain)NSMutableArray *leavesIDArray;
@property(nonatomic,retain)NSMutableArray *holidayArray;
@property(nonatomic,retain)NSMutableArray *holidayIDArray;
@property(nonatomic,retain)NSMutableArray *loanArray;
@property(nonatomic,retain)NSMutableArray *loanIDArray;
@property(nonatomic,retain)NSMutableArray *reimbursemntArray;
@property(nonatomic,retain)NSMutableArray *reimbursemntIDArray;

@property(nonatomic,retain)IBOutlet UILabel *shiftResultTextLabel;



///
@property(nonatomic,retain)IBOutlet UIView *rulePopup;
@property(nonatomic,retain)IBOutlet UILabel *seletedRuleLabel;
@property(nonatomic,retain)IBOutlet UITableView *popupTC;
@property(nonatomic,retain)NSMutableArray *ruleArray;
@property(nonatomic,retain)NSMutableArray *ruleIDArray;
@property(nonatomic,retain)NSMutableArray *ruleDescriptionArray;
@property(nonatomic,retain)NSMutableArray *shiftOptionArray;
@property(nonatomic,retain)NSMutableArray *payTypeArray;
@property(nonatomic,retain)NSString *selctedRule;
@property(nonatomic,retain)NSString *highlightedRule;

@property(nonatomic,retain)NSString *selectedField;

@property(nonatomic,retain)NSMutableDictionary *ruleDict;

-(void)ruleSelection:(NSString *)option;

@property(nonatomic,assign)int a;
@property(nonatomic,assign)int b;
@property(nonatomic,assign)int c;
@property(nonatomic,assign)int d;

@property(nonatomic,retain)NSMutableArray *teamShiftArray;
@property(nonatomic,retain)IBOutlet UITableView *shiftOptionTC;
-(void)shiftTeamOptionList:(NSString *)type;
@property(nonatomic,retain)IBOutlet UILabel *salaryLabel;

@property(nonatomic,retain)NSMutableDictionary *selectedLeaveDict;
@property(nonatomic,retain)NSMutableDictionary *selectedLoanDict;
@property(nonatomic,retain)NSMutableDictionary *selectedExpenseDict;
@property(nonatomic,assign)int action;

@property(nonatomic,retain)NSString *weekID;
@property(nonatomic,retain)NSString *payID;
@property(nonatomic,retain)NSString *overtimeID;
@property(nonatomic,retain)NSString *shiftID;
@property(nonatomic,retain)NSString *shiftType;
@property(nonatomic,assign)int value;
@property(nonatomic,retain)NSTimer *timer;

@property(nonatomic,retain)NSMutableDictionary *detailsDict;
-(void)fillDetails:(id)personalDict;
@property(nonatomic,retain)NSString *empID;
@property(nonatomic,retain)NSString *empCode;

@end
