//
//  ContainerTableCell.h
//  sometesting
//
//  Created by Emvigo on 21/01/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerCellView.h"
@interface ContainerTableCell : UITableViewCell
- (void)setCollectionData:(NSArray *)collectionData;
@property (strong, nonatomic) ContainerCellView *collectionView;
@end
