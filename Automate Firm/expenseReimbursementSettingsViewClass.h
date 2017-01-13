//
//  expenseReimbursementSettingsViewClass.h
//  Automate Firm
//
//  Created by leonine on 11/24/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "expenseTile.h"
#import "AppDelegate.h"
#import "connectionclass.h"
#import "headerprotocol.h"
@interface expenseReimbursementSettingsViewClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,headerprotocol>
{
    expenseTile *accordion;
    AppDelegate *app;
}
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;

@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UICollectionView *expenseCollectionView;
@property(nonatomic,retain)NSMutableArray *expenseArray;
@property(nonatomic,retain)IBOutlet UIButton *addNewButton;
-(IBAction)addNewExpense:(id)sender;
-(IBAction)textfieldShouldEndEditing:(id)sender;
-(IBAction)textfieldShouldBeginEditing:(id)sender;
-(IBAction) deleteCell:(id)sender;
-(IBAction)saveAction:(id)sender;
-(IBAction)cancelAction:(id)sender;
@property(nonatomic,retain)NSIndexPath *inPath;
-(void)enable;
-(void)disable;
-(void)alertAction:(NSString *)alertMessage;

@property(nonatomic,assign)int addNewFlag;

@property(nonatomic,retain)IBOutlet UITextField *expenseNameText;
@property(nonatomic,retain)IBOutlet UITextField *abbrvText;
@property(nonatomic,retain)IBOutlet UITextField *expenseTypeText;
@property(nonatomic,retain)IBOutlet UITextField *descriptionText;
@property(nonatomic,retain)IBOutlet UITableView *expenseTypeTC;
@property(nonatomic,retain)NSMutableArray *expenseTypeArray;
@property(nonatomic,retain)IBOutlet UIButton *addTileButton;
-(IBAction)AddTileAction:(id)sender;

@property(nonatomic,retain)IBOutlet UIButton *saveButton;
@property(nonatomic,retain)IBOutlet UIButton *cancelButton;

@end



