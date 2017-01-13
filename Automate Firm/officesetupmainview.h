//
//  officesetupmainview.h
//  Automate Firm
//
//  Created by leonine on 05/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"

@interface officesetupmainview : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,headerprotocol>
{
    AppDelegate *app;
}

//for property declarations
@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UICollectionView *officesetupcollectionview;
@property(nonatomic,retain)NSMutableArray *iconsarray;
@property(nonatomic,retain)NSMutableArray *iconnamesarray;
@property (weak, nonatomic) IBOutlet UITableView *officesetupcontainstableview;
@property(nonatomic,retain)NSMutableDictionary *onlinestoredictionary;
@property (weak, nonatomic) IBOutlet UIView *officesetupsettingscontainsview;
@property(nonatomic,retain)IBOutlet UIImageView *logoimgview;
@property (weak, nonatomic) IBOutlet UILabel *ofcnamelabel;
@property (weak, nonatomic) IBOutlet UILabel *oficesector;
@property (weak, nonatomic) IBOutlet UILabel *oficefinancialyear;
@property (weak, nonatomic) IBOutlet UILabel *oficeregid;
@property (weak, nonatomic) IBOutlet UILabel *curency;
@property(nonatomic,retain)NSMutableArray *departmentary;
@property(nonatomic,retain)NSMutableArray *categoryaray;

//functiondeclarations

-(IBAction)updationofcreatedoffice:(id)sender;
-(IBAction)uploadimagepickeraction:(id)sender;
-(void)getofficefunction;
@end
