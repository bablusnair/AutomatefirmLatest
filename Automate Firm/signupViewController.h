//
//  signupViewController.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 23/01/2017.
//  Copyright © 2017 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
@interface signupViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,headerprotocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UITextField *estTextfield;
@property(nonatomic,retain)IBOutlet UITextField *firmnameTextfield;
@property(nonatomic,retain)IBOutlet UITextField *urlTextfield;
@property(nonatomic,retain)IBOutlet UITextField *subTextfield;
@property(nonatomic,retain)IBOutlet UITextField *dateTextfield;
@property(nonatomic,retain)IBOutlet UITextField *agentTextfield;
@property(nonatomic,retain)IBOutlet UITextField *livinginTextfield;
@property(nonatomic,retain)IBOutlet UITextField *stateTextfield;
@property(nonatomic,retain)IBOutlet UITextField *cityTextfield;
@property(nonatomic,retain)IBOutlet UITextField *regcontactTextfield;
@property(nonatomic,retain)IBOutlet UITextField *regemailTextfield;
@property(nonatomic,retain)IBOutlet UITextField *secondaryTextfield;
@property(nonatomic,retain)IBOutlet UITextField *firstnameTextfield;
@property(nonatomic,retain)IBOutlet UITextField *lastnameTextfield;
@property(nonatomic,retain)IBOutlet UITextField *usernameTextfield;
@property(nonatomic,retain)IBOutlet UITextField *sectorTextfield;
@property(nonatomic,retain)UITextField *activeField;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UILabel *nofileChooselabel;
@property(nonatomic,retain)IBOutlet UIImageView *logoImageview;
@property(nonatomic,retain)IBOutlet UITableView *sectorTableview;
@property(nonatomic,retain)IBOutlet UITableView *agentTableview;
@property(nonatomic,retain)IBOutlet UITableView *livinginTableview;
@property(nonatomic,retain)IBOutlet UITableView *stateTableview;
@property(nonatomic,retain)IBOutlet UITableView *cityTableview;

@property (retain, nonatomic) IBOutlet UIDatePicker *estDatePicker;
@property (retain, nonatomic) IBOutlet UIDatePicker *DatesDatePicker;

@property(nonatomic,retain)NSMutableArray *sectorArray;
@property(nonatomic,retain)NSMutableArray *agentArray;
@property(nonatomic,retain)NSMutableArray *livingInArray;
@property(nonatomic,retain)NSMutableArray *stateArray;
@property(nonatomic,retain)NSMutableArray *cityArray;

@property(nonatomic,retain)NSMutableArray *filtercountryArray;
@property(nonatomic,retain)NSMutableArray *filterstateArray;
@property(nonatomic,retain)NSMutableArray *filtercityArray;


@property (retain, nonatomic) IBOutlet UIView *datebackgroundView;
@property (retain, nonatomic) IBOutlet UIView *estdatebackgroundView;

@property (retain, nonatomic)NSString *encodedString;
@property (retain, nonatomic)NSString *countryString;
@property (retain, nonatomic)NSString *stateString;
@property (retain, nonatomic)NSString *cityString;
@property (retain, nonatomic)NSString *sectorString;
@property (retain, nonatomic)NSString *agentString;
@property (retain, nonatomic)NSString *domainstring;

@property(nonatomic,assign)int filterflag;
@property(nonatomic,assign)int filterflag1;
@property(nonatomic,assign)int filterflag2;

-(IBAction)uploadLogoAction:(id)sender;
-(IBAction)signupbuttonAction:(id)sender;
- (IBAction)datepickerDoneaction:(id)sender;


@property(nonatomic,retain)NSMutableDictionary *countrydict;
@property(nonatomic,retain)NSMutableDictionary *statedict;
@property(nonatomic,retain)NSMutableDictionary *citydict;
@property(nonatomic,retain)NSMutableDictionary *sectordict;
@property(nonatomic,retain)NSMutableDictionary *agentdict;
@end
