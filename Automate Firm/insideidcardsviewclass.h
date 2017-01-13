//
//  insideidcardsviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 24/06/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface insideidcardsviewclass : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *mycollectionView;
@property(nonatomic,retain)NSMutableArray *selecetdArray;
@property (strong, nonatomic) NSArray *mycollectionData1;
- (void)setCollectionData:(NSArray *)data;
@end
