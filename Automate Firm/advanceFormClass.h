//
//  advanceFormClass.h
//  Automate Firm
//
//  Created by leonine on 6/20/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "advancedplusCollectionViewCell.h"
#import "advancedplustableviewclass.h"
#import "advancedplussecondtableviewclass.h"
#import "homeViewController.h"
#import "AppDelegate.h"
#import "connectionclass.h"

@interface advanceFormClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,headerprotocol>

@property(nonatomic,retain)connectionclass *myconnection;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView2;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *activeField;
@property(nonatomic,retain)NSMutableArray *stamparray;
@property(nonatomic,retain)NSMutableArray *stamparray1;
@property(nonatomic,retain)NSMutableArray *numberArray;
@property(nonatomic,retain)IBOutlet UITextField *visaExpiry;
@property(nonatomic,retain)IBOutlet UITextField *lastWorkingDay;
@property(nonatomic,retain)IBOutlet UITextField *leaveApplication;
@property(nonatomic,retain)IBOutlet UITextField *pendingLoanAmount;
@property(nonatomic,retain)IBOutlet UITextField *dateJoining;
@property(nonatomic,retain)IBOutlet UITextField *numberInstallment;
@property(nonatomic,retain)IBOutlet UITextView *reasonText;
@property(nonatomic,retain)IBOutlet UITableView *installmentTC;
@property(nonatomic,retain)IBOutlet UITextField *approvedAmountText;
@property(nonatomic,retain)NSString *approvedAmount;
@property(nonatomic,retain)IBOutlet UIButton *dropButton1;
-(IBAction)dateEdit:(id)sender;

@property(nonatomic,assign)int x;
@property(nonatomic,assign)int z;
@property(nonatomic,assign)int flag;
@property(nonatomic,assign)int dateflag;

@property(nonatomic,retain)IBOutlet UITableView *installmentTableView;
@property(nonatomic,retain)NSMutableArray *installmentArray;
-(IBAction)noinstallmentAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *tableeditButton;
@property(nonatomic,retain)NSMutableArray *kwdArray;
-(IBAction)editButton1:(id)sender;
-(IBAction)editButton2:(id)sender;
@property(nonatomic,retain)IBOutlet UITextField *authorizationText;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain)IBOutlet UIView *datePickerView;
-(IBAction)datePickerAction:(id)sender;
@property(nonatomic,retain)NSIndexPath *inPath;
@property(nonatomic,retain)NSMutableArray *dateArray;
-(IBAction)doneKwdAction:(id)sender;
@property(nonatomic,retain)IBOutlet UILabel *applicationDate;


@property(nonatomic,retain)IBOutlet UITextField *requestAmount;
-(void)showAlert:(NSString *)alertMsg;
-(IBAction)employeeSelectionAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIImageView *empIcon;
@property(nonatomic,retain)IBOutlet UILabel *empNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *empIDLabel;
@property(nonatomic,retain)IBOutlet UILabel *employeeApplicableGrossLabel;

//
@property(nonatomic,retain)IBOutlet UITextField *paymentDateText;
@property(nonatomic,retain)IBOutlet UITableView *authorityFlowTC;
@property(nonatomic,retain)IBOutlet UITableView *firstTableView;
@property(nonatomic,retain)IBOutlet UITableView *secondTableView;
@property(nonatomic,retain)NSMutableArray *firstArray;
-(IBAction)tileButtonClicked:(id)sender;
@property(nonatomic,assign)int x1;
@property(nonatomic,retain)IBOutlet UIScrollView *myscrollView;
@property(nonatomic,retain)IBOutlet UIView *firstView;
@property(nonatomic,retain)IBOutlet UIView *contentview;
-(IBAction)forwardbuttonaction:(id)sender;
-(IBAction)prioritybutton1action:(id)sender;
-(IBAction)prioritybutton2action:(id)sender;
-(IBAction)prioritybutton3action:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *priorityButton1;
@property(nonatomic,retain)IBOutlet UIButton *priorityButton2;
@property(nonatomic,retain)IBOutlet UIButton *priorityButton3;
-(IBAction)signatureAction:(id)sender;
-(IBAction)stampButtonAction:(id)sender;
-(void)installmentTableSetting:(NSDate *)date;
@property(nonatomic,retain)NSDate *startDate;
@property(nonatomic,retain)NSDate *nextDate;
-(IBAction)amountEditingChanged:(id)sender;
@property(nonatomic,retain)NSMutableArray *amountEditedArray;
@property(nonatomic,retain)AppDelegate *app;
@property(nonatomic,assign)float amount;
@property(nonatomic,retain)NSMutableDictionary *installmentDict;
-(IBAction)resetButtonAction:(id)sender;
@property(nonatomic,assign)int resetFlag;
@property(nonatomic,retain)IBOutlet UIButton *resetButton;
@property(nonatomic,retain)NSMutableDictionary *installmentValueDict;

-(void)amountChangeAction;
@property(nonatomic,assign)int presetFlag;
-(void)resetInstallmentTable;


@property(nonatomic,retain)NSString *empID;
@property(nonatomic,retain)IBOutlet UILabel *officeLabel;
@property(nonatomic,retain)IBOutlet UILabel *workingPremiseLabel;
@property(nonatomic,retain)IBOutlet UILabel *departmentLabel;
@property(nonatomic,retain)IBOutlet UILabel *designationLabel;
@property(nonatomic,retain)IBOutlet UILabel *nationalityLabel;
@property(nonatomic,retain)IBOutlet UILabel *passportNOLabel;
@property(nonatomic,retain)IBOutlet UILabel *categoryLabel;




-(void)formColorSetting;
@property(nonatomic,retain)NSString *colour;
@property(nonatomic,retain)IBOutlet UIImageView *image1;
@property(nonatomic,retain)IBOutlet UIImageView *image2;
@property(nonatomic,retain)IBOutlet UIImageView *image3;
@property(nonatomic,retain)IBOutlet UIImageView *image4;
@property(nonatomic,retain)IBOutlet UIImageView *image5;
@property(nonatomic,retain)IBOutlet UIImageView *image6;
@property(nonatomic,retain)IBOutlet UIImageView *image7;
@property(nonatomic,retain)IBOutlet UIImageView *image8;
@property(nonatomic,retain)IBOutlet UIImageView *image9;
@property(nonatomic,retain)IBOutlet UIImageView *image10;
@property(nonatomic,retain)IBOutlet UIImageView *image11;
@property(nonatomic,retain)IBOutlet UIImageView *image12;
@property(nonatomic,retain)IBOutlet UIImageView *image13;
@property(nonatomic,retain)IBOutlet UIImageView *backImage;
@end
