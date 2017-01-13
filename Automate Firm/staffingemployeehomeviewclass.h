//
//  staffingemployeehomeviewclass.h
//  Automate Firm
//
//  Created by leonine on 03/09/15.
//  Copyright (c) 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "headerprotocol.h"
#import "connectionclass.h"
@interface staffingemployeehomeviewclass : UIView<UITableViewDataSource,UITableViewDelegate,headerprotocol,UITextFieldDelegate>
@property(nonatomic,retain)NSArray *myarray;
@property (retain, nonatomic)IBOutlet UITableView *tableView;
@property (retain, nonatomic)IBOutlet UIView *filterview;

@property (retain, nonatomic)IBOutlet UITableView *filtertableView1;
@property (retain, nonatomic)IBOutlet UITableView *workingpremisetableview;
@property (retain, nonatomic)IBOutlet UITableView *departmenttableview;
@property (retain, nonatomic)IBOutlet UITableView *categorytableview;

@property (retain, nonatomic)IBOutlet UITableView *presentabsenttableview;

-(IBAction)actionbuttonforfilter:(id)sender;
-(IBAction)donebuttonaction:(id)sender;
@property(nonatomic,assign)int flagvalue;

@property (retain, nonatomic)IBOutlet UIButton *workingpremisebutton;
@property (retain, nonatomic)IBOutlet UIButton *departmentbutton;
@property (retain, nonatomic)IBOutlet UIButton *categorybutton;
@property (retain, nonatomic)IBOutlet UIButton *designationbutton;

@property(nonatomic,retain)NSMutableArray *selectedarray;
@property(nonatomic,retain)NSMutableArray *selectedarray2;
@property(nonatomic,retain)NSMutableArray *selectedarray3;
@property(nonatomic,retain)NSMutableArray *selectedarray4;


@property(nonatomic,retain)NSMutableArray *officearray;
@property(nonatomic,retain)NSMutableArray *departmentarray;
@property(nonatomic,retain)NSMutableArray *categoryarray;
@property(nonatomic,retain)NSMutableArray *designationarray;


@property (retain, nonatomic)connectionclass *myconnection;

@property(nonatomic,retain)NSMutableDictionary *maincreativedictionary;
@property(nonatomic,retain)NSMutableDictionary *subcreativedictionary;
@property(nonatomic,retain)NSMutableDictionary *storesubcreativedictionary;
@property (strong, nonatomic) NSMutableDictionary *filterdict;


@property (strong, nonatomic) NSMutableDictionary *officefilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *storefilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *departmentfilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *categoryfilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *designationfilterdictionary;


@property(nonatomic,retain)NSMutableArray *statusarray;
@property(nonatomic,retain)NSMutableArray *statusimagearray;
@property(nonatomic,retain)IBOutlet UIView *presentfilterview;

@property(nonatomic,retain)NSMutableArray *office_servicesendarray;
@property(nonatomic,retain)NSMutableArray *store_servicesendarray;
@property(nonatomic,retain)NSMutableArray *department_servicesendarray;
@property(nonatomic,retain)NSMutableArray *category_servicesendarray;
@property(nonatomic,retain)NSMutableArray *designation_servicesendarray;


@end
