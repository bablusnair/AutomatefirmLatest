//
//  individualofficeclass.h
//  Automate Firm
//
//  Created by leonine on 05/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"
@interface individualofficeclass : UIView<UITableViewDelegate,UITableViewDataSource,headerprotocol,UITextFieldDelegate>
{
    AppDelegate *app;
}

//for property declarations

@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)NSMutableArray *bankarray;
@property(nonatomic,retain)NSMutableArray *countryaray;
@property(nonatomic,retain)NSMutableArray *countryserviceid;
@property(nonatomic,retain)NSMutableArray *statearay;
@property(nonatomic,retain)NSMutableArray *stateserviceid;
@property(nonatomic,retain)NSMutableArray *cityserviceid;
@property(nonatomic,retain)NSMutableArray *city;
@property(nonatomic,retain)NSMutableArray *officetypearray;
@property(nonatomic,retain)NSMutableArray *officetypeimagearray;
@property(nonatomic,retain)NSMutableArray *sectorarar;
@property(nonatomic,retain)NSMutableArray *sectorIDArray;
@property(nonatomic,retain)NSMutableArray *currencyaray;
@property(nonatomic,retain)NSMutableArray *currencyAbbrvArray;
@property(nonatomic,retain)NSMutableArray *currencyIDArray;
@property(nonatomic,retain)NSString *selectedCurrency;
@property(nonatomic,retain)NSString *selectedSector;

@property(nonatomic,retain)NSMutableDictionary *countrydict;
@property(nonatomic,retain)NSMutableDictionary *statedict;
@property(nonatomic,retain)NSMutableDictionary *citydict;


@property(nonatomic,retain)IBOutlet UITableView *otherdetailstableview;
@property(nonatomic,retain)NSMutableArray *otherdetailsfield1array;
@property(nonatomic,retain)NSMutableArray *otherdetailsfield2array;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)UITextField *activeField;
@property(nonatomic,retain)IBOutlet UITableView *financialyrtableview;
@property(nonatomic,retain)NSMutableArray *finyrarray;
@property(nonatomic,retain)IBOutlet UILabel *officeheading;
@property(nonatomic,retain)IBOutlet UILabel *officenamelabel;
@property (retain, nonatomic) IBOutlet UITextField *regtext;
@property (retain, nonatomic) IBOutlet UILabel *abbreviationtext;

@property (retain, nonatomic) IBOutlet UITextField *websitetext;
@property (retain, nonatomic) IBOutlet UITextField *financialyeartext;

@property(nonatomic,retain)IBOutlet UITextField *telephonetextfield;
@property(nonatomic,retain)IBOutlet UITextField *faxtextfield;
@property(nonatomic,retain)IBOutlet UITextField *emailtextfield;
@property (retain, nonatomic) IBOutlet UITextField *buildingtext;
@property (retain, nonatomic) IBOutlet UITextField *blocktext;
@property (retain, nonatomic) IBOutlet UITextField *streettext;
@property (retain, nonatomic) IBOutlet UITextField *countrytext;
@property (retain, nonatomic) IBOutlet UITextField *statetext;
@property (retain, nonatomic) IBOutlet UITextField *citytext;
@property (retain, nonatomic) IBOutlet UITextField *postcodetext;
@property (retain, nonatomic) IBOutlet UITextField *landmarktext;

@property(nonatomic,retain)NSIndexPath *k;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int g;
@property(nonatomic,retain)IBOutlet UITextField *officetextfield;
@property(nonatomic,retain)IBOutlet UITextField *sectortextfield;
@property(nonatomic,retain)IBOutlet UITextField *abbrvtextfield;
@property(nonatomic,retain)IBOutlet UITextField *currencytextfield;
@property(nonatomic,retain)IBOutlet UITableView *departmentTableView;
@property(nonatomic,retain)NSMutableArray *deptArray;
@property(nonatomic,retain)NSMutableArray *deptIDArray;
@property(nonatomic,retain)NSMutableArray *deptSequenceArray;
@property (retain, nonatomic) IBOutlet UITextField *subtitletext;
@property(nonatomic,retain)NSIndexPath *inPath;
@property(nonatomic,retain)NSMutableArray *selectedDeptArray;
@property(nonatomic,retain)IBOutlet UIButton *deptEditButton;
@property(nonatomic,assign)int deptEditFlag;
@property(nonatomic,assign)int i;
@property(nonatomic,retain)IBOutlet UITableView *categoryTableView;
@property(nonatomic,retain)NSMutableArray *categoryArray;
@property(nonatomic,retain)NSMutableArray *categoryIDArray;
@property(nonatomic,retain)NSMutableArray *categorySequenceArray;
@property(nonatomic,retain)NSIndexPath *inPath1;
@property(nonatomic,retain)NSMutableArray *selectedCategryArray;
@property(nonatomic,retain)IBOutlet UIButton *catEditButton;
@property(nonatomic,assign)int catEditFlag;
@property(nonatomic,assign)int j;
@property(nonatomic,assign)int x1;
@property(nonatomic,retain)NSMutableArray *selectedarray;
@property(nonatomic,retain)NSIndexPath  *deleletepath;
@property(nonatomic,retain)IBOutlet UIView *departmentcategorydeletealertview;

@property (retain, nonatomic) IBOutlet UITableView *countrytable;
@property (retain, nonatomic) IBOutlet UITableView *statetable;
@property (retain, nonatomic) IBOutlet UITableView *citytable;
@property (retain, nonatomic) IBOutlet UITableView *sectotable;
@property (retain, nonatomic) IBOutlet UITableView *currencytable;

//functiondeclarations


-(IBAction)cancel:(id)sender;
-(IBAction)addnewbank:(id)sender;
-(IBAction)deptBeginEdit:(id)sender;
-(IBAction)deptEndEdit:(id)sender;
-(IBAction)deleteDept:(id)sender;
-(IBAction)deptEditAction:(id)sender;
-(IBAction)cancelfor_deletepopup:(id)sender;
-(IBAction)donefor_deletepopup:(id)sender;
-(IBAction)addnewprinter:(id)sender;
-(IBAction)addotherdetailsaction:(id)sender;
-(IBAction)donebuttonaction:(id)sender;
-(IBAction)textfieldendinginaction2:(id)sender;
-(IBAction)otherdetailsclosebuttonaction:(id)sender;
-(IBAction)categoryEditAction:(id)sender;
-(IBAction)deleteCat:(id)sender;
-(IBAction)categoryBeginEdit:(id)sender;
-(IBAction)categoryEndEdit:(id)sender;


@property(nonatomic,assign)int filteredFlag;
@property(nonatomic,assign)int filteredFlag1;
@property(nonatomic,assign)int filteredFlag2;
@property(nonatomic,assign)int otherflag;


@property(nonatomic,assign)int fordeletedepartflag;

@property(nonatomic,assign)int otherdteialsdeleteflag;

@property(nonatomic,retain)NSMutableArray *fileteredArray;
@property(nonatomic,retain)NSMutableArray *fileteredArraystate;
@property(nonatomic,retain)NSMutableArray *fileteredArraycity;


@property(nonatomic,assign)int bankflag;
@property(nonatomic,assign)int printerflag;
@property(nonatomic,retain)NSMutableArray *send_selectedbankarray;
@property(nonatomic,retain)NSMutableArray *send_selectedprinterarray;
@property(nonatomic,retain)NSMutableArray *send_otherdetailsarray;

@property (retain, nonatomic) NSIndexPath *fordeletecategoryindex;

@property (retain, nonatomic) NSIndexPath *globalindex;
@property (retain, nonatomic) NSIndexPath *globalindex1;

-(void)deptAutocodeSequencing:(int)ab;
-(void)catAutocodeSequencing:(int)ab;
@property(nonatomic,assign)int errorFlag;

@property(nonatomic,retain) IBOutlet UILabel *popupLabel;
@property(nonatomic,retain) IBOutlet UITextField *popupDropdownText;
@property(nonatomic,retain) IBOutlet UITableView *popupDropdownTC;
@property(nonatomic,retain)NSMutableArray *popupDropdownContentArray;
@property(nonatomic,retain)NSMutableArray *popupDropdownIDArray;
@property(nonatomic,assign)int moveFlag;
@property(nonatomic,retain)NSString *moveID;
@property(nonatomic,assign)int alertFlag;

@end
