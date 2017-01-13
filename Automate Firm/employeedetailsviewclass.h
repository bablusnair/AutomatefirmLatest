//
//  employeedetailsviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/9/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newearningscellclass.h"
#import "connectionclass.h"
@interface employeedetailsviewclass : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,headerprotocol>
@property(nonatomic,retain)connectionclass *myconnection;
@property (strong, nonatomic) IBOutlet UIView *firstScrollView;
@property (strong, nonatomic) IBOutlet UIView *secondScrollView;
@property(nonatomic,retain)IBOutlet UITableView *mainTableView;
@property(nonatomic,retain)NSMutableDictionary *detailsDict;
-(void)displayDetails;

@property(nonatomic,retain)IBOutlet UILabel *empNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *empCodeLabel;
@property(nonatomic,retain)IBOutlet UILabel *genderLabel;
@property(nonatomic,retain)IBOutlet UILabel *dobLabel;
@property(nonatomic,retain)IBOutlet UILabel *nationalityLabel;
@property(nonatomic,retain)IBOutlet UILabel *bloodGroupLabel;
@property(nonatomic,retain)IBOutlet UILabel *maritalStatusLabel;
@property(nonatomic,retain)IBOutlet UILabel *dojLabel;
@property(nonatomic,retain)IBOutlet UILabel *workingPremisesLabel;
@property(nonatomic,retain)IBOutlet UILabel *departmentLabel;
@property(nonatomic,retain)IBOutlet UILabel *categoryLabel;
@property(nonatomic,retain)IBOutlet UILabel *designationLabel;
@property(nonatomic,retain)IBOutlet UILabel *empStatusLabel;

@property(nonatomic,retain)NSMutableArray *leaveArray;
@property(nonatomic,retain)NSMutableArray *holidayArray;
@property(nonatomic,retain)NSMutableArray *loanArray;
@property(nonatomic,retain)NSMutableArray *expenseReimbursementArray;

@property(nonatomic,retain)NSString *weekAbbrv;
@property(nonatomic,retain)NSString *weekDescription;
@property(nonatomic,retain)NSString *payAbbrv;
@property(nonatomic,retain)NSString *payDescription;
@property(nonatomic,retain)NSString *shiftAbbrv;
@property(nonatomic,retain)NSString *shiftDescription;
@property(nonatomic,retain)NSString *overtimeAbbrv;
@property(nonatomic,retain)NSString *overtimeDescription;

@end
