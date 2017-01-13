//
//  leaveSettingsViewClass.h
//  bablusdemokpproject
//
//  Created by leonine on 8/20/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "settingsViewController.h"
#import "connectionclass.h"


@interface leaveSettingsViewsClass : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,headerprotocol>
{
    AppDelegate *myappde;
}
@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UIView *paymentStructureView;
@property(nonatomic,retain)IBOutlet UIView *firstView;
@property(nonatomic,retain)IBOutlet UIView *secondView;
-(IBAction)advancedAction:(id)sender;

@property(nonatomic,assign) int x;
@property(nonatomic,assign) int y;
@property(nonatomic,assign) int z;
@property(nonatomic,assign) int i;
@property(nonatomic,assign) int j;
@property(nonatomic,assign) int p;
@property(nonatomic,assign) int q;
@property(nonatomic,assign) int r;
@property(nonatomic,assign) int s;
@property(nonatomic,assign) int checkFlag;
@property(nonatomic,assign) int checkFlag1;
@property(nonatomic,assign) int flag;



@property(nonatomic,retain)IBOutlet UIButton *checkButton1;
@property(nonatomic,retain)IBOutlet UIButton *checkButton2;
@property(nonatomic,retain)IBOutlet UIButton *checkButton3;
@property(nonatomic,retain)IBOutlet UIButton *checkButton4;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText1;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText2;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText3;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText4;
-(IBAction)checkButtonAction:(id)sender;

-(IBAction)saveButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *saveButton;

@property(nonatomic,retain)IBOutlet UITextField *maxConsecutivedaysText;

@property(nonatomic,retain)IBOutlet UIButton *maleCheckButton;
@property(nonatomic,retain)IBOutlet UIButton *femaleCheckButton;
@property(nonatomic,retain)IBOutlet UITextField *maleCheckText;
@property(nonatomic,retain)IBOutlet UITextField *femaleCheckText;
-(IBAction)applyTocheckAction:(id)sender;


@property(nonatomic,retain)NSMutableArray *weekDropArray;
@property(nonatomic,retain)IBOutlet UITableView *weekDropTableView;
@property(nonatomic,retain)NSMutableArray *leaveArray;
@property(nonatomic,retain)IBOutlet UITableView *leaveApplicableDropTableView;


@property(nonatomic,retain)NSMutableArray *monthArray;
@property(nonatomic,retain)IBOutlet UITableView * carryForwardTC;
@property(nonatomic,retain)IBOutlet UITextView *carryForwardDropTextView;

@property(nonatomic,retain)IBOutlet UITextField *conditionText1;
@property(nonatomic,retain)IBOutlet UITextField *conditionText2;
@property(nonatomic,retain)IBOutlet UITextField *conditionText3;
@property(nonatomic,retain)IBOutlet UITextField *conditionText4;
@property(nonatomic,retain)IBOutlet UITextField *conditionText5;
@property(nonatomic,retain)IBOutlet UITextField *paymentText1;
@property(nonatomic,retain)IBOutlet UITextField *paymentText2;
@property(nonatomic,retain)IBOutlet UITextField *paymentText3;
-(void)changeyourframe;


@property(nonatomic,retain)IBOutlet UITableView *exceptLeaveTableView;
@property(nonatomic,retain)IBOutlet UIView *leaveView;
-(IBAction)leaveDoneButtonAction:(id)sender;
@property(nonatomic,retain)NSMutableArray *leavesArray;
@property(nonatomic,retain)NSMutableArray *selectedArray;
@property(nonatomic,retain)IBOutlet UITextField *leavesText;

@property(nonatomic,retain)IBOutlet UIView *switchPopUpView;
-(IBAction)popUpDoneAction:(id)sender;

@property(nonatomic,retain)IBOutlet UIButton *chechBox1;
@property(nonatomic,retain)IBOutlet UIButton *chechBox2;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText11;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText22;
-(IBAction)checkBoxAction:(id)sender;

@property(nonatomic,retain)IBOutlet UIView *modifiedView;

-(IBAction)groupselectionaction:(id)sender;
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)NSMutableArray *grouparray;
@property(nonatomic,retain)NSIndexPath *indexpath;

@property(nonatomic,retain)IBOutlet UILabel *modifyDate;
@property(nonatomic,retain)IBOutlet UIButton *switchButton1;
@property(nonatomic,retain)IBOutlet UIButton *switchButton2;
@property(nonatomic,retain)IBOutlet UIButton *switchButton3;
@property(nonatomic,retain)IBOutlet UIButton *switchButton4;
@property(nonatomic,retain)IBOutlet UIButton *switchButton5;
@property(nonatomic,retain)IBOutlet UIButton *switchButton6;
@property(nonatomic,retain)IBOutlet UIButton *switchButton7;
@property(nonatomic,retain)IBOutlet UIButton *switchButton8;
-(IBAction)switchButtonAction:(id)sender;
@property(nonatomic,assign) int s1;
@property(nonatomic,assign) int s2;
@property(nonatomic,assign) int s3;
@property(nonatomic,assign) int s4;
@property(nonatomic,assign) int s5;
@property(nonatomic,assign) int s6;
@property(nonatomic,assign) int s7;
@property(nonatomic,assign) int s8;

@property(nonatomic,assign) int selectedFlag;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;

-(IBAction)popupButtonAction:(id)sender;

@property(nonatomic,retain)IBOutlet UIImageView *dropTextImage;
@property(nonatomic,retain)IBOutlet UITextField *dropText;
@property(nonatomic,retain)IBOutlet UILabel *dropmandatoryLabel;

-(IBAction)valueChangedAction:(id)sender;

-(IBAction)valueChangedAction1:(id)sender;


-(void)collectionViewReload:(NSMutableArray *)desigArray;
@property(nonatomic,retain)NSMutableArray *leaveTileIDArray;

@property(nonatomic,retain)NSMutableDictionary *leaveDict;
@property(nonatomic,retain)NSMutableDictionary *conditionDict;

@property(nonatomic,retain)NSString *firstCheckValue;
@property(nonatomic,retain)NSString *secondCheckValue;
@property(nonatomic,retain)NSString *thirdCheckValue;
@property(nonatomic,retain)NSString *maleCheckValue;
@property(nonatomic,retain)NSString *femaleCheckValue;
@property(nonatomic,retain)NSString *clubCheckValue;

@property(nonatomic,retain)NSString *switchValue1;
@property(nonatomic,retain)NSString *switchValue2;
@property(nonatomic,retain)NSString *switchValue3;
@property(nonatomic,retain)NSString *switchValue4;
@property(nonatomic,retain)NSString *switchValue5;
@property(nonatomic,retain)NSString *switchValue6;
@property(nonatomic,retain)NSString *switchValue7;
@property(nonatomic,retain)NSString *switchValue8;

@property(nonatomic,retain)NSString *carryForwardDropFlag;
@end
