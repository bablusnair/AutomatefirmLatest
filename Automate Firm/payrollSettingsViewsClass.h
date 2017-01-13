//
//  payrollSettingsViewsClass.h
//  Automate Firm
//
//  Created by leonine on 12/2/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"

@interface payrollSettingsViewsClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,headerprotocol>
{
    AppDelegate *app;

}
@property(nonatomic,retain)connectionclass *myconnection;

@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)IBOutlet UITableView *mytableview;
@property(nonatomic,retain)IBOutlet UIView *payrollContainsView;

@property(nonatomic,retain)NSMutableArray *payrollLabel;
@property(nonatomic,retain)NSMutableArray *payrollImage;


@property(nonatomic,retain)NSMutableArray *overtimeArray;
@property(nonatomic,retain)NSMutableArray *overtimeIDArray;
@property(nonatomic,retain)NSMutableArray *payArray;
@property(nonatomic,retain)NSMutableArray *payIdArray;

@property(nonatomic,retain)NSMutableArray *earningsArray;
@property(nonatomic,retain)NSMutableArray *earningsIdArray;

@property(nonatomic,retain)NSMutableArray *DeductionsArray;
@property(nonatomic,retain)NSMutableArray *DeductionsIdArray;
@property(nonatomic,retain)NSMutableArray *DeductionsDescArray;
@property(nonatomic,retain)NSMutableArray *deductDteArray;




@property(nonatomic,retain)NSIndexPath *k;
@property(nonatomic,assign)int selectedFlag;

-(IBAction)createNewRuleAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *createRuleButton;
@end
