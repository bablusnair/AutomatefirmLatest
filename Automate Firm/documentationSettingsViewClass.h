//
//  documentationSettingsViewClass.h
//  Automate Firm
//
//  Created by leonine on 11/20/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "headerprotocol.h"
@interface documentationSettingsViewClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,headerprotocol>
@property(nonatomic,retain)connectionclass *myconnection;

@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)IBOutlet UIView *documentsContainsView;
@property(nonatomic,retain)NSMutableArray *documentationIconLabel;
@property(nonatomic,retain)NSMutableArray *documentationIcon;
@property(nonatomic,retain)NSMutableArray *documentationSelectedIcon;
@property(nonatomic,retain)NSMutableArray *selectedArray;
@property(nonatomic,retain)NSIndexPath *k;
@property(nonatomic,assign) int selectedFlag;
@property(nonatomic,assign) int firstTimeFlag;
@property(nonatomic,retain)IBOutlet UITableView *mytableview;

@property(nonatomic,retain)NSMutableArray *customRuleArray;
@property(nonatomic,retain)NSMutableArray *customRuleIDArray;
@property(nonatomic,retain)NSMutableArray *leaveArray;
@property(nonatomic,retain)NSMutableArray *leavesIDArray;
@property(nonatomic,retain)NSMutableArray *advanceArray;
@property(nonatomic,retain)NSMutableArray *loanArray;
@property(nonatomic,retain)NSMutableArray *loanidarray;
@property(nonatomic,retain)NSMutableArray *fineArray;
@property(nonatomic,retain)NSMutableArray *fineIDArray;
@property(nonatomic,retain)NSMutableArray *expenseArray;
@property(nonatomic,retain)NSMutableArray *expenseIDArray;
@property(nonatomic,retain)NSMutableArray *performanceArray;
@property(nonatomic,retain)NSMutableArray *promotionArray;
@property(nonatomic,retain)NSMutableArray *terminationArray;
@property(nonatomic,retain)NSMutableArray *retirementArray;

@property(nonatomic,retain)IBOutlet UIButton *addNewButton;
-(IBAction)createAction:(id)sender;

@property(nonatomic,retain)NSString *dateString;


@end
