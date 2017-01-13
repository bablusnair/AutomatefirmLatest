//
//  pjtgenatedcustumviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 13/03/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pjtgenatedcustumviewclass : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectinview;
@property(nonatomic,retain)NSMutableArray *stamparray;
@property(nonatomic,retain)NSMutableArray *stampnamearray;
@property(nonatomic,retain)NSMutableArray *selectedarray;
@property(nonatomic,retain)NSIndexPath *k;
-(IBAction)closeButton:(id)sender;

@end
