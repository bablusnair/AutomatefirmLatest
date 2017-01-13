//
//  individualShiftScreenViewClass.h
//  Automate Firm
//
//  Created by leonine on 04/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface individualShiftScreenViewClass : UIView<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *nameTableView;

@property (weak, nonatomic) IBOutlet UITableView *shiftDetailsTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *calenderCollection;
@property(nonatomic,retain)NSMutableArray *scrollTableAray;
@property(nonatomic,retain)NSMutableArray *daysArray;

@property(nonatomic,assign)int date;
- (IBAction)teamSelectionAction:(id)sender;
- (IBAction)teamdetailsViewAction:(id)sender;
@end
