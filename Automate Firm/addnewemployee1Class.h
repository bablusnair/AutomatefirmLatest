//
//  addnewemployee1Class.h
//  bablusdemokpproject
//
//  Created by leonine on 8/20/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "headerprotocol.h"
#import "connectionclass.h"
#import "AppDelegate.h"
@interface addnewemployee1Class : UIView<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,headerprotocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UIWindow *alertWindow;
    AppDelegate *app;
}

@property (strong, nonatomic)NSMutableArray *contentList2;
@property (strong, nonatomic)NSMutableArray *filterarraycountry;
@property (strong, nonatomic)NSMutableArray *skillsservicearray;
@property (strong, nonatomic)NSMutableArray *departmentarray;
@property (strong, nonatomic)NSMutableArray *departmentIDArray;
@property(nonatomic,retain)NSMutableArray *departmentCodeArray;

@property (strong, nonatomic)NSMutableArray *designationarray;
@property (strong, nonatomic)NSMutableArray *designationIDArray;
@property (strong, nonatomic)NSMutableArray *categoryarray;
@property (strong, nonatomic)NSMutableArray *categoryIDArray;
@property(nonatomic,retain)NSMutableArray *categoryCodeArray;
@property(nonatomic,retain)NSMutableArray *degreearray;
@property(nonatomic,retain)NSMutableArray *institutionarray;
@property(nonatomic,retain)NSMutableArray *descriptionarray;
@property(nonatomic,retain)NSMutableArray *experiance;
@property(nonatomic,retain)NSMutableArray *banknamearray;
@property(nonatomic,retain)NSMutableArray *bankIDArray;
@property(nonatomic,retain)NSMutableArray *myarray;
@property(nonatomic,retain)NSMutableArray *ratearray;
@property(nonatomic,retain)NSMutableArray *bloodgroupArray;
@property(nonatomic,retain)NSMutableArray *martialarray;
@property(nonatomic,retain)NSMutableArray *genderArray;
@property(nonatomic,retain)NSMutableArray *countryArray;
@property(nonatomic,retain)NSMutableArray *yeararray;
@property(nonatomic,retain)NSMutableArray *serviceyeararray;
@property(nonatomic,retain)NSMutableArray *custumcellmainarray;
@property(nonatomic,retain)NSMutableArray *custumcellmainarray2;
@property(nonatomic,retain)NSMutableArray *workingPremiseArray;
@property(nonatomic,retain)NSMutableArray *workingPremiseIDArray;
@property(nonatomic,retain)NSMutableArray *workingPremiseCodeArray;

@property(nonatomic,retain)NSMutableArray *employeeCodeArray;

@property(nonatomic,retain)NSString *empCode;
@property(nonatomic,retain)NSString *employeeCode;
@property (strong, nonatomic)NSString *storestring;

@property(nonatomic,assign)int warningFlag;

@property (strong, nonatomic) IBOutlet UITableView *skillsTableView;
@property (strong, nonatomic) IBOutlet UITableView *mytableview;
@property (strong, nonatomic) IBOutlet UITableView *yeartableview;
@property (strong, nonatomic) IBOutlet UITableView *rateingtableview;
@property (strong, nonatomic) IBOutlet UITableView *bloodgrouptableview;
@property (strong, nonatomic) IBOutlet UITableView *martialstatustableview;
@property (strong, nonatomic) IBOutlet UITableView *gendertableview;
@property (strong, nonatomic) IBOutlet UITableView *nationalitytableview;
@property (strong, nonatomic) IBOutlet UITableView *banknametableview;
@property (strong, nonatomic) IBOutlet UITableView *workingPremiseTableView;
@property (strong, nonatomic) IBOutlet UITableView *departmenttableview;
@property (strong, nonatomic) IBOutlet UITableView *designationtableview;
@property (strong, nonatomic) IBOutlet UITableView *categorytableiew;

@property (strong, nonatomic)IBOutlet UITextField *departmenttextfield;
@property (strong, nonatomic)IBOutlet UITextField *designationtextfield;
@property (strong, nonatomic)IBOutlet UITextField *officetextfield;
@property (strong, nonatomic)IBOutlet UITextField *categorytextfield;
@property(nonatomic,retain)IBOutlet UITextField *bloodtextfield;
@property(nonatomic,retain)IBOutlet UITextField *martialtextfield;
@property(nonatomic,retain)IBOutlet UITextField *gendertextfield;
@property(nonatomic,retain)IBOutlet UITextField *nationalitytextfield;
@property(nonatomic,retain)IBOutlet UITextField *banknametextfield;
@property(nonatomic,retain)IBOutlet UITextField *dateofbirthtextfield;
@property(nonatomic,retain)IBOutlet UITextField *dateofjoiningtextfield;
@property(nonatomic,retain)IBOutlet UITextField *visaexpirytextfield;
@property(nonatomic,retain)IBOutlet UITextField *employeeNameTextField;
@property(nonatomic,retain)IBOutlet UITextField *employeecodeTextField;
@property(nonatomic,retain)IBOutlet UITextField *passportNoTextField;
@property(nonatomic,retain)IBOutlet UITextField *labourCardNoTextField;
@property(nonatomic,retain)IBOutlet UITextField *nationalIDNoTextField;
@property(nonatomic,retain)IBOutlet UITextField *pfNoTextField;
@property(nonatomic,retain)IBOutlet UITextField *incomeTaxNoTextField;
@property(nonatomic,retain)IBOutlet UITextField *esiNoTextField;
@property(nonatomic,retain)IBOutlet UITextField *bankAccountNoTextField;
@property(nonatomic,retain)IBOutlet UITextField *wpsNoTextField;

@property(nonatomic,retain)IBOutlet UILabel *mandatoryImage1;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryImage2;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryImage3;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryImage4;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryImage5;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryImage6;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryImage7;
@property(nonatomic,retain)IBOutlet UILabel *mandatoryImage8;


@property(nonatomic,assign)int nationalityFlag;
@property(nonatomic,assign)int y;
@property(nonatomic,assign)int index;
@property(nonatomic,assign)int actionFlag;

-(void)imagePickerAction;


-(IBAction)imagepickeraction:(id)sender;
-(IBAction)saveAndnext:(id)sender;
-(IBAction)visadatepickeraction:(id)sender;
-(IBAction)visadatetextfieldaction:(id)sender;
-(IBAction)textfieldbegininaction:(id)sender;//Begin action for degree and description custom cell
-(IBAction)textfieldbegininaction2:(id)sender;//Begin action for institute and experience
-(IBAction)textFieldEndingAction:(id)sender;//Ending action for degree
-(IBAction)textFieldEndingAction2:(id)sender;//Ending action for institute
-(IBAction)descriptionEndEditing:(id)sender;//Ending action for decsiption text
-(IBAction)experienceEndEditing:(id)sender;//Ending action for experience text
-(IBAction)yearfirstresponderaction:(id)sender;//Begin action for year
-(IBAction)rateingfirstresponderaction:(id)sender;//Begin action for rating
-(IBAction)datepickeraction:(id)sender;
-(IBAction)seconddatepickeraction:(id)sender;
-(IBAction)visadateExpiry:(id)sender;
-(IBAction)clearButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;

@property (retain, nonatomic)connectionclass *myconnection;//Connection class object

@property (weak, nonatomic) IBOutlet UIView *datepickerviewfirst;
@property (weak, nonatomic) IBOutlet UIDatePicker *mydatepicker;

@property (weak, nonatomic) IBOutlet UIView *datepickerviewsecond;
@property (weak, nonatomic) IBOutlet UIDatePicker *mydatepickersecond;

@property (strong, nonatomic) IBOutlet UIImageView *employeeprofilepic;

@property (weak, nonatomic) IBOutlet UIView *visaexpiryview;;
@property (weak, nonatomic) IBOutlet UIDatePicker *visapicker;

@property(nonatomic,retain)NSIndexPath *yearindexpath;
@property(nonatomic,retain)NSIndexPath *inPath;


@property(nonatomic,retain)NSString *dateofbirthstring;
@property(nonatomic,retain)NSString *dateofjoingstring;
@property(nonatomic,retain)NSString *visaexpirystring;

@property (strong, nonatomic)NSMutableDictionary *countrydict;
@property(nonatomic,retain)IBOutlet UIButton *bankDropButton;
@property(nonatomic,retain)IBOutlet UITextView *barcodeTextView;


@property(nonatomic,retain)NSString *empID;
@property(nonatomic,retain)NSString *nationalityID;
@property(nonatomic,retain)NSString *workingPremiseID;
@property(nonatomic,retain)NSString *workingPremiseType;
@property(nonatomic,retain)NSString *departmentID;
@property(nonatomic,retain)NSString *categoryID;
@property(nonatomic,retain)NSString *designationID;
@property(nonatomic,retain)NSString *bankID;

@property(nonatomic,retain)NSMutableArray *educationArray;
@property(nonatomic,retain)NSMutableArray *skillsArray;

-(void)alertAction:(NSString *)message;
-(void)alertAction1:(NSString *)message :(NSString *)type :(NSIndexPath *)selectedIndex;

@property(nonatomic,retain)NSMutableDictionary *personalDetailsDict;

-(void)resetTextField:(UITextField *)textField;
@property(nonatomic,retain)NSMutableDictionary *empDict;
-(void)fillDetails;
@property(nonatomic,assign)int imageFlag;
@end
