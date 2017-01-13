//
//  incometaxViewClass.h
//  Automate Firm
//
//  Created by leonine on 12/3/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"

@interface incometaxViewClass : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,headerprotocol>
@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)NSMutableArray *taxarray1;
@property(nonatomic,retain)NSMutableArray *taxarray2;


@property(nonatomic,retain)NSMutableArray *amountarray;
@property(nonatomic,retain)NSMutableArray *percentagetaxarray;
@property(nonatomic,retain)NSMutableArray *zeroarray;


@property(nonatomic,retain)NSMutableArray *selectedarray;
@property(nonatomic,retain)NSMutableArray *taxrangeRedarray;
@property(nonatomic,retain)NSMutableArray *subchargerangeRedarray;


@property(nonatomic,retain)IBOutlet UITableView *instancetableview;
@property(nonatomic,retain)IBOutlet UITableView *mytableview;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;


@property(nonatomic,retain)NSIndexPath *inPath;
@property(nonatomic,retain)NSIndexPath *inPath1;
@property(nonatomic,retain)NSIndexPath *inPath2;


@property(nonatomic,retain)NSString *globalstring;
@property(nonatomic,retain)NSString *lastglobalstring;


@property(nonatomic,retain)IBOutlet UITableView *otherSurchargesTC;
@property(nonatomic,retain)NSMutableArray *otherChargesArray;
@property(nonatomic,retain)NSMutableArray *otherChargesTaxArray;
@property(nonatomic,retain)NSMutableArray *otherChargesAmountArray;

@property(nonatomic,retain)IBOutlet UITableView *amountdropTC;
//-(IBAction)amountfieldediting:(id)sender;
//-(IBAction)taxfieldediting:(id)sender;
//-(IBAction)taxfieldeditingaction2:(id)sender;
//-(IBAction)begineditingaction1:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;


-(IBAction)doneButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *doneButton;

@property(nonatomic,retain)NSMutableArray *otherInstanceRangeArray;
@property(nonatomic,retain)NSMutableArray *otherInstanceTaxableAmountArray;
@property(nonatomic,retain)NSMutableArray *otherInstanceTaxArray;
@property(nonatomic,retain)NSMutableArray *otherInstanceTaxAmtArray;


@property(nonatomic,retain)IBOutlet UILabel *annualIncomeAmtLabel;
@property(nonatomic,retain)IBOutlet UILabel *grosspayableAmountLabel;
@property(nonatomic,assign)NSInteger amount;
@property(nonatomic,assign)NSInteger netamount;
@property(nonatomic,retain)IBOutlet UILabel *netpayableAmountLabel;
@property(nonatomic,retain)IBOutlet UITableView *otherChargesDisplayTC;
@property(nonatomic,retain)NSMutableArray *otherchargeArray;
@property(nonatomic,retain)NSMutableArray *otherTaxArray;
@property(nonatomic,retain)NSMutableArray *otherAmountArray;

@property(nonatomic,retain)NSIndexPath *myindex2;

@property(nonatomic,assign)int amountFlag;
@property(nonatomic,assign)int taxFlag;


@property(nonatomic,retain)NSMutableArray *amountErrorIndexArray;
@property(nonatomic,retain)NSMutableArray *taxErrorIndexArray;

//-(IBAction)firstcelltaxbeginaction:(id)sender;

//-(IBAction)secondlastcelltaxbeginaction:(id)sender;



-(IBAction)amountFieldEndediting:(id)sender;
-(IBAction)taxFieldEndediting:(id)sender;
-(IBAction)aboveTaxtextfieldEndediting:(id)sender;

@property(nonatomic,retain)IBOutlet UILabel *aboveNumberlabel;
@property(nonatomic,retain)IBOutlet UILabel *aboveResultvalue;
@property(nonatomic,retain)IBOutlet UIView  *abovebackgdView;
@property(nonatomic,retain)IBOutlet UITextField *aboveTaxtextfield;

@property(nonatomic,assign)int abovebgflag;


-(IBAction)editingChangedAmounttextfield:(id)sender;

-(IBAction)surchargeEndnamefield:(id)sender;
-(IBAction)surchargeEndtaxfield:(id)sender;

@property(nonatomic,retain)NSMutableArray *sur_selectedarray;
@property(nonatomic,retain)NSMutableArray *sur_selectedarray2;
@property(nonatomic,retain)IBOutlet UILabel *forinstanceaboveAmtvalue;
@property(nonatomic,retain)IBOutlet UILabel *forinstanceaboveTaxvalue;
@property(nonatomic,retain) NSString *abovetaxsavedstring;

@property(nonatomic,retain)NSIndexPath *storingIndevalue;

@property (weak, nonatomic) IBOutlet UIButton *cancl;

@property(nonatomic,retain)IBOutlet UILabel *instancenotapplicable1;
@property(nonatomic,retain)IBOutlet UILabel *instancenotapplicable2;

@property(nonatomic,retain)IBOutlet UILabel *abovelabel;


@property(nonatomic,retain)NSMutableArray *amountdropdownArray;

@property(nonatomic,retain)NSMutableArray *amountfieldSelectedarray;
@property(nonatomic,retain)NSMutableArray *otherNametextSelectedarray;


-(IBAction)firsttaxcelWhenchanged:(id)sender;

-(IBAction)editingforothersurtaxField:(id)sender;

@property(nonatomic,assign) int resetflag;

@property(nonatomic,assign) int s1;

-(IBAction)radiobuttonaction:(id)sender;


@property(nonatomic,retain)IBOutlet UIButton *radiobuttonfirst;
@property(nonatomic,retain)IBOutlet UIButton *radiobuttonsecond;
@property(nonatomic,retain)IBOutlet UILabel *incometaxdeductlabel;
@property(nonatomic,retain)IBOutlet UIButton *checkboxbutton;
-(IBAction)incometaxcheckboxaction:(id)sender;

@property(nonatomic,retain)NSString *sendabovepercentagevalue;

@property(nonatomic,retain)NSString *deductincometaxfromalarystring;
@property(nonatomic,retain)NSString *nodeductincometaxfromalarystring;
@property(nonatomic,retain)NSString *checkboxstringvalue;
@property(nonatomic,retain)NSString *swichbuttonstringvalue;
@property (weak, nonatomic) IBOutlet UITextField *checktext;
@property (weak, nonatomic) IBOutlet UITextField *checktext2;
@property (weak, nonatomic) IBOutlet UITextField *checkboxtext;

@property(nonatomic,retain)IBOutlet UIButton *switchButton;
-(IBAction)switchbuttonaction:(id)sender;

@property(nonatomic,retain)IBOutlet UILabel *abovefieldmandtory;

-(IBAction)abovetaxbegineditingfunction:(id)sender;
@end

