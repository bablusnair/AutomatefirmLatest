//
//  expenseReimbursementFormClass.h
//  Automate Firm
//
//  Created by leonine on 9/6/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "documentsRemarksTableCell.h"
#import "firstTableViewCellClass.h"
#import "connectionclass.h"
@interface expenseReimbursementFormClass : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate,headerprotocol>

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


@property (strong, nonatomic) IBOutlet UICollectionView *mycollectionView;
@property(nonatomic,retain) IBOutlet UITableView *expenseTableView;
- (IBAction)checkBoxAction1:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *mytableview;
- (IBAction)checkBoxAction2:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *checkBox2;
@property(nonatomic,retain)NSMutableArray *stamparray;
@property(nonatomic,retain)NSMutableArray *stamparray1;
@property (strong, nonatomic) IBOutlet UIButton *checkBox1;
-(IBAction)statusButtonAction:(id)sender;
@property(nonatomic,assign)NSInteger buttontag;
@property(nonatomic,retain)NSIndexPath *inpath;
- (IBAction)comboButton:(id)sender;
@property(nonatomic,retain)firstTableViewCellClass *cell;
-(IBAction)uploadImage:(id)sender;
@property(nonatomic,retain)NSMutableArray *expenseArray;
@property(nonatomic,retain)NSMutableArray *expenseNameArray;
@property(nonatomic,retain)NSMutableArray *expenseIDArray;
@property(nonatomic,retain)NSMutableArray *categoryArray;
@property(nonatomic,retain)NSMutableArray *categoryDummyArray;
@property(nonatomic,retain)NSMutableArray *categoryValueArray;
@property(nonatomic,retain)NSMutableArray *categoryDummyValueArray;
@property(nonatomic,retain)NSMutableArray *categoryIDArray;
@property(nonatomic,retain)NSMutableArray *categoryDummyIDArray;

@property (strong, nonatomic) IBOutlet UILabel *expenseType;
@property(nonatomic,retain)firstTableViewCellClass *clickedCell;
@property(nonatomic,retain)IBOutlet UITextField *expensedateText;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain)IBOutlet UIView *datePickerView;
-(IBAction)datePickerAction:(id)sender;
@property(nonatomic,retain)IBOutlet UITextView *declarationText;
-(IBAction)categoryDropDown:(id)sender;
@property(nonatomic,retain)IBOutlet UITableView *categoryTableView;

@property(nonatomic,retain)IBOutlet UITextField *activeField;
@property(nonatomic,retain)IBOutlet UITextView *purposeTextView;

@property(nonatomic,retain)NSMutableArray *selectedCategoryIDArray;
@property(nonatomic,retain)NSMutableArray *expenseCategoryArray;
@property(nonatomic,retain)NSMutableArray *expenseLimitArray;
@property(nonatomic,retain)NSMutableArray *expenseDescriptionArray;
@property(nonatomic,retain)NSMutableArray *expenseRqstAmountArray;
@property(nonatomic,retain)NSMutableArray *expenseApprAmountArray;
@property(nonatomic,retain)NSMutableArray *expenseBillImageArray;
@property(nonatomic,retain)NSMutableArray *expenseRemarksArray;

-(IBAction)employeeSelectionAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIImageView *empIcon;
@property(nonatomic,retain)IBOutlet UILabel *empNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *empIDLabel;
@property(nonatomic,retain)IBOutlet UILabel *applicationDateLabel;
@property(nonatomic,retain)NSString *empID;
@property(nonatomic,retain)IBOutlet UILabel *officeNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *departmentLabel;
@property(nonatomic,retain)IBOutlet UILabel *designationLabel;
@property(nonatomic,retain)IBOutlet UILabel *nationalityLabel;
@property(nonatomic,retain)IBOutlet UILabel *passportNOLabel;
@property(nonatomic,retain)IBOutlet UILabel *WorkingPremiseLabel;
@property(nonatomic,retain)IBOutlet UILabel *visaExpiryLabel;
@property(nonatomic,retain)IBOutlet UILabel *formNameLabel;

@property(nonatomic,retain)NSMutableArray *indexPathArray;
@property(nonatomic,retain)NSMutableArray *approveIndexPathArray;
-(IBAction)descriptionEndEditing:(id)sender;
-(IBAction)rqstAmountEndEditing:(id)sender;
-(IBAction)apprvAmountEndEditing:(id)sender;
-(IBAction)remarksEndEditing:(id)sender;

-(IBAction)descriptionBeginEditing:(id)sender;
-(IBAction)rqstAmountBeginEditing:(id)sender;
-(IBAction)apprvAmountBeginEditing:(id)sender;
-(IBAction)remarksBeginEditing:(id)sender;
-(IBAction)addNewCell:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *plusButton;



-(void)formColorSetting;
@property(nonatomic,retain)NSString *colour;
@property(nonatomic,retain)IBOutlet UIImageView *image1;
@property(nonatomic,retain)IBOutlet UIImageView *image2;
@property(nonatomic,retain)IBOutlet UIImageView *image3;
@property(nonatomic,retain)IBOutlet UIImageView *image4;
@property(nonatomic,retain)IBOutlet UIImageView *image5;
@property(nonatomic,retain)IBOutlet UIImageView *image6;
@property(nonatomic,retain)IBOutlet UIImageView *image7;
@property(nonatomic,retain)IBOutlet UIImageView *backImage;
@end
