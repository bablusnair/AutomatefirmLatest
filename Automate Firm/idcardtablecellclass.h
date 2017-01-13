//
//  idcardtablecellclass.h
//  bablusdemokpproject
//
//  Created by leonine on 24/06/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "insideidcardsviewclass.h"
@interface idcardtablecellclass : UITableViewCell
@property (strong, nonatomic) insideidcardsviewclass *collectionView;
- (void)setCollectionData:(NSArray *)collectionData;

@end
