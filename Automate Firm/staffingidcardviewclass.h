//
//  staffingidcardviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 24/06/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
@interface staffingidcardviewclass : UIView<UITableViewDataSource,UITableViewDelegate,headerprotocol>
@property (weak, nonatomic)IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSArray *myarray;
@property (retain, nonatomic)connectionclass *myconnection;
@property (retain, nonatomic) NSMutableDictionary *maincreativedictionary;
@property (strong, nonatomic) NSMutableDictionary *filterdict;
@property(nonatomic,assign)int flagvalue;
@property(nonatomic,retain)IBOutlet UITextField *searchfield;
@property(nonatomic,retain)IBOutlet UIView *filterview;
-(IBAction)filterbuttonaction:(id)sender;
@property(nonatomic,assign)int x;
-(IBAction)filterdonebuttonaction:(id)sender;

@property (retain, nonatomic)IBOutlet UITableView *filtertableView1;
@property (retain, nonatomic)IBOutlet UITableView *workingpremisetableview;
@property (retain, nonatomic)IBOutlet UITableView *departmenttableview;
@property (retain, nonatomic)IBOutlet UITableView *categorytableview;


@property (retain, nonatomic)IBOutlet UIButton *workingpremisebutton;
@property (retain, nonatomic)IBOutlet UIButton *departmentbutton;
@property (retain, nonatomic)IBOutlet UIButton *categorybutton;
@property (retain, nonatomic)IBOutlet UIButton *designationbutton;

@property(nonatomic,retain)NSMutableArray *selectedarray;
@property(nonatomic,retain)NSMutableArray *selectedarray2;
@property(nonatomic,retain)NSMutableArray *selectedarray3;
@property(nonatomic,retain)NSMutableArray *selectedarray4;

@property (strong, nonatomic) NSMutableDictionary *officefilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *storefilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *departmentfilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *categoryfilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *designationfilterdictionary;



@property(nonatomic,retain)NSMutableArray *officearray;
@property(nonatomic,retain)NSMutableArray *departmentarray;
@property(nonatomic,retain)NSMutableArray *categoryarray;
@property(nonatomic,retain)NSMutableArray *designationarray;

-(IBAction)actionbuttonforfilter:(id)sender;

@property(nonatomic,retain)NSMutableArray *office_servicesendarray;
@property(nonatomic,retain)NSMutableArray *store_servicesendarray;
@property(nonatomic,retain)NSMutableArray *department_servicesendarray;
@property(nonatomic,retain)NSMutableArray *category_servicesendarray;
@property(nonatomic,retain)NSMutableArray *designation_servicesendarray;
@end

