//
//  myprofileadminViewcontroller.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 19/01/2017.
//  Copyright © 2017 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerController.h"
@interface myprofileadminViewcontroller : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,ELCImagePickerControllerDelegate>
@property(nonatomic,retain)IBOutlet UIView *addnewPaymentmethodview;
-(IBAction)donebutton:(id)sender;
-(IBAction)cancelbutton:(id)sender;
-(IBAction)addnewpaymentMethod:(id)sender;
@property(nonatomic,retain)IBOutlet UITableView *paymentHistroytable;
@property(nonatomic,retain)IBOutlet UITableView *cartHistroytable;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *activeField;
@property (weak, nonatomic) IBOutlet UIDatePicker *estDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *estmatedDatetext;
@property (weak, nonatomic) IBOutlet UIDatePicker *dobPicker;
@property (weak, nonatomic) IBOutlet UITextField *dobtext;
@property(nonatomic,retain)IBOutlet UITableView *paymentMethodtableview;
@property(nonatomic,retain)NSMutableArray *imagearray;
@property(nonatomic,retain)IBOutlet UICollectionView *broswecollectionview;
@property(nonatomic,retain)NSIndexPath *myindexpath;
-(IBAction)browseaction:(id)sender;
-(IBAction)browseimagecloseaction:(id)sender;
@property(nonatomic,retain)NSIndexPath *preindexpath;
@end
