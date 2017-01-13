//
//  addnewbankclass.h
//  Automate Firm
//
//  Created by leonine on 05/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addnewbankclass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *bankcollectionview;
-(IBAction)donebuttonaction:(id)sender;
@property(nonatomic,retain)NSMutableArray *selectedarray;

@property(nonatomic,retain)NSMutableArray *bankarray;
@property(nonatomic,retain)NSMutableArray *bankidarray;
@property(nonatomic,retain)NSMutableDictionary *myoficeDictionary;


@property(nonatomic,retain)NSMutableArray *brancharray;
@property(nonatomic,strong)NSIndexPath *myindex2;
@property(nonatomic,retain)NSString *wpsstring;

@property(nonatomic,retain)NSMutableDictionary *wpscodedictionary;
@property(nonatomic,retain)NSIndexPath *inPath;
@end
