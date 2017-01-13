//
//  generalDocumentsViewClass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 27/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"

@interface generalDocumentsViewClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,headerprotocol>
-(IBAction)doneButton:(id)sender;
-(IBAction)cancelButton:(id)sender;
@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *activeField;//Textfield for keyboard scrolling

@property(nonatomic,retain)IBOutlet UICollectionView *documentCollectionView;
@property(nonatomic,retain)NSMutableArray *documentNameArray;
-(IBAction)readAccess:(id)sender;
-(IBAction)writeAccess:(id)sender;
@property(nonatomic,assign)int readFlag;
@property(nonatomic,assign)int writeFlag;
@property(nonatomic,assign)NSIndexPath * inpath;

@property(nonatomic,retain)NSMutableArray *canViewArray;
@property(nonatomic,retain)NSMutableArray *canEditArray;
@property(nonatomic,retain)NSMutableArray *sendArray;
@property(nonatomic,retain)NSMutableArray *cellIdAray;

@property(nonatomic,retain)NSMutableArray *newcanViewArray;
@property(nonatomic,retain)NSMutableArray *newcanEditArray;
@property(nonatomic,retain)NSMutableArray *newdocumentNameArray;
@property(nonatomic,retain)NSMutableArray *newcellIdAray;

@property(nonatomic,retain)NSMutableArray *existingDocDictAray;
@property(nonatomic,assign)int inserFlag;

-(IBAction)deleteDocuments:(id)sender;

@end
