//
//  addnewemployee2Class.h
//  bablusdemokpproject
//
//  Created by leonine on 8/19/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "headerprotocol.h"
#import "connectionclass.h"
#import "AppDelegate.h"
@interface addnewemployee2Class : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,headerprotocol>
{
    AppDelegate *app;
}
-(IBAction)saveButtonAction:(id)sender;
-(IBAction)clearButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;
@property(nonatomic,retain)connectionclass *connection;//ConnectionClass Object

@property(nonatomic,retain)IBOutlet UITextField *companyTelephoneText;
@property(nonatomic,retain)IBOutlet UITextField *extText;
@property(nonatomic,retain)IBOutlet UITextField *companyMobileText;
@property(nonatomic,retain)IBOutlet UITextField *personalMobileText;
@property(nonatomic,retain)IBOutlet UITextField *personalEmailText;
@property(nonatomic,retain)IBOutlet UITextField *companyEmailText;
@property(nonatomic,retain)IBOutlet UITextField *nomineeNameText;
@property(nonatomic,retain)IBOutlet UITextField *nomineeContactText;
@property(nonatomic,retain)IBOutlet UITextField *nomineeRelationshipText;
@property(nonatomic,retain)IBOutlet UITextField *localBlockText;
@property(nonatomic,retain)IBOutlet UITextField *localStreetText;
@property(nonatomic,retain)IBOutlet UITextField *localBuildingText;
@property(nonatomic,retain)IBOutlet UITextField *localFlatText;
@property(nonatomic,retain)IBOutlet UITextField *localCityText;
@property(nonatomic,retain)IBOutlet UITextField *localPostcodeText;
@property(nonatomic,retain)IBOutlet UITextField *homeBlockText;
@property(nonatomic,retain)IBOutlet UITextField *homeStreetText;
@property(nonatomic,retain)IBOutlet UITextField *homeBuildingText;
@property(nonatomic,retain)IBOutlet UITextField *homeFlatText;
@property(nonatomic,retain)IBOutlet UITextField *homeCityText;
@property(nonatomic,retain)IBOutlet UITextField *homePostcodeText;
@property(nonatomic,retain)IBOutlet UITextField *homeCountryText;
@property(nonatomic,retain)IBOutlet UITextField *homeStateText;

@property(nonatomic,retain)IBOutlet UITableView *relationshipTableView;
@property(nonatomic,retain)IBOutlet UITableView *localCityTableView;
@property(nonatomic,retain)IBOutlet UITableView *homeCountryTableView;
@property(nonatomic,retain)IBOutlet UITableView *homeStateTableView;
@property(nonatomic,retain)IBOutlet UITableView *homeCityTableView;

@property(nonatomic,retain)NSMutableArray *relationshipArray;
@property(nonatomic,retain)NSMutableArray *localCityArray;
@property(nonatomic,retain)NSMutableArray *homeCountryArray;
@property(nonatomic,retain)NSMutableArray *homeStateArray;
@property(nonatomic,retain)NSMutableArray *homeCityArray;
@property(nonatomic,retain)NSMutableArray *countryFilteredArray;
@property(nonatomic,retain)NSMutableArray *stateFilterdArray;
@property(nonatomic,retain)NSMutableArray *cityFilteredArray;
@property(nonatomic,retain)NSMutableArray *localCityFilteredArray;

@property(nonatomic,retain)NSMutableDictionary *countryDict;
@property(nonatomic,retain)NSMutableDictionary *stateDict;
@property(nonatomic,retain)NSMutableDictionary *cityDict;
@property(nonatomic,retain)NSMutableDictionary *localCityDict;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;

@property(nonatomic,assign)int x;
@property(nonatomic,assign) int y;
@property(nonatomic,assign) int z;
@property(nonatomic,assign) int p;
@property(nonatomic,assign) int q;
@property(nonatomic,assign) int r;

-(BOOL)validateEmail:(NSString *)emailStr;
@property(nonatomic,retain)NSString *localCityID;
@property(nonatomic,retain)NSString *homeCountryID;
@property(nonatomic,retain)NSString *homeStateID;
@property(nonatomic,retain)NSString *homeCityID;
@property(nonatomic,retain)NSString *cityAddressFlag;
@property(nonatomic,retain)IBOutlet UILabel *plusLabel1;
@property(nonatomic,retain)IBOutlet UILabel *plusLabel2;
@property(nonatomic,retain)IBOutlet UITextField *codeText1;
@property(nonatomic,retain)IBOutlet UITextField *codeText2;

-(void)fillDetails:(NSMutableDictionary *)detailsDict;
@property(nonatomic,retain)NSMutableDictionary *detailsDict;
@property(nonatomic,retain)NSString *empID;
@property(nonatomic,retain)NSString *empCode;


@end
