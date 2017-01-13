//
//  addnewstorebankclass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 11/02/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addnewstorebankclass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *bankcollectionview;
-(IBAction)donebuttonaction:(id)sender;
@property(nonatomic,retain)NSMutableArray *selectedarray;

@property(nonatomic,retain)NSMutableArray *availablebankarray;
@property(nonatomic,retain)NSMutableArray *selectedbankarray;
@property(nonatomic,retain)NSMutableDictionary *myoficeDictionary;


@property(nonatomic,retain)NSMutableArray *brancharray;
@property(nonatomic,strong)NSIndexPath *myindex2;
@property(nonatomic,retain)NSString *wpsstring;

@property(nonatomic,retain)NSMutableDictionary *wpscodedictionary;
@property(nonatomic,retain)NSIndexPath *inPath;

@end
