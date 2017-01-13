//
//  documentViewClass.h
//  Automate Firm
//
//  Created by leonine on 8/9/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commonFunctionsCallClass.h"
#import "connectionclass.h"
#import "AppDelegate.h"
@class commonFunctionsCallClass;
@interface documentViewClass : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,headerprotocol>

@property(nonatomic,retain)commonFunctionsCallClass *obj;//Creating an instance object of CommonClass
@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)AppDelegate *app;
@property(nonatomic,retain)IBOutlet UICollectionView *documentCollectionView;
@property(nonatomic,retain)NSMutableArray *documentArray;
@property(nonatomic,retain)NSMutableArray *deleteIndexArray;
@property(nonatomic,retain)NSIndexPath *inPath;
-(IBAction)deleteDocument:(id)sender;
-(IBAction)closePopup:(id)sender;
-(IBAction)save:(id)sender;
@property(nonatomic,retain)NSTimer *hideButtonTimer;
@property(nonatomic,assign)int hideFlag;
@property(nonatomic,assign)CGRect cellFrame;
@property(nonatomic,assign)CGAffineTransform centralWobble;
@property(nonatomic,assign)int actionFlag;
@property(nonatomic,assign)CGRect frame1;
@property (weak, nonatomic) IBOutlet UILabel *documentTitle;

@property(nonatomic,retain)NSMutableDictionary *documentDictionary;
@property(nonatomic,retain)NSMutableDictionary *documentIDDictionary;
@property(nonatomic,retain)NSString *replaceString;
@property(nonatomic,assign)int replaceFlag;






@end
