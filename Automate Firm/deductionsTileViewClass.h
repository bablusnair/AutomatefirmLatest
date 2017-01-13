//
//  deductionsTileViewClass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 09/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "connectionclass.h"

@interface deductionsTileViewClass : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,headerprotocol,UICollectionViewDelegate,UICollectionViewDataSource>
{
    AppDelegate *app;
}
-(IBAction)saveButtonAction:(id)sender;
@property(nonatomic,retain)connectionclass * myconnection;
@property(nonatomic,retain)IBOutlet UIButton *saveButton;

@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *activeField;

@property(nonatomic,retain)IBOutlet UIPickerView *payPickerView;
@property(nonatomic)IBOutlet UIView *pickerView;
-(IBAction)donePickerAction:(id)sender;


@property(nonatomic,retain)NSString *dayString;
@property(nonatomic,retain)NSString *monthString;
@property(nonatomic,retain)NSString *yearString;
@property(nonatomic,retain)NSString *sendDesig;

@property(nonatomic,retain) IBOutlet UITableView *paymentinterveltableview;
@property(nonatomic,retain) IBOutlet UITableView *agetableview;
@property(nonatomic,retain)IBOutlet UITableView *issuePaymentTableView;
@property(nonatomic,retain)IBOutlet UITableView *hoursWorkedTC;
@property(nonatomic,retain)IBOutlet UITableView *issueRateTC;

@property(nonatomic,retain)NSMutableArray *paymentintervelarray;
@property(nonatomic,retain)NSMutableArray *agearray;
@property(nonatomic,retain)NSMutableArray *issuePaymentArray;
@property(nonatomic,retain)NSMutableArray *issuePaymentArray1;
@property(nonatomic,retain)NSMutableArray *dummyIssuePaymentArray;
@property(nonatomic,retain)NSMutableArray *hoursWorkedArray;
@property(nonatomic,retain)NSMutableArray *dummyHoursWorkedArray;
@property(nonatomic,retain)NSMutableArray *issueRateArray;
@property(nonatomic,retain)NSMutableArray *monthArray;
@property(nonatomic,retain)NSMutableArray *yearArray;
@property(nonatomic,retain)NSMutableArray *dayArray;


@property(nonatomic,retain)NSMutableArray *paymentMsgArray;
@property(nonatomic,retain)NSMutableArray *nextPaymentArray;
@property(nonatomic,retain)NSMutableArray *designationArray;


@property(nonatomic,assign)int selected;


@property(nonatomic,retain) IBOutlet UITextField *paymentinterveltext;
@property(nonatomic,retain) IBOutlet UITextField *maxLimitText;
@property(nonatomic,retain) IBOutlet UITextField *eligibilityText;
@property(nonatomic,retain) IBOutlet UITextField *agetext;
@property(nonatomic,retain) IBOutlet UITextField *ageValueText;
@property(nonatomic,retain) IBOutlet UITextField *payOnText;

@property(nonatomic,retain) IBOutlet UITextField *fixedAmountText;


@property(nonatomic,retain) IBOutlet UITextField *issueHoursText;
@property(nonatomic,retain) IBOutlet UITextField *issueRateText1;
@property(nonatomic,retain) IBOutlet UITextField *hoursWorkedText1;
@property(nonatomic,retain) IBOutlet UITextField *issueHoursText1;

@property(nonatomic,retain) IBOutlet UITextField *issuePercentageText;
@property(nonatomic,retain) IBOutlet UITextField *issue2PaymentText;

@property(nonatomic,retain) IBOutlet UIView *maximumlimitview;
@property(nonatomic,retain) IBOutlet UIView *amountview;
@property(nonatomic,retain) IBOutlet UIView *issuesecondview;
@property(nonatomic,retain) IBOutlet UIView *issuethirdview;

@property(nonatomic,retain)IBOutlet UIView *radio1stView;
@property(nonatomic,retain)IBOutlet UIView *radio2ndView;
@property(nonatomic,retain)IBOutlet UIView *amountPerHourView;
@property(nonatomic,retain)IBOutlet UIView *replaceView;

@property(nonatomic,retain)IBOutlet UILabel *paymentMessageLabel;
@property(nonatomic,retain)IBOutlet UILabel *nextPaymentLabel;
@property(nonatomic,retain)IBOutlet UILabel *deductionLabel;
@property(nonatomic,retain)IBOutlet UILabel *paymentIntervalLabel;
@property(nonatomic,retain)IBOutlet UITextField *replaceHourText;
@property (weak, nonatomic) IBOutlet UICollectionView *desigcollection;

@property(nonatomic,assign)int rateFlag;
@property(nonatomic,retain)IBOutlet UIButton *rateDropButton;
@property(nonatomic,assign)int issuePaymentFlag;
@property(nonatomic,assign)int hoursWorkedFlag;

-(IBAction)radioButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *radioButton1;
@property(nonatomic,retain)IBOutlet UIButton *radioButton2;
@property(nonatomic,retain)IBOutlet UITextField *radioText1;
@property(nonatomic,retain)IBOutlet UITextField *radioText2;
-(IBAction)checkButtonAction:(id)sender;
-(IBAction)issueCheckButtonAction:(id)sender;

@property(nonatomic,retain)IBOutlet UIButton *checkButton1;
@property(nonatomic,retain)IBOutlet UIButton *checkButton2;
@property(nonatomic,retain)IBOutlet UIButton *checkButton5;
@property(nonatomic,retain)IBOutlet UIButton *issueCheckButton;
@property(nonatomic,retain)IBOutlet UITextField *earningsCheckText;
@property(nonatomic,retain)IBOutlet UITextField *accumulateCheckText;
@property(nonatomic,retain)IBOutlet UITextField *replaceCheckText;
@property(nonatomic,retain)IBOutlet UITextField *issueCheckText;

@property(nonatomic,retain)NSString *radioString;
@property(nonatomic,retain)NSString *deductionCheckString;
@property(nonatomic,retain)NSString *accumalteCheckString;
@property(nonatomic,retain)NSString *switchString;
@property(nonatomic,retain)NSString *deductOnlyCheckString;
@property(nonatomic,retain)NSString *paymentIntervalString;
@property(nonatomic,retain)NSString *basicString;
@property(nonatomic,retain)NSString *deductTypeString;
@property(nonatomic,retain)NSString *deductOnlyTableString;
@property(nonatomic,retain)NSString *ageString;



@property(nonatomic,assign)int p;
@property(nonatomic,assign)int q;
@property(nonatomic,assign)int r;
@property(nonatomic,assign)int s;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;

-(IBAction)valueChangedActon:(id)sender;
@property(nonatomic,retain)IBOutlet UILabel *descriptionLabel;
-(void)collectionViewReload:(NSMutableArray *)desigArray;

@property(nonatomic,retain)NSString *payondateString;

@end
