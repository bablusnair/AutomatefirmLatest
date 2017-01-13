//
//  advanceGroupClass.h
//  
//
//  Created by leonine on 10/6/15.
//
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"

@interface advanceGroupClass : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,headerprotocol>
{
    AppDelegate *myappde;
}
@property(nonatomic,retain)connectionclass * myconnection;
@property(nonatomic,retain)IBOutlet UITextField *eligibilityText1;
@property(nonatomic,retain)IBOutlet UITextField *eligibilityText2;
@property(nonatomic,retain)IBOutlet UITextField *eligibilityText3;
@property(nonatomic,retain)IBOutlet UITextField *eligibilityText4;
@property(nonatomic,retain)IBOutlet UITextField *eligibilityText5;
@property(nonatomic,retain)IBOutlet UITextField *conditionsText1;
@property(nonatomic,retain)IBOutlet UITextField *conditionsText2;
@property(nonatomic,retain)IBOutlet UITextField *conditionsText3;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText1;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText2;
@property(nonatomic,retain)IBOutlet UITextField *checkBoxText3;
@property(nonatomic,retain)IBOutlet UIButton *checkBoxButton1;
@property(nonatomic,retain)IBOutlet UIButton *checkBoxButton2;
@property(nonatomic,retain)IBOutlet UIButton *checkBoxButton3;
@property(nonatomic,retain)IBOutlet UITableView *exceptLeaveTableView;
@property(nonatomic,retain)IBOutlet UITableView *istallmentLimitTableView;
@property(nonatomic,retain)IBOutlet UIView *leaveView;
-(IBAction)leaveDoneButtonAction:(id)sender;
-(IBAction)includeDesignationButtonAction:(id)sender;

@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)NSMutableArray *grouparray;
@property(nonatomic,retain)NSIndexPath *indexpath;

-(IBAction)checkBoxAction1:(id)sender;
-(IBAction)checkBoxAction2:(id)sender;
-(IBAction)checkBoxAction3:(id)sender;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;
@property(nonatomic,assign)int z;
@property(nonatomic,assign)int flag;
@property(nonatomic,assign)int selectedflag;
@property(nonatomic,retain)NSMutableArray *leaveArray;
@property(nonatomic,retain)NSMutableArray *selectedArray;
@property(nonatomic,retain)NSMutableArray *limitArray;
-(IBAction)saveButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;
@property(nonatomic,retain)IBOutlet UIButton *saveButton;
-(IBAction)valueChangedAction:(id)sender;

@property(nonatomic,retain)IBOutlet UIButton *switchButton;
-(IBAction)switchButtonAction:(id)sender;
@property(nonatomic,assign) int s1;
@property(nonatomic,retain)NSString *radioString1;
@property(nonatomic,retain)NSString *radioString2;
@property(nonatomic,retain)NSString *radioString3;
@property(nonatomic,retain)NSString *strId;
@property(nonatomic,retain)NSString *text1;
@property(nonatomic,retain)NSString *text2;
@property(nonatomic,retain)NSString *text3;
@property(nonatomic,retain)NSString *text4;
@property(nonatomic,retain)NSString *text5;
@property(nonatomic,retain)NSString *text6;
@property(nonatomic,retain)NSString *enableStaus;
@property(nonatomic,retain)NSString *selectedDesignation;








-(void)collectionViewReload:(NSMutableArray *)desigArray;
-(void)viewloadfunction;
@end
