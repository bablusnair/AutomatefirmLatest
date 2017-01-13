//
//  individualstoreview.h
//  Automate Firm
//
//  Created by leonine on 12/01/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"
@interface individualstoreview : UIView<UITableViewDelegate,UITableViewDataSource,headerprotocol>
{
    AppDelegate *app;
}


-(IBAction)cancel:(id)sender;
@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)NSMutableArray *bankarray;
@property(nonatomic,retain)NSMutableArray *outlettypearray;
@property(nonatomic,retain)NSMutableArray *officetypeimagearray;
@property(nonatomic,retain)IBOutlet UITableView *otherdetailstableview;
@property(nonatomic,retain)NSMutableArray *otherdetailsfield1array;
@property(nonatomic,retain)NSMutableArray *otherdetailsfield2array;
@property(nonatomic,retain)NSMutableArray *sectoraray;
@property(nonatomic,retain)NSMutableArray *countryaray;
@property(nonatomic,retain)NSMutableArray *statearay;
@property(nonatomic,retain)NSMutableArray *city;
@property(nonatomic,retain)NSMutableArray *selectedarray;
@property(nonatomic,retain)NSMutableArray *currencyarray;
@property(nonatomic,retain)NSMutableDictionary *countrydict;
@property(nonatomic,retain)NSMutableDictionary *statedict;
@property(nonatomic,retain)NSMutableDictionary *citydict;
@property(nonatomic,retain)NSMutableDictionary *myoficeDictionary;
@property(nonatomic,retain)NSIndexPath *inPath;
@property(nonatomic,retain)NSString *storeid;

@property (retain, nonatomic) NSIndexPath *globalindex;
@property(nonatomic,retain)NSMutableArray *send_otherdetailsarray;




-(IBAction)shipdetailsbuttonaction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *shipingbutton1;
-(IBAction)addotherdetailsaction:(id)sender;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)UITextField *activeField;

@property(nonatomic,retain)IBOutlet UIButton *sameasbutton;
@property(nonatomic,retain)IBOutlet UILabel *sameaslabel;

@property(nonatomic,retain)IBOutlet UITableView *financialyrtableview;

@property(nonatomic,retain)NSMutableArray *finyrarray;

-(IBAction)sameasbillingaction:(id)sender;
@property(nonatomic,retain)IBOutlet UITextField *telephonetextfield;
@property(nonatomic,retain)IBOutlet UITextField *faxtextfield;
@property(nonatomic,retain)IBOutlet UITextField *emailtextfield;
@property(nonatomic,retain)NSIndexPath *k;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int g;
@property(nonatomic,assign)int filteredFlag;
@property(nonatomic,assign)int filteredFlag1;
@property(nonatomic,assign)int filteredFlag2;
@property(nonatomic,assign)int otherdteialsdeleteflag;
@property(nonatomic,retain)NSMutableArray *fileteredArray;
@property(nonatomic,retain)NSMutableArray *fileteredArraystate;
@property(nonatomic,retain)NSMutableArray *fileteredArraycity;
@property(nonatomic,retain)NSString *sendoutletString;




-(IBAction)donebuttonaction:(id)sender;

@property(nonatomic,retain)IBOutlet UITextField *outletnametext;
@property(nonatomic,retain)IBOutlet UITextField *outlettextfield;
@property(nonatomic,retain)IBOutlet UITextField *sectortextfield;
@property(nonatomic,retain)IBOutlet UITextField *abbrvtextfield;
@property(nonatomic,retain)IBOutlet UITextField *finanialtextfield;
@property(nonatomic,retain)IBOutlet UITextField *currencytextfield;
@property (weak, nonatomic) IBOutlet UITextField *buildingtext;
@property (weak, nonatomic) IBOutlet UITextField *streettext;
@property (weak, nonatomic) IBOutlet UITextField *countrytext;
@property (weak, nonatomic) IBOutlet UITextField *statetext;
@property (weak, nonatomic) IBOutlet UITextField *blocktext;
@property (weak, nonatomic) IBOutlet UITextField *postcodetext;
@property (weak, nonatomic) IBOutlet UITextField *citytext;
@property (weak, nonatomic) IBOutlet UITextField *landmarktext;
@property (weak, nonatomic) IBOutlet UITextField *subtitltext;
@property (weak, nonatomic) IBOutlet UITextField *regtext;
@property (weak, nonatomic) IBOutlet UITextField *webtext;


@property(nonatomic,retain)IBOutlet UITableView *outlettypetableview;
@property (weak, nonatomic) IBOutlet UITableView *sectortable;
@property (weak, nonatomic) IBOutlet UITableView *cuurencytable;
@property (weak, nonatomic) IBOutlet UITableView *countrytable;
@property (weak, nonatomic) IBOutlet UITableView *citytable;
@property (weak, nonatomic) IBOutlet UITableView *statetable;
@property(nonatomic,assign)int bankflag;
@property(nonatomic,assign)int printerflag;
@property(nonatomic,retain)NSMutableArray *send_selectedbankarray;
@property(nonatomic,retain)NSMutableArray *send_selectedprinterarray;

-(IBAction)addnewvehile:(id)sender;
-(IBAction)addnewprinter:(id)sender;

@end
