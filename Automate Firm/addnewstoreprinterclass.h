//
//  addnewstoreprinterclass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 11/02/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addnewstoreprinterclass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *printercollectionview;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *activeField;

@property(nonatomic,retain)NSMutableArray *prnternamearray;
@property(nonatomic,retain)NSMutableArray *emailarray;
@property(nonatomic,retain)NSMutableArray *rateaarray;

@property(nonatomic,retain)IBOutlet UIButton *doneButton;

@property(nonatomic,retain)IBOutlet UIButton *plusbutton;
-(IBAction)printereditingendaction:(id)sender;
-(IBAction)printereditingendaction1:(id)sender;
-(IBAction)printereditingendaction2:(id)sender;
-(IBAction)plusbuttonaction:(id)sender;


-(IBAction)nameBeginEdit:(id)sender;
-(IBAction)emailBeginEdit:(id)sender;
-(IBAction)domainBeginEdit:(id)sender;

@property(nonatomic,retain)NSIndexPath *myindex2;
-(IBAction)donebuttonaction:(id)sender;

@property(nonatomic,retain)NSMutableArray *selectedarray;
@property(nonatomic,assign)int x;

@property(nonatomic,retain)NSMutableDictionary *myoficeDictionary;

@property(nonatomic,assign)int editFlag;


@end
