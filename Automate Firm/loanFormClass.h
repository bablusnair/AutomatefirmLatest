//
//  loanFormClass.h
//  Automate Firm
//
//  Created by leonine on 9/21/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "documentsRemarksTableCell.h"
#import "documentflowcellclass.h"
#import "connectionclass.h"


@interface loanFormClass : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,headerprotocol>


@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UITableView *firstTableView;
@property(nonatomic,retain)IBOutlet UITableView *secondTableView;
@property(nonatomic,retain)NSMutableArray *firstArray;
-(IBAction)tileButtonClicked:(id)sender;
@property(nonatomic,assign)int y;
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
@property (weak, nonatomic) IBOutlet UIView *formView;




@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)IBOutlet UITextField *pendingLoanAmount;
@property(nonatomic,retain)IBOutlet UITextField *dateJoining;
@property(nonatomic,retain)IBOutlet UITextField *leaveApplications;
@property(nonatomic,retain)IBOutlet UITextField *lastWorkingDay;
@property(nonatomic,retain)IBOutlet UITextField *visaExpiry;
@property(nonatomic,retain)IBOutlet UITextField *numberInstallment;
@property(nonatomic,retain)IBOutlet UITableView *LoanTypeTC;
@property(nonatomic,retain)IBOutlet UILabel *LoanLabel;
-(IBAction)dropDown1:(id)sender;
@property(nonatomic,retain)NSMutableArray *loanTypeArray;
@property(nonatomic,retain)IBOutlet UITextField *paymentDateText;
@property(nonatomic,retain)IBOutlet UITextField *deductDateText;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain)IBOutlet UIView *datePickerView;
-(IBAction)dateChanged:(id)sender;
@property(nonatomic,assign)int flag;
@property(nonatomic,retain)IBOutlet UIButton *combo1;
@property(nonatomic,retain)IBOutlet UITextView *reasonText;
@property(nonatomic,retain)IBOutlet UIButton *forwardButton;
@property(nonatomic,assign)int x;
@property(nonatomic,retain)NSMutableArray *stamparray;
@property(nonatomic,retain)NSMutableArray *stamparray1;
@property(nonatomic,retain)IBOutlet UITextView *declarationText;
@property(nonatomic,retain)IBOutlet UITextField *authorisationText;



-(void)alertAction:(NSString *)alertMsg;

@property(nonatomic,retain)IBOutlet UIImageView *empIcon;
@property(nonatomic,retain)IBOutlet UILabel *empNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *empIDLabel;
@property(nonatomic,retain)IBOutlet UILabel *applicationDateLabel;
@property(nonatomic,retain)IBOutlet UILabel *formNameLabel;

@property(nonatomic,retain)IBOutlet UILabel *officeNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *workingPremiseLabel;
@property(nonatomic,retain)IBOutlet UILabel *departmentLabel;
@property(nonatomic,retain)IBOutlet UILabel *designationLabel;
@property(nonatomic,retain)IBOutlet UILabel *nationalityLabel;
@property(nonatomic,retain)IBOutlet UILabel *passportNOLabel;

@property(copy,nonatomic)NSString *empID;

-(IBAction)empSelectionAction:(id)sender;
@end
