//
//  expenseSettingsInnerViewClass.h
//  Automate Firm
//
//  Created by leonine on 11/24/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "connectionclass.h"
#import "headerprotocol.h"
@interface expenseSettingsInnerViewClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,headerprotocol>
{
    AppDelegate *app;
}
@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UICollectionView *categoryCollectionView;
@property(nonatomic,retain)NSMutableArray *categoryArray;
@property(nonatomic,retain)NSMutableArray *limitArray;
@property(nonatomic,assign)int x;

-(IBAction)includeDesignationButtonAction:(id)sender;
-(IBAction)doneButtonAction:(id)sender;
-(IBAction)switchButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *switchButton;
@property(nonatomic,retain)IBOutlet UIButton *saveButton;

@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)NSMutableArray *grouparray;
@property(nonatomic,retain)NSIndexPath *indexpath;
-(void)collectionViewReload:(NSMutableArray *)desigArray;

@property(nonatomic,retain)NSIndexPath *inPath;

@property(nonatomic,retain)IBOutlet UITableView *dropTableView;
@property(nonatomic,retain)NSMutableArray *dropArray;

@property(nonatomic,assign)int flagValue;
@property(nonatomic,assign)int s1;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
-(void)saveAction;
-(void)updateAction;

@property (weak, nonatomic) UITextField *activeField;
@end
