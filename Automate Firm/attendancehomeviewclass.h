//
//  attendancehomeviewclass.h
//  Automate Firm
//
//  Created by leonine on 28/09/15.
//  Copyright (c) 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface attendancehomeviewclass : UIView<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)IBOutlet UITableView *mytableview1;
@property(nonatomic,retain)IBOutlet UITableView *mytableview2;
@property(nonatomic,retain)NSMutableArray *numarray;
@property(nonatomic,retain)NSMutableArray *daysarray;
-(IBAction)closebuttonaction:(id)sender;

-(IBAction)timecardovertime:(id)sender;

@property(nonatomic,assign)int overtimeflag;

@property(nonatomic,assign)int setflag;
@property(nonatomic,assign)NSIndexPath *rowFlag;

@property(nonatomic,retain)IBOutlet UILabel *totalworkinglabel;

-(IBAction)timecardeditfuction:(id)sender;
@end
