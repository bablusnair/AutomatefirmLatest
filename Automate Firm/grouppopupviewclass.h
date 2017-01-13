//
//  grouppopupviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 17/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "headerprotocol.h"
#import "AppDelegate.h"
@interface grouppopupviewclass : UIView<headerprotocol,UICollectionViewDataSource,UICollectionViewDelegate,headerprotocol,UITextFieldDelegate>

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


//-(void)service;
-(IBAction)officeButtonAction:(id)sender;
@end
