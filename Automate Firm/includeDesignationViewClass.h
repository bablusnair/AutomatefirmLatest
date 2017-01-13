//
//  includeDesignationViewClass.h
//  Automate Firm
//
//  Created by leonine on 3/30/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"

@interface includeDesignationViewClass : UIView<headerprotocol,UICollectionViewDataSource,UICollectionViewDelegate,headerprotocol,UITextFieldDelegate>
{
    AppDelegate *app;
}


@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UICollectionView *designationCollectionView;
@property(nonatomic,retain)IBOutlet UICollectionView *storesCollectionView;

@property(nonatomic,retain)NSMutableArray *designationArray;
@property(nonatomic,retain)NSMutableArray *designationIDArray;
@property(nonatomic,retain)NSMutableArray *storesArray;
@property(nonatomic,retain)NSMutableArray * storesIDArray;
@property(nonatomic,retain)NSMutableArray *selectedarray;
@property(nonatomic,retain)NSMutableArray *highlightArray;
@property(nonatomic,retain)NSMutableArray *selectedDesignationArray;

@property(nonatomic,retain)NSMutableArray *selectedArrays;

@property(nonatomic,retain)NSMutableArray *filteredDesignationArray;

@property(nonatomic,assign)int filteredFlag;

@property(nonatomic,retain)IBOutlet UITextField *searchText;

@property (weak, nonatomic) IBOutlet UILabel *officename;
@property(nonatomic,retain)NSString *officeID;
@property(nonatomic,retain)IBOutlet UIButton *officeButton;

@property(nonatomic,retain)NSString *selectedStore;

@property(nonatomic,retain)NSMutableDictionary *finalDict;
@property(nonatomic,retain)NSMutableDictionary *finalSelectedDict;
@property(nonatomic,retain)NSMutableDictionary *designationDict;

@property(nonatomic,retain)NSString *ruleID;
@property(nonatomic,retain)NSString *tileID;


//-(void)service;
-(IBAction)officeButtonAction:(id)sender;


@end
