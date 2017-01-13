//
//  autocodeTileViewClass.h
//  Automate Firm
//
//  Created by leonine on 7/13/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "headerprotocol.h"
#import "AppDelegate.h"
#import "autocodingTileClass.h"

@interface autocodeTileViewClass : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,headerprotocol>

@property(nonatomic,retain)connectionclass *myconnection;

@property(nonatomic,retain)AppDelegate *app;

@property(nonatomic,retain)IBOutlet UICollectionView *officesetupcollectionview;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic)  UITextField *activeField;


@property(nonatomic,retain) NSMutableArray *iconnamesarray;
@property(nonatomic,retain) NSMutableArray *iconsarray;

@property(nonatomic,retain)IBOutlet UITableView *workingPremiseTC;
@property(nonatomic,retain)NSMutableArray *workingPremiseArray;
@property(nonatomic,retain)NSMutableArray *workingPremiseIDArray;
@property(nonatomic,retain)NSMutableArray *workingPremiseCodeArray;

@property(nonatomic,retain)IBOutlet UITableView *departmentTC;
@property(nonatomic,retain)NSMutableArray *departmentArray;
@property(nonatomic,retain)NSMutableArray *departmentIDArray;
@property(nonatomic,retain)NSMutableArray *departmentCodeArray;

@property(nonatomic,retain)NSMutableArray *allWorkingPremiseArray;

@property(nonatomic,retain)IBOutlet UITableView *categoryTC;
@property(nonatomic,retain)NSMutableArray *categoryArray;
@property(nonatomic,retain)NSMutableArray *categoryIDArray;
@property(nonatomic,retain)NSMutableArray *categoryCodeArray;

-(void)autocodeDone;
-(IBAction)saveAction:(id)sender;
-(IBAction)clearAction:(id)sender;
-(IBAction)clear:(id)sender;
@property(nonatomic,retain)IBOutlet UIView *clearView;

@property(nonatomic,retain)NSIndexPath *inPath;


@property(nonatomic,retain)IBOutlet UIButton *switchButton;
@property(nonatomic,retain)IBOutlet UIButton *clearButton;
@property(nonatomic,retain)IBOutlet UILabel *clearLabel;
-(IBAction)switchButtonAction:(id)sender;
@property(nonatomic,assign)int s1;
@property(nonatomic,retain)NSString *switchButtonstring;
@property(nonatomic,retain)NSString *autocodeID;


@end
