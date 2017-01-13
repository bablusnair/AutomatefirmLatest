//
//  employeeleaveviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/10/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "leavecellclass.h"
#import "ViewController.h"
@interface employeeleaveviewclass : UIView<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,retain)NSMutableArray *numberArray;
@property(nonatomic,retain)NSMutableArray *leaveArray;
@property(nonatomic,retain)NSMutableArray *statusArray;
@property(nonatomic,retain)NSMutableArray *startDateArray;
@property(nonatomic,retain)NSMutableArray *enddateArray;
@property(nonatomic,retain)NSMutableArray *durationArray;
@property(nonatomic,retain)NSMutableArray *rejoiningArray;
@property(nonatomic,retain)NSMutableArray *reasonArray;


@property(nonatomic,retain)IBOutlet UICollectionView *leaveCollectionView;
@property(nonatomic,retain)NSMutableArray *leaveQutoaArray;
@property(nonatomic,retain)NSMutableArray *totalQuotaArray;


@end
