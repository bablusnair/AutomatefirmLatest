//
//  shiftMainViewClass.h
//  Automate Firm
//
//  Created by leonine on 03/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shiftMainViewClass : UIView<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *shiftCellCollection;
@property(nonatomic,retain)NSMutableArray *cellImageArray;
@end
