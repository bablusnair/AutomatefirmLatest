//
//  fineApplicationFormClass.h
//  Automate Firm
//
//  Created by leonine on 9/17/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "documentsRemarksTableCell.h"
#import "advancedplusCollectionViewCell.h"
#import "connectionclass.h"
@interface fineApplicationFormClass : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,headerprotocol>

@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UITableView *firstTableView;
@property(nonatomic,retain)IBOutlet UITableView *secondTableView;
@property(nonatomic,retain)NSMutableArray *firstArray;
-(IBAction)tileButtonClicked:(id)sender;
@property(nonatomic,assign)int x;
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


@property(nonatomic,retain)IBOutlet UITextField *violationDate;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain)IBOutlet UIView *datePickerView;
-(IBAction)datePickerAction:(id)sender;
@property(nonatomic,retain)IBOutlet UITableView *violationTypeTC;
-(IBAction)dropDownAction:(id)sender;
@property(nonatomic,retain)IBOutlet UILabel *violationTypeLabel;
@property(nonatomic,retain)NSMutableArray *violationsArray;
@property(nonatomic,retain)NSMutableArray *violationIDArray;


@property(nonatomic,retain)IBOutlet UILabel *warningLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView2;
@property(nonatomic,retain)NSMutableArray *stamparray;
@property(nonatomic,retain)NSMutableArray *stamparray1;



-(IBAction)employeeSelectionAction:(id)sender;

@property(nonatomic,retain)IBOutlet UIImageView *empIcon;
@property(nonatomic,retain)IBOutlet UILabel *empNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *empIDLabel;
@property(nonatomic,retain)IBOutlet UILabel *appleDateLabel;
@property(nonatomic,retain)IBOutlet UILabel *formTitleLabel;

@property(nonatomic,retain)NSString *empID;
@property(nonatomic,retain)IBOutlet UILabel *officeLabel;
@property(nonatomic,retain)IBOutlet UILabel *workingPremiseLabel;
@property(nonatomic,retain)IBOutlet UILabel *departmentLabel;
@property(nonatomic,retain)IBOutlet UILabel *designationLabel;
@property(nonatomic,retain)IBOutlet UILabel *nationalityLabel;
@property(nonatomic,retain)IBOutlet UILabel *passportNOLabel;
@property(nonatomic,retain)IBOutlet UILabel *visaLabel;
@property(nonatomic,retain)IBOutlet UITextField *fineAmountText;
@property(nonatomic,retain)IBOutlet UITextField *installmentsText;




@end
