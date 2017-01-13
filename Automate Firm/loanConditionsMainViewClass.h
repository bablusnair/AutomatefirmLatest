//
//  loanConditionsMainViewClass.h
//  Automate Firm
//
//  Created by leonine on 11/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"

@interface loanConditionsMainViewClass : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,headerprotocol>
@property(nonatomic,retain)IBOutlet UITextField *annualInterestText;
@property(nonatomic,retain)IBOutlet UITextField *maxDurationText;
@property(nonatomic,retain)IBOutlet UITextField *maxLoanAmount;
@property(nonatomic,retain)IBOutlet UITextField *pendingLoanAmount;
@property(nonatomic,retain)IBOutlet UITextField *loanEligibilityText;
@property(nonatomic,retain)IBOutlet UITextField *visaExpirationText;
@property(nonatomic,retain)IBOutlet UITextField *nextApproveLeaveDaysText;
@property(nonatomic,retain)IBOutlet UITextField *exceptLeaveText;
@property(nonatomic,retain)IBOutlet UITextField *lastWorkingText;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText1;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText2;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText3;
@property(nonatomic,retain)IBOutlet UITextField *activeField;

@property(nonatomic,retain)IBOutlet UIButton *checkBoxButton1;
@property(nonatomic,retain)IBOutlet UIButton *checkBoxButton2;
@property(nonatomic,retain)IBOutlet UIButton *checkBoxButton3;

-(IBAction)checkBoxAction1:(id)sender;
-(IBAction)checkBoxAction2:(id)sender;
-(IBAction)checkBoxAction3:(id)sender;
-(IBAction)saveButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *saveButton;
@property(nonatomic,retain)IBOutlet UITableView *maxDurationTC;
@property(nonatomic,retain)NSMutableArray *maxDurationArray;

@property(nonatomic,retain)IBOutlet UITableView *exceptLeaveTableView;
@property(nonatomic,retain)IBOutlet UIView *leaveView;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
-(IBAction)leaveDoneButtonAction:(id)sender;
@property(nonatomic,retain)NSMutableArray *leaveArray;
@property(nonatomic,retain)NSMutableArray *selectedArray;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;
@property(nonatomic,assign)int z;
@property(nonatomic,assign)int flag;

@property(nonatomic,retain)IBOutlet UIButton *switchButton;
-(IBAction)switchButtonAction:(id)sender;
@property(nonatomic,assign) int s1;

-(IBAction)includeDesignationButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)NSMutableArray *grouparray;
@property(nonatomic,retain)NSIndexPath *indexpath;
-(void)collectionViewReload:(NSMutableArray *)desigArray;


-(IBAction)valueChanged:(id)sender;

@property (retain, nonatomic)connectionclass *myconnection;

-(void)showalerviewcontroller:(NSString *)alertMessage;

@property(nonatomic,retain)NSString *checkbuttonstring1;
@property(nonatomic,retain)NSString *checkbuttonstring2;
@property(nonatomic,retain)NSString *checkbuttonstring3;


@property(nonatomic,retain)NSString *service_maxdurationtext;
@property(nonatomic,retain)NSString *service_eligiblemonthtext;
@property(nonatomic,retain)NSString *service_lastworkingdaytext;
@property(nonatomic,retain)NSString *service_visaexpirationtext;
@property(nonatomic,retain)NSString *service_nextapprovedtext;
@property(nonatomic,retain)NSString *exceptleavestring;



@property(nonatomic,retain)NSString *tile_idstring;
@property(nonatomic,retain)NSString *loan_idstring;



@property(nonatomic,retain)NSString *switchButtonstring;
@property(nonatomic,assign)int clickincludedesignationforupdation;


-(void)enableall;

@end
