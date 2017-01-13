//
//  includeEmployeeClass.h
//  Automate Firm
//
//  Created by leonine on 10/22/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"

@interface includeEmployeeClass : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,headerprotocol>



@property(nonatomic,retain)connectionclass *myconnetion;
@property(nonatomic,retain)AppDelegate *app;
@property(nonatomic,retain)IBOutlet UICollectionView *storesCollectionView;
@property(nonatomic,retain)IBOutlet UICollectionView *employeeCollectionView;
@property(nonatomic,retain)IBOutlet UITableView *filterTableView;
@property(nonatomic,retain)IBOutlet UIView *filterView;
@property(nonatomic,retain)IBOutlet UIView *scrollView;

@property(nonatomic,retain)NSMutableArray *employeeArray;
@property(nonatomic,retain)NSMutableArray *employeeIDArray;
@property(nonatomic,retain)NSMutableArray *employeeImageArray;
@property(nonatomic,retain)NSMutableArray *employeeSelectedArray;
@property(nonatomic,retain)NSMutableArray *storesArray;
@property(nonatomic,retain)NSMutableArray * storesIDArray;
@property(nonatomic,retain)NSMutableArray *selectedStoreArray;
@property(nonatomic,retain)NSMutableArray *filterArray;
@property(nonatomic,retain)NSMutableArray *filterIDArray;
@property(nonatomic,retain)NSMutableArray *selectedDepartmentArray;
@property(nonatomic,retain)NSMutableArray *selectedCategoryArray;
@property(nonatomic,retain)NSMutableArray *selectedDesignationArray;
@property(nonatomic,retain)NSMutableArray *selectedEmployeeArray;



@property(nonatomic,retain)IBOutlet UIButton *selectDeselectButton;
-(IBAction)selectDeselect:(id)sender;
-(IBAction)showAllAction:(id)sender;
-(IBAction)doneButtonAction:(id)sender;
-(IBAction)officeButtonAction:(id)sender;
-(IBAction)filterDoneAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *officename;
@property(nonatomic,retain)NSString *officeID;
@property(nonatomic,retain)IBOutlet UIButton *officeButton;

@property(nonatomic,retain)NSString *selectedStore;
@property(nonatomic,retain)NSString *selectedPremiseID;
@property(nonatomic,retain)NSString *selectedPremiseType;

@property(nonatomic,retain)NSMutableDictionary *finalDict;
@property(nonatomic,retain)NSMutableDictionary *empDict;
@property(nonatomic,retain)NSMutableDictionary *finalSelectedDict;
@property(nonatomic,retain)NSMutableDictionary *filterDictionary;



@property(nonatomic,assign)int filterFlag;
@property(nonatomic,assign)int filterViewFlag;
@property(nonatomic,retain)IBOutlet UITextField *departmentText;
@property(nonatomic,retain)IBOutlet UITextField *categoryText;
@property(nonatomic,retain)IBOutlet UITextField *designationText;

@property(nonatomic,retain)NSString *type;

@end
