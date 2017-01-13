//
//  assignToSpecificEmployeeClass.h
//  Automate Firm
//
//  Created by leonine on 11/18/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "connectionclass.h"

@interface assignToSpecificEmployeeClass : UIView<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,headerprotocol>
{
    AppDelegate *app;
}
@property(nonatomic,retain)connectionclass *myconnection;

@property(nonatomic,retain)IBOutlet UITableView *myTableView;
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionView;
@property(nonatomic,retain)IBOutlet UITextField *searchTextField;

@property(nonatomic,retain)NSMutableArray *nameArray;
@property(nonatomic,retain)NSMutableArray *idArray;
@property(nonatomic,retain)NSMutableArray *selectedArray;
@property(nonatomic,retain)NSMutableArray *selectedEmpNameArray;
@property (strong, nonatomic) NSMutableArray *selectedEmployeeIconArray;

@property (strong, nonatomic) NSMutableArray *filterarraycountry;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int flag;

@property(nonatomic,retain)NSString *selectedString;

@property (strong, nonatomic)NSMutableDictionary *maindictionary;
@property (strong, nonatomic)NSMutableDictionary *finalEmpDict;
@property(nonatomic,retain)NSMutableDictionary *empDict;



-(IBAction)deleteSelectedEmployee:(id)sender;
-(IBAction)doneButtonAction:(id)sender;
@end
