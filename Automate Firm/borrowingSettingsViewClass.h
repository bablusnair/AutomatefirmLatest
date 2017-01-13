//
//  borrowingSettingsViewClass.h
//  Automate Firm
//
//  Created by leonine on 11/7/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"

@interface borrowingSettingsViewClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,headerprotocol>
@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)NSMutableArray *borrowingLabel;
@property(nonatomic,retain)NSMutableArray *borrowingImage;
@property(nonatomic,retain)IBOutlet UITableView *mytableview;
@property(nonatomic,retain)IBOutlet UIView *borrowingContainsView;
@property(nonatomic,retain)IBOutlet UIButton *createNewRuleButton;
-(IBAction)createRuleButtonAction:(id)sender;
@property(nonatomic,assign) int selectedFlag;
@property(nonatomic,retain)NSMutableArray *loanarray;
@property(nonatomic,retain)NSMutableArray *loanidarray;
@property(nonatomic,retain)NSMutableArray *advancearray;
@property(nonatomic,retain)NSMutableArray *finearray;
@property(nonatomic,retain)NSMutableArray *fineIdarray;

@property(nonatomic,retain)NSMutableArray *expenseArray;
@property(nonatomic,retain)NSMutableArray *expenseIDArray;
@property(nonatomic,retain) NSIndexPath *k;
@property(nonatomic,retain) NSString *dateString;







@end
