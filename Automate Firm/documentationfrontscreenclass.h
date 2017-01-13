//
//  documentationfrontscreenclass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 17/08/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"
#import "commonFunctionsCallClass.h"
@interface documentationfrontscreenclass : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,headerprotocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)NSArray *myarray;
@property (retain, nonatomic)IBOutlet UITableView *tableView;

@property(nonatomic,retain)commonFunctionsCallClass *obj;
-(IBAction)adddnewsession:(id)sender;


@property(nonatomic,retain)NSMutableDictionary *maindict;

@property(nonatomic,retain)NSMutableArray *dictarray1;
@property(nonatomic,retain)NSMutableArray *dictarray2;
@property(nonatomic,retain)NSMutableArray *dictarray3;
@property(nonatomic,retain)NSMutableArray *dictarray4;
@property(nonatomic,retain)NSMutableArray *dictarray5;
@property(nonatomic,retain)NSMutableArray *dictarray6;
@property(nonatomic,retain)NSMutableArray *dictarray7;
@property(nonatomic,retain)NSMutableArray *dictarray8;


@property (retain, nonatomic)UITextField *sectionTitleTF1;

@property (retain, nonatomic)IBOutlet UIView *moveView;

@property (retain, nonatomic)IBOutlet UITableView *movetableview;

-(IBAction)folderbuttonaction:(id)sender;
@property(nonatomic,assign)int y;
@property(nonatomic,assign)int y1;
@property (retain, nonatomic)IBOutlet UICollectionView *mycollectionview;

@property (retain, nonatomic)IBOutlet UIView *folderslistview;


-(IBAction)uploadaction:(id)sender;

-(IBAction)closebutton:(id)sender;

@property (retain, nonatomic)IBOutlet UIButton *movebutton;
@property (retain, nonatomic)IBOutlet UIButton *copybutton;
@property (retain, nonatomic)IBOutlet UIButton *uploadbutton;

@property (retain, nonatomic) NSMutableArray *selectedarray;

@property (retain, nonatomic)IBOutlet UIButton *folderbutton;
@property (retain, nonatomic)IBOutlet UIButton *printbutton;
@property (retain, nonatomic)IBOutlet UIButton *emailbutton;
@property (retain, nonatomic)IBOutlet UIButton *deselectallbutton;
@property (retain, nonatomic)IBOutlet UIButton *signaturebutton;
@property (retain, nonatomic)IBOutlet UIButton *deletebutton;

-(IBAction)deselectallbutton:(id)sender;

@property (retain, nonatomic)NSMutableDictionary *documentdict;

@property (retain, nonatomic)NSMutableDictionary *foldernamesdict;

@property (retain, nonatomic)NSString *Folderstring;
@property(nonatomic,retain)AppDelegate *app;
@property (retain, nonatomic)NSMutableDictionary *saveingDictionary;
@property(nonatomic,assign)CGRect frame1;
@property(nonatomic,assign)int folderFlag;
@property(nonatomic,assign)int actionFlag;
@property(nonatomic,retain)NSMutableDictionary *documentDictionary;
@property(nonatomic,retain)NSIndexPath *inPath;
@property(nonatomic,retain)NSMutableArray *storeviewsarray;

@property(nonatomic,retain)NSMutableArray *CustomFolderarray;


-(IBAction)rename:(id)sender;
@property (retain,nonatomic)IBOutlet UIView *renameView;
@property(nonatomic,retain) IBOutlet UITextField *renameTextField;
@property(nonatomic,retain)IBOutlet UILabel *renameExistAlertlabel;
@property(nonatomic,retain)IBOutlet UIImageView *convertImage;
@property(nonatomic,retain)IBOutlet UIButton *renameDoneButton;
-(IBAction)renameDoneButtonAction:(id)sender;
-(IBAction)renameAlertViewAction:(id)sender;
-(IBAction)renameCloseAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *renameButton;
@property(nonatomic,retain)IBOutlet UIButton *makeCopyButton;
@property(nonatomic,retain)IBOutlet UIButton *cancelButton;
@property(nonatomic,retain)NSMutableArray *customfoldernamesarray;

@property(nonatomic,retain)NSString *actionstring;

@property(nonatomic,assign)int filterflag;
-(IBAction)filterbuttonaction:(id)sender;
@property(nonatomic,retain)IBOutlet UIView *filterviews;

-(IBAction)donebuttonaction:(id)sender;


@property (retain, nonatomic)IBOutlet UIButton *workingpremisebutton;
@property (retain, nonatomic)IBOutlet UIButton *departmentbutton;
@property (retain, nonatomic)IBOutlet UIButton *categorybutton;
@property (retain, nonatomic)IBOutlet UIButton *designationbutton;


@property(nonatomic,retain)NSMutableArray *selectedarray1;
@property(nonatomic,retain)NSMutableArray *selectedarray2;
@property(nonatomic,retain)NSMutableArray *selectedarray3;
@property(nonatomic,retain)NSMutableArray *selectedarray4;


@property(nonatomic,retain)NSMutableArray *officearray;
@property(nonatomic,retain)NSMutableArray *departmentarray;
@property(nonatomic,retain)NSMutableArray *categoryarray;
@property(nonatomic,retain)NSMutableArray *designationarray;


@property (strong, nonatomic) NSMutableDictionary *officefilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *storefilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *departmentfilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *categoryfilterdictionary;
@property (strong, nonatomic) NSMutableDictionary *designationfilterdictionary;


@property(nonatomic,retain)NSMutableArray *office_servicesendarray;
@property(nonatomic,retain)NSMutableArray *store_servicesendarray;
@property(nonatomic,retain)NSMutableArray *department_servicesendarray;
@property(nonatomic,retain)NSMutableArray *category_servicesendarray;
@property(nonatomic,retain)NSMutableArray *designation_servicesendarray;


@property (retain, nonatomic)IBOutlet UITableView *filtertableView1;
@property (retain, nonatomic)IBOutlet UITableView *workingpremisetableview;
@property (retain, nonatomic)IBOutlet UITableView *departmenttableview;
@property (retain, nonatomic)IBOutlet UITableView *categorytableview;

-(IBAction)deletedDocumentsInfrontscreen:(id)sender;

@end
