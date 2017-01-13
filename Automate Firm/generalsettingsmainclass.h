//
//  generalsettingsmainclass.h
//  Automate Firm
//
//  Created by leonine on 18/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"
@interface generalsettingsmainclass : UIView<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,headerprotocol>

@property(nonatomic,retain)connectionclass *myconnection; //Connection class object
@property(nonatomic,retain)AppDelegate *app;// Appdelegate object
@property (weak, nonatomic) IBOutlet UITableView *generalsettingstableview;
@property(nonatomic,retain)NSMutableArray *generalCurrencyarray;
@property(nonatomic,retain)NSMutableArray *generalbrancharray;
@property(nonatomic,retain)NSMutableArray *generalBranchIDArray;
@property(nonatomic,retain)NSMutableArray *generaldesignationarray;
@property(nonatomic,retain)NSMutableArray *generalDesignationIDArray;
@property(nonatomic,retain)NSMutableArray *dummyDesignationArray;
@property(nonatomic,retain)NSMutableArray *dummyDesignationIDArray;
@property(nonatomic,retain)IBOutlet UICollectionView *generalsettingcollectionview;
@property(nonatomic,retain)NSMutableArray *iconsarray;
@property(nonatomic,retain)NSMutableArray *iconnamesarray;
@property(nonatomic,retain)NSIndexPath *k;
@property(nonatomic,retain)NSIndexPath *k1;
@property (weak, nonatomic) IBOutlet UIView *generalsettingscontainsview;
@property (weak, nonatomic) IBOutlet UIButton *createnewbutton;
-(IBAction)addnewbuttonaction:(id)sender;

@property(nonatomic,retain)NSMutableArray *dummyarray;
@property (assign, nonatomic)int selectedflag;
@property (retain, nonatomic)NSString *imagestring;
@property (retain, nonatomic)NSString *nsindeximagestring;

@property(nonatomic,retain)NSMutableArray *othersArray;
@property(nonatomic,retain)NSMutableArray *othersIconArray;
@property(nonatomic,retain)NSString *dateString;
@property(nonatomic,retain)NSString *portalLastModifiedDate;
@property(nonatomic,retain)NSString *businessTemplateLastModifiedDate;
@property(nonatomic,retain)NSString *autocodeLastModifiedDate;

@property(nonatomic,retain)IBOutlet UIView *designationDeletionPopup;
@property(nonatomic,retain)IBOutlet UITableView *popupTableView;
@property(nonatomic,retain)IBOutlet UITextField *popupSelectionText;
-(IBAction)movePopupAction:(id)sender;
@property(nonatomic,retain)NSString *moveDesignationID;

-(void)savedDesignationsarray:(NSMutableArray *)designationData;
-(void)savedBanksarray:(NSMutableArray *)bankData;
@property(nonatomic,retain)NSIndexPath *inPath;
@end
